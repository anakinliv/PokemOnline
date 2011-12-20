/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.struts;

import com.pokemon.database.Database;
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
public class CombatAction extends org.apache.struts.action.Action {
    
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
        String paid = request.getParameter("aid");
        if (paid == null || "".equals(paid))
             return mapping.findForward(FAILED);
        Database db = Database.getNewDatabase();
        user.setRights(db.getUserOverallInfo(user.getUid()).getRights());
        int punishmentLevel = db.getPunishmentLevel(user.getUid());
        int oaid = db.getUserAtAreaId(user.getUid());
        Database.databaseAfterUse(db);
        if ((user.getRights() & User.ADVENTURE_RIGHTS) != User.ADVENTURE_RIGHTS)
             return mapping.findForward(FAILED);
        if (punishmentLevel == 0 && paid != null && !("".equals(paid))) {
            db = Database.getNewDatabase();
            db.setUserAtAreaId(user.getUid(), Integer.parseInt(paid));
            Database.databaseAfterUse(db);
        } else if (punishmentLevel == 0)
             return mapping.findForward(FAILED);
        return mapping.findForward(SUCCESS);
    }
}
