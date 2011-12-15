/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.others;

/**
 *
 * @author Sidney
 */
public class CombatStates {
    CombatState []states;

    public CombatStates(int uid, int enemyPmid) {
        states = new CombatState[2];
        states[0] = new CombatState(true, uid);
        states[1] = new CombatState(false, enemyPmid);
    }

    public CombatState getState(int index) {
        return states[index];
    }
}
