<%--
    Document   : Rep_MYS_RECIBOS_COBRADOS_POR_COBRAR_3
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
 
           
            Ext.define('Rep_MYS_RECIBOS_POR_COBRAR',{// create the Data Atenciones
                id:'Rep_MYS_RECIBOS_POR_COBRAR',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'FECHA_COBRO'},
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
                    {name: 'ID_RECOLECTOR'},
                    {name: 'ID_USUARIO'}
                   
                ]
            });

            var storeRep_MYS_RECIBOS_COBRADOS = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'Rep_MYS_RECIBOS_POR_COBRAR',
                waitMsg:'Loading...',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=report_Rep_MYS_RECIBOS_COBRADOS', 
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
            Ext.define('Reportes.Rep_MYS_RECIBOS_POR_COBRAR_3', {
                extend: 'Ext.window.Window',
                id:'Rep_MYS_RECIBOS_POR_COBRAR_3',
                name: 'Reportes.Rep_MYS_RECIBOS_POR_COBRAR_3',
                alias:'widget.Rep_MYS_RECIBOS_POR_COBRAR_3',                
                title: 'Listado de Recibos por Cobrar',
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
                                store: storeRep_MYS_RECIBOS_COBRADOS,
                                id:'gridRep_MYS_RECIBOS_COBRADOS',
                                name: 'gridRep_MYS_RECIBOS_COBRADOS',
                                columns: [
                                    {
                                        dataIndex: 'FECHA_COBRO',
                                        flex: .5,
                                        text :'FECHA_COBRO'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .2,
                                        text :'NOMBRE_DONANTE'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_TIPO_DIRECCION',
                                        flex: .8,
                                        text :'ID_TIPO_DIRECCION'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'CALLE',
                                        flex: .4,
                                        text :'CALLE'
                                    },
                                    {
                                        dataIndex: 'NUMERO',
                                        flex: .6,
                                        text: 'NUMERO'
                                    },
                                    {
                                        dataIndex: 'COLONIA',
                                        flex: .6,
                                        text: 'COLONIA'
                                    },
                                    {
                                        dataIndex: 'ID_MUNICIPIO',
                                        flex: .6,
                                        //                                        align:'center',
                                        text: 'ID_MUNICIPIO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'TEL_CASA',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'TEL_CASA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ESTATUS_PAGO_TMP',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ESTATUS_PAGO_TMP'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_FORMA_PAGO',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_FORMA_PAGO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_CAMPANA_FINANCIERA',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_CAMPANA_FINANCIERA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_CATEGORIA',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_CATEGORIA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_ASIGNACION',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_ASIGNACION'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_ZONA',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_ZONA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_RECOLECTOR',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_RECOLECTOR'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_USUARIO',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'ID_USUARIO'
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
                                                    storeRep_MYS_RECIBOS_COBRADOS.load();
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
                                                    storeRep_MYS_RECIBOS_COBRADOS.load();
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
                                                    storeRep_MYS_RECIBOS_COBRADOS.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=93&fechaini="+parametersAT.fechaini+ "&fechafin="+parametersAT.fechafin+"&usuario="+parametersAT.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('Rep_MYS_RECIBOS_POR_COBRAR_3');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 50,
                                    store: storeRep_MYS_RECIBOS_COBRADOS,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.Rep_MYS_RECIBOS_POR_COBRAR_3.superclass.initComponent.apply(this, arguments);
                    storeRep_MYS_RECIBOS_COBRADOS.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>