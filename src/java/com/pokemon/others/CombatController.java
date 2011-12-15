/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.others;

import com.pokemon.structure.Pet;
import com.pokemon.structure.Skill;

/**
 *
 * @author Sidney
 */
public class CombatController {
    public int calculateDamage(CombatStates states, int skillIndex, boolean fromUser1) {
        CombatState attackerState = states.getState(fromUser1 ? 0 : 1);
        Pet attackerPet = attackerState.getCurrentPet();
        CombatState attackeeState = states.getState(fromUser1 ? 1 : 0);
        Pet attackeePet = attackeeState.getCurrentPet();
        Skill skill = attackerPet.getSkills().elementAt(skillIndex);
        int result = attackerPet.getPersonal_attack() - attackeePet.getPersonal_defense();
        // TODO some complex calculation

        return result;
    }

}
