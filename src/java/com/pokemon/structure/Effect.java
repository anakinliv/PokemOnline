/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

/**
 *
 * @author Sidney
 */
public class Effect {
  public final static int SELF = 0x8000;
  public final static int ENEMY = 0x0000;
  public final static int PERSONAL_HP = 0;
  public final static int PERSONAL_ATTACK = 1;
  public final static int PERSONAL_DEFENSE = 2;
  public final static int PERSONAL_SPECIAL_ATTACK = 3;
  public final static int PERSONAL_SPECIAL_DEFENSE = 4;
  public final static int PERSONAL_SPEED = 5;
  public final static int EFFORT_HP = 6;
  public final static int EFFORT_ATTACK = 7;
  public final static int EFFORT_DEFENSE = 8;
  public final static int EFFORT_SPECIAL_ATTACK = 9;
  public final static int EFFORT_SPECIAL_DEFENSE = 10;
  public final static int EFFORT_SPEED = 11;
  public final static int LEVEL = 12;
  public final static int EXPERIENCE = 13;
  int id=0;
  int targetInDataBase=0;
  int v=0;
  int longlast=0;

  public Effect(int eid, int target, int value, int longlast) {
      this.id = eid;
      this.targetInDataBase = target;
      this.v = value;
      this.longlast = longlast;
  }

  public Effect(Effect another) {
      this.id = another.id;
      this.targetInDataBase = another.targetInDataBase;
      this.v = another.v;
  }

  public boolean targetIsSelf() {
      return (targetInDataBase & SELF) == SELF;
  }

  public int targetProperty() {
      return targetInDataBase & 0x7FFF;
  }

  public int value() {
      return this.v;
  }

  public void setValue(int v) {
      this.v = v;
  }

  public int getLonglast() {
      return longlast;
  }
}
