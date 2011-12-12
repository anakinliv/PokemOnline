/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import com.pokemon.structure.*;
import java.util.Vector;

/**
 *
 * @author Sidney
 */
public class Database {
    private Connection connection = null;
    final private static String dbAddress = "localhost";
    final private static String dbPort = "3306";
    final private static String dbName = "pokemon";

    public static Database getNewDatabase() {
        Database db = new Database();
        return db;
    }

    public static void databaseAfterUse(Database db) {
        db.close();
    }

    public Database() {
        try {
            java.lang.Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        try {
            connection =
                    DriverManager.getConnection("jdbc:mysql://" + dbAddress +
                    ":" + dbPort + "/" + dbName + "?" +
                    "user=root&password=tecton&useUnicode=true&characterEncoding=UTF-8");
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
    }

    public void addItem(String itemname, String description) throws SQLException {
        String sql = null;
        if (description == null)
            sql = String.format("INSERT INTO item(itemname) VALUES('%s')", itemname);
        else
            sql = String.format("INSERT INTO item(itemname, description) VALUES('%s', '%s')", itemname, description);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addType(String typename) throws SQLException {
        String sql = String.format("INSERT INTO type(typename) VALUES('%s')", typename);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addEffect(int target, int value) throws SQLException {
        String sql = String.format("INSERT INTO effect(target, value) VALUES('%d', '%d')", target, value);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addMap(int mapid) throws SQLException {
        String sql = String.format("INSERT INTO map(mapid) VALUES('%d')", mapid);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addItemEffect(int itemid, int effectid) throws SQLException {
        String sql = String.format("INSERT INTO item_effect(itemid, effectid) VALUES('%d', '%d')", itemid, effectid);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addSkill(int typeid, String skillname, String description) throws SQLException {
        String sql = String.format("INSERT INTO skill(typeid, skillname, description) VALUES('%d', '%s', '%s')", typeid, skillname, description);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addTypeRelation(int from_type, int to_type, int effectid) throws SQLException {
        String sql = String.format("INSERT INTO type_relation(from_type, to_type, effectid) VALUES('%d', '%d', '%d')", from_type, to_type, effectid);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addPokemon(int typeid, String name, int hp, int attack, int defense, int sattack, int sdefense, int speed, int catchrate, int levelup_exp) throws SQLException {
        String sql = String.format("INSERT INTO pokemon(typeid, name, hp, attack, defense, sattack, sdefense, speed, catchrate, levelup_exp) VALUES('%d', '%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d')", typeid, name, hp, attack, defense, sattack, sdefense, speed, catchrate, levelup_exp);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addSkillEffect(int skillid, int effectid) throws SQLException {
        String sql = String.format("INSERT INTO skill_effect(skillid, effectid) VALUES('%d', '%d')", skillid, effectid);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addAppearRate(int pmid, int areaid, int rate) throws SQLException {
        String sql = String.format("INSERT INTO appear_rate(pmid, areaid, rate) VALUES('%d', '%d', '%d')", pmid, areaid, rate);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addPmSkill(int pmid, int skillid, int level) throws SQLException {
        String sql = String.format("INSERT INTO pm_skill(pmid, skillid, level) VALUES('%d', '%d', '%d')", pmid, skillid, level);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addEvolve(int from_pokemon, int to_pokemon, int level) throws SQLException {
        String sql = String.format("INSERT INTO evolve(from_pokemon, to_pokemon, level) VALUES('%d', '%d', '%d')",from_pokemon, to_pokemon, level);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addPet(int pmid, String name, int max_hp, int cur_hp, int intimate, int personal_hp, int personal_attack, int personal_defense, int personal_sattack, int personal_sdefense, int personal_speed, int effort_hp, int effort_attack, int effort_defense, int effort_sattack, int effort_sdefense, int effort_speed, int level, int exp, int pm_status) throws SQLException {
        String sql = String.format("INSERT INTO pet(pmid, name, max_hp, cur_hp, intimate, personal_hp, personal_attack, personal_defense, personal_sattack, personal_sdefense, personal_speed, effort_hp, effort_attack, effort_defense, effort_sattack, effort_sdefense, effort_speed, level, exp, pm_status) VALUES('%d', '%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d')",pmid, name, max_hp, cur_hp, intimate, personal_hp, personal_attack, personal_defense, personal_sattack, personal_sdefense, personal_speed, effort_hp, effort_attack, effort_defense, effort_sattack, effort_sdefense, effort_speed, level, exp, pm_status);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addUser(String username, String password, int type) throws SQLException {
        String sql = String.format("INSERT INTO user(areaid, username, password, type, rights, money, punishment_level) VALUES('%d', '%s', '%s', '%d', '%d', '%d', '%d')", 1, username, password, type, 0xFF, 0, 0);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addFriendRequest(int from_user, int to_user) throws SQLException {
        String sql = String.format("INSERT INTO friend_request(from_user, to_user) VALUES('%d', '%d')", from_user, to_user);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addFriend(int usera, int userb) throws SQLException {
        String sql = String.format("INSERT INTO friend(usera, userb) VALUES('%d', '%d')", usera, userb);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addBox(int userid, int petid) throws SQLException {
        String sql = String.format("INSERT INTO box(userid, petid) VALUES('%d', '%d')", userid, petid);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addBag(int userid, int itemid, int count) throws SQLException {
        String sql = String.format("INSERT INTO bag(userid, itemid, count) VALUES('%d', '%d', '%d')", userid, itemid, count);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }

    public void addEmptyUser(String name, String password) throws SQLException {
        String sql = String.format("INSERT INTO user(username, password, type) VALUES('%s','%s','%d')", name, password, 1);
        Statement stmt = connection.createStatement();
        stmt.execute(sql);
        stmt.execute("COMMIT;");
        stmt.close();
    }
    
    public User getUserOverallInfo(int uid) {
        User result = null;
        String sql = String.format("SELECT username, type FROM user WHERE userid = '%d'", uid);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            if (rs.next()) {
                result = new User();
                result.setUid(uid);
                result.setUserName(rs.getString("username"));
                result.setType(rs.getInt("type"));
            }
            stmt.close();
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }
        
        return result;
    }

    public Vector<User> getFriendRequest(int uid) {
        Vector<User> result = new Vector<User>();
        String sql = String.format("SELECT from_user FROM friend_request WHERE to_user = '%d'", uid);
        Vector<Integer> senderUid = new Vector<Integer>();
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            while (rs.next())
                senderUid.add(new Integer(rs.getInt("from_user")));
            for (int i = 0;i < senderUid.size();++i)
                result.add(getUserOverallInfo(senderUid.elementAt(i)));
            stmt.close();
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }
        return result;
    }

    public Vector<User> getFriendList(int uid) {
        Vector<User> result = new Vector<User>();
        String sql = String.format("SELECT usera, userb FROM friend WHERE usera = '%d' OR userb = '%d'", uid, uid);
        Vector<Integer> friendUid = new Vector<Integer>();
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            while (rs.next())
            {
                int usera = rs.getInt("usera");
                int userb = rs.getInt("userb");
                int friend = usera == uid ? userb : usera;
                friendUid.add(new Integer(friend));
            }
            stmt.close();
            for (int i = 0;i < friendUid.size();++i)
                result.add(getUserOverallInfo(friendUid.elementAt(i)));
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }
        return result;
    }

    public Effect getEffect(int eid) {
        Effect result = null;
        String sql = String.format("SELECT target, value FROM effect WHERE effectid = '%d'", eid);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            if (rs.next())
                result = new Effect(eid, rs.getInt("target"), rs.getInt("value"));
            stmt.close();
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }

        return result;
    }
    
    public Item getItem(int iid) {
        Item result = null;
        String sql = String.format("SELECT itemname, description FROM item WHERE itemid = '%d'", iid);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            if (rs.next())
            {
                result = new Item(iid, rs.getString("itemname"), rs.getString("description"));
                sql = String.format("SELECT effectid FROM item_effect WHERE itemid = '%d'", iid);
                stmt.execute(sql);
                rs = stmt.getResultSet();
                while (rs.next()) {
                    result.addEffect(getEffect(rs.getInt("effectid")));
                }
            }
            stmt.close();
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }
        
        return result;
    }

    public Bag getUserBag(int uid) {
        Bag result = new Bag();
        Vector<Integer> itemIds = new Vector<Integer>();
        Vector<Integer> counts = new Vector<Integer>();
        String sql = String.format("SELECT itemid, count FROM bag WHERE userid = '%d'", uid);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            while (rs.next())
            {
                itemIds.add(new Integer(rs.getInt("itemid")));
                counts.add(new Integer(rs.getInt("count")));
            }
            stmt.close();
            for (int i = 0;i < itemIds.size();++i)
                result.AddItem(getItem(itemIds.elementAt(i).intValue()), counts.elementAt(i).intValue());
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }

        return result;
    }

    public SearchResult searchUser(String username, int page) {
        SearchResult result = new SearchResult();
        final int PAGE_COUNT_PER_SEARCH = 3;
        String sql = String.format("SELECT userid, username, type FROM user WHERE username like '%s'", username);
        try {
            Statement stmt = connection.createStatement();
            stmt.execute(sql);
            ResultSet rs = stmt.getResultSet();
            int count = 0;
            while (rs.next())
            {
                ++count;
                if (count > SearchResult.COUNT_PER_PAGE * (page - 1) &&
                    count <= SearchResult.COUNT_PER_PAGE * (count + PAGE_COUNT_PER_SEARCH - 1)) {
                    User currentUser = new User(rs.getInt("userid"), rs.getString("username"), rs.getInt("type"));
                    result.result.add(currentUser);
                }
            }
            stmt.close();
            result.pageFrom = page;
            result.totalPages = (count + SearchResult.COUNT_PER_PAGE - 1) / SearchResult.COUNT_PER_PAGE;
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return result;
        }
        
        return result;
    }

    public User logUser(String username, String password) {
        String sql = String.format("SELECT userid, username, type FROM user where username = '%s' and password = '%s'", username, password);
        User user = null;
        try {
            Statement stmt = connection.createStatement();
            if (stmt.execute(sql)) {
                ResultSet rs = stmt.getResultSet();
                if (rs.next()) {
                     user = new User(rs.getInt("userid"), rs.getString("username"), rs.getInt("type"));
                }
            }
            stmt.close();
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        return user;
    }

    public void close() {
        try {
            connection.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
