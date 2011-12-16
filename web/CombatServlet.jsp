<%-- 
    Document   : CombatServlet
    Created on : 2011-12-15, 20:56:07
    Author     : Sidney
--%>
<%@page import="com.pokemon.structure.Skill"%>
<%@page import="com.pokemon.structure.Item"%>
<%@page import="java.util.Vector"%>
<%@page import="com.pokemon.structure.Pet"%>
<%@page import="com.pokemon.others.CombatStates"%>
<%@page import="com.pokemon.others.CombatController"%>
<%@page import="com.pokemon.structure.User"%>
<%@page contentType="json" pageEncoding="UTF-8"%>
<%
    final int NO_COMMAND = 0;
    final int COMMAND_SUCCESS = 1;
    final int COMMAND_FAILED = 2;
    final int REQUEST_MAIN_INFO = 0;
    final int REQUEST_ITEM_INFO = 1;
    final int REQUEST_SKILL_INFO = 2;
    final int REQUEST_ALL_PETS_INFO = 3;
    int commandResult = NO_COMMAND;
    int requestThing = REQUEST_MAIN_INFO;
    Object obj = request.getSession().getAttribute("user");
    if (obj == null)
        return;
    User user = (User)obj;
    if (!CombatController.userCanCombat(user.getUid()))
        return;
    obj = request.getSession().getAttribute("combatstates");
    obj = null;
    if (obj == null) {
        // Init combat state
        obj = CombatController.initCombatStates(user.getUid());
        request.getSession().setAttribute("combatstates", obj);
    }
    CombatStates combatStates = (CombatStates) obj;
    obj = request.getParameter("command");
    if (obj == null) {
        // Output the whole combat state, used to tell user the state when he first enter the combat page or refresh the web page
        if (request.getParameter("item") != null)
            requestThing = REQUEST_ITEM_INFO;
        else if (request.getParameter("skill") != null)
            requestThing = REQUEST_SKILL_INFO;
        else if (request.getParameter("skill") != null)
            requestThing = REQUEST_ALL_PETS_INFO;
    } else {
        String commandStr = (String) obj;
        Integer command = Integer.parseInt(commandStr);
        obj = request.getParameter("value");
        String valueStr = (String) obj;
        Integer value = Integer.parseInt(valueStr);
        boolean success = CombatController.acceptUserCommand(combatStates, command.intValue(), value.intValue());
        commandResult = success ? COMMAND_SUCCESS : COMMAND_FAILED;
    }
%>
{
  "commandResult" : <%= commandResult %>,
  "requestThing"  : <%= requestThing %>,
<%
    switch (requestThing) {
        case REQUEST_MAIN_INFO:
%>
  "mainInfo" :
  [
<%
            for (int i = 0;i < 2;++i) {
                Pet pet = combatStates.getState(i).getCurrentPet();
%>
    <%= i == 0 ? "" : "," %>{ "id" : '<%= pet.getPetid() %>',
      "name" : '<%= pet.getName() %>',
      "currenthp" : '<%= pet.getCur_hp() %>',
      "maxhp" : '<%= pet.getMax_hp() %>',
      "state" : '<%= pet.getPm_status() %>'}
<%
            }
            break;
        case REQUEST_ITEM_INFO:
%>
  "iteminfo" :
  [
<%
            Vector<Item> items = combatStates.getState(0).getBag().getItems();
            Vector<Integer> counts = combatStates.getState(0).getBag().getCounts();
            for (int i = 0;i < items.size();++i) {
%>
    <%= i == 0 ? "" : "," %>{ "id" : '<%= items.elementAt(i).getIid() %>',
      "name" : '<%= items.elementAt(i).getName() %>',
      "description" : '<%= items.elementAt(i).getDescription() %>',
      "count" : '<%= counts.elementAt(i).intValue() %>'}
<%
            }
            break;
        case REQUEST_SKILL_INFO:
%>
  "currentPetId" : <%= combatStates.getState(0).getCurrentPetIndex() %>,
  "skillinfo" :
  [
<%
            Vector<Skill> skills = combatStates.getState(0).getCurrentPet().getSkills();
            Vector<Integer> maxpps = combatStates.getState(0).getCurrentPet().getMaxpps();
            Vector<Integer> curpps = combatStates.getState(0).getCurrentPet().getCurpps();
            for (int i = 0;i < skills.size();++i) {
%>
    <%= i == 0 ? "" : "," %>{ "id" : '<%= skills.elementAt(i).getSid() %>',
      "name" : '<%= skills.elementAt(i).getName() %>',
      "description" : '<%= skills.elementAt(i).getDescription() %>',
      "type" : '<%= skills.elementAt(i).getType().getName() %>',
      "curpp" : '<%= curpps.elementAt(i).intValue() %>',
      "maxpp" : '<%= maxpps.elementAt(i).intValue() %>'}
<%
            }
            break;
        case REQUEST_ALL_PETS_INFO:
            Vector<Pet> petsOfUser = combatStates.getState(0).getPetsOfUser();
            for (int i = 0;i < petsOfUser.size();++i) {
%>
    <%= i == 0 ? "" : "," %>{ "id" : '<%= petsOfUser.elementAt(i).getPetid() %>',
      "name" : '<%= petsOfUser.elementAt(i).getName() %>',
      "level" : '<%= petsOfUser.elementAt(i).getLevel() %>',
      "type" : '<%= petsOfUser.elementAt(i).getPokemon().getTypeName() %>'}
<%
            }
            break;
    }
%>
  ],
  "combatInfo"    : <%= combatStates.getLastCombatInfo() %>
}