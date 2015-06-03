<%--
    Document   : Reporte de Aportaciones Anuales SHCP
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
 
           
            
            function render_moneyRPP(v, p, record){
                return '$ '+v
            }
            
            function render_statusRLC(v, p, record){
                if(v=="0"){
                    return "<img src='img/class/edit-doc.png'";
                }  else if(v=="1"){
                    return "<img src='img/status-1.png'";
                } else if(v=="2"){
                    return "<img src='img/class/new-doc.png'>";                    
                } else {
                    return "";
                }
            }  
              
           
            Ext.define('aportacionesAnuales',{// create the Data Atenciones
                id:'aportacionesAnuales',
                extend: 'Ext.data.Model',
                fields:     [
                     {name: 'ID_DONANTE'},
                    {name: 'ID_TITULO'},
                    {name: 'NOMBRE_DONANTE'},
                    {name: 'CALLE'},
                    {name: 'NUMERO'},
                    {name: 'COLONIA'},
                    {name: 'MUNICIPIO'},
                    {name: 'TEL_CASA'},
                    {name: 'TEL_OFICINA'},
                    {name: 'TEL_MOVIL'},
                    {name: 'EMAIL'},
                    {name: 'ID_TIPO_DONATIVO'},
                    {name: 'ID_CAMPANA_FINANCIERA'},
                    {name: 'ID_USUARIO'}
                   
                   
                ]
            });

            var storeOPE_reProspectar = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'aportacionesAnuales',
                waitMsg:'Loading...',
                pageSize: 200,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=report_OPE_reProspectar', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                    }
                },
                listeners:{
                    beforeload:function(store,operation,option){ 
                        store.proxy.extraParams = {fechaini:parametersApoAnuaSHCP.fechaini,fechafin:parametersApoAnuaSHCP.fechafin,usuario:parametersApoAnuaSHCP.usuario};
                    }
                }
            });   
                       
            
            var parametersApoAnuaSHCP = new Ext.form.field.Hidden({//Parametros para obtener informacion en el grid

                fechaini :'15/08/2012',
                fechafin : '31/12/2012' ,
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
            Ext.define('Reportes.OPE_reProspectar_5', {
                extend: 'Ext.window.Window',
                id:'OPE_reProspectar_5',
                name: 'Reportes.OPE_reProspectar_5',
                alias:'widget.OPE_reProspectar_5',                
                title: 'Reporte de OPE Donantes o Bienechores',
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
                                store: storeOPE_reProspectar,
                                id:'gridOPE_reProspectar',
                                name: 'gridOPE_reProspectar',
                                columns: [
                                    {
                                        dataIndex: 'ID_DONANTE',
                                        flex: .5,
                                        text :'ID_DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_TITULO',
                                        flex: .2,
                                        text :'ID_TITULO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .8,
                                        text :'NOMBRE_DONANTE'
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
                                        dataIndex: 'MUNICIPIO',
                                        flex: .6,
                                        text: 'MUNICIPIO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'TEL_CASA',
                                        flex: .6,
                                        text: 'TEL_CASA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'TEL_OFICINA',
                                        flex: .6,
                                        text: 'TEL_OFICINA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'TEL_MOVIL',
                                        flex: .6,
                                        text: 'TEL_MOVIL'
                                    }
                                    ,
                                    {
                                        dataIndex: 'EMAIL',
                                        flex: .6,
                                        text: 'EMAIL'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_TIPO_DONATIVO',
                                        flex: .6,
                                        text: 'ID_TIPO_DONATIVO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_USUARIO',
                                        flex: .6,
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
                                                    parametersApoAnuaSHCP.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                                    storeOPE_reProspectar.load();
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
                                                    parametersApoAnuaSHCP.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                                    storeOPE_reProspectar.load();
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
                                                    parametersApoAnuaSHCP.usuario= record[0].get("ID");
                                                    storeOPE_reProspectar.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=1&fechaini="+parametersApoAnuaSHCP.fechaini+ "&fechafin="+parametersApoAnuaSHCP.fechafin+"&usuario="+parametersApoAnuaSHCP.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('OPE_reProspectar_5');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 200,
                                    store: storeOPE_reProspectar,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.OPE_reProspectar_5.superclass.initComponent.apply(this, arguments);
                    storeOPE_reProspectar.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>