/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.struts;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author Sidney
 */
public class LoginForm extends org.apache.struts.action.ActionForm {
    
    private String username;
    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    /**
     *
     */
    public LoginForm() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        if (getUsername() == null || getUsername().length() < 1)
            errors.add("username", new ActionMessage("error.name.required"));
            // TODO: add 'error.name.required' key to your resources
        else if ( getPassword() == null || getPassword().length() < 1 )
            errors.add("password", new ActionMessage("error.password.required"));
        return errors;
    }
}
