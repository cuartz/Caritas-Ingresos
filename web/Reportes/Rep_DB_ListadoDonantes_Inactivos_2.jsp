<%--
    Document   : Rep_DB_ListadoDonantes_Activos
    Created on : 26/11/2011, 19:59:12 pm
    Author     : JZAMORA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%//Obtenemos los datos de la cita programanda

%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript"> 
 
           
            Ext.define('TES_concentradocobranza',{// create the Data Atenciones
                id:'TES_concentradocobranza',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ESTATUS_PAGO_TMP'},
                    {name: 'TIPO_FRECUENCIA'},
                    {name: 'TIPO_DONATIVO'},
                    {name: 'FORMA_PAGO'},
                    {name: 'CAMPANA_FINANCIERA'},
                    {name: 'ASIGNACION'},
                    {name: 'ID_USUARIO'},
                    
                   
                ]
            });

            var storeRep_DB_ListadoDonantes_Inactivos = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'TES_concentradocobranza',
                waitMsg:'Loading...',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=report_Rep_DB_ListadoDonantes_Activos', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                    }
                },
                listeners:{
                    beforeload:function(store,operation,option){ 
                        store.proxy.extraParams = {fechaini:parametersAT.fechaini,fechafin:parametersAT.fechafin,usuario:parametersAT.usuario};
                    }
                }
            });   
                       
            
            var parametersAT = new Ext.form.field.Hidden({//Parametros para obtener informacion en el grid

                fechaini :'15/08/2012',
                fechafin : '31/08/2012' ,
                usuario : '-1'
                //usuario : 'CWILSON'
            });
            
            
            
           
               
            Ext.define('Usuarios',{// create the Data cbUsuarios
                id:'Usuarios',
                extend: 'Ext.data.Model',
                fields:['NOMBRE', 'ID']
            });

            var storeUsuario = Ext.create('Ext.data.JsonStore', {// create the Store cbUsuarios
                model: 'Usuarios',
                pageSize: 50,
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getAllUsuarios', 
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });         
            
            //Inicia
            Ext.define('Reportes.Rep_DB_ListadoDonantes_Inactivos_2', {
                extend: 'Ext.window.Window',
                id:'Rep_DB_ListadoDonantes_Activos',
                name: 'Reportes.Rep_DB_ListadoDonantes_Inactivos_2',
                alias:'widget.Rep_DB_ListadoDonantes_Inactivos_2',                
                title: 'Reporte Listado de Donantes Inactivos',
                width: 1150,                
                height: 600,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',    
                region:'center',
                closeAction:'destroy',
                autoScroll:true,//modificacion
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'grid',
                                store: storeRep_DB_ListadoDonantes_Inactivos,
                                id:'gridRep_DB_ListadoDonantes_Inactivos',
                                name:'gridRep_DB_ListadoDonantes_Inactivos',
                                columns: [
                                    {
                                        dataIndex: 'ESTATUS_PAGO_TMP',
                                        flex: .5,
                                        text :'ESTATUS PAGO TMP'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'TIPO_FRECUENCIA',
                                        flex: .4,
                                        text :'TIPO FRECUENCIA'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'TIPO_DONATIVO',
                                        flex: .4,
                                        text :'TIPO DONATIVO'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'FORMA_PAGO',
                                        flex: .4,
                                        text :'FORMA PAGO'
                                    },
                                    {
                                        dataIndex: 'CAMPANA_FINANCIERA',
                                        flex: .6,
                                        text: 'CAMPANA FINANCIERA'
                                    },
                                    {
                                        dataIndex: 'ASIGNACION',
                                        flex: .4,
                                        text: 'ASIGNACION'
                                    },
                                    {
                                        dataIndex: 'ID_USUARIO',
                                        flex: .6,
                                        //                                        align:'center',
                                        text: 'USUARIO'
                                    }
                                ]                        
                                ,
                               
                                tbar: {
                                    xtype: 'toolbar',
                                    items: [
                                        {
                                            xtype: 'datefield',
                                            name: 'fechaini',
                                            id: 'fechaini',
                                            labelWidth: 45,
                                            fieldLabel: 'Fecha Inicial',
                                            labelWidth: 80,
                                            listeners: {
                                                select: function(field, value, option){
                                                    parametersAT.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                                    storeRep_DB_ListadoDonantes_Inactivos.load();
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
                                                    parametersAT.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                                    storeRep_DB_ListadoDonantes_Inactivos.load();
                                                }
                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'combo',
                                            name: 'UsuarioAT',
                                            id: 'UsuarioAT',
                                            fieldLabel: 'Usuario',
                                            labelWidth: 45,
                                            store: storeUsuario,
                                            anchor: '60%',
                                            editable: false,
                                            valueField: 'NOMBRE',
                                            allowBlank:false,
                                            displayField:'ID',
                                            triggerAction: 'all',
                                            defaultValue:'Mexico',
                                            tabIndex: 13,
                                            listeners:{
                                                select:function(combo,record,opcion)
                                                {
                                                    parametersAT.usuario= record[0].get("ID");
                                                    storeRep_DB_ListadoDonantes_Inactivos.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=902&fechaini="+parametersAT.fechaini+ "&fechafin="+parametersAT.fechafin+"&usuario="+parametersAT.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('TES_concentradocobranza_2');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 50,
                                    store: storeRep_DB_ListadoDonantes_Inactivos,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.Rep_DB_ListadoDonantes_Inactivos_2.superclass.initComponent.apply(this, arguments);
                    storeRep_DB_ListadoDonantes_Inactivos.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>