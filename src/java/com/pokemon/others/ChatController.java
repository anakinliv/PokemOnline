/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.others;

import com.pokemon.structure.ChatUnit;
import java.util.Calendar;
import java.util.LinkedList;

/**
 *
 * @author Sidney
 */
public class ChatController {
    public static final int MAX_BUFFERRED_CHAT = 100;
    LinkedList<ChatUnit> chats;

    public ChatController() {
        chats = new LinkedList<ChatUnit>();
    }

    public LinkedList<ChatUnit> getChats() {
        return chats;
    }

    public void addChatUnit(int id, String name, String words) {
        addChatUnit(new ChatUnit(id, name, Calendar.getInstance(), words));
    }

    public void addChatUnit(ChatUnit chat) {
        if (chats.size() >= MAX_BUFFERRED_CHAT)
            chats.pollFirst();
        chats.addLast(chat);
    }

    public LinkedList<ChatUnit> getChatsFromTime(Calendar t) {
        LinkedList<ChatUnit>  result = new LinkedList<ChatUnit>();
        for (ChatUnit chat : chats) {
            if (t == null || chat.getDatetime().after(t))
                result.addLast(chat);
        }
        return result;
    }
}
