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
 
//   //combo tipos de Recolectores
////            var listaFiltros = [
////                ['1', 'Cancelación por proyecto.'],
////                ['2', 'Cancelación por asignación.']];
////
////
////            var storeCBReportListadoCobranza = Ext.create('Ext.data.SimpleStore',{
////                autoLoad: true,
////                fields: ['ID', 'NOMBRE'],
////                data: listaFiltros
////            });  
//            
//            
//            var storereporteConcentradoCobranza = Ext.create('Ext.data.JsonStore', ({
//                fields:[{name: 'fecha'},
//                    {name: 'proyecto'},
//                    {name: 'asignacion'},
//                    {name: 'cantidad_Cobrada'},
//                    {name: 'total_Recibos'}],
//                data: [
//                    {fecha:'12/Abr/2012', proyecto: '1001', asignacion:'La Asignacion', cantidad_Cobrada:'4561.23', total_Recibos:'6'}
//                ]
//            })); 
//                     
//            ////**********Datos fijos de fechaini y fechafin ,Parametros para obtener informacion en el grid**********
//            var parametersRLC = new Ext.form.field.Hidden({
//
//                fechainiRLC :'12/Abr/2012',
//                fechafinRLC : '12/Abr/2012' 
////                listado : '-1'
//                
//                //usuario : 'CWILSON'
//            });
            
            
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
                    {name: 'NOMBRE_DONANTE'},
                    {name: 'ASIGNACION'},
                    {name: 'NUM_FRECUENCIA'},
                    {name: 'IMPORTE'},
                    {name: 'ID_RECIBO'},
                    {name: 'NUM_CASO'},
                    {name: 'ID_RECIBO'},
                    {name: 'ID_USUARIO'}
                   
                ]
            });

            var storeaportacionesAnualesSHCP = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'aportacionesAnuales',
                waitMsg:'Loading...',
                pageSize: 200,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=getR_aportacionesAnualesSHCP', 
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
            Ext.define('Reportes.SHCPaportacionesAnuales_1', {
                extend: 'Ext.window.Window',
                id:'SHCPaportacionesAnuales_1',
                name: 'Reportes.SHCPaportacionesAnuales_1',
                alias:'widget.SHCPaportacionesAnuales_1',                
                title: 'Reporte de Aportaciones Anuales',
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
                                store: storeaportacionesAnualesSHCP,
                                id:'gridaportacionesAnualesSHCP',
                                name: 'gridaportacionesAnualesSHCP',
                                columns: [
                                    {
                                        dataIndex: 'ID_DONANTE',
                                        flex: .4,
                                        align:'center',
                                        text :'DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'NOMBRE_DONANTE',
                                        flex: .9,
                                        text :'NOMBRE DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ASIGNACION',
                                        flex: .4,
                                        align:'center',
                                        text :'ASIGNACION'
                                    }
                                    ,
                                    {
                                        dataIndex: 'NUM_FRECUENCIA',
                                        flex: .4,
                                        align:'center',
                                        text :'NUMERO FRECUENCIA'
                                    },
                                    {
                                        dataIndex: 'IMPORTE',
                                        flex: .4,
                                        align:'center',
                                        renderer:render_moneyRPP,
                                        text: 'IMPORTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_RECIBO',
                                        flex: .4,
                                        align:'center',
                                        text: 'RECIBO'
                                    }
                                    ,
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
                                                    parametersApoAnuaSHCP.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                                    storeaportacionesAnualesSHCP.load();
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
                                                    storeaportacionesAnualesSHCP.load();
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
                                                    storeaportacionesAnualesSHCP.load();
                                                }
                                            }
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=4&fechaini="+parametersApoAnuaSHCP.fechaini+ "&fechafin="+parametersApoAnuaSHCP.fechafin+"&usuario="+parametersApoAnuaSHCP.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('SHCPaportacionesAnuales_1');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 200,
                                    store: storeaportacionesAnualesSHCP,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.SHCPaportacionesAnuales_1.superclass.initComponent.apply(this, arguments);
                    storeaportacionesAnualesSHCP.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>