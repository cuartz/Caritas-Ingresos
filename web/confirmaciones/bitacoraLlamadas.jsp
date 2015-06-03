<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>       
        <script type="text/javascript">
        /************* VARIABLES GLOBALES *********************/
        var winBitacoraLlamadas;
        var idBitacoraLlamada;
        
        Ext.define('bitacoraLlamadasMdl',{
            id:'bitacoraLlamadasMdl',
            extend: 'Ext.data.Model',
            fields:     [                   
                {name: 'ID_USUARIO'},
                {name: 'FECHA'},                        
                {name: 'HORA'},
                {name: 'RESPUESTA'},
                {name: 'COMENTARIOS'}                    
            ]
        });
                
        Ext.define('confirmaciones.bitacoraLlamadas', {
            extend: 'Ext.window.Window',                   
            alias:'widget.bitacoraLlamadas',                
            title: 'Bitacora de Llamadas',
            constrain : true,
            width: 750,                
            height: 350,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy', 
            region:'center',
            modal: true,
            initComponent: function() {
                winBitacoraLlamadas = this;
                idBitacoraLlamada   = this.name;
                
                /************* TOLLBAR *********************/
                var tbarBitacoraLlamadas = new Ext.Toolbar({ // toolbar Dos
                    items: [                        
                        Ext.create('Ext.Button',{
                            text:'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                                            
                                winBitacoraLlamadas.close();
                            }
                        })
                    ]
                });
                
                /************* STORE *****************/
                var storeBitacoraLlamadas = Ext.create('Ext.data.JsonStore', {                   
                    model: 'bitacoraLlamadasMdl',
                    pageSize: 100,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'listaConfirmacionAC.do?method=getBitacoraLlamadas', 
                        extraParams:{idBitacora:idBitacoraLlamada},
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
                            xtype: 'grid',
                            height: 220,                            
                            id: 'gridBitacoraLlamadas', 
                            tbar: tbarBitacoraLlamadas,
                            store: storeBitacoraLlamadas,
                            columns:[                                        
                            {
                                dataIndex: 'ID_USUARIO',
                                text: 'Usuario',
                                flex: .03,
                                align:'center'
                            },
                            {
                                dataIndex: 'FECHA',
                                text: 'Fecha',
                                flex: .03,
                                align:'center'
                            },
                            {
                                dataIndex: 'HORA',
                                text: 'Hora',
                                flex: .02,
                                align:'center'
                            },
                            {
                                dataIndex: 'RESPUESTA',
                                text: '¿Contestó?',
                                flex: .03,
                                align:'center'
                            },
                            {
                                dataIndex: 'COMENTARIOS',
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
                            pageSize: 50,
                            store: storeBitacoraLlamadas,
                            displayInfo: true,
                            emptyMsg: '¡No hay información!'                                                                                            
                        })                          
                        }
                    ]//Cierra items Ext.apply                
                }) //Cierra Ext.apply
                storeBitacoraLlamadas.load()
                confirmaciones.bitacoraLlamadas.superclass.initComponent.apply(this, arguments);                    
            } //Cierra initComponent            
        }); //Cierra Ext.define
        
        
        
        </script>
    </head>
    <body>
    </body>
</html> 