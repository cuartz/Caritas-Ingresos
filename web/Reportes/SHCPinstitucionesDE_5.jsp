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
              
           
            Ext.define('SHCPinstitucionesDE',{// create the Data Atenciones
                id:'SHCPinstitucionesDE',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_RECIBO'},
                    {name: 'ID_DONANTE'},
                    {name: 'NOMBRE_DONANTE'},
                    {name: 'FECHA_IMPRESION'},
                    {name: 'FECHA_COBRO'},
                    {name: 'RAZON_SOCIAL'},
                    {name: 'TIPO_DONATIVO'},
                    {name: 'TIPO_INSTITUCION'},
                    {name: 'IMPORTE'},
                   
                ]
            });

            var storeSHCPinstitucionesDE = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'SHCPinstitucionesDE',
                waitMsg:'Loading...',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=getR_institucionesDESHCP', 
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
            Ext.define('Reportes.SHCPinstitucionesDE_5', {
                extend: 'Ext.window.Window',
                id:'SHCPinstitucionesDE_5',
                name: 'Reportes.SHCPinstitucionesDE_5',
                alias:'widget.SHCPinstitucionesDE_5',                
                title: 'Reporte de SHCP Instituciones durante el Ejercicio',
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
                                store: storeSHCPinstitucionesDE,
                                id:'gridSHCPinstitucionesDE',
                                name: 'gridSHCPinstitucionesDE',
                                columns: [
                                    {
                                        dataIndex: 'ID_RECIBO',
                                        flex: .4,
                                        align:'center',
                                        text :'ID_RECIBO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_DONANTE',
                                        flex: .4,
                                        align:'center',
                                        text :'ID_DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .9,
                                        text :'NOMBRE_DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'FECHA_IMPRESION',
                                        flex: .4,
                                        align:'center',
                                        text :'FECHA_IMPRESION'
                                    }
                                    ,
                                    {
                                        dataIndex: 'FECHA_COBRO',
                                        flex: .4,
                                        align:'center',
                                        text: 'FECHA_COBRO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'RAZON_SOCIAL',
                                        flex: .4,
                                        align:'center',
                                        text: 'RAZON_SOCIAL'
                                    }
                                    ,
                                    {
                                        dataIndex: 'TIPO_DONATIVO',
                                        flex: .4,
                                        align:'center',
                                        text: 'TIPO_INSTITUCION'
                                    }
                                    ,
                                    {
                                        dataIndex: 'TIPO_INSTITUCION',
                                        flex: .4,
                                        align:'center',
                                        text: 'TIPO_INSTITUCION'
                                    }
                                    ,
                                    {
                                        dataIndex: 'IMPORTE',
                                        flex: .4,
//                                        renderer:render_moneyRPP,
                                        align:'center',
                                        text: 'IMPORTE'
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
                                                    storeSHCPinstitucionesDE.load();
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
                                                    storeSHCPinstitucionesDE.load();
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
                                                    storeSHCPinstitucionesDE.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=8&fechaini="+parametersApoAnuaSHCP.fechaini+ "&fechafin="+parametersApoAnuaSHCP.fechafin+"&usuario="+parametersApoAnuaSHCP.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('SHCPinstitucionesDE_5');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 50,
                                    store: storeSHCPinstitucionesDE,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.SHCPinstitucionesDE_5.superclass.initComponent.apply(this, arguments);
                    storeSHCPinstitucionesDE.load();//en blanco comentar esta linea
                }
             });
        </script>
    </head>
    <body>
    </body>
</html>