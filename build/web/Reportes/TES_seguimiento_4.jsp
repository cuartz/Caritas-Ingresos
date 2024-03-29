<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>        
        <script type="text/javascript"> 
         
        var winReportTesSeguimiento; 
         
        /************************* FUNCIONES JAVASCRIPT *******************************/
        function render_moneyRPP(v, p, record){
            return '$ '+v
        }
        
        /************************* MODELS ******************************/           
        Ext.define('TES_seguimiento',{// create the Data Atenciones
            id:'TES_seguimiento',
            extend: 'Ext.data.Model',
            fields:     [
//                {name: 'ID_DONANTE'},
//                {name: 'NOMBRE_DONANTE'},
//                {name: 'ID_RECIBO'},
//                {name: 'ID_CAMPANA_FINANCIERA'},
//                {name: 'SUB_CAMPANA'},
//                {name: 'ID_ASIGNACION'},
//                {name: 'ID_NUM_PAGO'},
//                {name: 'IMPORTE'},
//                {name: 'ID_TIPO_DIRECCION'},
//                {name: 'CALLE'},
//                {name: 'NUMERO'},
//                {name: 'COLONIA'},
//                {name: 'ID_USUARIO'}                
                {name: 'ID_DONANTE'},
                {name: 'NOMBRE'},
                {name: 'ID_RECIBO'},
                {name: 'IMPORTE'},
                {name: 'STATUS_RECIBO'},
                {name: 'CAMP_FIN'},
                {name: 'CATEGORIA'},
                {name: 'ASIGNACION'},
                {name: 'USUARIO'},
                {name: 'NUM_CASO'},
                {name: 'DIRECCION'},
            ]
        });
        
        Ext.define('Usuarios',{// create the Data cbUsuarios
            id:'Usuarios',
            extend: 'Ext.data.Model',
            fields:['NOMBRE', 'ID']
        });
        
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });
        
        /************************* STORES ******************************/
        var storeTES_seguimiento_4 = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
            model: 'TES_seguimiento',
            waitMsg:'Loading...',
            pageSize: 200,
            autoLoad:false,
            proxy: {
                type: 'ajax',
                url: 'reportesAC.do?method=reporte_TESORERIA_seguimiento', 
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'
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
        
        var storeUsuario = Ext.create('Ext.data.JsonStore', {// create the Store cbUsuarios
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
            
        var parametersAT = new Ext.form.field.Hidden({
            fechaini :'15/08/2012',
            fechafin : '31/12/2012' ,
            usuario : '-1'            
        });         
            
       /************************* INICIA PANTALLA ******************************/
        Ext.define('Reportes.TES_seguimiento_4', {
            extend: 'Ext.window.Window',
            id:'TES_seguimiento_4',
            name: 'Reportes.TES_seguimiento_4',
            alias:'widget.TES_seguimiento_4',                
            title: 'Reporte de Tesoreria Seguimiento',
            width: 1150,                
            height: 600,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',    
            region:'center',
            closeAction:'destroy',
            autoScroll:true,//modificacion
            initComponent: function() {
                winReportTesSeguimiento = this;
                
                var tbReporTesSeguimiento = new Ext.Toolbar({
                    items:[
                        new Ext.Button({
                            text:'Buscar',
                            iconCls: 'icon-find',
                            handler:function(){
                                var FECHA_PAGO_INICIAL = Ext.getCmp('FECHA_PAGO_INICIAL').getValue();
                                var FECHA_PAGO_FINAL = Ext.getCmp('FECHA_PAGO_FIN').getValue();
                                var CAMP_FINN = Ext.getCmp('ID_CAMPANA_FINANCIERA').getValue();
                                storeTES_seguimiento_4.proxy.extraParams = {
                                    FECHA_INI:FECHA_PAGO_INICIAL,
                                    FECHA_FIN:FECHA_PAGO_FINAL,
                                    idCampFin:CAMP_FINN
                                };
                                storeTES_seguimiento_4.load();
                            }
                        }),
                        '-',
                        {
                            xtype: 'datefield',
                            name: 'FECHA_PAGO_INICIAL',
                            id: 'FECHA_PAGO_INICIAL',
                            labelWidth: 45,
                            fieldLabel: 'Fecha Inicial',
                            labelWidth: 80//                                
                        },
                        '-',
                        {
                            xtype: 'datefield',
                            name: 'FECHA_PAGO_FIN',
                            id: 'FECHA_PAGO_FIN',
                            labelWidth: 45,
                            fieldLabel: 'Fecha Final',
                            labelWidth: 80
                        },
                        '-',
                        Ext.create('Ext.form.ComboBox', {
                            fieldLabel: 'Campaña Financiera',
                            store: cbxCampFinanciera,
                            id: 'ID_CAMPANA_FINANCIERA',
                            emptyText: 'Seleccione la campaña',
                            labelWidth: 140,
                            displayField: 'nombre',
                            valueField: 'id'
                        }),
                        '-',
                        new Ext.Button({
                            text:'Limpiar Filtros',
                            iconCls: 'icon-clear',
                            handler:function(){                                    
                                Ext.getCmp('FECHA_PAGO_INICIAL').reset();
                                Ext.getCmp('FECHA_PAGO_FIN').reset();
                                Ext.getCmp('ID_CAMPANA_FINANCIERA').reset();
                                storeTES_seguimiento_4.proxy.extraParams = {
                                    FECHA_INI:null,
                                    FECHA_FIN:null,
                                    ID_CAMPANA_FINANCIERA:0
                                };
                                storeTES_seguimiento_4.load();
                            }
                        }),                        
                        '-',
                        new Ext.Button({
                            text:'Exportar',
                            iconCls:'icon-xlsx',
                            handler:function(){                                                                        
                                var FECHA_PAGO_INICIAL = Ext.getCmp('FECHA_PAGO_INICIAL').getValue();
                                var FECHA_PAGO_FINAL = Ext.getCmp('FECHA_PAGO_FIN').getValue();
                                if(FECHA_PAGO_INICIAL == null){
                                    Ext.MessageBox.alert('Error','¡Seleccione una fecha de pago!');
                                }else{
                                    window.open("ShowExcel?idOperationType=17&fechaPagoIni="+FECHA_PAGO_INICIAL+"&fechaPagoFin="+FECHA_PAGO_FINAL);
                                }
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winReportTesSeguimiento.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                Ext.apply(this, {
                    items: [
                        {
                            xtype: 'grid',
                            store: storeTES_seguimiento_4,
                            tbar: tbReporTesSeguimiento,
                            id:'gridTES_seguimiento_4',
                            name: 'gridTES_seguimiento_4',
                            columns: [
                                {
                                    dataIndex: 'ID_DONANTE',
                                    flex: .02,
                                    align:'center',
                                    text :'Donante'
                                },
                                {
                                    dataIndex: 'NOMBRE',
                                    flex: .06,
                                    align:'left',
                                    text :'Nombre'
                                },
                                {
                                    dataIndex: 'ID_RECIBO',
                                    flex: .02,
                                    align:'center',
                                    text :'Recibo'
                                },
                                {
                                    dataIndex: 'IMPORTE',
                                    flex: .02,
                                    align:'center',
                                    text :'Importe',
                                    renderer: render_moneyRPP
                                },
                                {
                                    dataIndex: 'STATUS_RECIBO',
                                    flex: .02,
                                    align:'center',
                                    text :'Status'
                                },                                
                                {
                                    dataIndex: 'ASIGNACION',
                                    flex: .05,
                                    align:'left',
                                    text :'ASIGNACION'
                                },
                                {
                                    dataIndex: 'NUM_CASO',
                                    flex: .02,
                                    align:'center',
                                    text :'Caso'
                                },
                                {
                                    dataIndex: 'DIRECCION',
                                    flex: .1,
                                    align:'left',
                                    text :'Direccion Principal'
                                }
                            ],

//                            tbar: {
//                                xtype: 'toolbar',
//                                items: [
//                                    {
//                                        xtype: 'datefield',
//                                        name: 'fechaini',
//                                        id: 'fechaini',
//                                        labelWidth: 45,
//                                        fieldLabel: 'Fecha Inicial',
//                                        labelWidth: 80,
//                                        listeners: {
//                                            select: function(field, value, option){
//                                                parametersAT.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
//                                                storeTES_seguimiento_4.load();
//                                            }
//                                        }
//                                    }
//                                    ,
//                                    {xtype:'tbseparator'},
//                                    {
//                                        xtype: 'datefield',
//                                        name: 'fechafin',
//                                        id: 'fechafin',
//                                        labelWidth: 45,
//                                        fieldLabel: 'Fecha Final',
//                                        labelWidth: 80,
//                                        listeners: {
//                                            select: function(field, value, option){
//                                                parametersAT.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
//                                                storeTES_seguimiento_4.load();
//                                            }
//                                        }
//                                    }
//                                    ,
//                                    {xtype:'tbseparator'},
//                                    {
//                                        xtype: 'combo',
//                                        name: 'UsuarioAT',
//                                        id: 'UsuarioAT',
//                                        fieldLabel: 'Usuario',
//                                        labelWidth: 45,
//                                        store: storeUsuario,
//                                        anchor: '60%',
//                                        editable: false,
//                                        valueField: 'NOMBRE',
//                                        allowBlank:false,
//                                        displayField:'ID',
//                                        triggerAction: 'all',
//                                        defaultValue:'Mexico',
//                                        tabIndex: 13,
//                                        listeners:{
//                                            select:function(combo,record,opcion)
//                                            {
//                                                parametersAT.usuario= record[0].get("ID");
//                                                storeTES_seguimiento_4.load();
//                                            }
//                                        }
//                                    }
//                                    ,{xtype:'tbseparator'}
//                                    ,Ext.create('Ext.Button', {
//                                        text: ' Exportar ',
//                                        iconCls:'icon-xlsx',
//                                        handler: function() {
//                                            window.open("ShowExcel?idOperationType=13&fechaini="+parametersAT.fechaini+ "&fechafin="+parametersAT.fechafin+"&usuario="+parametersAT.usuario);
//                                        }
//                                    }),
//                                    {xtype:'tbseparator'},
//                                    {
//                                        xtype: 'button',
//                                        text: 'Salir',
//                                        iconCls:'icon-salir',
//                                        handler: function()
//                                        {
//                                            var win=Ext.getCmp('TES_seguimiento_4');
//                                            win.close();
//                                        }   
//                                    }
//                                ]
//                            },//Fin de tbar continuacion de barra de paginacion //Paginacion
                            bbar: new Ext.PagingToolbar({
                                pageSize: 200,
                                store: storeTES_seguimiento_4,
                                displayInfo: true
                            })
                        }
                    ]
                });            
                Reportes.TES_seguimiento_4.superclass.initComponent.apply(this, arguments);
                storeTES_seguimiento_4.load();//en blanco comentar esta linea
                cbxCampFinanciera.load();
            }
        });
        </script>
    </head>
    <body>
    </body>
</html>