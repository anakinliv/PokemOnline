/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.others;

import com.pokemon.database.Database;
import com.pokemon.structure.ChatUnit;
import com.pokemon.structure.User;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;

/**
 *
 * @author Sidney
 */
public class ChatController {
    public static final int MAX_BUFFERRED_CHAT = 100;
    LinkedList<ChatUnit> chats;
    HashMap<Integer, Boolean> permit;

    public ChatController() {
        chats = new LinkedList<ChatUnit>();
        permit = new HashMap<Integer, Boolean>();
    }

    public LinkedList<ChatUnit> getChats() {
        return chats;
    }

    public void addChatUnit(int id, String name, String words) {
        Boolean isPermit = permit.get(id);
        if (isPermit == null) {
            Database db = Database.getNewDatabase();
            User user = db.getUserOverallInfo(id);
            Database.databaseAfterUse(db);
            isPermit = (user.getRights() & User.CHAT_RIGHTS) == User.CHAT_RIGHTS;
            permit.put(id, isPermit);
        }
        if (isPermit)
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

    public void setPermit(int uid, boolean permitToChat) {
        permit.put(uid, permitToChat);
    }
}
