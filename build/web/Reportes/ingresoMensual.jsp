<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%
    HttpSession sesion = request.getSession();
    String idusersession = "";
    try {
        if (sesion.getAttribute("idusersession") != null) {
            idusersession = sesion.getAttribute("idusersession").toString();
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>
<html>
    <head>       
        <script type="text/javascript">
        /******************** VARIABLES GLOBALES **************************/
        var winReportIngresoMensual;
        
        /******************** MODEL ***********************/   
        Ext.define('ingresoMensualMdl',{ 
            id:'ingresoMensualMdl',
            extend: 'Ext.data.Model',
            fields:[                
                {name: 'TARJETA_CREDITO'},
                {name: 'TARJETA_DEBITO'},
                {name: 'TRANSFERENCIA'},
                {name: 'DEPOSITO'},
                {name: 'CHEQUE'},
                {name: 'EFECTIVO'},
                {name: 'NO_ESPECIFICADO'}
            ]
        });
        
        /******************** FUNCIONES JAVASCRIPT **************************/
        function render_moneyRIM(v, p, record){
            var q = Ext.util.Format.number(v , '0,000.00')
            return '$ '+q
        }
        
        /******************** STORES **************************/
        var storeReportIngresoMensual = Ext.create('Ext.data.JsonStore', {                   
            model: 'ingresoMensualMdl',
            pageSize: 200,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'reportesAC.do?method=reportIngresoMensual',                                     
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
        
            
        Ext.define('Reportes.ingresoMensual', {
            extend: 'Ext.window.Window',                   
            alias:'widget.ingresoMensual',                
            title: 'Ingreso Mensual por Forma de Pago',
            constrain : true,
            width: 1100,                
            height: 300,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy', 
            region:'center',
            modal: true,
            initComponent: function() {                
                winReportIngresoMensual = this;
                
                var tbarReportIngresoMensual = new Ext.Toolbar({
                    items:[
                        {
                            xtype: 'datefield',
                            name: 'imFechaInicial',
                            id: 'imFechaInicial',
                            labelWidth: 45,
                            fieldLabel: 'Fecha Inicial',
                            labelWidth: 80,
                            listeners: {
                                
                            }
                        },
                        '-',
                        {
                            xtype: 'datefield',
                            name: 'imFechaFinal',
                            id: 'imFechaFinal',
                            labelWidth: 45,
                            fieldLabel: 'Fecha Final',
                            labelWidth: 80,
                            listeners: {
                                
                            }
                        },
                        '-',
                        new Ext.Button({
                            text:'Buscar',
                            iconCls: 'icon-find',
                            handler:function(){                                
                                var FECHA_1 = Ext.getCmp('imFechaInicial').getValue();
                                var FECHA_2 = Ext.getCmp('imFechaFinal').getValue();
                                storeReportIngresoMensual.proxy.extraParams = {
                                    FECHA_INI:FECHA_1,
                                    FECHA_FIN:FECHA_2
                                };
                                storeReportIngresoMensual.load();
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Limpiar Filtros',
                            iconCls: 'icon-clear',
                            handler:function(){
                                Ext.getCmp('frmReportIngresoMensual').getForm().reset();
                                Ext.getCmp('imFechaInicial').setValue('');
                                Ext.getCmp('imFechaFinal').setValue('');
                                storeReportIngresoMensual.proxy.extraParams = {
                                    FECHA_INI:null,
                                    FECHA_FIN:null
                                };
                                storeReportIngresoMensual.load();
                            }
                        }),                        
                        '-',                        
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winReportIngresoMensual.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',  
                            id: 'frmReportIngresoMensual',
                            border: false,
                            tbar: tbarReportIngresoMensual,
                            items:[                                
                                {
                                    xtype: 'grid',                                                    
                                    height: 240,
                                    id: 'gridReportIngresoMensual',
                                    store: storeReportIngresoMensual,
                                    columns: [
                                        {
                                            dataIndex: 'TARJETA_CREDITO',
                                            text: 'Tarjeta Crédito',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        },
                                        {
                                            dataIndex: 'TARJETA_DEBITO',
                                            text: 'Tarjeta Débito',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        },
                                        {
                                            dataIndex: 'TRANSFERENCIA',
                                            text: 'Transferencia',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        },
                                        {
                                            dataIndex: 'DEPOSITO',
                                            text: 'Deposito',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        },
                                        {
                                            dataIndex: 'CHEQUE',
                                            text: 'Cheque',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        },
                                        {
                                            dataIndex: 'EFECTIVO',
                                            text: 'Efectivo',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        },
                                        {
                                            dataIndex: 'NO_ESPECIFICADO',
                                            text: 'No especificado',
                                            flex: .04,
                                            align:'center',
                                            renderer: render_moneyRIM
                                        }
                                    ],
                                    viewConfig: {
                                        
                                    },
                                    selModel: Ext.create('Ext.selection.CheckboxModel', {
                                        
                                    }),
                                    bbar: new Ext.PagingToolbar({
                                        pageSize: 200,
                                        store: storeReportIngresoMensual,
                                        displayInfo: true,
                                        emptyMsg: '¡No hay registros para que mostrar!'  
                                    })
                                }
                            ] //Cierra form principal
                        }                        
                    ] //Cierra items Ext.apply
                }) //Cierra Ext.apply
                storeReportIngresoMensual.load();
                Reportes.ingresoMensual.superclass.initComponent.apply(this, arguments);
            } //Cierra initComponent
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>