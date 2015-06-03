<%--
    Document   : Total Registros Donantes
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
                
                
          
    
            Ext.define('Rep_MYS_RECIBOS_IMPRESOSMES',{// create the Data totalReg
                id:'Rep_MYS_RECIBOS_IMPRESOSMES',
                extend: 'Ext.data.Model',
                fields: [
                    {name: 'FECHA_IMPRESION'},
                    {name: 'NOMBRE_DONANTE'},
                    {name: 'ID_TIPO_DIRECCION'},
                    {name: 'CALLE'},                  
                    {name: 'NUMERO'},                  
                    {name: 'COLONIA'},                  
                    {name: 'ID_MUNICIPIO'},                  
                    {name: 'TEL_CASA'},                  
                    {name: 'ESTATUS_PAGO_TMP'},                  
                    {name: 'ID_FORMA_PAGO'},                  
                    {name: 'ID_CAMPANA_FINANCIERA'},                  
                    {name: 'ID_CATEGORIA'},                  
                    {name: 'ID_ASIGNACION'},                  
                    {name: 'ID_ZONA'},                  
                    {name: 'ID_RECOLECTOR'}                
                                      
                ]
            });

            var storeRep_MYS_RECIBOS_IMPRESOSMES = Ext.create('Ext.data.JsonStore', {// create the Store totalReg
                model: 'Rep_MYS_RECIBOS_IMPRESOSMES',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=report_Rep_MYS_RECIBOS_IMPRESOSMES', 
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
            Ext.define('Reportes.Rep_MYS_RECIBOS_IMPRESOSMES_1', {
                extend: 'Ext.window.Window',
                id:'Rep_MYS_RECIBOS_IMPRESOSMES_1',
                alias:'widget.Rep_MYS_RECIBOS_IMPRESOSMES_1',                
                title: 'Listado de Recibos Cobrados por Mes',
                width: 1300,                
                height: 650,
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
                                store: storeRep_MYS_RECIBOS_IMPRESOSMES,
                                id:'gridRep_MYS_RECIBOS_IMPRESOSMES',
                                name: 'gridRep_MYS_RECIBOS_IMPRESOSMES',
                                //                              plugins: summary,
                                columns: [
                                    {
                                        dataIndex: 'FECHA_IMPRESION',
                                        flex: .1,
                                        text: 'FECHA_IMPRESION'
                                    },
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .3,
                                        text: 'NOMBRE_DONANTE'
                                    },
                                    {
                                        dataIndex: 'ID_TIPO_DIRECCION',
                                        flex: .1,
                                        text: 'ID_TIPO_DIRECCION'
                                    }
                                    , 
                                    {
                                        dataIndex: 'CALLE',
                                        text :'CALLE',
                                        align:'center',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'NUMERO',
                                        text :'NUMERO',
                                        align:'center',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'COLONIA',
                                        text :'COLONIA',
                                        align:'center',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_MUNICIPIO',
                                        text :'ID_MUNICIPIO',
                                        align:'center',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'TEL_CASA',
                                        text :'TEL_CASA',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ESTATUS_PAGO_TMP',
                                        text :'ESTATUS_PAGO_TMP',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_FORMA_PAGO',
                                        text :'ID_FORMA_PAGO',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_CAMPANA_FINANCIERA',
                                        text :'ID_CAMPANA_FINANCIERA',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_CATEGORIA',
                                        text :'ID_CATEGORIA',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_ASIGNACION',
                                        text :'ID_ASIGNACION',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_ZONA',
                                        text :'ID_ZONA',
                                        flex: .1
                                    }  
                                    , 
                                    {
                                        dataIndex: 'ID_RECOLECTOR',
                                        text :'ID_RECOLECTOR',
                                        flex: .1
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
                                                storeRep_MYS_RECIBOS_IMPRESOSMES.proxy.extraParams = {fechaini:'',fechafin:''};
                                                storeRep_MYS_RECIBOS_IMPRESOSMES.load();
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
                                                    storeRep_MYS_RECIBOS_IMPRESOSMES.load();
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
                                                    storeRep_MYS_RECIBOS_IMPRESOSMES.load();
                                                }
                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        Ext.create('Ext.Button', {
                                            text: 'Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=91&fechaini="+parametersTR.fechaini+ "&fechafin="+parametersTR.fechafin);
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
                                                var win=Ext.getCmp('Rep_MYS_RECIBOS_IMPRESOSMES_1');
                                                win.close();
                                            }   
                                        }
                                    ]
                                }
                                ,
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 1000,
                                    store: storeRep_MYS_RECIBOS_IMPRESOSMES,
                                    displayInfo: true
                                })
                            }
                        ]
                    });
                    Reportes.Rep_MYS_RECIBOS_IMPRESOSMES_1.superclass.initComponent.apply(this, arguments); 
                    storeRep_MYS_RECIBOS_IMPRESOSMES.load();
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
