/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.database;

import com.pokemon.structure.Pet;
import com.pokemon.structure.PetsOfAUser;
import java.sql.SQLException;

/**
 *
 * @author Sidney
 */
public class CreateTestData {
    final private static int ITEM_COUNT = 100;
    final private static int TYPE_COUNT = 10;
    final private static int EFFECT_COUNT = 100;
    final private static int AREA_COUNT = 10;
    final private static int SKILL_COUNT = 100;
    final private static int POKEMON_COUNT = 100;
    final private static int SKILL_PER_POKEMON = 6;
    final private static int PLAYER_COUNT = 100;
    final private static int PM_COUNT = 10;
    final private static int ADMIN_COUNT = 1;
    final private static int ITEM_PER_PLAYER_COUNT = 5;

    private static void createItems() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < ITEM_COUNT;++i)
            d.addItem(String.format("物品%d", i), String.format("物品%d的描述", i));
        d.close();
    }

    private static void createTypes() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < TYPE_COUNT;++i)
            d.addType(String.format("种类%d", i));
        d.close();
    }

    private static void createEffects() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < EFFECT_COUNT;++i)
            d.addEffect(i, i, 1);
        d.close();
    }

    private static void createMaps() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < AREA_COUNT;++i)
            d.addMap(0);
        d.close();
    }

    private static void createItemEffects() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < ITEM_COUNT;++i)
            d.addItemEffect(i + 1, i % EFFECT_COUNT + 1);
        d.close();
    }

    private static void createSkills() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < SKILL_COUNT;++i)
            d.addSkill(i % TYPE_COUNT + 1, String.format("技能%d", i), String.format("技能%d的描述", i));
        d.close();
    }

    private static void createTypeRelations() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < TYPE_COUNT;++i)
            d.addTypeRelation(i+ 1, (i + 1) % TYPE_COUNT + 1, i % EFFECT_COUNT + 1);
        d.close();
    }

    private static void createPokemons() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < POKEMON_COUNT;++i)
            d.addPokemon(i % TYPE_COUNT + 1, (i + 1) % TYPE_COUNT + 1, String.format("Pokemon%d", i), i + 1, i + 1, i + 1, i + 1, i + 1, i + 1, i + 1, i + 1, i + 1);
        d.close();
    }

    private static void createSkillEffects() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < SKILL_COUNT;++i)
            d.addSkillEffect(i + 1, i % EFFECT_COUNT + 1);
        d.close();
    }

    private static void createAppearRates() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < POKEMON_COUNT;++i)
            d.addAppearRate(i + 1, i % AREA_COUNT + 1, 1);
        d.close();
    }

    private static void createPmSkills() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < POKEMON_COUNT;++i)
            for (int j = 0;j < SKILL_PER_POKEMON;++j)
                d.addPmSkill(i + 1, ((i + 1 + j + 1)) % SKILL_COUNT + 1 , j * 10);
        d.close();
    }

    private static void createEvolves() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < POKEMON_COUNT / 4;++i)
            for (int j = 0;j < 3;++j)
                d.addEvolve(i + 1, i + 1 + 1 + POKEMON_COUNT / 4, j * 2);
        d.close();
    }

    private static void createPets() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < POKEMON_COUNT;++i)
            d.addPet(i + 1, String.format("宠物%d", i), 100, 100, 0, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 1, 0, 0);
        d.close();
    }

    private static void createUsers() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < PLAYER_COUNT;++i)
            d.addUser(String.format("player%d", i), "1", 1);
        for (int i = 0; i < PM_COUNT;++i)
            d.addUser(String.format("pm%d", i), "1", 2);
        for (int i = 0; i < ADMIN_COUNT;++i)
            d.addUser(String.format("admin%d", i), "1", 3);
        d.close();
    }

    private static void createFriendRequests() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < PLAYER_COUNT;++i)
            d.addFriendRequest(i + 1, (i + 2) % PLAYER_COUNT + 1);
        d.close();
    }

    private static void createFriends() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < PLAYER_COUNT;++i)
            d.addFriend(i + 1, (i + 3) % PLAYER_COUNT + 1);
        d.close();
    }

    private static void createChats() throws SQLException {
        return;
    }

    private static void createBoxs() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < PLAYER_COUNT;++i)
            d.addBox(i + 1, i + 1);
        d.close();
    }

    private static void createBags() throws SQLException {
        Database d = new Database();
        for (int i = 0; i < PLAYER_COUNT;++i)
            for (int j = 0;j < ITEM_PER_PLAYER_COUNT;++j)
                d.addBag(i + 1, (i + j) % ITEM_COUNT + 1, 5);
        d.close();
    }

    public static void createLevelData(int level) {
        try {
            switch (level) {
                case 1:
                    createItems();
                    createTypes();
                    createEffects();
                    createMaps();
                    break;
                case 2:
                    createItemEffects();
                    createSkills();
                    createTypeRelations();
                    createPokemons();
                    break;
                case 3:
                    createSkillEffects();
                    createAppearRates();
                    createPmSkills();
                    createEvolves();
                    createPets();
                    break;
                case 4:
                    createUsers();
                    break;
                case 5:
                    createFriendRequests();
                    createFriends();
                    createChats();
                    createBoxs();
                    createBags();
                    break;
            }
        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
    }

    public static void main(String[] args) {
        createLevelData(1);
        createLevelData(2);
        createLevelData(3);
        createLevelData(4);
        createLevelData(5);
    }
}
