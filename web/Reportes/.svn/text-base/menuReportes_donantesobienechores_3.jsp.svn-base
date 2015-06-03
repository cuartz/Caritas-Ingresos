<%--
    Document   : menuReportes_MonitoreoySupervision_2
    Created on : 10/04/2012, 14:14:12 pm
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
            //Citas,DatosServicio,EstSocio,Ingresos,SolCheques,eorganizacional,helpRegistration,registro,serviciosAsignados
            
                     
            //Inicia
            //Creation Screen            
            Ext.define('Reportes.menuReportes_donantesobienechores_3', {
                extend: 'Ext.window.Window',
//                id:'menuReportes',
                alias:'widget.menuReportes_donantesobienechores_3',                
                title: 'Menu Reportes Donantes o Bienechores',
                width: 370,                
                height: 300,
                border: false,
                buttonAlign: 'left',
                layout: 'fit',
                maximizable: true,
                modal:true,
                closeAction:'destroy',
                autoDestroy: true,
                region:'center',
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'panel',
                                border: false,
                                height: 270,
                                width: 900,
                                activeItem: 0,
                                layout: {
                                    type: 'border'
                                },
                                items: [
                                    {
                                        xtype: 'panel',
                                        border: false,
                                        width: 300,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        region: 'center',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                title: 'Monitoreo y Supervision',
                                                width: 50,
                                                margin:'5 5 5 5',
                                                width: 50,
                                                flex: 1,
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        collapsed: false,
                                                        border: false,
                                                        items: [
                                                            Ext.create('Ext.Button', {
                                                                text: 'Listado de Donantes Activos',
//                                                                text: 'Recibos deducibles',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_DB_ListadoDonantes_Activos');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        collapsed: false,
                                                        border: false,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Listado de Donantes por Universo',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        collapsed: false,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Listado de Donantes Inactivos',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_DB_ListadoDonantes_Inactivos_2');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                ]
                            }
                        ]
                
                    });
                    Reportes.menuReportes_donantesobienechores_3.superclass.initComponent.apply(this, arguments); 
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
