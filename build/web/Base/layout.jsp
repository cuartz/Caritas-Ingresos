<%--
    Document   : Total Registros
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
     * Person();
    }
     */
%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
   
//   ="INSERT INTO [BD_ADMIN].[dbo].[dbo.ADM_CATALOGS_VALUES] VALUES( '"&J2&"', '"&K2&"', '"&L2&"');"
            ///EJEMPLO DE HARDCODE de COMBO
             //combo tipos de Recolectores
//            var listaFiltros = [
//                ['1', 'Cancelación por proyecto.'],
//                ['2', 'Cancelación por asignación.']];
//
//
//            var storeCBReportListadoCobranza = Ext.create('Ext.data.SimpleStore',{
//                autoLoad: true,
//                fields: ['ID', 'NOMBRE'],
//                data: listaFiltros
//            });  


//          EJEMPLO DE HARDCODE DE STORE
//var storereporteConcentradoCobranza = Ext.create('Ext.data.JsonStore', ({
//                fields:[{name: 'fecha'},
//                    {name: 'proyecto'},
//                    {name: 'asignacion'},
//                    {name: 'cantidad_Cobrada'},
//                    {name: 'total_Recibos'}],
//                data: [
//                    {fecha:'12/Abr/2012', proyecto: '1001', asignacion:'La Asignacion', cantidad_Cobrada:'4561.23', total_Recibos:'6'}
//                ]
//            })); 

// funcion de formato de pesos
//function render_moneyRPP(v, p, record){
//                return '$ '+v
//            }

//COMBO DEL STORE
//{xtype:'tbseparator'},
    //                                        {
    //                                            xtype: 'combo',
    //                                            name: 'tipoFiltro',
    //                                            id: 'tipoFiltro',
    //                                            fieldLabel: 'Tipo de Filtro',
    //                                            labelWidth: 80,
    //                                            store: storeCBReportListadoCobranza,
    //                                            anchor: '90%',
    //                                            editable: false,
    //                                            valueField: 'NOMBRE',
    //                                            allowBlank:false,
    //                                            displayField:'NOMBRE',
    //                                            triggerAction: 'all',
    //                                            mode: 'local',
    //                                            tabIndex: 13,
    //                                            listeners:{
    //                                                select:function(combo,record,opcion)
    //                                                {
    //                                                    parametersRLC.usuario= record[0].get("ID");
    //                                                    storeReporteListCobranza.load();
    //                                                }
    //                                            }
    //                                        }
           //EJMPLO DE LA PAGINACION
//            ,//Fin de tbar continuacion de barra de paginacion //Paginacion
//                                bbar: new Ext.PagingToolbar({
//                                    pageSize: 50,
//                                    store: storereporteConcentradoCobranza,
//                                    displayInfo: true
//                                })
//          

//      EJEMPLO DE GRID 
//        {
    //                                xtype: 'grid',
    //                                store: storeaportacionesAnualesSHCP,
    //                                id:'gridaportacionesAnualesSHCP',
    //                                name: 'gridaportacionesAnualesSHCP',
    //                                columns: [
    //                                    {
    //                                        dataIndex: 'FECHA_IMPRESION',
    //                                        text: 'FECHA IMPRESION',
    //                                        flex: .1
    //                                    },
    //                                    {
    //                                        dataIndex: 'NUM_DONANTE',
    //                                        text: 'NUM DONANTE',
    //                                        flex: .1
    //                                    },
    //                                    {
    //                                        dataIndex: 'NOMBRE_DONANTE',
    //                                        text: 'NOMBRE DONANTE',
    //                                        flex: .1
    //                                                    
    //                                    },
    //                                    {
    //                                        dataIndex: 'ASIGNACION',
    //                                        text: 'ASIGNACION',
    //                                        flex: .1
    //                                    }
    //                                    ,
    //                                    {
    //                                        dataIndex: 'MONTO_DONATIVO',
    //                                        text: '$ DONATIVO',
    //                                        renderer: render_moneyRPP,
    //                                        flex: .1
    //                                    }
    //                                    ,
    //                                    {
    //                                        dataIndex: 'NUM_RECIBO',
    //                                        text: '# RECIBO',
    //                                        flex: .1
    //                                    }

                     
            //Inicia
            //Creation Screen            
//            Ext.define('confirmaciones.sinConfirmar', {
//                extend: 'Ext.window.Window',
////                id:'sinConfirmar',
//                alias:'widget.sinConfirmar',                
//                title: 'Sin Confirmacion',
//                width: 750,                
//                height: 500,
//                border: false,
//                buttonAlign: 'left',
//                maximizable: true,
//                layout: 'fit',
//                closeAction : 'close',
//                region:'center',
//                initComponent: function() {
//                    Ext.apply(this, {
//                        items: [
//                            
//                        ]
//                    });
//                    confirmaciones.sinConfirmar.superclass.initComponent.apply(this, arguments); 
//                }
//            });
   

        </script>
    </head>
    <body>
    </body>
</html>
