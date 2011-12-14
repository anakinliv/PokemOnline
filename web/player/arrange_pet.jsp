<%-- 
    Document   : arrange_pet
    Created on : 2011-12-10, 20:55:02
    Author     : Sidney
--%>

<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pokemon.structure.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        response.sendRedirect("../index.jsp");
    }
    User user = (User)obj;

    obj = request.getSession().getAttribute("pet_list");
    if (obj == null)
        response.sendRedirect("index.jsp");
    PetsOfAUser pets = (PetsOfAUser) obj;
    Vector<Pet> activePets = pets.getActivePets();
    Vector<Pet> petsInBox = pets.getPetsInBox();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/common.css"/>
        <link rel="stylesheet" type="text/css" href="../js/ext/resources/css/ext-all.css" />
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript">
            Ext.require([
                'Ext.grid.*',
                'Ext.data.*',
                'Ext.util.*'
            ]);
            
            Ext.define('PetDataObject', {
                extend: 'Ext.data.Model',
                fields: ['pid', 'nsme', 'type', 'exp']
            });

            Ext.onReady(function() {
                Ext.QuickTips.init();

            var activePets = [
<%
    boolean first = true;
    for (int i = 0;i < activePets.size();++i) {
        if (activePets.elementAt(i) == null)
            continue;
 %>
            <%= first ? "" : "," %>{<%= "pid: '" + activePets.elementAt(i).getPetid() + "'" %>, <%= "name: '" + activePets.elementAt(i).getName() + "'" %>, <%= "type: '" + activePets.elementAt(i).getPokemon().getName() + "'" %>, <%= "exp '" + activePets.elementAt(i).getExp() + "/" + activePets.elementAt(i).getPokemon().getLevelup_exp() + "'" %>}
<%
        first = false;
    }
%>
            ];
            var petsInBox = [
<%
    first = true;
    for (int i = 0;i < petsInBox.size();++i) {
        if (petsInBox.elementAt(i) == null)
            continue;
 %>
            <%= first ? "" : "," %>{<%= "pid: '" + petsInBox.elementAt(i).getPetid() + "'" %>, <%= "name: '" + petsInBox.elementAt(i).getName() + "'" %>, <%= "type: '" + petsInBox.elementAt(i).getPokemon().getName() + "'" %>, <%= "exp: '" + petsInBox.elementAt(i).getExp() + "/" + petsInBox.elementAt(i).getPokemon().getLevelup_exp() + "'" %>}
<%
        first = false;
    }
    request.getSession().removeAttribute("pet_list");
%>
            ];

        // create the data store
        var activePetsGridStore = Ext.create('Ext.data.Store', {
            model: 'PetDataObject',
            data: activePets
        });
        var petsInBoxGridStore = Ext.create('Ext.data.Store', {
            model: 'PetDataObject',
            data: petsInBox
        });
        var dropPetGridStore = Ext.create('Ext.data.Store', {
            model: 'PetDataObject'
        });
            // Column Model shortcut array
    var columns = [
        {text: "宠物名", flex: 1, sortable: false, dataIndex: 'name'},
        {text: "宠物类型", width: 70, sortable: false, dataIndex: 'type'},
        {text: "经验值", width: 70, sortable: false, dataIndex: 'exp'}
    ];

    // declare the source Grid
    var activePetsGrid = Ext.create('Ext.grid.Panel', {
        multiSelect: true,
        viewConfig: {
            plugins: [
                {ptype: 'gridviewdragdrop',
                dragGroup: 'activePetsGridDDGroup',
                dropGroup: 'activePetsGridDDGroup'},
                {ptype: 'gridviewdragdrop',
                dragGroup: 'activePetsGridDDGroup',
                dropGroup: 'petsInBoxGridDDGroup'},
                {ptype: 'gridviewdragdrop',
                dragGroup: 'dropPetsGridDDGroup',
                dropGroup: 'petsInBoxGridDDGroup'}
            ]
        },
        store            : activePetsGridStore,
        columns          : columns,
        stripeRows       : true,
        title            : '随身宠物',
        margins          : '0 2 0 0'
    });
    // create the destination Grid
    var petsInBoxGrid = Ext.create('Ext.grid.Panel', {
        viewConfig: {
            plugins: [
                {ptype: 'gridviewdragdrop',
                dragGroup: 'petsInBoxGridDDGroup',
                dropGroup: 'activePetsGridDDGroup'},
                {ptype: 'gridviewdragdrop',
                dragGroup: 'petsInBoxGridDDGroup',
                dropGroup: 'dropPetGridDDGroup'}
            ]
        },
        store            : petsInBoxGridStore,
        columns          : columns,
        stripeRows       : true,
        title            : '箱子中的宠物',
        margins          : '0 0 0 3'
    });
    // create the destination Grid
    var dropPetBoxGrid = Ext.create('Ext.grid.Panel', {
        viewConfig: {
            plugins: [
                {ptype: 'gridviewdragdrop',
                dragGroup: 'dropPetGridDDGroup',
                dropGroup: 'activePetsGridDDGroup'},
                {ptype: 'gridviewdragdrop',
                dragGroup: 'dropPetGridDDGroup',
                dropGroup: 'petsInBoxGridDDGroup'}
            ]
        },
        store            : dropPetGridStore,
        columns          : columns,
        stripeRows       : true,
        title            : '丢弃的宠物',
        margins          : '0 0 0 3'
    });
    //Simple 'border layout' panel to house both grids
    var displayPanel = Ext.create('Ext.Panel', {
        width        : 650,
        height       : 300,
        title        : '管理宠物',
        layout       : {
            type: 'hbox',
            align: 'stretch',
            padding: 5
        },
        renderTo     : 'pet_list',
        defaults     : { flex : 1 }, //auto stretch
        items        : [activePetsGrid,petsInBoxGrid,dropPetBoxGrid]
        });
    });

        </script>
        <title>Pokémon——管理宠物</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <div id="pet_list">
            </div>
        </div>
    </body>
</html>