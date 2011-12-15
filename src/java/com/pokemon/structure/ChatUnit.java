/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

import java.util.Calendar;

/**
 *
 * @author Sidney
 */
public class ChatUnit {
    int id;
    String name;
    Calendar datetime;
    String words;

    public ChatUnit(int id, String name, Calendar datetime, String words) {
        this.id = id;
        this.name = name;
        this.datetime = datetime;
        this.words = words;
    }

    public Calendar getDatetime() {
        return datetime;
    }

    public void setDatetime(Calendar datetime) {
        this.datetime = datetime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWords() {
        return words;
    }

    public void setWords(String words) {
        this.words = words;
    }
}
