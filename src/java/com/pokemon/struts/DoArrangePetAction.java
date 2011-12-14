/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.struts;

import com.pokemon.database.Database;
import com.pokemon.structure.PetsOfAUser;
import com.pokemon.structure.User;
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
public class DoArrangePetAction extends org.apache.struts.action.Action {
    
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
        DoArrangePetForm formBean = (DoArrangePetForm)form;
        Database db = Database.getNewDatabase();

        int [] active = formBean.getActive();
        int [] box = formBean.getBox();
        if (active.length == 0 || active.length > PetsOfAUser.MAX_ACTIVE_PET_COUNT) {
            Database.databaseAfterUse(db);
            return mapping.findForward(FAILED);
        }
        int i;
        for (i = 0;i < active.length;++i)
            db.setActivePet(user.getUid(), i + 1, active[i]);
        for (;i < PetsOfAUser.MAX_ACTIVE_PET_COUNT;++i)
            db.clearActivePet(user.getUid(), i + 1);
        db.clearBox(user.getUid());
        if (box != null)
            for (i = 0;i < box.length;++i)
                db.addBox(user.getUid(), box[i]);
        Database.databaseAfterUse(db);
        
        return mapping.findForward(SUCCESS);
    }
}
