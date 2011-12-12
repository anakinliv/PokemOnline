/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.structure;

import java.util.Vector;

/**
 *
 * @author Sidney
 */
public class Bag {
    Vector<Item> items=new Vector<Item>();
    Vector<Integer> counts= new Vector<Integer>();

    public Bag() {
    }

    public void AddItem(Item item, int count) {
        items.add(item);
        counts.add(new Integer(count));
    }

    public Vector<Integer> getCounts() {
        return counts;
    }

    public void setCounts(Vector<Integer> counts) {
        this.counts = counts;
    }

    public Vector<Item> getItems() {
        return items;
    }

    public void setItems(Vector<Item> items) {
        this.items = items;
    }


}
