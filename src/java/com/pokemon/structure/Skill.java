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
public class Skill {
    int sid;
    String name;
    String description;
    Type type;
    Vector<Effect> effects;

    public Skill(int sid, String name, String description, Type type, Vector<Effect> effects) {
        this.sid = sid;
        this.name = name;
        this.description = description;
        this.type = type;
        this.effects = effects;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Vector<Effect> getEffects() {
        return effects;
    }

    public void setEffects(Vector<Effect> effects) {
        this.effects = effects;
    }


}
