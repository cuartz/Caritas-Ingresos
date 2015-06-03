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
        /************* VARIABLES GLOBALES *********************/
        var winReportRecibosPrecancelados;
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        
        Ext.define('recibosPrecanceladosMdl',{
            id:'recibosPrecanceladosMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_BITACORA'},    
                {name: 'ID_RECIBO'},
                {name: 'USUARIO_CANCELACION'},
                {name: 'FECHA_CANCELACION'},             
                {name: 'COMENTARIOS_CANCELACION'},                
                {name: 'IMPORTE'},
                {name: 'ID_DONATIVO'},
                {name: 'NOMBRE_DONANTE'}
            ]
        });
        
        Ext.define('donativosPrecanceladosMdl',{
            id:'donativosPrecanceladosMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_DONATIVO'},
                {name: 'FECHA_CANCELACION'},
                {name: 'MOTIVO_CANCELACION'},
                {name: 'ID_USUARIO_CANCELACION'},
                {name: 'NOMBRE_DONANTE'}                
            ]
        });
        
        Ext.define('Reportes.solicitudesRecibosPrecancelados', {
            extend: 'Ext.window.Window',                   
            alias:'widget.solicitudesRecibosPrecancelados',                
            title: 'Solicitud de Precancelación',
            constrain : true,
            width: 1100,                
            height: 600,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy', 
            region:'center',
            modal: true,
            initComponent: function() {
                /************* INICIALIZAR VARIABLES ****************/
                winReportRecibosPrecancelados = this;
                
                var storeRecibosPrecancelados = Ext.create('Ext.data.JsonStore', {                   
                    model: 'recibosPrecanceladosMdl',
                    pageSize: 100,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'cancelarPagoAC.do?method=getSolicitudesRecibosPrecancelados',                         
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty:'totalcount'//Paginacion                
                        }
                    }
                });
                
                var storeDonativosPrecancelados = Ext.create('Ext.data.JsonStore', {                   
                    model: 'donativosPrecanceladosMdl',
                    pageSize: 100,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'donativoAC.do?method=getSolicitudesDonativosPrecancelados',                         
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty:'totalcount'//Paginacion                
                        }
                    }
                });
                
                /************* TOOLBAR ****************/
                var tbarReportRecibosPrecancelados = new Ext.Toolbar({
                    items:[                        
                        new Ext.Button({
                            text: 'Aprobar',
                            iconCls: 'icon-add',
                            handler: function(){                                
                            var selectedRow = Ext.getCmp('gridRecibosPrecancelados').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                Ext.Msg.confirm('Aprobar', '¿Esta seguro de Aprobar la solicitud de cancelación?', function(btn, text){
                                    if (btn == 'yes'){                                        
                                        Ext.Ajax.request({  
                                            url : 'cancelarPagoAC.do?method=aprobarCancelacion&idUsuario='+idUsuario,
                                            params : {                                                         
                                                ID_BITACORA:selectedRow.data.ID_BITACORA
                                            },
                                            method: 'GET',
                                            success: function ( result, request ) {
                                                Ext.MessageBox.alert('Cancelado','El recibo se ha cancelado definitivamente');
                                                storeRecibosPrecancelados.load();
                                            },
                                            failure: function ( result, request) {
                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al cancelar el recibo!');                                                
                                            }
                                        });
                                    }
                                })                                                                                
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea cancelar!');
                            }
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Denegar',
                            iconCls: 'icon-delete',
                            handler: function(){                                
                            var selectedRow = Ext.getCmp('gridRecibosPrecancelados').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                Ext.Msg.confirm('Aprobar', '¿Esta seguro de Denegar la solicitud de cancelación?', function(btn, text){
                                    if (btn == 'yes'){                                        
                                        Ext.Ajax.request({  
                                            url : 'cancelarPagoAC.do?method=denegarCancelacion',
                                            params : {                                                         
                                                ID_BITACORA:selectedRow.data.ID_BITACORA
                                            },
                                            method: 'GET',
                                            success: function ( result, request ) {
                                                Ext.MessageBox.alert('Cancelado','El recibo se ha activado nuevamente');
                                                storeRecibosPrecancelados.load();
                                            },
                                            failure: function ( result, request) {
                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al denegar la solicitud!');                                                
                                            }
                                        });
                                    }
                                })                                                                                
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea cancelar!');
                            }
                            }
                        }),
                        '-',
                        {
                            xtype: 'button',
                            text: 'Buscar Donantes',
                            iconCls:'icon-registro',
                            handler: function(){                                                                                                                       
                                createNewObj('donantes.donantes'); 
                            }
                        },
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winReportRecibosPrecancelados.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                var tbarReportDonativosPrecancelados = new Ext.Toolbar({
                    items:[                        
                        new Ext.Button({
                            text: 'Aprobar',
                            iconCls: 'icon-add',
                            handler: function(){                                
                            var selectedRow = Ext.getCmp('gridDonativosPrecancelados').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                Ext.Msg.confirm('Aprobar', '¿Esta seguro de Aprobar la solicitud de cancelación?', function(btn, text){
                                    if (btn == 'yes'){                                        
                                        Ext.Ajax.request({  
                                            url : 'donativoAC.do?method=aprobarCancelacionDonativo&idUsuario='+idUsuario,
                                            params : {                                                         
                                                ID_DONATIVO:selectedRow.data.ID_DONATIVO
                                            },
                                            method: 'GET',
                                            success: function ( result, request ) {
                                                Ext.MessageBox.alert('Cancelado','El donativo se ha cancelado definitivamente');
                                                storeDonativosPrecancelados.load();
                                            },
                                            failure: function ( result, request) {
                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al cancelar el Donativo!');                                                
                                            }
                                        });
                                    }
                                })                                                                                
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea cancelar!');
                            }
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Denegar',
                            iconCls: 'icon-delete',
                            handler: function(){                                
                            var selectedRow = Ext.getCmp('gridDonativosPrecancelados').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                Ext.Msg.confirm('Aprobar', '¿Esta seguro de Denegar la solicitud de cancelación?', function(btn, text){
                                    if (btn == 'yes'){                                        
                                        Ext.Ajax.request({  
                                            url : 'donativoAC.do?method=denegarCancelacionDonativo',
                                            params : {                                                         
                                                ID_DONATIVO:selectedRow.data.ID_DONATIVO
                                            },
                                            method: 'GET',
                                            success: function ( result, request ) {
                                                Ext.MessageBox.alert('Cancelado','El donativo se ha activado nuevamente');
                                                storeDonativosPrecancelados.load();
                                            },
                                            failure: function ( result, request) {
                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al denegar la solicitud!');                                                
                                            }
                                        });
                                    }
                                })                                                                                
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea cancelar!');
                            }
                            }
                        }),
                        '-',
                        {
                            xtype: 'button',
                            text: 'Buscar Donantes',
                            iconCls:'icon-registro',
                            handler: function(){                                                                                                                       
                                createNewObj('donantes.donantes'); 
                            }
                        },
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winReportRecibosPrecancelados.close();                            
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'tabpanel',
                            height: 565,
                            width: 1100,
                            activeTab: 0,
                            border:false,
                            items:[
                                { /************************ PESTAÑA RECIBOS ********************************/
                                    xtype: 'panel',                                    
                                    border: false,
                                    title: 'Recibos',
                                    tbar: tbarReportRecibosPrecancelados,
                                    items:[
                                        {    
                                            xtype: 'grid',
                                            height: 515,                            
                                            id: 'gridRecibosPrecancelados',                                     
                                            store: storeRecibosPrecancelados,
                                            columns:[
                                                {
                                                    dataIndex: 'ID_RECIBO',
                                                    text: 'Recibo',
                                                    flex: .02,
                                                    align:'center'
                                                }, 
                                                {
                                                    dataIndex: 'NOMBRE_DONANTE',
                                                    text: 'Donante',
                                                    flex: .05,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'ID_DONATIVO',
                                                    text: 'Donativo',
                                                    flex: .03,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'FECHA_CANCELACION',
                                                    text: 'Fecha Cancelación',
                                                    flex: .04,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'USUARIO_CANCELACION',
                                                    text: 'Usuario',
                                                    flex: .03,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'COMENTARIOS_CANCELACION',
                                                    text: 'Comentarios de Cancelación',
                                                    flex: .1,
                                                    align:'center'
                                                }
                                            ],
                                            viewConfig: {

                                            },
                                            selModel: Ext.create('Ext.selection.CheckboxModel', {

                                            }),
                                            bbar: new Ext.PagingToolbar({
                                                pageSize: 100,
                                                store: storeRecibosPrecancelados,
                                                displayInfo: true,
                                                emptyMsg: '¡No hay información!'                                                                                            
                                            })
                                        }
                                    ] //Cierra items panel pestaá recibos
                                },
                                { /************************ PESTAÑA DONATIVOS ********************************/
                                    xtype: 'panel',                                    
                                    border: false,
                                    title: 'Donativos',
                                    tbar: tbarReportDonativosPrecancelados,
                                    items:[
                                        {
                                            xtype: 'grid',
                                            height: 515,                            
                                            id: 'gridDonativosPrecancelados',                                     
                                            store: storeDonativosPrecancelados,
                                            columns:[
                                                {
                                                    dataIndex: 'ID_DONATIVO',
                                                    text: 'Donativo',
                                                    flex: .02,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'NOMBRE_DONANTE',
                                                    text: 'Donante',
                                                    flex: .03,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'FECHA_CANCELACION',
                                                    text: 'Fecha Cancelación',
                                                    flex: .03,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'ID_USUARIO_CANCELACION',
                                                    text: 'Usuario',
                                                    flex: .03,
                                                    align:'center'
                                                },
                                                {
                                                    dataIndex: 'MOTIVO_CANCELACION',
                                                    text: 'Comentarios',
                                                    flex: .1,
                                                    align:'center'
                                                }
                                            ],
                                            viewConfig: {

                                            },
                                            selModel: Ext.create('Ext.selection.CheckboxModel', {

                                            }),
                                            bbar: new Ext.PagingToolbar({
                                                pageSize: 100,
                                                store: storeDonativosPrecancelados,
                                                displayInfo: true,
                                                emptyMsg: '¡No hay información!'                                                                                            
                                            })
                                        }
                                    ]
                                }
                            ] //Cierra items tabpanel  
                            
                        }
                    ] //Cierra items Ext.apply
                }) //Cierra Ext.apply
                storeRecibosPrecancelados.load();
                storeDonativosPrecancelados.load();
                Reportes.solicitudesRecibosPrecancelados.superclass.initComponent.apply(this, arguments);                                    
            } //Cierra initComponent            
        }); //Cierra Ext.define
        
            
        </script>
    </head>
    <body>
    </body>
</html>