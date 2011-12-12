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
import javax.servlet.http.HttpSession;
import java.nio.charset.*;

/**
 *
 * @author Sidney
 */
public class LoginAction extends org.apache.struts.action.Action {
    
    /* forward name="failure" path="" */
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
        HttpSession session = request.getSession();
        Object object = session.getAttribute("user");
        if (object != null) {
            return mapping.findForward(((User)object).getTypeName());
        }

        LoginForm formBean = (LoginForm)form;
//Charset cs = Charset.forName("UTF-8");
//CharsetDecoder cd = cs.newDecoder();
//cd.replaceWith(formBean.getUsername());

        String username = formBean.getUsername();
        String password = formBean.getPassword();
        
        Database db = Database.getNewDatabase();
        User user = db.logUser(username, password);
        String forwardStr = FAILURE;
        if (user != null)
        {
            session.setAttribute("user", user);
            forwardStr = user.getTypeName();
        }
        Database.databaseAfterUse(db);
        return mapping.findForward(forwardStr);
    }
}
