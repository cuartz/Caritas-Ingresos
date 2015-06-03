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
        /************************** Variables Globales ********************************/            
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        var winComentariosRecibos;
        var idBitacoraTmpp          = 0;
        var comentarios             = '';
        var usuarioConfirmacionFld  = '';
        var fechaConfirmacionFld    = '';
        
        var usuarioCancelFld    = '';
        var fechaCancelFld      = '';
        var comentariosCancel   = '';
        
        var fechaRepFld         = '';
        var comentariosReprogramacionPrimeraVez = '';
        
        
        Ext.define('comentariosConfirmacionMdl',{
            id:'comentariosConfirmacionMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_BITACORA'},
                {name: 'COMENTARIOS'},
                {name: 'USUARIO_CONFIRMACION'},
                {name: 'FECHA_CONFIRMACION'}
            ]
        });
        
        Ext.define('comentariosCancelacionMdl',{
            id:'comentariosCancelacionMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_BITACORA'},
                {name: 'COMENTARIOS'},
                {name: 'USUARIO_CANCELACION'},
                {name: 'FECHA_CANCELACION'}
            ]
        });
        
        Ext.define('comentariosReprogramacionnMdl',{
            id:'comentariosReprogramacionnMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_BITACORA'},
                {name: 'COMENTARIOS'},
                {name: 'FECHA_REPROGRAMACION'}
            ]
        });
        
        Ext.define('comentariosReprogramacionMdl',{
            id:'comentariosReprogramacionMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_BITACORA'},                
                {name: 'MOTIVO_REPROGRAMACION'},
                {name: 'USUARIO'},
                {name: 'FECHA_VISITA'}
            ]
        });
        
        
        
        function loadComentarios(ID_BITACORA){            
            storeComentariosConfirmacion.proxy.extraParams.ID_BITACORA = ID_BITACORA;
            storeComentariosConfirmacion.load({ callback: function(records,o,s){
                    usuarioConfirmacionFld  = records[0].data.USUARIO_CONFIRMACION;
                    fechaConfirmacionFld    = records[0].data.FECHA_CONFIRMACION;
                    comentarios             = records[0].data.COMENTARIOS;
                    Ext.getCmp('comentariosConfirmacionFld').setValue(records[0].data.COMENTARIOS);
                    Ext.getCmp('usuarioConfirmacionFld').setValue(records[0].data.USUARIO_CONFIRMACION);
                    Ext.getCmp('fechaConfirmacionFld').setValue(records[0].data.FECHA_CONFIRMACION);
                }
            }); //Cierra Store            
            
            storeComentariosCancelacion.proxy.extraParams.ID_BITACORA = ID_BITACORA;
            storeComentariosCancelacion.load({ callback: function(records,o,s){
                    usuarioCancelFld = records[0].data.USUARIO_CANCELACION;
                    fechaCancelFld = records[0].data.FECHA_CANCELACION;
                    comentariosCancel = records[0].data.COMENTARIOS;
                    Ext.getCmp('usuarioCancelFld').setValue(records[0].data.USUARIO_CANCELACION);
                    Ext.getCmp('fechaCancelFld').setValue(records[0].data.FECHA_CANCELACION);
                    Ext.getCmp('comentariosCancel').setValue(records[0].data.COMENTARIOS);
                }
            }); //Cierra Store
            
            storeComentariosReprogramacionn.proxy.extraParams.ID_BITACORA = ID_BITACORA;
            storeComentariosReprogramacionn.load({ callback: function(records,o,s){
                    fechaRepFld = records[0].data.FECHA_REPROGRAMACION;
                    comentariosReprogramacionPrimeraVez = records[0].data.COMENTARIOS;
                    Ext.getCmp('fechaRepFld').setValue(records[0].data.FECHA_REPROGRAMACION);
                    Ext.getCmp('comentariosReprogramacionPrimeraVez').setValue(records[0].data.COMENTARIOS);
                }
            }); //Cierra Store
        }
        
        var storeComentariosConfirmacion = Ext.create('Ext.data.JsonStore', {                   
            model: 'comentariosConfirmacionMdl',
            pageSize: 100,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'listaConfirmacionAC.do?method=getComentariosConfirmacion', 
                extraParams:{idBitacora:idBitacoraTmpp},
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
        var storeComentariosCancelacion = Ext.create('Ext.data.JsonStore', {                   
            model: 'comentariosCancelacionMdl',
            pageSize: 100,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'listaConfirmacionAC.do?method=getComentariosCancelacion', 
                extraParams:{idBitacora:idBitacoraTmpp},
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });
        
        var storeComentariosReprogramacionn = Ext.create('Ext.data.JsonStore', {                   
            model: 'comentariosReprogramacionnMdl',
            pageSize: 100,
            autoLoad:false,
            proxy: {
                type: 'ajax',                       
                url: 'listaConfirmacionAC.do?method=getComentariosReprogramacion', 
                extraParams:{idBitacora:idBitacoraTmpp},
                reader: {
                    type: 'json',
                    root: 'rows',
                    totalProperty:'totalcount'//Paginacion                
                }
            }
        });

        Ext.define('confirmaciones.comentariosRecibo', {
            extend: 'Ext.window.Window',                
            alias:'widget.comentariosRecibo',               
            title: 'Comentarios del Recibo',
            width: 800,                
            height: 600,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy',
            region:'center',
            modal: true,
            initComponent: function() {
                
                winComentariosRecibos   = this; 
                idBitacoraTmpp          = this.name;
                loadComentarios(idBitacoraTmpp);
                
                var tbarComentariosRecibos = new Ext.Toolbar({ // toolbar Dos
                items: [
                    new Ext.Button({
                        text: 'Salir',
                        iconCls: 'icon-salir',
                        handler: function(){
                            winComentariosRecibos.close();
                        }
                    })
                ]
                }); //termina toolbar
                                
                var storeComentariosReprogramacion = Ext.create('Ext.data.JsonStore', {                   
                    model: 'comentariosReprogramacionMdl',
                    pageSize: 10,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'listaConfirmacionAC.do?method=getComentariosBitacoraReprogramacion', 
                        extraParams:{idBitacora:idBitacoraTmpp},
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty:'totalcount'//Paginacion                
                        }
                    }
                });
                
                Ext.apply(this, {
                    items: [
                        {
                            xtype: 'form',
                            id: 'frmComentariosRecibo',                            
                            tbar: tbarComentariosRecibos,
                            items:[
                                {
                                    xtype: 'fieldset',
                                    title: 'Comentarios de Confirmación',
                                    items:[
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'usuarioConfirmacionFld',
                                            value: usuarioConfirmacionFld,
                                            labelWidth: 80,
                                            fieldLabel: 'Usuario'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'fechaConfirmacionFld',
                                            value: fechaConfirmacionFld,
                                            labelWidth: 80,
                                            fieldLabel: 'Fecha'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'comentariosConfirmacionFld',
                                            value: comentarios,
                                            labelWidth: 80,
                                            fieldLabel: 'Comentarios'
                                        }
                                    ] //Cierra items fieldset comentarios generales
                                },
                                {
                                    xtype: 'fieldset',
                                    title: 'Comentarios de Cancelación',
                                    items:[
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'usuarioCancelFld',
                                            value: usuarioCancelFld,
                                            labelWidth: 80,
                                            fieldLabel: 'Usuario'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'fechaCancelFld',
                                            value: fechaCancelFld,
                                            labelWidth: 80,
                                            fieldLabel: 'Fecha'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'comentariosCancel',
                                            value: comentariosCancel,
                                            labelWidth: 80,
                                            fieldLabel: 'Comentarios'
                                        }
                                    ] //Cierra items fieldset comentarios generales
                                },
                                {
                                    xtype: 'fieldset',
                                    title: 'Reprogramación Primera Vez',
                                    items:[
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'fechaRepFld',
                                            value: fechaRepFld,
                                            labelWidth: 80,
                                            fieldLabel: 'Fecha Rep'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            width: 750,
                                            id: 'comentariosReprogramacionPrimeraVez',
                                            value: comentariosReprogramacionPrimeraVez,
                                            labelWidth: 80,
                                            fieldLabel: 'Comentarios'
                                        }
                                    ] //Cierra items fieldset comentarios generales
                                },
                                {
                                    xtype: 'grid',
                                    height: 210,
                                    title: 'Bitacora de Reprogramación',
                                    id: 'gridComentariosReprogramacion',                                        
                                    store: storeComentariosReprogramacion,
                                    columns:[
                                        {
                                            dataIndex: 'USUARIO',
                                            text: 'USUARIO',
                                            flex: .02,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'FECHA_VISITA',
                                            text: 'F. VISITA',
                                            flex: .02,
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'MOTIVO_REPROGRAMACION',
                                            text: 'COMENTARIO',
                                            flex: .1,
                                            align:'left'
                                        }
                                    ],
                                    viewConfig: {

                                    },
                                    bbar: new Ext.PagingToolbar({
                                        pageSize: 10,
                                        store: storeComentariosReprogramacion,
                                        displayInfo: true,
                                        displayMsg: '{0} - {1} of {2} Registros',  
                                        emptyMsg: 'No hay registros para mostrar'
                                    })
                                }
                            ] //cierra items form principal
                                
                        }
                    ] //cierra items ext.apply
                }); //Cierre de Ext.apply
                storeComentariosReprogramacion.load();
            confirmaciones.comentariosRecibo.superclass.initComponent.apply(this, arguments);    
            } //Cierre de Init component
        }); //Cierre de Ext.define



        </script>
    </head>
    <body>
    </body>
</html>