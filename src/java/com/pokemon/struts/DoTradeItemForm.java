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
public class DoTradeItemForm extends org.apache.struts.action.ActionForm {
    private int[] itemid;
    private int[] amount;

    public int[] getAmount() {
        return amount;
    }

    public void setAmount(int[] amount) {
        this.amount = amount;
    }

    public int[] getItemid() {
        return itemid;
    }

    public void setItemid(int[] itemid) {
        this.itemid = itemid;
    }

    /**
     *
     */
    public DoTradeItemForm() {
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
