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
    String lastCombatInfo;

    public CombatStates(int uid, int enemyPmid) {
        states = new CombatState[2];
        states[0] = new CombatState(true, uid);
        states[1] = new CombatState(false, enemyPmid);
        lastCombatInfo = "";
    }

    public CombatState getState(int index) {
        return states[index];
    }

    public String getLastCombatInfo() {
        return lastCombatInfo;
    }

    public void setLastCombatInfo(String lastCombatInfo) {
        this.lastCombatInfo = lastCombatInfo;
    }

    public void appendtLastCombatInfo(String combatInfo, boolean newLine) {
        this.lastCombatInfo += (newLine ? "\n" : "") + combatInfo;
    }

}
