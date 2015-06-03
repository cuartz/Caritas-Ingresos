<%--
    Document   : Reporte de Ortografia
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
 
           
            Ext.define('Rep_Ortografia',{// create the Data Atenciones
                id:'Rep_Ortografia',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'FECHA_ALTA'},
                    {name: 'ID_DONANTE'},
                    {name: 'NOMBRE_DONANTE'},
                    {name: 'USUARIO_DONANTE'},
                    {name: 'CALLE'},
                    {name: 'COLONIA'},
                    {name: 'ENTRE_CALLES'},
                    {name: 'ID_USUARIO'}
                   
                ]
            });

            var storeRep_Ortografia = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'Rep_Ortografia',
                waitMsg:'Loading...',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=getAllReport_Ortografia2', 
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
            Ext.define('Reportes.Rep_Ortografia', {
                extend: 'Ext.window.Window',
                id:'Rep_Ortografia',
                name: 'Reportes.Rep_Ortografia',
                alias:'widget.Rep_Ortografia',                
                title: 'Reporte de Atenciones',
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
                                store: storeRep_Ortografia,
                                id:'gridAtenciones',
                                name: 'gridAtenciones',
                                columns: [
                                    {
                                        dataIndex: 'FECHA_ALTA',
                                        flex: .5,
                                        text :'Fecha Alta'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_DONANTE',
                                        flex: .2,
                                        text :'Id Donante'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .8,
                                        text :'Nombre Donante'
                                        
                                    }
                                    ,
                                    {
                                        dataIndex: 'USUARIO_DONANTE',
                                        flex: .4,
                                        text :'Usuario Donante'
                                    },
                                    {
                                        dataIndex: 'CALLE',
                                        flex: .6,
                                        text: 'Servicio Solicitado'
                                    },
                                    {
                                        dataIndex: 'COLONIA',
                                        flex: .6,
                                        text: 'Calle'
                                    },
                                    {
                                        dataIndex: 'ENTRE_CALLES',
                                        flex: .6,
                                        //                                        align:'center',
                                        text: 'Entre Calles'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_USUARIO',
                                        flex: .4,
                                        //                                        align:'center',
                                        text: 'Usuario Direccion'
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
                                                    storeRep_Ortografia.load();
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
                                                    storeRep_Ortografia.load();
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
                                                    storeRep_Ortografia.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=1&fechaini="+parametersAT.fechaini+ "&fechafin="+parametersAT.fechafin+"&usuario="+parametersAT.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('Rep_Ortografia');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 50,
                                    store: storeRep_Ortografia,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.Rep_Ortografia.superclass.initComponent.apply(this, arguments);
                    storeRep_Ortografia.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>