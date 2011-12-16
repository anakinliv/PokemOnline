/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.others;

import com.pokemon.database.Database;
import com.pokemon.structure.Effect;
import com.pokemon.structure.Item;
import com.pokemon.structure.Pet;
import com.pokemon.structure.Skill;
import com.pokemon.structure.Type;
import java.util.Vector;

/**
 *
 * @author Sidney
 */
public class CombatController {
    public static final int USE_SKILL = 0;
    public static final int USE_ITEM = 1;
    public static final int CHANGE_PET = 2;
    public static final int ESCAPE = 3;

    private static int preferValue(CombatStates states, int skillIndex, boolean fromUser1) {
        // Finished
        CombatState attackerState = states.getState(fromUser1 ? 0 : 1);
        Pet attackerPet = attackerState.getCurrentPet();
        CombatState attackeeState = states.getState(fromUser1 ? 1 : 0);
        Pet attackeePet = attackeeState.getCurrentPet();
        Skill skill = attackerPet.getSkills().elementAt(skillIndex);
        int result = attackerPet.getPersonal_attack() - attackeePet.getPersonal_defense();
        result *= calculateFactor(attackerPet.getType1(), attackerPet.getType2(), skill.getType(), attackeePet.getType1(), attackeePet.getType2());
        return result;
    }

    private static double calculateFactor(Type attackerMainType, Type attackerSubType, Type attackerSkillType, Type attackeeMainType, Type attackeeSubType) {
        // Not Finished
        // TODO some complex calculation(even use random value-.-)
        return 1;
    }

    private static boolean useSkill(CombatStates states, int skillIndex, boolean fromUser1) {
        // Finished
        CombatState userState = states.getState(fromUser1 ? 0 : 1);
        Skill skill;
        try {
            skill= userState.getCurrentPet().getSkills().elementAt(skillIndex);
            if (!userState.useSkill(skill.getSid()))
                return false;
        } catch (ArrayIndexOutOfBoundsException e) {
            return false;
        }
        Vector<Effect> currentSkillEffect = skill.getEffects();
        for (Effect effect : currentSkillEffect) {
            if (effect.targetIsSelf())
                effectOn(states, effect, (fromUser1 && effect.targetIsSelf()) || ((!fromUser1) && (!effect.targetIsSelf())));
            else
                skillEffectOn(states, skill.getType(), effect, !fromUser1);
        }
        return true;
    }

    private static boolean useItem(CombatStates states, int iid, boolean fromUser1) {
        // Finished
        CombatState userState = states.getState(fromUser1 ? 0 : 1);
        if (!userState.useItem(iid))
            return false;
        Database db = Database.getNewDatabase();
        Item item = db.getItem(iid);
        Vector<Effect> itemEffects = item.getEffects();
        for (Effect effect : itemEffects) {
            effectOn(states, effect, (fromUser1 && effect.targetIsSelf()) || ((!fromUser1) && (!effect.targetIsSelf())));
        }
        Database.databaseAfterUse(db);
        return true;
    }

    private static void skillEffectOn(CombatStates states, Type skillType, Effect effect, boolean toUser1) {
        // Finished
        Pet useSkillPet = states.getState(toUser1 ? 1 : 0).getCurrentPet();
        CombatState beEffectState = states.getState(toUser1 ? 0 : 1);
        Pet beUsedSkillPet = beEffectState.getCurrentPet();
        double factor = calculateFactor(useSkillPet.getType1(), useSkillPet.getType2(), skillType, beUsedSkillPet.getType1(), beUsedSkillPet.getType2());
        effectOn(states, effect, toUser1, factor);
    }

    private static void effectOn(CombatStates states, Effect effect, boolean toUser1) {
        // Finished
        effectOn(states, effect, toUser1, 1.0);
    }

    private static void effectOn(CombatStates states, Effect effect, boolean toUser1, double factor) {
        // Not Finished, currently, it's only a test
        // TODO make effect effect the combat state
        CombatState beEffectState = states.getState(toUser1 ? 0 : 1);
        Pet effectedPet = beEffectState.getCurrentPet();
        Effect recalculatedEffect = new Effect(effect);
        recalculatedEffect.setValue((int) (recalculatedEffect.value() * factor));
        effectOn(effectedPet, effect);
    }

    private static void aiMove(CombatStates states) {
        // Finished
        Pet aiPet = states.getState(1).getCurrentPet();
        Vector<Skill> skills = aiPet.getSkills();
        if (skills.isEmpty())
            return;
        boolean chooseFreferOne = Math.random() < 0.5;
        int skillIndex = 0;
        if (chooseFreferOne) {
            int maxPreferValue = preferValue(states, 0, false);
            for (int i = 1;i < skills.size();++i) {
                int value = preferValue(states, i, false);
                if (value > maxPreferValue) {
                    maxPreferValue = value;
                    skillIndex = i;
                }
            }
        } else {
            skillIndex = (int)(Math.random() * skills.size());
        }
        useSkill(states, skillIndex, false);
    }

    private static boolean changePet(CombatStates states, int pid, boolean user1) {
        CombatState userState = states.getState(user1 ? 0 : 1);
        return userState.setCurrentPet(pid);
    }

    private static boolean escape(CombatStates states, int index, boolean user1) {
        // Not Finished, currently, it's only a test
        return true;
    }

    public static void effectOn(Pet pet, Effect effect) {
        // Can be also used when using an item at peace
        // Not Finished, currently, it's only a test

        pet.setCur_hp(pet.getCur_hp() - effect.value());

        if (pet.getPetid() >= 0 /*&& effect.getLonglast()*/) {
            // Save it to the database
            Database db = Database.getNewDatabase();
            db.updatePet(pet);
            Database.databaseAfterUse(db);
        }
    }

    public static boolean acceptUserCommand(CombatStates states, int command, int value) {
        switch (command) {
            case USE_SKILL:
                if (!useSkill(states, value, true))
                    return false;
                aiMove(states);
                break;
            case USE_ITEM:
                if (!useItem(states, value, true))
                    return false;
                aiMove(states);
                break;
            case CHANGE_PET:
                if (!changePet(states, value, true))
                    return false;
                aiMove(states);
                break;
            case ESCAPE:
                if (!escape(states, value, true))
                    return false;
                aiMove(states);
                break;
        }
        // TODO exam state to judge whether the combat is over
        // TODO if it's over, calculate the reward or punishment, record them into database
        return true;
    }

    public static boolean userCanCombat(int uid) {
        Database db = Database.getNewDatabase();
        boolean result = db.userHaveFirstPet(uid);
        Database.databaseAfterUse(db);
        return result;
    }

    public static CombatStates initCombatStates(int uid) {
        Database db = Database.getNewDatabase();
        int wildpmid = db.getRandomPmIdAtUserArea(uid);
        Database.databaseAfterUse(db);
        return new CombatStates(uid, wildpmid);
    }

}
