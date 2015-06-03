<%--
    Document   : R_totalRegistrosBitacora
    Created on : 25/11/2011, 14:14:12 pm
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
     * Person(); }
     */
%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
   
            
            
            // utilize custom extension for Group Summary
                //                var summary = new Ext.ux.grid.GroupSummary();
//                var summary = new Ext.ux.grid.GridSummary();
                
                
          
    
            Ext.define('R_totalRegistrosBitacora',{// create the Data totalReg
                id:'R_totalRegistrosBitacora',
                extend: 'Ext.data.Model',
                fields: [
                    //                    'CANTIDAD_REGISTROS',
                    {name: 'CANTIDAD_BITACORAS', type: 'float'},
                    {name: 'USUARIO'},
                    {name: 'NOMBRE'},                  
                ]
            });

            var storeR_totalRegistrosBitacora = Ext.create('Ext.data.JsonStore', {// create the Store totalReg
                model: 'R_totalRegistrosBitacora',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=getAllR_totalRegistrosBitacora', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                    }
                }
                ,
                listeners:{
                    beforeload:function(store,operation,option){
                        store.proxy.extraParams = {fechaini:parametersTR.fechaini,fechafin:parametersTR.fechafin};
                    }
                }
            });   
            
           
            var parametersTR = new Ext.form.field.Hidden({//Parametros para obtener informacion en el grid                   
                fechaini :'01/08/2012',
                fechafin : '31/12/2012',
                usuario : '-1'
            });
            
            //Inicia
            Ext.define('Reportes.R_totalRegistrosBitacora', {
                extend: 'Ext.window.Window',
                id:'R_totalRegistrosBitacora',
                alias:'widget.R_totalRegistrosBitacora',                
                title: 'Registros por Conteo de Bitacoras por Usuario',
                width: 900,                
                height: 550,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction:'destroy',
                region:'center',
                initComponent: function() {
                    var showSummary = true;
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'grid',
                                store: storeR_totalRegistrosBitacora,
                                id:'gridR_totalRegistrosBitacora',
                                name: 'gridR_totalRegistrosBitacora',
//                              plugins: summary,
                                columns: [
                                    {
                                        dataIndex: 'NOMBRE',
                                        flex: .3,
                                        text: 'NOMBRE'
                                    },
                                    {
                                        dataIndex: 'USUARIO',
                                        flex: .1,
                                        text: 'USUARIO'
                                    },
                                    {
                                        dataIndex: 'CANTIDAD_BITACORAS',
                                        text :'CANTIDAD BITACORAS',
                                        align:'center',
                                        flex: .1
//                                        summaryType: 'sum'
                                        
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
                                                //                                                store.proxy.extraParams = {query:''};
                                                storeR_totalRegistrosBitacora.proxy.extraParams = {fechaini:'',fechafin:''};
                                                storeR_totalRegistrosBitacora.load();
                                            }
                                        }),
                                        {
                                            xtype: 'datefield',
                                            name: 'fechaini',
                                            id: 'fechaini',
                                            labelWidth: 45,
                                            fieldLabel: 'Fecha Inicial',
                                            labelWidth: 80,
                                            listeners: {
                                                select: function(field, value, option){
                                                    parametersTR.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                                    storeR_totalRegistrosBitacora.load();
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
                                                    parametersTR.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                                    storeR_totalRegistrosBitacora.load();
                                                }
                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        Ext.create('Ext.Button', {
                                            text: 'Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=3&fechaini="+parametersTR.fechaini+ "&fechafin="+parametersTR.fechafin);
//                                                window.open("ShowExcel?idOperationType=0&fechaini="+parametersTR.fechaini+ "&fechafin="+parametersTR.fechafin);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('R_totalRegistrosBitacora');
                                                win.close();
                                            }   
                                        }
                                    ]
                                }
                                ,
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 1000,
                                    store: storeR_totalRegistrosBitacora,
                                    displayInfo: true
                                })
                            }
                        ]
                    });
                    Reportes.R_totalRegistrosBitacora.superclass.initComponent.apply(this, arguments); 
                    storeR_totalRegistrosBitacora.load();
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
