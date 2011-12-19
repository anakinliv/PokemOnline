<%-- 
    Document   : adventure
    Created on : 2011-12-10, 20:51:22
    Author     : Sidney
--%>
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
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../js/ext/resources/css/ext-all.css" />
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
	<script type="text/javascript" src="../js/wz_jsgraphics.js"></script>
	<script type="text/javascript" src="../js/cvi_map_lib.js"></script>
        <jsp:include flush="true" page="../chat.jsp"></jsp:include>
        <jsp:include flush="true" page="nav.jsp"></jsp:include>
        <script type="text/javascript">
        <!--
        function ById(v) {return(document.getElementById(v));}
        function setClassTo(id) {var ele=ById('l'+id); ele.className="al";}
        function resetClass(id) {var ele=ById('l'+id); ele.className="lk";}
        function setup(opts) {
                if(isIE) {this.blur(); }//IE specific
                var adventure_map = ById('adventure_map');
                if (opts.mapid != "map1")
                    cvi_map.modify(adventure_map,opts);
                else
                    cvi_map.modify(adventure_map,{imgsrc:'',mapid:''});
                return false;
        }
        -->
        </script>
        <script type="text/javascript">
            Ext.onReady(function() {
                // Define the model for a State
                Ext.regModel('Map', {
                    fields: [
                        {type: 'int', name: 'id'},
                        {type: 'string', name: 'name'}
//                        ,
//                        {type: 'string', name: 'description'}
                    ]
                });

                data = [{id : 1, name : "芳缘地区"},
                        {id : 2, name : "关东地区"},
                        {id : 3, name : "神奥地区"}];

                // The data store holding the states
                var store = Ext.create('Ext.data.Store', {
                    model: 'Map',
                    data: data
                });

                // Simple ComboBox using the data store
                var mapCombo = Ext.create('Ext.form.field.ComboBox', {
                    fieldLabel: '选择地图',
                    displayField: 'name',
                    store: store,
                    queryMode: 'local',
                    forceSelection: true,
                    listConfig: {
                        getInnerTpl: function() {
                            return '<div data-qtip="<b>{name}</b>">{name}</div>';
                        }
                    },
                    listeners: {
                        select: function(combo, records, eOpts) {
                            setup({imgsrc: '../image/map'+records[0].data.id+'.gif', mapid: 'map'+records[0].data.id});
                            return false;
                        }
                    }
                });

                var displayPanel = Ext.create('Ext.Panel', {
                    tbar:mapCombo,
                    html: "<img id=\"adventure_map\" src=\"../image/map1.gif\" usemap=\"#map1\" />"
                });

                Ext.create('Ext.Viewport', {
                    layout: {
                        type: 'border',
                        padding: 5
                    },
                    items: [createNavMenu(),{
                        region: 'center',
                        layout: {
                            type: 'border',
                            padding: 5
                        },
                        border: false,
                        items: [
                            {
                                region: 'center',
                                layout: 'fit',
                                items: displayPanel
                            },createChatWidget()
                        ]
                    }]
                });
                
                cvi_map.add(ById('adventure_map'),{opacity: 50, areacolor: '#00ff00', bordercolor: '#009900' });
            });
        </script>
        <title>Pokémon——冒险</title>
        <body>
<map id="map1" name="map1">
<area id="1" href="#" data-qtip="1" data-qtip="1" shape="rect" coords="74, 175, 125, 219" alt="迷失森林" onclick="alert(1)"/>
<area id="2" href="#" data-qtip="2" shape="circle" coords="121, 135, 34" alt="红岩谷" />
<area id="3" href="#" data-qtip="3" shape="rect" coords="83, 43, 134, 87" alt="狂沙镇" />
<area id="4" href="#" data-qtip="4" shape="circle" coords="161, 70, 25" alt="炽热火山" />
<area id="5" href="#" data-qtip="5" shape="circle" coords="220, 78, 37" alt="无人沙漠" />
<area id="6" href="#" data-qtip="6" shape="circle" coords="360, 142, 33" alt="幽灵岛" />
<area id="7" href="#" data-qtip="7" shape="circle" coords="461, 198, 32" alt="水上都市" />
<area id="8" href="#" data-qtip="8" shape="circle" coords="528, 143, 33" alt="战斗基地" />
<area id="9" href="#" data-qtip="9" shape="rect" coords="543, 180, 630, 286" alt="无人小岛" />
<area id="10" href="#" data-qtip="10" shape="rect" coords="34, 313, 147, 357" alt="南方幻影岛" />
</map>
<map id="map2" name="map2">
<area id="11" href="#" data-qtip="11" shape="rect" coords="119, 187, 234, 288" alt="幽暗森林" />
<area id="12" href="#" data-qtip="12" shape="rect" coords="290, 179, 375, 256" alt="研究所" />
<area id="13" href="#" data-qtip="13" shape="rect" coords="139, 103, 229, 168" alt="狂沙镇" />
<area id="14" href="#" data-qtip="14" shape="circle" coords="649, 123, 35" alt="炽热火山" />
<area id="15" href="#" data-qtip="15" shape="circle" coords="569, 396, 37" alt="无人沙漠" />
<area id="16" href="#" data-qtip="16" shape="circle" coords="314, 562, 14" alt="幽灵岛" />
<area id="17" href="#" data-qtip="17" shape="circle" coords="207, 552, 43" alt="水上都市" />
<area id="18" href="#" data-qtip="18" shape="rect" coords="430, 170, 537, 264" alt="战斗基地" />
<area id="19" href="#" data-qtip="19" shape="circle" coords="339, 563, 14" alt="无人小岛" />
<area id="20" href="#" data-qtip="20" shape="rect" coords="446, 297, 532, 370" alt="游艇码头" />
</map>
<map id="map3" name="map3">
<area id="21" href="#" alt="风花之城" shape="rect" coords="143, 378, 209, 441" />
<area id="22" href="#" alt="格斗之镇" shape="rect" coords="256, 209, 340, 278" />
<area id="23" href="#" alt="森林小湖" shape="circle" coords="89, 451, 31" />
<area id="24" href="#" alt="山谷温泉" shape="circle" coords="317, 53, 28" />
<area id="25" href="#" alt="无人荒山" shape="polygon" coords="501, 297, 524, 318, 512, 337, 571, 377, 624, 368, 616, 334, 571, 314, 535, 277" />
<area id="26" href="#" alt="幽暗森林" shape="rect" coords="443, 378, 543, 453" />
<area id="27" href="#" alt="水上都市" shape="polygon" coords="668, 262, 704, 214, 756, 253, 700, 305, 670, 292" />
<area id="28" href="#" alt="战斗之山" shape="rect" coords="505, 22, 642, 117" />
<area id="29" href="#" alt="迷茫岛" shape="polygon" coords="131, 226, 187, 179, 209, 213, 147, 250" />
<area id="30" href="#" alt="幻境海宾" shape="rect" coords="679, 373, 773, 446" />
</map>
        </body>
    </head>
</html>