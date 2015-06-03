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
     * Person(); }
     */
%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
                     
            //Inicia
            Ext.define('Graficas.G_TotalRegistosDonante', {
                extend: 'Ext.window.Window',
                id:'G_TotalRegistosDonante',
                alias:'widget.G_TotalRegistosDonante',                
                title: 'Graficas Total de Registos Donantes',
                height: 580,
                width:1100,
                closeAction : 'close',
                border: false,
                buttonAlign: 'left',
                maximizable: false,
                layout: 'fit',
                region:'center',
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'panel',
                                height: 1053,
                                width: 942,
                                autoScroll: true,
                                layout: {
                                    align: 'stretch',
                                    type: 'hbox'
                                }
                                , items: [
                                    {
                                        xtype: 'panel',
                                        height: 1053,
                                        width: 571,
                                        layout: {
                                            type: 'anchor'
                                        },
                                        title: 'pie chart',
                                        items: [
                                            {
                                                xtype: 'chart',
                                                height: 550,
                                                width: 480,
                                                animate: true,
                                                insetPadding: 20,
                                                store:storetotalRegistros,
                                                legend: {
                                                    position: 'right'
                                                },
                                                insetPadding: 25,
                                                theme: 'Base:gradients',
                                                series: [
                                                    {
                                                        type: 'pie',
                                                        label: {
                                                            field: 'USUARIO',
                                                            display: 'rotate',
                                                            contrast: true,
                                                            font: '10px Arial',
                                                            trackMouse: true

                                                        },
                                                        tips: {
                                                            trackMouse: true,
                                                            width: 140,
                                                            height: 28,
                                                            renderer: function(storeItem, item) {
                                                                var total = 0;//calculate percentage.
                                                                storetotalRegistros.each(function(rec) {
                                                                    total += rec.get('CANTIDAD_REGISTROS');
                                                                });
                                                                this.setTitle(storeItem.get('USUARIO') + ': ' + Math.round(storeItem.get('CANTIDAD_REGISTROS') / total * 100) + '%');
                                                            }
                                                        },highlight: {
                                                            segment: {
                                                                margin: 20
                                                            }
                                                        },
                                                        showInLegend: true,
                                                        angleField: 'CANTIDAD_REGISTROS'
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                    ,
                                    {
                                        xtype: 'panel',
                                        height: 1053,
                                        width: 571,
                                        layout: {
                                            type: 'anchor'
                                        }
                                        ,
                                        title: 'bar graphic',
                                        items: [
                                            {
                                                xtype: 'chart',
                                                height: 480,
                                                width: 505,
                                                animate: true,
                                                insetPadding: 20,
                                                store:storetotalRegistros,
                            
                                                axes: [
                                                    {
                                                        type: 'Category',
                                                        fields: [
                                                            'USUARIO'
                                                        ],
                                                        position: 'bottom',
                                                        title: 'Trabajadora Social',
                                                        label: {
                                                            rotate: {
                                                                degrees: 315
                                                            }
                                                        }
                                                    },
                                                    {
                                                        type: 'Numeric',
                                                        fields: [
                                                            'CANTIDAD_REGISTROS'
                                                        ],
                                                        position: 'left',
                                                        title: 'Numero de Atenciones'
                                                    }
                                                ],
                                                series: [
                                                    {
                                                        type: 'column',
                                                        label: {
                                                            display: 'insideEnd',
                                                            field: 'CANTIDAD_REGISTROS',
                                                            color: '#4E9E06',
                                                            highlight: true,
                                                            'text-anchor': 'middle'
                                               
                                                        }, tips: {
                                                            trackMouse: true,
                                                            width: 140,
                                                            height: 28,
                                                            renderer: function(storeItem, item) {
                                                                var total = 0;//calculate and display percentage on hover
                                                                storetotalRegistros.each(function(rec) {
                                                                    total += rec.get('CANTIDAD_REGISTROS');
                                                                });
                                                                this.setTitle(storeItem.get('USUARIO') + ': ' + Math.round(storeItem.get('CANTIDAD_REGISTROS') / total * 100) + '%');
                                                            }
                                                        },

                                                        xField: 'USUARIO',
                                                        
                                                        yField: [
                                                            'CANTIDAD_REGISTROS'
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                        ,tbar: {
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
                                            parametersTR.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                            storetotalRegistros.load();
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
                                            parametersTR.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                            storetotalRegistros.load();
                                        }
                                    }
                                }
                                ,
                                {xtype:'tbseparator'},
                                {
                                    xtype: 'button',
                                    text: 'Salir',
                                    iconCls:'icon-salir',
                                    handler: function()
                                    {
                                        Ext.getCmp('G_TotalRegistosDonante').close();
                                    }   
                                }                                
                            ]
                        }
                    });           
                    Graficas.G_TotalRegistosDonante.superclass.initComponent.apply(this, arguments); 
                    storetotalRegistros.load();
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
