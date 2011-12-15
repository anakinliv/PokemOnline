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

    public void addItem(Item item, int count) {
        items.add(item);
        counts.add(new Integer(count));
    }

    public int getItemCount(int iid) {
        for (int i = 0;i < items.size();++i)
            if (items.elementAt(i).getIid() == iid)
                return counts.elementAt(i).intValue();
        return 0;
    }

    public void setItemCount(int iid, int count) {
        for (int i = 0;i < items.size();++i)
            if (items.elementAt(i).getIid() == iid) {
                counts.set(i, count);
                return;
            }
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
