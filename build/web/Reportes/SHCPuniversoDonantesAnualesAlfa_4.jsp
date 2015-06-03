<%--
    Document   : universoDonantesAnualSHCP
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
              
           
            Ext.define('universoDonantesAnualesAlfaSHCP',{// create the Data Atenciones
                id:'universoDonantesAnualesAlfaSHCP',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_DONANTE'},
                    {name: 'NOMBRE_DONANTE'},
                    {name: 'RAZON_SOCIAL'},
                    {name: 'NUM_FRECUENCIA'},
                    {name: 'FECHA_COBRO'},
                    {name: 'TIPO_DONATIVO'},
                    {name: 'IMPORTE'},
                    {name: 'ID_USUARIO'},
                   
                ]
            });

            var storeuniversoDonantesAnualesAlfaSHCP = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'universoDonantesAnualesAlfaSHCP',
                waitMsg:'Loading...',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=getR_universoDonantesAnualesAlfaSHCP', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                    }
                },
                listeners:{
                    beforeload:function(store,operation,option){ 
                        store.proxy.extraParams = {fechaini:parametersuniversoDonantesAnualSHCP.fechaini,fechafin:parametersuniversoDonantesAnualSHCP.fechafin,usuario:parametersuniversoDonantesAnualSHCP.usuario};
                    }
                }
            });   
                       
            
            var parametersuniversoDonantesAnualSHCP = new Ext.form.field.Hidden({//Parametros para obtener informacion en el grid

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
            Ext.define('Reportes.SHCPuniversoDonantesAnualesAlfa_4', {
                extend: 'Ext.window.Window',
                id:'SHCPuniversoDonantesAnualesAlfa_4',
                name: 'Reportes.SHCPuniversoDonantesAnualesAlfa_4',
                alias:'widget.SHCPuniversoDonantesAnualesAlfa_4',                
                title: 'Reporte de SHCP Universo Donantes AnualesAlfa ',
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
                                store: storeuniversoDonantesAnualesAlfaSHCP,
                                id:'griduniversoDonantesAnualesAlfaSHCP',
                                name: 'griduniversoDonantesAnualesAlfaSHCP',
                                columns: [
                                    {
                                        dataIndex: 'ID_DONANTE',
                                        flex: .4,
                                        align:'center',
                                        text :'ID DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .9,
                                        text :'NOMBRE DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'RAZON_SOCIAL',
                                        flex: .4,
                                        align:'center',
                                        text :'RFC'
                                    }
                                    ,
                                    {
                                        dataIndex: 'NUM_FRECUENCIA',
                                        flex: .4,
                                        align:'center',
                                        text :'NUM FRECUENCIA'
                                    }
                                    ,
                                    {
                                        dataIndex: 'FECHA_COBRO',
                                        flex: .4,
                                        align:'center',
                                        text :'FECHA COBRO'
                                    },
                                    {
                                        dataIndex: 'ID_TIPO_DONATIVO',
                                        flex: .4,
                                        align:'center',
                                        text: 'ID_TIPO_DONATIVO'
                                    },
                                    {
                                        dataIndex: 'IMPORTE',
                                        flex: .4,
                                        align:'center',
                                        renderer:render_moneyRPP,
                                        text: 'IMPORTE'
                                    },
                                    {
                                        dataIndex: 'ID_USUARIO',
                                        flex: .4,
                                        align:'center',
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
                                                    parametersuniversoDonantesAnualSHCP.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                                    storeuniversoDonantesAnualesAlfaSHCP.load();
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
                                                    parametersuniversoDonantesAnualSHCP.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                                    storeuniversoDonantesAnualesAlfaSHCP.load();
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
                                                    parametersuniversoDonantesAnualSHCP.usuario= record[0].get("ID");
                                                    storeuniversoDonantesAnualesAlfaSHCP.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=7&fechaini="+parametersuniversoDonantesAnualSHCP.fechaini+ "&fechafin="+parametersuniversoDonantesAnualSHCP.fechafin+"&usuario="+parametersuniversoDonantesAnualSHCP.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('SHCPuniversoDonantesAnualesAlfa_4');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 50,
                                    store: storeuniversoDonantesAnualesAlfaSHCP,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.SHCPuniversoDonantesAnualesAlfa_4.superclass.initComponent.apply(this, arguments);
                    storeuniversoDonantesAnualesAlfaSHCP.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>