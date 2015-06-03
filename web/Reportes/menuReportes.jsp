<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>       
        <script type="text/javascript">                      
            Ext.define('Reportes.menuReportes', {
                extend: 'Ext.window.Window',
                alias:'widget.menuReportes',                
                title: 'Menu Reportes',
                width: 910,                
                height: 400,
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
                                height: 280,
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
                                                title: 'Operacion',
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
                                                                text: 'Cancelación de donativos',
//                                                                text: 'Recibos deducibles',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.OPE_CancelaciondeDonativos_1');    
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
                                                                text: 'Menu: Monitoreo y Supervisión',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.menuReportes_MonitoreoySupervision_2');    
//                                                                    createNewObj('Reportes.OPE_monitoreoySupervision_1');    
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
                                                                text: 'Recibos Deducibles',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.OPE_recibosDeducibles_3');    
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
                                                                text: 'Menu: Donantes o Bienechores',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.menuReportes_donantesobienechores_3');    
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
                                                                text: 'Re Prospectar',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.OPE_reProspectar_5');    
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
                                                                text: 'Agradecimiento',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.OPE_agradecimiento_6');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        border: false,
                                        width: 300,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        region: 'west',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                title: 'Tesoreria',
                                                width: 50,
                                                margin:'5 5 5 5',
                                                width: 50,
                                                flex: 1,
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        animCollapse: false,
                                                        collapsed: false,
                                                        items: [
                                                            Ext.create('Ext.Button', {
                                                                text: 'Listados de cobranza',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.TES_listadoCobranza_1');    
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
                                                                text: 'Concentrado de cobranza',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.TES_concentradocobranza_2');    
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
                                                                text: 'Recibos Impresos',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.TES_rastreoRecibosDeducibles_3');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        height: 43,
                                                        width: 363,
                                                        collapsed: false,
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Seguimiento',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.TES_seguimiento_4');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        flex: 1
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        border: false,
                                        width: 300,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        region: 'east',
                                        items: [
                                            {
                                                xtype: 'fieldset',
                                                title: 'SHCP',
                                                width: 50,
                                                margin:'5 5 5 5',
                                                width: 50,
                                                flex: 1,
                                                items: [
                                            
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        collapsed: false,
                                                        title: '',
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Aportaciones anuales',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.SHCPaportacionesAnuales_1');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        collapsed: false,
                                                        title: '',
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Donantes anual',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.SHCPuniversodeDonantes_2');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        collapsed: false,
                                                        title: '',
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Deducible emitidos en el año anterior',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.SHCPdeduciblesEmitidosAnoAnterior_3');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        collapsed: false,
                                                        title: '',
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Donantes anuales por orden alfabético',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.SHCPuniversoDonantesAnualesAlfa_4');    
                                                                }
                                                            })
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: false,
                                                        collapsed: false,
                                                        title: '',
                                                        items: [
                                                        Ext.create('Ext.Button', {
                                                                text: 'Instituciones durante el ejercicio',
                                                                margin: '9,9,9,9',
                                                                width: 240,
                                                                handler: function() {
                                                                    createNewObj('Reportes.SHCPinstitucionesDE_5');    
                                                                }
                                                            })
                                                        ]
                                                    }
                                                ]
                                            }    
                                        ]
                                        
                                    }
                                ]
                            }
                        ]
                
                    });
                    Reportes.menuReportes.superclass.initComponent.apply(this, arguments); 
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
