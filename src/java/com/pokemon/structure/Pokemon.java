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
    Type type1;
    Type type2;

    public Pokemon(int pmid, String name, int hp, int attack, int defense, int sattack, int sdefense, int speed, int catchrate, int levelup_exp, Type type1, Type type2) {
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
        this.type1 = type1;
        this.type2 = type2;
    }

    public int getPmid() {
        return pmid;
    }

    public void setPmid(int pmid) {
        this.pmid = pmid;
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

    public Type getType1() {
        return type1;
    }

    public void setType1(Type type1) {
        this.type1 = type1;
    }

    public Type getType2() {
        return type2;
    }

    public void setType2(Type type2) {
        this.type2 = type2;
    }
    
}
