<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            /********************VARIABLES GLOBALES****************/
            var winBitaComents;
            var idBitacora;
            var comentarios, fechaCancelacion, motivoCancelacion, comentariosCancelacion, fechaReprogramar, comentariosReprogramar;
            
            /******************** MODELOS ****************/
            Ext.define('comentariosReprogramacionMdl',{
                id:'comentariosReprogramacionMdl',
                extend: 'Ext.data.Model',
                fields:     [                   
                    {name: 'ID_BITACORA'},
                    {name: 'COMENTARIOS'},
                    {name: 'MOTIVO_REPROGRAMACION'},
                    {name: 'USUARIO'}
                ]
            });

            Ext.define('bitacoraComentariosMdl',{
                id:'bitacoraComentariosMdl',
                extend: 'Ext.data.Model',
                fields: [
                    'ID_DONATIVO',
                    'COMENTARIOS',
                    'ID_MOTIVO_CANCELACION',
                    'MOTIVO_CANCELACION',
                    'FECHA_CANCELACION',
                    'FECHA_ACTUALIZACION',                        
                    'COMENTARIOS_CANCELACION',
                    'ID_MOTIVO_REPROGRAMAR',
                    'COMENTARIOS_REPROGRAMAR'                        
                ]
            });
            
            /******************** FUNCIONES ****************/            
            function loadComentarios(ID_BITACORA){                
                storeBitacoraComentarios.proxy.extraParams.ID_BITACORA = ID_BITACORA;
                storeBitacoraComentarios.load({ callback: function(records,o,s){
                       comentarios = records[0].data.COMENTARIOS;
                       fechaCancelacion = records[0].data.FECHA_CANCELACION;
                       motivoCancelacion = records[0].data.MOTIVO_CANCELACION;
                       comentariosCancelacion = records[0].data.COMENTARIOS_CANCELACION;                     
                       comentariosReprogramar = records[0].data.COMENTARIOS_REPROGRAMAR; 
                       fechaReprogramar = records[0].data.FECHA_ACTUALIZACION;  
                       
                        Ext.getCmp('gralComents').setValue(records[0].data.COMENTARIOS);
                        Ext.getCmp('fechaCancelacion').setValue(records[0].data.FECHA_CANCELACION);
                        Ext.getCmp('motivoCancelacion').setValue(records[0].data.MOTIVO_CANCELACION);
                        Ext.getCmp('comentCancelacion').setValue(records[0].data.COMENTARIOS_CANCELACION);
                        Ext.getCmp('fechaReprogramar').setValue(records[0].data.FECHA_ACTUALIZACION);
                        Ext.getCmp('comentReprogramar').setValue(records[0].data.COMENTARIOS_REPROGRAMAR);

                    }
                }); //Cierra Store
            }           
            
            /******************** STORES ****************/
            var storeBitacoraComentarios = Ext.create('Ext.data.JsonStore', {
                model: 'bitacoraComentariosMdl',
                pageSize: 50,
                id:'storeBitacoraComentarios',
                name:'storeBitacoraComentarios',
                proxy: {
                    type: 'ajax',
                    url: 'bitacoraPagosAC.do',
                    extraParams: {method: 'getBitacoraComentarios'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            
            
            //Creation Screen            
            Ext.define('donantes.bitacoraComentarios', {
                extend: 'Ext.window.Window',                
                alias:'widget.bitacoraComentarios',                
                title: 'Comentarios Específicos',                
                width: 800,                
                height: 600,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                constrain:true,
                modal: true,
                initComponent: function() {
                    /******************** Inicializar ****************/
                    winBitaComents = this;
                    idBitacora = this.name;                   
                    loadComentarios(idBitacora);
                    
                    /********************TOOLBAR****************/
                    var tbarComents = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winBitaComents.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar
                    
                    var storeComentariosReprogramacion = Ext.create('Ext.data.JsonStore', {                   
                        model: 'comentariosReprogramacionMdl',
                        pageSize: 100,
                        autoLoad:false,
                        proxy: {
                            type: 'ajax',                       
                            url: 'listaConfirmacionAC.do?method=getComentariosReprogramacion', 
                            extraParams:{idBitacora:idBitacora},
                            reader: {
                                type: 'json',
                                root: 'rows',
                                totalProperty:'totalcount'//Paginacion                
                            }
                        }
                    });
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmComents',
                                tbar: tbarComents,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Comentarios Confirmación',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 750,
                                                id: 'gralComents',
                                                value: comentarios,
                                                labelWidth: 100,
                                                fieldLabel: 'Comentarios' 
                                            }
                                        ] //Cierra items fieldset comentarios generales
                                    },
                                    {
                                        xtype: 'fieldset',
                                        title: 'Cancelación',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 750,
                                                id: 'fechaCancelacion',
                                                value: fechaCancelacion,
                                                labelWidth: 100,
                                                fieldLabel: 'Fecha' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 750,
                                                id: 'motivoCancelacion',
                                                value: motivoCancelacion,
                                                labelWidth: 100,
                                                fieldLabel: 'Motivo'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 750,
                                                id: 'comentCancelacion',
                                                value: comentariosCancelacion,
                                                labelWidth: 100,
                                                fieldLabel: 'Comentarios' 
                                            }
                                        ] //Cierra items cancelacion
                                    },
                                    {
                                        xtype: 'fieldset',
                                        title: 'Reprogramación Primera Vez',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 750,
                                                id: 'fechaReprogramar',
                                                value: fechaReprogramar,
                                                labelWidth: 100,
                                                fieldLabel: 'Fecha' 
                                            },                                            
                                            {
                                                xtype: 'displayfield',
                                                width: 750,
                                                id: 'comentReprogramar',
                                                value: comentariosReprogramar,
                                                labelWidth: 100,
                                                fieldLabel: 'Comentarios' 
                                            }
                                        ] //CIerra items reprogramacion
                                    },
                                    {
                                        xtype: 'grid',
                                        height: 90,
                                        title: 'Comentarios de Reprogramación',
                                        id: 'gridComentariosReprogramacion',                                        
                                        store: storeComentariosReprogramacion,
                                        columns:[
                                            {
                                                dataIndex: 'USUARIO',
                                                text: 'USUARIO',
                                                flex: .02,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'MOTIVO_REPROGRAMACION',
                                                text: 'COMENTARIO',
                                                flex: .1,
                                                align:'left'
                                            }
                                        ],
                                        viewConfig: {

                                        }
                                    }
                                ] //Cierra items container
                            }                            
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                    storeComentariosReprogramacion.load();
                    donantes.bitacoraComentarios.superclass.initComponent.apply(this, arguments); 
                } //Cierra initComponent
            }); //Cierra Ext.define
        </script>
    </head>
    <body>
       
    </body>
</html>