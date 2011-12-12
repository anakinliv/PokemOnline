/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

import java.util.Vector;

/**
 *
 * @author Sidney
 */
public class Item {
    int iid=-1;
    String name="";
    String description="";
    Vector<Effect> effects = new Vector<Effect>();

    public Item() {
    }

    public Item(int iid, String name, String description) {
        this.iid = iid;
        this.name = name;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getIid() {
        return iid;
    }

    public void setIid(int iid) {
        this.iid = iid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Vector<Effect> getEffects() {
        return effects;
    }

    public void addEffect(Effect e) {
        effects.add(e);
    }

}
