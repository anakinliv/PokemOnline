/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.struts;

import com.pokemon.database.Database;
import com.pokemon.structure.Item;
import com.pokemon.structure.User;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Sidney
 */
public class DoTradeItemAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILED = "failed";
    
    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Object object = session.getAttribute("user");
        if (object == null)
            return mapping.findForward(FAILED);

        User user = (User)object;
        DoTradeItemForm formBean = (DoTradeItemForm)form;
        Database db = Database.getNewDatabase();

        int [] itemids = formBean.getItemid();
        int [] amounts = formBean.getAmount();
        if (itemids.length != amounts.length) {
            Database.databaseAfterUse(db);
            return mapping.findForward(FAILED);
        }
        Vector<Item> items = db.getAllItemsWithoutEffect();
        int userCurrentMoney = db.getUserCurrentMoney(user.getUid());
        int totalPrice = 0;
        for (int i = 0;i < itemids.length;++i) {
            boolean found = false;
            for (int j = 0;j < items.size();++j) {
                if (itemids[i] == items.elementAt(j).getIid()) {
                    found = true;
                    totalPrice += items.elementAt(j).getPrice() * amounts[i];
                    break;
                }
            }
            if (!found) {
                Database.databaseAfterUse(db);
                return mapping.findForward(FAILED);
            }
        }

        if (userCurrentMoney < totalPrice) {
            Database.databaseAfterUse(db);
            return mapping.findForward(FAILED);
        }

        db.setUserCurrentMoney(user.getUid(), totalPrice - userCurrentMoney);

        for (int i = 0;i < itemids.length;++i)
            db.addUserItem(user.getUid(), itemids[i], amounts[i]);

        Database.databaseAfterUse(db);

        return mapping.findForward(SUCCESS);
    }
}
