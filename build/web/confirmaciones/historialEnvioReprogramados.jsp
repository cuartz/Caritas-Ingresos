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
            var winHistorialEnvio;
            var idReciboTmp     = "";
            
            Ext.define('historialReprogramacionMdl',{
                id:'historialReprogramacionMdl',
                extend: 'Ext.data.Model',
                fields:     [                   
                    {name: 'ID_RECIBO'},
                    {name: 'FECHA_VISITA'},                        
                    {name: 'FECHA_REPROGRAMACION'},
                    {name: 'MOTIVO_REPROGRAMACION'},
                    {name: 'USUARIO'},
                    {name: 'COMENTARIOS_CONFIRMACION'}                    
                ]
            });
            
            //Inicia
            //Creation Screen            
            Ext.define('confirmaciones.historialEnvioReprogramados', {
                extend: 'Ext.window.Window',                
                alias:'widget.historialEnvioReprogramados',               
                title: 'Historial de Envio',
                width: 950,                
                height: 282,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'destroy',
                region:'center',
                initComponent: function() {
                    //Inicializar las variables                    
                    winHistorialEnvio   = this;                   
                    idReciboTmp         = this.name;
                    
                    var tbarHistorialEnvio = new Ext.Toolbar({ // toolbar Dos
                    items: [
                        new Ext.Button({
                            text: 'Salir',
                            iconCls: 'icon-salir',
                            handler: function(){
                                winHistorialEnvio.close();
                            }
                        })
                        ]
                    }); //termina toolbar
                    
                    var storeHistorialReprogramacion = Ext.create('Ext.data.JsonStore', {                   
                        model: 'historialReprogramacionMdl',
                        pageSize: 100,
                        autoLoad:false,
                        proxy: {
                            type: 'ajax',                       
                            url: 'reprogramarPagoAC.do?method=getHistorialReprogramacion', 
                            extraParams:{idRecibo:idReciboTmp},
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
                                id: 'frmHistorialEnvio',                            
                                tbar: tbarHistorialEnvio,
                                items:[
                                    {
                                        xtype: 'grid',
                                        height: 220,
                                        title: 'Historial de Reprogramación',
                                        id: 'gridHistorial de Envio',                                        
                                        store: storeHistorialReprogramacion,
                                        columns:[
                                            {
                                                dataIndex: 'ID_RECIBO',
                                                text: 'Recibo',
                                                flex: .03,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'FECHA_VISITA',
                                                text: 'Fecha Visita',
                                                flex: .04,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'COMENTARIOS_CONFIRMACION',
                                                text: 'Comentarios de Confirmación',
                                                flex: .1
                                            },                                            
                                            {
                                                dataIndex: 'FECHA_REPROGRAMACION',
                                                text: 'Nueva F. Visita',
                                                flex: .04,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'MOTIVO_REPROGRAMACION',
                                                text: 'Comentarios de Reprogramación',
                                                flex: .1
                                            },
                                            {
                                                dataIndex: 'USUARIO',
                                                text: 'Usuario',
                                                flex: .04,
                                                align:'center'
                                            }
                                        ],
                                        viewConfig: {
                                
                                        },
                                        selModel: Ext.create('Ext.selection.CheckboxModel', {

                                        }),
                                        bbar: new Ext.PagingToolbar({
                                            pageSize: 50,
                                            store: storeHistorialReprogramacion,
                                            displayInfo: true,
                                            emptyMsg: '¡No hay información para este recibo!'                                                                                            
                                        })
                                    }
                                ] //Cierra items form principal
                            } //Cierra grupo items Ext apply
                        ] //Cierra items Ext apply
                    }); //Cierra Ext Apply
                    storeHistorialReprogramacion.load();
                    confirmaciones.historialEnvioReprogramados.superclass.initComponent.apply(this, arguments); 
                } //Cierra initComponent
                 
            }); //Cierra Ext define

        </script>
    </head>
    <body>
    </body>
</html>
