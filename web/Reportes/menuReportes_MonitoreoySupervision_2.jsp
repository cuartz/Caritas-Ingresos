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
            Ext.define('Reportes.menuReportes_MonitoreoySupervision_2', {
                extend: 'Ext.window.Window',
//                id:'menuReportes',
                alias:'widget.menuReportes_MonitoreoySupervision_2',                
                title: 'Menu Reportes Monitoreo y Supervision',
                width: 370,                
                height: 520,
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
                                                                text: 'Lista de recibos impresos por mes',
//                                                                text: 'Recibos deducibles',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_MYS_RECIBOS_IMPRESOSMES_1');    
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
                                                                text: 'Lista de recibos cobrados',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_MYS_RECIBOS_COBRADOS_2');    
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
                                                                text: 'Lista de recibos por cobrar',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_MYS_RECIBOS_POR_COBRAR_3');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        margin: '',
                                                        width: 267,
                                                        collapsed: false,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista de donativos confirmados',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_MYS_RECIBOS_POR_CONFIRMADO_4');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        border: false,
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista por tipo de donante',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_MYS_RECIBOS_POR_TIPODONANTE_6');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                    ,
                                                    {
                                                        border: false,
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista de movimientos por usuario',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                    ,
                                                    {
                                                        border: false,
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista de donativos promesa',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                    ,
                                                    {
                                                        border: false,
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista de donativos de empresas',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.Rep_MYS_RECIBOS_POR_EMPRESA_5');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                    ,
                                                    {
                                                        border: false,
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista de recibos impresos por colonia',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                    ,
                                                    {
                                                        border: false,
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Lista de donantes que no han podido ser localizados',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('');    
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
                    Reportes.menuReportes_MonitoreoySupervision_2.superclass.initComponent.apply(this, arguments); 
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
