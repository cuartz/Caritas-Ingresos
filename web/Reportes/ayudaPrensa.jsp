<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>       
        <script type="text/javascript">
        /******************** VARIABLES GLOBALES ***********************/    
        var winReportAyudaPrensa;
        
        /******************** MODEL ***********************/   
        Ext.define('ayudaPrensaMdl',{ 
            id:'ayudaPrensaMdl',
            extend: 'Ext.data.Model',
            fields:[                
                {name: 'ID_RECIBO'},
                {name: 'ESTATUS'},
                {name: 'FECHA_ALTA'},               
                {name: 'CAMP_FINANCIERA'},
                {name: 'IMPORTE'},
                {name: 'NUM_CASO'},
                {name: 'FECHA_PAGO'},
                {name: 'FORMA_PAGO'}                
            ]
        });
        
        /******************** STORE ***********************/
        var storeReportAyudaPrensa = Ext.create('Ext.data.JsonStore', {                   
            model: 'ayudaPrensaMdl',
            pageSize: 200,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'reportesAC.do?method=reportAyudaPrensa',                                     
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
            
        /******************** INICIA PANTALLA ***********************/
        Ext.define('Reportes.ayudaPrensa', {                    
            extend: 'Ext.window.Window',                    
            alias:'widget.ayudaPrensa',                
            title: 'Ingresos - Reporte de Ayuda y Prensa',
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
                winReportAyudaPrensa = this;                
                
                var tbarReportAyudaPrensa = new Ext.Toolbar({
                    items:[
                        new Ext.Button({
                            text:'Buscar',
                            iconCls: 'icon-find',
                            handler:function(){                                
                                var FECHA_PAGO_1 = Ext.getCmp('FECHA_PAGO_REPORTAP_1').getValue();
                                var FECHA_PAGO_2 = Ext.getCmp('FECHA_PAGO_REPORTAP_2').getValue();
                                storeReportAyudaPrensa.proxy.extraParams = {
                                    FECHA_PAGO_INI:FECHA_PAGO_1,
                                    FECHA_PAGO_FIN:FECHA_PAGO_2
                                };
                                storeReportAyudaPrensa.load();
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Limpiar Filtros',
                            iconCls: 'icon-clear',
                            handler:function(){                                    
                                Ext.getCmp('frmReportAyudaPrensa').getForm().reset();
                                storeReportAyudaPrensa.proxy.extraParams = {
                                    FECHA_PAGO_INI:null,
                                    FECHA_PAGO_FIN:null                                        
                                };
                                storeReportAyudaPrensa.load();
                            }
                        }),                        
                        '-',
                        new Ext.Button({
                            text:'Exportar Reporte',
                            iconCls:'icon-xlsx',
                            handler:function(){                                    
                                var FECHA_PAGO_1 = Ext.getCmp('FECHA_PAGO_REPORTAP_1').getValue();
                                var FECHA_PAGO_2 = Ext.getCmp('FECHA_PAGO_REPORTAP_2').getValue();
                                if(FECHA_PAGO_1 == null){
                                    Ext.MessageBox.alert('Error','¡Seleccione una fecha de pago!');
                                }else{
                                    window.open("ShowExcel?idOperationType=20&fechaIni="+FECHA_PAGO_1+"&fechaFin="+FECHA_PAGO_2);
                                }
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winReportAyudaPrensa.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',  
                            id: 'frmReportAyudaPrensa',
                            border: false,
                            tbar: tbarReportAyudaPrensa,
                            items:[
                                {
                                    xtype: 'fieldset',
                                    height: 90,
                                    title: 'Filtros',
                                    items:[
                                        {
                                            xtype: 'datefield',
                                            width: 325,
                                            labelWidth: 130,
                                            fieldLabel: 'Fecha Inicial',
                                            id: 'FECHA_PAGO_REPORTAP_1'
                                        },
                                        {
                                            xtype: 'datefield',
                                            width: 325,
                                            labelWidth: 130,
                                            fieldLabel: 'Fecha Final',
                                            id: 'FECHA_PAGO_REPORTAP_2'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'grid',                                                    
                                    height: 460,
                                    id: 'gridReportAyudaPrensa',
                                    store: storeReportAyudaPrensa,
                                    columns: [
                                        {
                                            dataIndex: 'ID_RECIBO',
                                            text: 'Recibo',
                                            flex: .03,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'ESTATUS',
                                            text: 'Estatus',
                                            flex: .03,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'FECHA_ALTA',
                                            text: 'Fecha Alta',
                                            flex: .04,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'CAMP_FINANCIERA',
                                            text: 'Camp. Financiera',
                                            flex: .1,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'IMPORTE',
                                            text: 'Importe',
                                            flex: .03,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'NUM_CASO',
                                            text: 'Caso',
                                            flex: .03,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'FECHA_PAGO',
                                            text: 'Fecha Pago',
                                            flex: .03,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'FORMA_PAGO',
                                            text: 'Forma Pago',
                                            flex: .06,
                                            align:'center'
                                        }
                                    ],
                                    viewConfig: {

                                    },
                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                    }),
                                    bbar: new Ext.PagingToolbar({
                                        pageSize: 200,
                                        store: storeReportAyudaPrensa,
                                        displayInfo: true,
                                        emptyMsg: '¡No hay pagos para que mostrar!'  
                                    })
                                }
                            ] //Cierra items form
                        }
                    ] //Cierra items Ext.apply
                }); //Cierra Ext.apply
                storeReportAyudaPrensa.load();
                Reportes.ayudaPrensa.superclass.initComponent.apply(this, arguments);
            } //Cierra initComponent            
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>