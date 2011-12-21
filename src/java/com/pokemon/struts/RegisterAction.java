/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pokemon.struts;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.pokemon.database.Database;
import com.pokemon.structure.*;

/**
 *
 * @author amesists
 */
public class RegisterAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String FAILURE = "failure";

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
        
        RegisterForm formBean = (RegisterForm)form;
        
        String username = formBean.getUsername();
        String password = formBean.getPassword();
        String password2 = formBean.getPassword2();
        
        if ("".equals(username) || "".equals(password) ||
            "".equals(password2) || !password.equals(password2)) {
            return mapping.findForward(FAILURE);
        }
        
        Database db = Database.getNewDatabase();
        
        User checkUser = db.logUser(username, password);
        if (checkUser != null) {
            Database.databaseAfterUse(db);
            return mapping.findForward(FAILURE);
        }

        // OK, can add user
        db.addUser(username, password, 1);
        Database.databaseAfterUse(db);
        
        return mapping.findForward(SUCCESS);
    }
}
