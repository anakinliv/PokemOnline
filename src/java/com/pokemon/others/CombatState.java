/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.others;

import com.pokemon.database.Database;
import com.pokemon.structure.Bag;
import com.pokemon.structure.Pet;
import java.util.Vector;

/**
 *
 * @author Sidney
 */
public class CombatState {
    Vector<Pet> petsOfUser;
    int currentPetIndex;
    int uid;
    Bag bag;

    public CombatState(boolean user, int uid) {
        if (user) {
            this.uid = uid;
            Database db = Database.getNewDatabase();
            petsOfUser = (db.getPetsOfAUser(uid)).getActivePets();
            currentPetIndex = 0;
            bag = db.getUserBag(uid);
            Database.databaseAfterUse(db);
        } else {
            this.uid = -1;
            bag = new Bag();
            currentPetIndex = 0;
            // TODO generate a wild pet and store it in petsOfUser
            // In fact, the uid here is the pmid of the wild pet
        }
    }

    public Bag getBag() {
        return bag;
    }

    public void setBag(Bag bag) {
        this.bag = bag;
    }

    public Pet getCurrentPet() {
        return petsOfUser.elementAt(currentPetIndex);
    }

    public boolean setCurrentPet(int pid) {
        for (int i = 0;i < petsOfUser.size();++i)
            if (petsOfUser.elementAt(i).getPetid() == pid) {
                currentPetIndex = i;
                return true;
            }
        return false;
    }

    public boolean useItem(int iid) {
        int count = bag.getItemCount(iid);
        if (count == 0)
            return false;
        bag.setItemCount(iid, count - 1);
        if (uid != -1) {
            Database db = Database.getNewDatabase();
            db.setItemCount(uid, iid, count - 1);
            Database.databaseAfterUse(db);
        }
        return true;
    }

    public boolean useSkill(int sid) {
        int curpp = getCurrentPet().getSkillCurpp(sid);
        int maxpp = getCurrentPet().getSkillMaxpp(sid);
        if (curpp >= maxpp)
            return false;
        getCurrentPet().setSkillCurpp(sid, curpp + 1);
        if (uid != -1) {
            Database db = Database.getNewDatabase();
            db.setPetSkillCurpp(getCurrentPet().getPetid(), sid, curpp + 1);
            Database.databaseAfterUse(db);
        }
        return true;
    }

}
