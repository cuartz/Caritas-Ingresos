<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>       
        <script type="text/javascript">
        /******************** VARIABLES GLOBALES ***********************/
        var winReportContabilidad;
        
        Ext.define('contabilidadMdl',{ 
            id:'contabilidadMdl',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'NUM'},
                {name: 'ID_RECIBO'},
                {name: 'PROYECTO'},
                {name: 'NUM_FRECUENCIA'},               
                {name: 'FECHA_VENCIMIENTO'},
                {name: 'FECHA_PAGO'},
                {name: 'IMPORTE'},
                {name: 'FORMA_PAGO'},
                {name: 'CUENTA'},
                {name: 'ASIGNACION'},
                {name: 'RECOLECTOR'},
                {name: 'ID_BITACORA'}                
            ]
        });
        
        var storeReportContabilidad1 = Ext.create('Ext.data.JsonStore', {                   
            model: 'contabilidadMdl',
            pageSize: 50,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'tesoreriaAC.do?method=getReporteDiario',                                     
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
        var storeContabilidadEspecie = Ext.create('Ext.data.JsonStore', {                   
            model: 'contabilidadMdl',
            pageSize: 50,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'tesoreriaAC.do?method=getReporteDiarioEspecie',                                     
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
        var storeContabilidadTres = Ext.create('Ext.data.JsonStore', {                   
            model: 'contabilidadMdl',
            pageSize: 100,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'tesoreriaAC.do?method=getReporteDiarioTres',                                     
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
        
        /******************** INICIA PANTALLA ***********************/
        Ext.define('Reportes.contabilidad', {                    
            extend: 'Ext.window.Window',                    
            alias:'widget.contabilidad',                
            title: 'Administración - Reporte Contabilidad',
            width: 900,  
            constrain : true,
            height: 620,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            modal : true,
            closeAction : 'destroy',
            region:'center',
            initComponent: function() {
                winReportContabilidad = this;
                
                var tbContabilidad = new Ext.Toolbar({
                    items:[
                        new Ext.Button({
                            text:'Buscar',
                            iconCls: 'icon-find',
                            handler:function(){
                                var FECHA_PAGO_CONTABILIDAD = Ext.getCmp('FECHA_PAGO_CONTABILIDAD_1').getValue();
                                storeReportContabilidad1.proxy.extraParams = {
                                    FECHA_PAGO:FECHA_PAGO_CONTABILIDAD                                        
                                };
                                storeReportContabilidad1.load();
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Limpiar Filtros',
                            iconCls: 'icon-clear',
                            handler:function(){                                    
                                Ext.getCmp('frmReportContabilidadUno').getForm().reset();
                                storeReportContabilidad1.proxy.extraParams = {
                                    FECHA_PAGO:null                                        
                                };
                                storeReportContabilidad1.load();
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Modificar Fecha de Pago',
                            iconCls: 'icon-editar',
                            handler:function(){                                    
                                var selectedRow = Ext.getCmp('gridReportContabilidad1').selModel.selected.items[0];                                    
                                if(selectedRow!=undefined){                                                                               
                                    createNewObj3('tesoreria.modificarReciboPagado',selectedRow.data.ID_BITACORA,selectedRow.data.ID_RECIBO);                                                                    
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el recibo que va a modificar!');
                                }

                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Exportar Reporte',
                            iconCls:'icon-xlsx',
                            handler:function(){                                    
                                var FECHA_PAGO_CONTABILIDAD = Ext.getCmp('FECHA_PAGO_CONTABILIDAD_1').getValue();
                                if(FECHA_PAGO_CONTABILIDAD == null){
                                    Ext.MessageBox.alert('Error','¡Seleccione una fecha de pago!');
                                }else{
                                    window.open("ShowExcel?idOperationType=15&fechaPago="+FECHA_PAGO_CONTABILIDAD);
                                }
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winReportContabilidad.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                var tbContabilidadDos = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Buscar',
                                iconCls: 'icon-find',
                                handler:function(){                                    
                                    var FECHA_PAGO_CONTABILIDAD = Ext.getCmp('FECHA_PAGO_CONTABILIDAD_DOS').getValue();
                                    storeContabilidadEspecie.proxy.extraParams = {
                                        FECHA_PAGO:FECHA_PAGO_CONTABILIDAD                                        
                                    };
                                    storeContabilidadEspecie.load();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Limpiar Filtros',
                                iconCls: 'icon-clear',
                                handler:function(){                                    
                                    Ext.getCmp('frmContabilidadDos').getForm().reset();
                                    storeContabilidadEspecie.proxy.extraParams = {
                                        FECHA_PAGO:null                                        
                                    };
                                    storeContabilidadEspecie.load();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Modificar Fecha de Pago',
                                iconCls: 'icon-editar',
                                handler:function(){                                    
                                    var selectedRow = Ext.getCmp('gridContabilidad').selModel.selected.items[0];                                    
                                    if(selectedRow!=undefined){                                                                               
                                      createNewObj3('tesoreria.modificarReciboPagado',selectedRow.data.ID_BITACORA,selectedRow.data.ID_RECIBO);                                                                    
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el recibo que va a modificar!');
                                    }
                                    
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Exportar Reporte',
                                iconCls:'icon-xlsx',
                                handler:function(){                                    
                                    var FECHA_PAGO_CONTABILIDAD = Ext.getCmp('FECHA_PAGO_CONTABILIDAD_DOS').getValue();
                                    if(FECHA_PAGO_CONTABILIDAD == null){
                                        Ext.MessageBox.alert('Error','¡Seleccione una fecha de pago!');
                                    }else{
                                        window.open("ShowExcel?idOperationType=16&fechaPago="+FECHA_PAGO_CONTABILIDAD);
                                    }
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    winReportContabilidad.close();                            
                                }
                            })                            
                        ]
                    }); //Termina Toolbar
                    
                var tbContabilidadTres = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Buscar',
                                iconCls: 'icon-find',
                                handler:function(){                                    
                                    var FECHA_PAGO_INI = Ext.getCmp('FECHA_PAGO_INI').getValue();
                                    var FECHA_PAGO_FIN = Ext.getCmp('FECHA_PAGO_FIN').getValue();
                                    storeContabilidadTres.proxy.extraParams = {
                                        FECHA_INI:FECHA_PAGO_INI,
                                        FECHA_FIN:FECHA_PAGO_FIN                                        
                                    };
                                    storeContabilidadTres.load();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Limpiar Filtros',
                                iconCls: 'icon-clear',
                                handler:function(){                                    
                                    Ext.getCmp('frmContabilidadtTres').getForm().reset();
                                    storeContabilidadTres.proxy.extraParams = {
                                        FECHA_PAGO_INI:null,
                                        FECHA_PAGO_FIN:null                                        
                                    };
                                    storeContabilidadTres.load();
                                }
                            }),                            
                            '-',
                            new Ext.Button({
                                text:'Exportar Reporte',
                                iconCls:'icon-xlsx',
                                handler:function(){                                    
                                    var FECHA_PAGO_INI = Ext.getCmp('FECHA_PAGO_INI').getValue();
                                    var FECHA_PAGO_FIN = Ext.getCmp('FECHA_PAGO_FIN').getValue();
                                    if(FECHA_PAGO_INI == null && FECHA_PAGO_FIN == null){
                                        Ext.MessageBox.alert('Error','¡Seleccione una fecha inicial y final!');
                                    }else{
                                        window.open("ShowExcel?idOperationType=17&fechaIni="+FECHA_PAGO_INI+"&fechaFin="+FECHA_PAGO_FIN);
                                    }
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Exportar Reporte Por Asignación',
                                iconCls:'icon-xlsx',
                                handler:function(){                                    
                                    var FECHA_PAGO_INI = Ext.getCmp('FECHA_PAGO_INI').getValue();
                                    var FECHA_PAGO_FIN = Ext.getCmp('FECHA_PAGO_FIN').getValue();
                                    if(FECHA_PAGO_INI == null && FECHA_PAGO_FIN == null){
                                        Ext.MessageBox.alert('Error','¡Seleccione una fecha inicial y final!');
                                    }else{
                                        window.open("ShowExcel?idOperationType=18&fechaIni="+FECHA_PAGO_INI+"&fechaFin="+FECHA_PAGO_FIN);
                                    }
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Exportar Reporte Por Proyecto',
                                iconCls:'icon-xlsx',
                                handler:function(){                                    
                                    var FECHA_PAGO_INI = Ext.getCmp('FECHA_PAGO_INI').getValue();
                                    var FECHA_PAGO_FIN = Ext.getCmp('FECHA_PAGO_FIN').getValue();
                                    if(FECHA_PAGO_INI == null && FECHA_PAGO_FIN == null){
                                        Ext.MessageBox.alert('Error','¡Seleccione una fecha inicial y final!');
                                    }else{
                                        window.open("ShowExcel?idOperationType=19&fechaIni="+FECHA_PAGO_INI+"&fechaFin="+FECHA_PAGO_FIN);
                                    }
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    winReportContabilidad.close();                            
                                }
                            })                            
                        ]
                    }); //Termina Toolbar
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'tabpanel',
                            height: 890,                        
                            activeTab: 0,
                            border: false,
                            items:[
                                /**************************** PESTAÑA CONTABILIDAD 1 *********************************/
                                {
                                    xtype: 'panel',               
                                    border: false,
                                    tbar: tbContabilidad,
                                    title: 'Efectivo',
                                    items: [
                                        {
                                            xtype: 'form',  
                                            id: 'frmReportContabilidadUno',
                                            border: false,
                                            items:[
                                                {
                                                    xtype: 'fieldset',
                                                    height: 65,
                                                    title: 'Filtros',
                                                    items:[
                                                        {
                                                            xtype: 'datefield',
                                                            width: 325,
                                                            labelWidth: 130,
                                                            fieldLabel: 'Fecha Pago',
                                                            id: 'FECHA_PAGO_CONTABILIDAD_1'
                                                        }
                                                    ] //Cierre items fieldset
                                                },
                                                {
                                                    xtype: 'grid',                                                    
                                                    height: 460,
                                                    id: 'gridReportContabilidad1',
                                                    store: storeReportContabilidad1,
                                                    columns: [
                                                        {
                                                            dataIndex: 'NUM',
                                                            text: '#',
                                                            flex: .01,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'ID_RECIBO',
                                                            text: 'Recibo',
                                                            flex: .03,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'PROYECTO',
                                                            text: 'Proyecto',
                                                            flex: .06,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'NUM_FRECUENCIA',
                                                            text: 'Pago',
                                                            flex: .03,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_PAGO',
                                                            text: 'Fecha Pago',
                                                            flex: .04,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'IMPORTE',
                                                            text: 'Importe',
                                                            flex: .03,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'FORMA_PAGO',
                                                            text: 'Forma de Pago',
                                                            flex: .04,
                                                            align:'left'
                                                        },                                                    
                                                        {
                                                            dataIndex: 'ASIGNACION',
                                                            text: 'Asignacion',
                                                            flex: .04,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'RECOLECTOR',
                                                            text: 'Recoletor',
                                                            flex: .1,
                                                            align:'left'
                                                        }
                                                    ],
                                                    viewConfig: {

                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                    }),
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 50,
                                                        store: storeReportContabilidad1,
                                                        displayInfo: true,
                                                        emptyMsg: '¡No hay pagos para que mostrar!'  
                                                    })
                                                }
                                            ] //Cierre items form
                                        }
                                    ]
                                },
                                /**************************** PESTAÑA CONTABILIDAD 2 *********************************/
                                {
                                    xtype: 'panel',               
                                    border: false,
                                    tbar: tbContabilidadDos,
                                    title: 'Otras Cuentas',
                                    items: [
                                        {
                                            xtype: 'form',  
                                            id: 'frmContabilidadDos',
                                            border: false,
                                            items:[
                                                {
                                                    xtype: 'fieldset',
                                                    height: 65,
                                                    title: 'Filtros',
                                                    items:[
                                                        {
                                                            xtype: 'datefield',
                                                            width: 325,
                                                            labelWidth: 130,
                                                            fieldLabel: 'Fecha Pago',
                                                            id: 'FECHA_PAGO_CONTABILIDAD_DOS'
                                                        }
                                                    ] //Cierre items fieldset
                                                },
                                                {
                                                    xtype: 'grid',                                                    
                                                    height: 460,
                                                    id: 'gridContabilidadDos',
                                                    store: storeContabilidadEspecie,
                                                    columns: [
                                                        {
                                                            dataIndex: 'NUM',
                                                            text: '#',
                                                            flex: .01,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'ID_RECIBO',
                                                            text: 'Recibo',
                                                            flex: .03,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'PROYECTO',
                                                            text: 'Proyecto',
                                                            flex: .06,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'NUM_FRECUENCIA',
                                                            text: 'Pago',
                                                            flex: .03,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_PAGO',
                                                            text: 'Fecha Pago',
                                                            flex: .04,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'IMPORTE',
                                                            text: 'Importe',
                                                            flex: .03,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'FORMA_PAGO',
                                                            text: 'Forma de Pago',
                                                            flex: .05,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'CUENTA',
                                                            text: 'Cuenta',
                                                            flex: .04,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'ASIGNACION',
                                                            text: 'Asignacion',
                                                            flex: .04,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'RECOLECTOR',
                                                            text: 'Recoletor',
                                                            flex: .1,
                                                            align:'left'
                                                        }
                                                    ],
                                                    viewConfig: {

                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                    }),
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 50,
                                                        store: storeContabilidadEspecie,
                                                        displayInfo: true,
                                                        emptyMsg: '¡No hay pagos para que mostrar!'  
                                                    })
                                                }
                                            ] //Cierra items form
                                        }
                                    ] //Cierra items panel
                                },
                                /**************************** PESTAÑA CONTABILIDAD 3 *********************************/
                                {
                                    xtype: 'panel',               
                                    border: false,
                                    tbar: tbContabilidadTres,
                                    title: 'Mensual',
                                    items: [
                                        {
                                            xtype: 'form',  
                                            id: 'frmContabilidadTres',
                                            border: false,
                                            items:[
                                                {
                                                    xtype: 'fieldset',
                                                    height: 85,
                                                    title: 'Filtros',
                                                    items:[
                                                        {
                                                            xtype: 'datefield',
                                                            width: 325,
                                                            labelWidth: 130,
                                                            fieldLabel: 'Fecha Inicial',
                                                            id: 'FECHA_PAGO_INI'
                                                        },
                                                        {
                                                            xtype: 'datefield',
                                                            width: 325,
                                                            labelWidth: 130,
                                                            fieldLabel: 'Fecha Final',
                                                            id: 'FECHA_PAGO_FIN'
                                                        }
                                                    ] //Cierre items fieldset
                                                },
                                                {
                                                    xtype: 'grid',                                                    
                                                    height: 440,
                                                    id: 'gridContabilidadTres',
                                                    store: storeContabilidadTres,
                                                    columns: [
                                                        {
                                                            dataIndex: 'NUM',
                                                            text: '#',
                                                            flex: .01,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'ID_RECIBO',
                                                            text: 'Recibo',
                                                            flex: .03,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'PROYECTO',
                                                            text: 'Proyecto',
                                                            flex: .06,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'NUM_FRECUENCIA',
                                                            text: 'Pago',
                                                            flex: .03,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_PAGO',
                                                            text: 'Fecha Pago',
                                                            flex: .04,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'IMPORTE',
                                                            text: 'Importe',
                                                            flex: .03,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'FORMA_PAGO',
                                                            text: 'Forma de Pago',
                                                            flex: .05,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'CUENTA',
                                                            text: 'Cuenta',
                                                            flex: .04,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'ASIGNACION',
                                                            text: 'Asignacion',
                                                            flex: .04,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'RECOLECTOR',
                                                            text: 'Recoletor',
                                                            flex: .1,
                                                            align:'left'
                                                        }
                                                    ],
                                                    viewConfig: {

                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                    }),
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 100,
                                                        store: storeContabilidadTres,
                                                        displayInfo: true,
                                                        emptyMsg: '¡No hay pagos para que mostrar!'  
                                                    })
                                                }
                                            ] //Cierra items form
                                        }
                                    ] //Cierra items panel
                                }
                            ]//Cierra items tabpanel
                        }
                    ] //Cierra items ext.apply
                    
                }); //Cierra Ext.apply
                storeReportContabilidad1.load();
                storeContabilidadEspecie.load();
                storeContabilidadTres.load();
                Reportes.contabilidad.superclass.initComponent.apply(this, arguments);
            } //Cierra initComponent
            
        }); //CIerra Ext.define
            
        </script>
    </head>
    <body>
    </body>
</html>
