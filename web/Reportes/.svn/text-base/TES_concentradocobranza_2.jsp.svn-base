<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>       
    <script type="text/javascript">             
    /*********************** VARIABLES GLOBALES *******************************/       
    var winReportConcentradoCobranza;    
    
    /*********************** MODELS *******************************/       
    Ext.define('TES_concentradocobranza',{// create the Data Atenciones
        id:'TES_concentradocobranza',
        extend: 'Ext.data.Model',
        fields:     [
//            {name: 'PROYECTO'},
            {name: 'NOMBRE'},
            {name: 'CANTIDAD'},
            {name: 'IMPORTE'}
        ]
    });
    
    /*********************** STORES *******************************/
    var storeTES_concentradocobranza_1 = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
        model: 'TES_concentradocobranza',
        waitMsg:'Loading...',
        pageSize: 200,
        autoLoad:false,
        proxy: {
            type: 'ajax',
            url: 'reportesAC.do?method=reporte_TESORERIA_ConcentradoDeCobranza', 
            reader: {
                type: 'json',
                root: 'rows',
                totalProperty:'totalcount'
            }
        }
    });

    /************************ FUNCIONES JAVASCPRIT ******************************/
    function render_moneyRPP(v, p, record){
        return '$ '+v
    }
    
    function initialConcentradoCobranza(){        
        storeTES_concentradocobranza_1.load({callback: function(records,o,s){
                Ext.getCmp('chkbxAsignacion_concentrado').setValue(true);
//                storeTES_concentradocobranza_1.load();
        }});
    }

    //Inicia
    Ext.define('Reportes.TES_concentradocobranza_2', {
        extend: 'Ext.window.Window',
        id:'TES_concentradocobranza_2',
        name: 'Reportes.TES_concentradocobranza_2',
        alias:'widget.TES_concentradocobranza_2',                
        title: 'Tesoreria - Concentrado de Cobranza',
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
            winReportConcentradoCobranza = this;            
            initialConcentradoCobranza();
            
            var tbTesConcentradoCobranza = new Ext.Toolbar({
                items:[
                    new Ext.Button({
                        text:'Buscar',
                        iconCls: 'icon-find',
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
                            storeTES_concentradocobranza_1.proxy.extraParams = {
                                FECHA_INI:FECHA_PAGO_INICIAL_C,
                                FECHA_FIN:FECHA_PAGO_FINAL_C,
                                CHKBX_PROY:CHKBX_PROY_C,
                                CHKBX_ASIGN:CHKBX_ASIGN_C
                            };
                            storeTES_concentradocobranza_1.load();
                        }
                    }),
                    '-',
                    {
                        xtype: 'datefield',
                        name: 'FECHA_PAGO_INICIAL_CONCENTRADO',
                        id: 'FECHA_PAGO_INICIAL_CONCENTRADO',
                        labelWidth: 45,
                        fieldLabel: 'Fecha Inicial',
                        labelWidth: 80//                                
                    },
                    '-',
                    {
                        xtype: 'datefield',
                        name: 'FECHA_PAGO_FIN_CONCENTRADO',
                        id: 'FECHA_PAGO_FIN_CONCENTRADO',
                        labelWidth: 45,
                        fieldLabel: 'Fecha Final',
                        labelWidth: 80
                    },
                    '-',                    
                    {
                        xtype: 'checkbox',
                        fieldLabel: 'Proyecto',
                        id: 'chkbxProyecto_concentrado',
                        labelWidth: 60                        
                    },
                    '-',
                    {
                        xtype: 'checkbox',
                        labelWidth: 60,
                        id: 'chkbxAsignacion_concentrado',
                        fieldLabel: 'Asignación'
                    },
                    '-',
                    new Ext.Button({
                        text:'Limpiar Filtros',
                        iconCls: 'icon-clear',
                        handler:function(){                              
                            Ext.getCmp('FECHA_PAGO_INICIAL_CONCENTRADO').reset();
                            Ext.getCmp('FECHA_PAGO_FIN_CONCENTRADO').reset();
                            Ext.getCmp('chkbxProyecto_concentrado').reset();
                            Ext.getCmp('chkbxAsignacion_concentrado').setValue(true);
                            storeTES_concentradocobranza_1.proxy.extraParams = {
                                FECHA_INI:null,
                                FECHA_FIN:null,
                                CHKBX_PROY:0,
                                CHKBX_ASIGN:1
                            };
                            storeTES_concentradocobranza_1.load();
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
                            winReportConcentradoCobranza.close();                            
                        }
                    })                            
                ]
            }); //Termina Toolbar
            
            Ext.apply(this, {
                items: [
                    {
                        xtype: 'grid',
                        store: storeTES_concentradocobranza_1,
                        tbar: tbTesConcentradoCobranza,
                        id:'gridTES_concentradocobranza',
                        name: 'gridTES_concentradocobranza',                            
                        columns: [                            
                            {
                                dataIndex: 'NOMBRE',
                                flex: .1,
                                align:'left',
                                text :'Asignación / Proyecto'

                            },
                            {
                                dataIndex: 'CANTIDAD',
                                flex: .03,
                                align:'center',
                                text :'Cantidad'

                            },
                            {
                                dataIndex: 'IMPORTE',
                                flex: .03,
                                align:'center',
                                text :'Importe'

                            }
                        ],
                        bbar: new Ext.PagingToolbar({
                            pageSize: 200,
                            store: storeTES_concentradocobranza_1,
                            displayInfo: true
                        })
                    }
                ]
            });

            Reportes.TES_concentradocobranza_2.superclass.initComponent.apply(this, arguments);
            //storeTES_concentradocobranza_1.load();//en blanco comentar esta linea
        }
    });
    </script>
    </head>
    <body>
    </body>
</html>
