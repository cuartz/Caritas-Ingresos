<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>        
        <script type="text/javascript"> 
        /*********************** VARIABLES GLOBALES ****************************/
        var reportRecibosImpresos;
        
        /*********************** FUNCIONES JAVASCRIPT ****************************/
        function render_moneyRPP(v, p, record){
            return '$ '+v
        }
        
        /*********************** MODELS ****************************/
        Ext.define('TES_concentradocobranza',{// create the Data Atenciones
            id:'TES_concentradocobranza',
            extend: 'Ext.data.Model',
            fields:     [
                {name: 'ROWNUMBER'},
                {name: 'ID_DONANTE'},
                {name: 'NOMBRE_DONANTE'},                
                {name: 'ID_RECIBO'},
                {name: 'ID_NUM_PAGO'},
                {name: 'IMPORTE'},
                {name: 'RECOLECTOR'},
                {name: 'ID_RECOLECTOR'},
                {name: 'FECHA_IMPRESION'},
                {name: 'FORMA_PAGO'},
                {name: 'USUARIO_IMPRESO'}
            ]
        });
        
        Ext.define('Usuarios',{// create the Data cbUsuarios
            id:'Usuarios',
            extend: 'Ext.data.Model',
            fields:['NOMBRE', 'ID']
        });

        /*********************** STORES ****************************/
        var storeTES_rastreoRecibosDeducibles_3 = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
            model: 'TES_concentradocobranza',
            waitMsg:'Loading...',
            pageSize: 300,
            autoLoad:false,
            proxy: {
                type: 'ajax',
                url: 'reportesAC.do?method=reporte_TESORERIA_recibosImpresos', 
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'
                }
            }            
        });
        
        var storeUsuarioRI = Ext.create('Ext.data.JsonStore', {// create the Store cbUsuarios
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

        var parametersAT = new Ext.form.field.Hidden({//Parametros para obtener informacion en el grid
            fechaini :'15/08/2012',
            fechafin : '31/12/2012' ,
            usuario : '-1'            
        });     
            
        //Inicia
        Ext.define('Reportes.TES_rastreoRecibosDeducibles_3', {
            extend: 'Ext.window.Window',
            id:'TES_rastreoRecibosDeducibles_3',
            name: 'Reportes.TES_rastreoRecibosDeducibles_3',
            alias:'widget.TES_rastreoRecibosDeducibles_3',                
            title: 'Reporte de Tesoreria - Recibos Imprésos',
            width: 1150,                
            height: 600,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',    
            region:'center',
            closeAction:'destroy',
            autoScroll:true,
            initComponent: function() {                
                reportRecibosImpresos = this;
                
                var tbTesRecibosImpresos = new Ext.Toolbar({
                    items:[
                        new Ext.Button({
                            text:'Buscar',
                            iconCls: 'icon-find',
                            handler:function(){
                                var FECHA_PAGO_INICIAL_RI = Ext.getCmp('FECHA_PAGO_INICIAL_RIMPRESOS').getValue();
                                var FECHA_PAGO_FINAL_RI = Ext.getCmp('FECHA_PAGO_FIN_RIMPRESOS').getValue(); 
                                var USUARIO_RI = Ext.getCmp('ID_USUARIO_RIMPRESOS').getValue();                                
                                if(FECHA_PAGO_INICIAL_RI == null || FECHA_PAGO_FINAL_RI == null){
                                    Ext.MessageBox.alert('Error','Selecciona una fecha inicial y final');
                                    return false;
                                }                                                                
                                storeTES_rastreoRecibosDeducibles_3.proxy.extraParams = {
                                    FECHA_INI:FECHA_PAGO_INICIAL_RI,
                                    FECHA_FIN:FECHA_PAGO_FINAL_RI,
                                    USUARIO:USUARIO_RI                                    
                                };
                                storeTES_rastreoRecibosDeducibles_3.load();
                            }
                        }),
                        '-',
                        {
                            xtype: 'datefield',
                            name: 'FECHA_PAGO_INICIAL_RIMPRESOS',
                            id: 'FECHA_PAGO_INICIAL_RIMPRESOS',
                            labelWidth: 45,
                            fieldLabel: 'Fecha Inicial',
                            labelWidth: 80//                                
                        },
                        '-',
                        {
                            xtype: 'datefield',
                            name: 'FECHA_PAGO_FIN_RIMPRESOS',
                            id: 'FECHA_PAGO_FIN_RIMPRESOS',
                            labelWidth: 45,
                            fieldLabel: 'Fecha Final',
                            labelWidth: 80
                        },
                        '-',
                        Ext.create('Ext.form.ComboBox', {
                            fieldLabel: 'Usuario',
                            id: 'ID_USUARIO_RIMPRESOS',
                            store: storeUsuarioRI,                            
                            labelWidth: 45,
                            displayField: 'ID',
                            valueField: 'ID'
                        }),
                        '-',
                        new Ext.Button({
                            text:'Limpiar Filtros',
                            iconCls: 'icon-clear',
                            handler:function(){                              
                                Ext.getCmp('FECHA_PAGO_INICIAL_RIMPRESOS').reset();
                                Ext.getCmp('FECHA_PAGO_FIN_RIMPRESOS').reset();
                                Ext.getCmp('ID_USUARIO_RIMPRESOS').reset();                                
                                storeTES_rastreoRecibosDeducibles_3.proxy.extraParams = {
                                    FECHA_INI:null,
                                    FECHA_FIN:null,
                                    USUARIO:null
                                };
                                storeTES_rastreoRecibosDeducibles_3.load();
                            }
                        }),                    
                        '-',
                        new Ext.Button({
                            text:'Exportar',
                            iconCls:'icon-xlsx',
                            handler:function(){                                                                        
                                var FECHA_PAGO_INICIAL_C = Ext.getCmp('FECHA_PAGO_INICIAL_CONCENTRADO').getValue();
                                var FECHA_PAGO_FINAL_C = Ext.getCmp('FECHA_PAGO_FIN_CONCENTRADO').getValue(); 
                                var CHKBX_PROY_C = Ext.getCmp('chkbxProyecto_concentrado').getValue();
                                var CHKBX_ASIGN_C = Ext.getCmp('chkbxAsignacion_concentrado').getValue();
                                if(CHKBX_PROY_C == false) CHKBX_PROY_C = 0;
                                if(CHKBX_PROY_C == true) CHKBX_PROY_C = 1;
                                if(CHKBX_ASIGN_C == false) CHKBX_ASIGN_C = 0;
                                if(CHKBX_ASIGN_C == true) CHKBX_ASIGN_C = 1; 
                                if(FECHA_PAGO_INICIAL_C == null || FECHA_PAGO_FINAL_C == null){
                                    Ext.MessageBox.alert('Error','Selecciona una fecha inicial y final');
                                    return false;
                                }
                                if(CHKBX_PROY_C == 0 && CHKBX_ASIGN_C == 0){
                                    Ext.MessageBox.alert('Error','Selecciona alguna modalidad de Proyecto o Asignación');
                                    return false;
                                }
                                if(CHKBX_PROY_C == 1 && CHKBX_ASIGN_C == 1){
                                    Ext.MessageBox.alert('Error','Selecciona una sola modalidad de Proyecto o Asignación');
                                    return false;
                                }
                                window.open("ShowExcel?idOperationType=11&FECHA_INI="+FECHA_PAGO_INICIAL_C+"&FECHA_FIN="+FECHA_PAGO_FINAL_C+"&CHKBX_PROY="+CHKBX_PROY_C+"&CHKBX_ASIGN="+CHKBX_ASIGN_C);                            
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                reportRecibosImpresos.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar                
                
                Ext.apply(this, {
                    items: [
                        {
                            xtype: 'grid',
                            tbar: tbTesRecibosImpresos,
                            store: storeTES_rastreoRecibosDeducibles_3,
                            id:'gridTES_rastreoRecibosDeducibles_3',
                            name: 'gridTES_rastreoRecibosDeducibles_3',
                            columns: [
//                                {
//                                    dataIndex: 'ROWNUMBER',
//                                    flex: .02,
//                                    align:'center',
//                                    text :'#'
//                                },
                                {
                                    dataIndex: 'ID_DONANTE',
                                    flex: .02,
                                    align:'center',
                                    text :'Donante'
                                },
                                {
                                    dataIndex: 'NOMBRE_DONANTE',
                                    flex: .1,
                                    align:'left',
                                    text :'Nombre'
                                },
                                {
                                    dataIndex: 'ID_RECIBO',
                                    flex: .03,
                                    align:'center',
                                    text :'Recibo'
                                },
                                {
                                    dataIndex: 'ID_NUM_PAGO',
                                    flex: .02,
                                    align:'center',
                                    text :'Pago'
                                },
                                {
                                    dataIndex: 'IMPORTE',
                                    flex: .04,
                                    align:'center',
                                    text :'Importe'
                                },
                                {
                                    dataIndex: 'ID_RECOLECTOR',
                                    flex: .03,
                                    align:'center',
                                    text :'Recolector'
                                },
                                {
                                    dataIndex: 'FECHA_IMPRESION',
                                    flex: .03,
                                    align:'center',
                                    text :'Fecha Impresión'
                                },
                                {
                                    dataIndex: 'FORMA_PAGO',
                                    flex: .04,
                                    align:'center',
                                    text :'Forma Pago'
                                },
                                {
                                    dataIndex: 'USUARIO_IMPRESO',
                                    flex: .05,
                                    align:'center',
                                    text :'Usuario'
                                }
                            ],

//                                    ,Ext.create('Ext.Button', {
//                                        text: ' Exportar ',
//                                        iconCls:'icon-xlsx',
//                                        handler: function() {
//                                            window.open("ShowExcel?idOperationType=12&fechaini="+parametersAT.fechaini+ "&fechafin="+parametersAT.fechafin+"&usuario="+parametersAT.usuario);
//                                        }
//                                    }),
                            bbar: new Ext.PagingToolbar({
                                pageSize: 300,
                                store: storeTES_rastreoRecibosDeducibles_3,
                                displayInfo: true
                            })
                        }
                    ]
                });            
                Reportes.TES_rastreoRecibosDeducibles_3.superclass.initComponent.apply(this, arguments);
                storeTES_rastreoRecibosDeducibles_3.load();//en blanco comentar esta linea
            }
        });
        </script>
    </head>
    <body>
    </body>
</html>