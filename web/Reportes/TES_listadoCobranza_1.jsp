<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>        
        <script type="text/javascript"> 
           /****************************** VARIABLES GLOBALES ******************************/ 
           var winTesListadoCobranza_1;
           var strResultFormasPago;
            
            /****************************** MODELS *********************************/
            Ext.define('catalog',{
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
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
                    {name: 'ID_BITACORA'},
                    {name: 'ID_DONANTE'},
                    {name: 'NOMBRE_DONANTE'}
                ]
            });
            
            /****************************** STORES********************************/
            var storeTES_listadoCobranza = Ext.create('Ext.data.JsonStore', {                   
                model: 'contabilidadMdl',
                pageSize: 400,
                autoLoad:false,
                proxy: {
                    type: 'ajax',                       
                    url: 'reportesAC.do?method=reporte_TESORERIA_ListadoDeCobranza',                                     
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'//Paginacion                
                    }
                }
            });
            
            var cbxCampFinanciera = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var cbxFormaPago = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'DONATIVO_FORMA_PAGO'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            //var cbxDataTipoReporteListCobr =['Camp. Fin','Forma Pago'];
            
            var cbxDataTipoReporteListCobr = Ext.create('Ext.data.Store', {
                fields: ['namee', 'valuee'],
                data : [
                    {"namee":"Campaña Financiera", "valuee":"1"},
                    {"namee":"Forma de Pago", "valuee":"2"}
                ]
            }); 
            
           /****************************** FUNCIONES JAVASCRIPT *********************************/ 
           function render_moneyLISTCOBR(v, p, record){
                return '$ '+v
            }
            
            function remplazar(){
                var x = Ext.getCmp("ID_FORMA_PAGO_LISTCOBR").getValue();
                var n = x.replace(",","$");
                Ext.getCmp("ID_FORMA_PAGO_LISTCOBR").setValue(n);
            }
            
            //Inicia
            Ext.define('Reportes.TES_listadoCobranza_1', {
                extend: 'Ext.window.Window',
                id:'TES_listadoCobranza_1',
                name: 'Reportes.TES_listadoCobranza_1',
                alias:'widget.TES_listadoCobranza_1',                
                title: 'Reporte de Tesoreria listado Cobranza',
                width: 1200,                
                height: 600,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',    
                region:'center',
                closeAction:'destroy',
                autoScroll:true,//modificacion
                initComponent: function() {
                    winTesListadoCobranza_1 = this;                    
                    
                    var tbTesListadoCobranza = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Buscar',
                                iconCls: 'icon-find',
                                handler:function(){
                                    var FECHA_PAGO_INICIAL  = Ext.getCmp('FECHA_PAGO_INICIAL_LISTCOBR').getValue();
                                    var FECHA_PAGO_FINAL    = Ext.getCmp('FECHA_PAGO_FIN_LISTCOBR').getValue();
                                    var CAMP_FIN_LC         = Ext.getCmp('ID_CAMPANA_FINANCIERA_LISTCOBR').getValue();
//                                    var FORMA_PAGO_LC       = Ext.getCmp('ID_FORMA_PAGO_LISTCOBR').getValue();
                                    var TIPO_REPORTE_LC     = Ext.getCmp('TIPO_REPORTE_LISTCOBR').getValue();//                                   
                                    storeTES_listadoCobranza.proxy.extraParams = {
                                        FECHA_INI:FECHA_PAGO_INICIAL,
                                        FECHA_FIN:FECHA_PAGO_FINAL,
                                        CAMP_FIN:CAMP_FIN_LC,
                                        FORMA_PAGO:strResultFormasPago,
                                        TIPO_REPORTE:TIPO_REPORTE_LC
                                    };
                                    storeTES_listadoCobranza.load();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Limpiar',
                                iconCls: 'icon-clear',
                                handler:function(){                                    
                                    Ext.getCmp('FECHA_PAGO_INICIAL_LISTCOBR').reset();
                                    Ext.getCmp('FECHA_PAGO_FIN_LISTCOBR').reset();
                                    Ext.getCmp('ID_CAMPANA_FINANCIERA_LISTCOBR').reset();
                                    Ext.getCmp('ID_FORMA_PAGO_LISTCOBR').reset();
                                    Ext.getCmp('TIPO_REPORTE_LISTCOBR').reset();
                                    strResultFormasPago = null;
                                    storeTES_listadoCobranza.proxy.extraParams = {
                                        FECHA_INI:null,
                                        FECHA_FIN:null,
                                        CAMP_FIN:null,
                                        FORMA_PAGO:null,
                                        TIPO_REPORTE:'1'
                                    };
                                    storeTES_listadoCobranza.load();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Modificar Fecha de Pago',
                                iconCls: 'icon-editar',
                                handler:function(){                                    
                                    var selectedRow = Ext.getCmp('gridTES_listadoCobranza').selModel.selected.items[0];                                    
                                    if(selectedRow!=undefined){                                                                               
                                        createNewObj3('tesoreria.modificarReciboPagado',selectedRow.data.ID_BITACORA,selectedRow.data.ID_RECIBO);                                                                    
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el recibo que va a modificar!');
                                    }

                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Exportar',
                                iconCls:'icon-xlsx',
                                handler:function(){                                                                        
                                    var FECHA_PAGO_INICIAL  = Ext.getCmp('FECHA_PAGO_INICIAL_LISTCOBR').getValue();
                                    var FECHA_PAGO_FINAL    = Ext.getCmp('FECHA_PAGO_FIN_LISTCOBR').getValue();
                                    var CAMP_FIN_LC         = Ext.getCmp('ID_CAMPANA_FINANCIERA_LISTCOBR').getValue();
                                    var FORMA_PAGO_LC       = Ext.getCmp('ID_FORMA_PAGO_LISTCOBR').getValue();
//                                    var FORMA_PAGO_LC       = strResultFormasPago;
                                    var TIPO_REPORTE_LC     = Ext.getCmp('TIPO_REPORTE_LISTCOBR').getValue();
                                    
                                    if(CAMP_FIN_LC == null){                                        
                                        CAMP_FIN_LC = '0'
                                    }
                                    
                                    if(FECHA_PAGO_INICIAL == null){
                                        Ext.MessageBox.alert('Error','¡Seleccione una fecha de pago!');
                                    }else{
                                        window.open("ShowExcel?idOperationType=17&fechaPagoIni="+FECHA_PAGO_INICIAL+"&fechaPagoFin="+FECHA_PAGO_FINAL+"&CAMP_FINN="+CAMP_FIN_LC+"&FORMA_PAGO="+FORMA_PAGO_LC+"&TIPO_REPORTE="+TIPO_REPORTE_LC);
                                    }
                                }
                            }),
                             '-',
                            new Ext.Button({
                                //text:'Pdf',
                                iconCls:'icon-pdf',
                                handler:function(){                                                                        
                                    var FECHA_PAGO_INICIAL = mostrarFecha(Ext.getCmp('FECHA_PAGO_INICIAL').getValue());
                                    var FECHA_PAGO_FINAL = mostrarFecha(Ext.getCmp('FECHA_PAGO_FIN').getValue());
                                    if(FECHA_PAGO_INICIAL == null){
                                        Ext.MessageBox.alert('Error','¡Seleccione una fecha de pago!');
                                    }else{
                                         window.open("reportesAC.do?method=reporte_TESORERIA_ListadoDeCobranzaExportToPDF&fechainicial="+FECHA_PAGO_INICIAL+"&fechafinal="+FECHA_PAGO_FINAL+"&tipo_reporte=1");
                                    }
                                }
                            }),
                            '-',
                            Ext.create('Ext.form.ComboBox', {
                                fieldLabel: 'Tipo de Reporte',
                                store: cbxDataTipoReporteListCobr,
                                emptyText: 'Seleccione un tipo de reporte',
                                size: 30,
                                displayField: 'namee',
                                valueField: 'valuee',
                                value: '1',
                                id: 'TIPO_REPORTE_LISTCOBR'                               
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    winTesListadoCobranza_1.close();                            
                                }
                            })                            
                        ]
                    }); //Termina Toolbar
                    
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'frmRepTesListadoCobranza',   
                                tbar: tbTesListadoCobranza,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        height: 70,
                                        title: 'Filtros de Busqueda',
                                        items:[
                                            {
                                                xtype: 'container',
                                                layout: {
                                                    type: 'hbox'
                                                },
                                                items:[
                                                    {
                                                        xtype: 'container',
                                                        flex: 0.20,
                                                        items:[
                                                            {
                                                                xtype: 'datefield',
                                                                name: 'FECHA_PAGO_INICIAL',
                                                                id: 'FECHA_PAGO_INICIAL_LISTCOBR',
                                                                labelWidth: 80,
                                                                fieldLabel: 'Fecha Inicial' 
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'container',
                                                        flex: 0.20,
                                                        items:[
                                                            {
                                                                xtype: 'datefield',
                                                                name: 'FECHA_PAGO_FIN',
                                                                id: 'FECHA_PAGO_FIN_LISTCOBR',
                                                                labelWidth: 45,
                                                                fieldLabel: 'Fecha Final',
                                                                labelWidth: 80
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'container',
                                                        flex: 0.25,
                                                        items:[                                                            
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Camp. Fin',
                                                                store: cbxCampFinanciera,
                                                                id: 'ID_CAMPANA_FINANCIERA_LISTCOBR',
                                                                emptyText: 'Seleccione una campaña',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',
                                                                labelWidth: 60
                                                            })                                                            
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'container',
                                                        flex: 0.25,
                                                        items:[                                                            
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Forma de Pago',
                                                                store: cbxFormaPago,
                                                                emptyText: 'Seleccione una forma de pago',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',
                                                                id: 'ID_FORMA_PAGO_LISTCOBR',
                                                                multiSelect: true,
                                                                listeners:{
                                                                    select: function(combo, records){
                                                                        strResultFormasPago = this.getValue()+',';
                                                                    }
                                                                }
                                                            })                                                            
                                                        ]
                                                    }
                                                ]
                                            }
                                        ] // Cierra items fieldset
                                    },
                                    {
                                        xtype: 'grid',
                                        height: 455,
                                        store: storeTES_listadoCobranza,
                                        id:'gridTES_listadoCobranza',
                                        name: 'gridTES_listadoCobranza',
                                        columns: [
                                            {
                                                dataIndex: 'ID_RECIBO',
                                                flex: .03,
                                                align:'center',
                                                text :'Recibo'
                                            },
                                            {
                                                dataIndex: 'ID_DONANTE',
                                                flex: .03,
                                                align:'center',
                                                text :'Donante'
                                            },
                                            {
                                                dataIndex: 'NOMBRE_DONANTE',
                                                flex: .1,
                                                align:'left',
                                                text :'Nombre Donante'
                                            },
                                            {
                                                dataIndex: 'IMPORTE',
                                                flex: .03,
                                                align:'center',
                                                text :'Importe',
                                                renderer: render_moneyLISTCOBR
                                            },
                                            {
                                                dataIndex: 'NUM_FRECUENCIA',
                                                flex: .03,
                                                align:'center',
                                                text :'Pago'
                                            },
                                            {
                                                dataIndex: 'FECHA_PAGO',
                                                flex: .04,
                                                align:'center',
                                                text :'Fecha Pago'
                                            },                                    

                                            {
                                                dataIndex: 'FORMA_PAGO',
                                                flex: .04,
                                                align:'left',
                                                text :'Forma Pago'
                                            },
                                            {
                                                dataIndex: 'CUENTA',
                                                flex: .04,
                                                align:'left',
                                                text :'Cuenta'
                                            },
                                            {
                                                dataIndex: 'PROYECTO',
                                                flex: .06,
                                                align:'left',
                                                text :'Camp. Fin.'
                                            },
                                            {
                                                dataIndex: 'ASIGNACION',
                                                flex: .05,
                                                align:'left',
                                                text :'Asignación'
                                            }                                    
                                        ],
                                        viewConfig: {
                                        },
                                        selModel: Ext.create('Ext.selection.CheckboxModel', {
                                        }),
                                        bbar: new Ext.PagingToolbar({
                                            pageSize: 400,
                                            store: storeTES_listadoCobranza,
                                            displayInfo: true
                                        })
                                    }
                                ] //Cierra items form
                            }
                        ]
                    });            
                    Reportes.TES_listadoCobranza_1.superclass.initComponent.apply(this, arguments);
                    storeTES_listadoCobranza.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>