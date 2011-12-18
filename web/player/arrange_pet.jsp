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
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
        <jsp:include flush="true" page="../chat.jsp"></jsp:include>
        <jsp:include flush="true" page="nav.jsp"></jsp:include>
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

            var activePetsGridStore;
            var petsInBoxGridStore;;
            var dropPetGridStore;

            Ext.onReady(function() {
                Ext.QuickTips.init();

            var activePets = [
<%
    boolean first = true;
    for (int i = 0;i < activePets.size();++i) {
        if (activePets.elementAt(i) == null)
            continue;
 %>
            <%= first ? "" : "," %>{<%= "pid: '" + activePets.elementAt(i).getPetid() + "'" %>, <%= "name: '" + activePets.elementAt(i).getName() + "'" %>, <%= "type: '" + activePets.elementAt(i).getPokemon().getName() + "'" %>, <%= "exp: '" + activePets.elementAt(i).getExp() + "/" + activePets.elementAt(i).getPokemon().getLevelup_exp() + "'" %>}
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
        activePetsGridStore = Ext.create('Ext.data.Store', {
            model: 'PetDataObject',
            data: activePets
        });
        petsInBoxGridStore = Ext.create('Ext.data.Store', {
            model: 'PetDataObject',
            data: petsInBox
        });
        dropPetGridStore = Ext.create('Ext.data.Store', {
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
            plugins:
                {ptype: 'gridviewdragdrop',
                dragGroup: 'GridDDGroup',
                dropGroup: 'GridDDGroup'}
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
            plugins:
                {ptype: 'gridviewdragdrop',
                dragGroup: 'GridDDGroup',
                dropGroup: 'GridDDGroup'}
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
            plugins:
                {ptype: 'gridviewdragdrop',
                dragGroup: 'GridDDGroup',
                dropGroup: 'GridDDGroup'}
        },
        store            : dropPetGridStore,
        columns          : columns,
        stripeRows       : true,
        title            : '丢弃的宠物',
        margins          : '0 0 0 3'
    });
    //Simple 'border layout' panel to house both grids
    var displayPanel = Ext.create('Ext.Panel', {
        height       : 300,
        title        : '管理宠物',
        layout       : {
            type: 'hbox',
            align: 'stretch',
            padding: 5
        },
        defaults     : { flex : 1 }, //auto stretch
        items        : [activePetsGrid,petsInBoxGrid,dropPetBoxGrid]
        });

            displayPanel.addDocked({
                    id: "docked",
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: {text: "确定", handler: confirm}
                });
        
        
                Ext.create('Ext.Viewport', {
                    layout: {
                        type: 'border',
                        padding: 5
                    },
                    defaults: {
                        split: true
                    },
                    items: [{
                        region: 'north',
                        animCollapse: true,
                        collapsible: true,
                        items: createNavMenu()
                    },{
                        region: 'center',
                        layout: {
                            type: 'border',
                            padding: 5
                        },
                        border: false,
                        items: [
                            {
                                region: 'center',
                                items: displayPanel
                            },
                            {
                                region: 'east',
                                minWidth : 200,
                                width : 200,
                                split: true,
                                animCollapse: true,
                                collapsible: true,
                                items : [createChatWidget()]
                            }
                        ]
                    }]});

    function confirm() {
        var formStr = "<form id='DoArrangePetForm' name='DoArrangePetForm' action='../do_arrange_pet.do' method='post'>";
        var currentArray = activePetsGridStore.data.items;
        if (currentArray.length == 0) {
             Ext.Msg.alert("出错啦", "不随身携带任何宠物是不被允许的");
             return;
        }
        if (currentArray.length > <%= PetsOfAUser.MAX_ACTIVE_PET_COUNT %>) {
             Ext.Msg.alert("出错啦", "随身携带超过" + <%= PetsOfAUser.MAX_ACTIVE_PET_COUNT %> + "个宠物是不被允许的");
             return;
        }
        for (i = 0; i < currentArray.length;++i) {
            formStr = formStr + "<input type='text' name='active' value='" + currentArray[i].data.pid + "'/>";
        }
        currentArray = petsInBoxGridStore.data.items;
        for (i = 0; i < currentArray.length;++i) {
            formStr = formStr + "<input type='text' name='box' value='" + currentArray[i].data.pid + "'/>";
        }
        currentArray = dropPetGridStore.data.items;
        if (currentArray.length > 0) {
            Ext.Msg.confirm("请注意", "检测到有要丢弃的宠物，丢弃宠物时请慎重，一旦丢弃，不可找回。确认这样管理宠物？", function(btn, text){
                if (btn == 'yes') {
                    for (i = 0; i < currentArray.length;++i) {
                        formStr = formStr + "<input type='text' name='drop' value='" + currentArray[i].data.pid + "'/>";
                    }
                    formStr = formStr + "</form>";
                    document.getElementById("hiddenDiv").innerHTML = formStr;
                    document.forms["ArrangePetForm"].submit();
                }
            });
        } else {
            for (i = 0; i < currentArray.length;++i) {
                formStr = formStr + "<input type='text' name='drop' value='" + currentArray[i].data.pid + "'/>";
            }
            formStr = formStr + "</form>";
            document.getElementById("hiddenDiv").innerHTML = formStr;
            document.forms["DoArrangePetForm"].submit();
        }
    }

    });

        </script>
        <title>Pokémon——管理宠物</title>
    </head>

    <body>
        <div id="hiddenDiv" style="display:none">
        </div>
    </body>
</html>