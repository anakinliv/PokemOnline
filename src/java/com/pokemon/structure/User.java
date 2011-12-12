/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

/**
 *
 * @author Sidney
 */
public class User {
    private int uid=-1;
    private String userName="";
    private int type=0;

    public User() {
    }

    public User(int uid, String userName, int type) {
        this.uid = uid;
        this.userName = userName;
        this.type = type;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getTypeName() {
        switch (type)
        {
            case 1:
                return "player";
            case 2:
                return "gm";
            case 3:
                return "admin";
        }
        return "";
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }


}
