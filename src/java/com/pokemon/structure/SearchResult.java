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
public class SearchResult {
    public final static int COUNT_PER_PAGE = 12;
    public int pageFrom = 0;
    public int totalPages = 0;
    public Vector<Object> result = new Vector<Object>();
}
