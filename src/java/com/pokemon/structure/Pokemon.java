/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

/**
 *
 * @author Sidney
 */
public class Pokemon {
    int pmid;
    String name;
    int hp;
    int attack;
    int defense;
    int sattack;
    int sdefense;
    int speed;
    int catchrate;
    int levelup_exp;
    Type type;

    public Pokemon(int pmid, String name, int hp, int attack, int defense, int sattack, int sdefense, int speed, int catchrate, int levelup_exp, Type type) {
        this.pmid = pmid;
        this.name = name;
        this.hp = hp;
        this.attack = attack;
        this.defense = defense;
        this.sattack = sattack;
        this.sdefense = sdefense;
        this.speed = speed;
        this.catchrate = catchrate;
        this.levelup_exp = levelup_exp;
        this.type = type;
    }

    public int getAttack() {
        return attack;
    }

    public void setAttack(int attack) {
        this.attack = attack;
    }

    public int getCatchrate() {
        return catchrate;
    }

    public void setCatchrate(int catchrate) {
        this.catchrate = catchrate;
    }

    public int getDefense() {
        return defense;
    }

    public void setDefense(int defense) {
        this.defense = defense;
    }

    public int getHp() {
        return hp;
    }

    public void setHp(int hp) {
        this.hp = hp;
    }

    public int getLevelup_exp() {
        return levelup_exp;
    }

    public void setLevelup_exp(int levelup_exp) {
        this.levelup_exp = levelup_exp;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSattack() {
        return sattack;
    }

    public void setSattack(int sattack) {
        this.sattack = sattack;
    }

    public int getSdefense() {
        return sdefense;
    }

    public void setSdefense(int sdefense) {
        this.sdefense = sdefense;
    }

    public int getSpeed() {
        return speed;
    }

    public void setSpeed(int speed) {
        this.speed = speed;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }
    
}
