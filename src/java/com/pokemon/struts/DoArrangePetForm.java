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
public class DoArrangePetForm extends org.apache.struts.action.ActionForm {

    private int[] active;
    private int[] box;
    private int[] drop;

    public int[] getActive() {
        return active;
    }

    public void setActive(int[] active) {
        this.active = active;
    }

    public int[] getBox() {
        return box;
    }

    public void setBox(int[] box) {
        this.box = box;
    }

    public int[] getDrop() {
        return drop;
    }

    public void setDrop(int[] drop) {
        this.drop = drop;
    }

    /**
     *
     */
    public DoArrangePetForm() {
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
        return errors;
    }
}
