/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

/**
 *
 * @author Sidney
 */
public class Pet {
    int petid;
    String name;
    int max_hp;
    int cur_hp;
    int intimate;
    int personal_hp;
    int personal_attack;
    int personal_defense;
    int personal_sattack;
    int personal_sdefense;
    int personal_speed;
    int effort_hp;
    int effort_attack;
    int effort_defense;
    int effort_sattack;
    int effort_sdefense;
    int effort_speed;
    int level;
    int exp;
    int pm_status;
    Pokemon pokemon;

    public Pet(int petid, String name, int max_hp, int cur_hp, int intimate, int personal_hp, int personal_attack, int personal_defense, int personal_sattack, int personal_sdefense, int personal_speed, int effort_hp, int effort_attack, int effort_defense, int effort_sattack, int effort_sdefense, int effort_speed, int level, int exp, int pm_status, Pokemon pokemon) {
        this.petid = petid;
        this.name = name;
        this.max_hp = max_hp;
        this.cur_hp = cur_hp;
        this.intimate = intimate;
        this.personal_hp = personal_hp;
        this.personal_attack = personal_attack;
        this.personal_defense = personal_defense;
        this.personal_sattack = personal_sattack;
        this.personal_sdefense = personal_sdefense;
        this.personal_speed = personal_speed;
        this.effort_hp = effort_hp;
        this.effort_attack = effort_attack;
        this.effort_defense = effort_defense;
        this.effort_sattack = effort_sattack;
        this.effort_sdefense = effort_sdefense;
        this.effort_speed = effort_speed;
        this.level = level;
        this.exp = exp;
        this.pm_status = pm_status;
        this.pokemon = pokemon;
    }

    public int getCur_hp() {
        return cur_hp;
    }

    public void setCur_hp(int cur_hp) {
        this.cur_hp = cur_hp;
    }

    public int getEffort_attack() {
        return effort_attack;
    }

    public void setEffort_attack(int effort_attack) {
        this.effort_attack = effort_attack;
    }

    public int getEffort_defense() {
        return effort_defense;
    }

    public void setEffort_defense(int effort_defense) {
        this.effort_defense = effort_defense;
    }

    public int getEffort_hp() {
        return effort_hp;
    }

    public void setEffort_hp(int effort_hp) {
        this.effort_hp = effort_hp;
    }

    public int getEffort_sattack() {
        return effort_sattack;
    }

    public void setEffort_sattack(int effort_sattack) {
        this.effort_sattack = effort_sattack;
    }

    public int getEffort_sdefense() {
        return effort_sdefense;
    }

    public void setEffort_sdefense(int effort_sdefense) {
        this.effort_sdefense = effort_sdefense;
    }

    public int getEffort_speed() {
        return effort_speed;
    }

    public void setEffort_speed(int effort_speed) {
        this.effort_speed = effort_speed;
    }

    public int getExp() {
        return exp;
    }

    public void setExp(int exp) {
        this.exp = exp;
    }

    public int getIntimate() {
        return intimate;
    }

    public void setIntimate(int intimate) {
        this.intimate = intimate;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public int getMax_hp() {
        return max_hp;
    }

    public void setMax_hp(int max_hp) {
        this.max_hp = max_hp;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPersonal_attack() {
        return personal_attack;
    }

    public void setPersonal_attack(int personal_attack) {
        this.personal_attack = personal_attack;
    }

    public int getPersonal_defense() {
        return personal_defense;
    }

    public void setPersonal_defense(int personal_defense) {
        this.personal_defense = personal_defense;
    }

    public int getPersonal_hp() {
        return personal_hp;
    }

    public void setPersonal_hp(int personal_hp) {
        this.personal_hp = personal_hp;
    }

    public int getPersonal_sattack() {
        return personal_sattack;
    }

    public void setPersonal_sattack(int personal_sattack) {
        this.personal_sattack = personal_sattack;
    }

    public int getPersonal_sdefense() {
        return personal_sdefense;
    }

    public void setPersonal_sdefense(int personal_sdefense) {
        this.personal_sdefense = personal_sdefense;
    }

    public int getPersonal_speed() {
        return personal_speed;
    }

    public void setPersonal_speed(int personal_speed) {
        this.personal_speed = personal_speed;
    }

    public int getPetid() {
        return petid;
    }

    public void setPetid(int petid) {
        this.petid = petid;
    }

    public int getPm_status() {
        return pm_status;
    }

    public void setPm_status(int pm_status) {
        this.pm_status = pm_status;
    }

    public Pokemon getPokemon() {
        return pokemon;
    }

    public void setPokemon(Pokemon pokemon) {
        this.pokemon = pokemon;
    }


}
