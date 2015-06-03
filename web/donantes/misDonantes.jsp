<%--
    Document   : Mis Donantes
    Created on : 15/06/2012, 14:14:12 pm
    Author     : Ozamora
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%//Obtenemos los datos de la cita programanda
           /*
     * HttpSession sesion = request.getSession(); Person infoUser = (Person)
     * sesion.getAttribute("infoSesion"); if (infoUser == null) { infoUser = new
     * Person();
    }
     */
%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
   
            
            Ext.define('misDonantes',{
                id:'misDonantes',
                extend: 'Ext.data.Model',
                fields: ['CANTIDAD_REGISTROS',
                    {name: 'USUARIO'},
                    {name: 'NOMBRE'},                  
                ]
            });


            // create the Data Store
            var storemisDonantes = Ext.create('Ext.data.JsonStore', {
                model: 'misDonantes',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'donanteAC.do?method=getAllmisDonantes', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'//Paginacion
                    }
                }
//                ,
//                listeners:{
//                    beforeload:function(store,operation,option){
////                        store.proxy.extraParams = {fechaini:parameterstotRegistro.fechaini,fechafin:parameterstotRegistro.fechafin};
//                        store.proxy.extraParams = {fechaini:parametersTR.fechaini,fechafin:parametersTR.fechafin};
//                
//                    }
//                }
            });   
            
            //*****editable de grid*****
            //    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
            //                clicksToMoveEditor: 1,
            //                autoCancel: false
            //            });
            //            
            //            

            //**********Parametros para obtener informacion en el grid**********
//            var parametersTR = new Ext.form.field.Hidden({               
//                fechaini :'01/11/2011',
//                fechafin : '23/02/2012',
//                usuario : '-1'
//                //usuario : 'CWILSON'
//            });
            


                     
            //Inicia
            //Creation Screen            
            Ext.define('donantes.misDonantes', {
                extend: 'Ext.window.Window',
                id:'misDonantes',
                alias:'widget.misDonantes',                
                title: 'Mis Donantes',
                width: 750,                
                height: 500,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
//                region:'center',
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'grid',
                                store: storemisDonantes,
                                id:'gridmisDonantes',
                                name: 'gridmisDonantes',
                                //                                plugins: [rowEditing],
                                columns: [
                                    {
                                        dataIndex: 'NOMBRE',
                                        flex: .3,
                                        text: 'NOMBRE'
                                    },
                                    {
                                        dataIndex: 'USUARIO',
                                        flex: .2,
                                        text: 'USUARIO'
                                    },
                                    {
                                        dataIndex: 'CANTIDAD_REGISTROS',
                                        text :'CANTIDAD REGISTROS',
                                        flex: .3
                                        //                                        align:'center'
                                        
                                    }
                                ]                        
                                ,tbar: {
                                    items: [ 
                                        Ext.create('Ext.Button', {
                                            text: 'Mostrar todo',
                                            tooltip: 'Mostrar todos mis registros',
                                            iconCls:'icon-reload',
                                            hidden:true,
                                            handler: function() {
//                                                storemisDonantes.proxy.extraParams = {query:''};
                                                storemisDonantes.proxy.extraParams = {fechaini:'',fechafin:''};
                                                storemisDonantes.load();
                                            }
                                        }),
                                        //                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'datefield',
                                            name: 'fechaini',
                                            id: 'fechaini',
                                            labelWidth: 45,
                                            fieldLabel: 'Fecha Inicial',
                                            labelWidth: 80,
                                            listeners: {
                                                select: function(field, value, option){
                                                    //storeAtenciones.proxy.extraParams = {fechaini:Ext.getCmp('fechaini').getValue()};
                                                    parametersTR.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                                    storemisDonantes.load();
                                                }
                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'datefield',
                                            name: 'fechafin',
                                            id: 'fechafin',
                                            labelWidth: 45,
                                            fieldLabel: 'Fecha Final',
                                            labelWidth: 80,
                                            listeners: {
                                                select: function(field, value, option){
                                                    // storeAtenciones.proxy.extraParams = {fechafin:Ext.getCmp('fechafin').getValue()};
                                                    parametersTR.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                                    storemisDonantes.load();
                                                }
                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        Ext.create('Ext.Button', {
                                            text: 'Exportar ',
                                            iconCls:'icon-xlsx',
                                            
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=1&fechaini="+parametersTR.fechaini+ "&fechafin="+parametersTR.fechafin);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        Ext.create('Ext.Button', {
                                            text: 'Grafica ',
                                            iconCls:'icon-grafica',
                                            
                                            handler: function() {
                                                createNewObj('Reportes.graphicTotalRegistos');    
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('totalRegistros');
                                                win.close();
                                            }   
                                        }
                                    ]
                                }
                                ,
                                //Fin de tbar continuacion de barra de paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 1000,
                                    store: storemisDonantes,
                                    displayInfo: true
                                })
                            }
                        ]
                    });
                    donantes.misDonantes.superclass.initComponent.apply(this, arguments); 
                    storemisDonantes.load();
//                    Ext.getCmp('gridRegistroPersonal').addListener('edit', uptsolicitudCheque);
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
