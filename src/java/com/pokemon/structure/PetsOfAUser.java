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
public class PetsOfAUser {
    public static final int MAX_ACTIVE_PET_COUNT = 6;
    int uid;
    Vector<Pet> activePets;
    Vector<Pet> petsInBox;

    public PetsOfAUser(int uid, Vector<Pet> activePets, Vector<Pet> petsInBox) {
        this.uid = uid;
        this.activePets = activePets;
        this.petsInBox = petsInBox;
    }

    public Vector<Pet> getActivePets() {
        return activePets;
    }

    public void setActivePets(Vector<Pet> activePets) {
        this.activePets = activePets;
    }

    public Vector<Pet> getPetsInBox() {
        return petsInBox;
    }

    public void setPetsInBox(Vector<Pet> petsInBox) {
        this.petsInBox = petsInBox;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

}
