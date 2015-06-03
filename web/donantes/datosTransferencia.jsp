<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
            //Variables
            var winDatosTransferencia;
            var idDonanteDeposito = 0;
            var UIDTransferencia; 
            
            /*********************** MODELS ********************************/
            Ext.define('catalog',{
                    id:'catalog',
                    extend: 'Ext.data.Model',
                    fields: ['id','id_catalog','nombre','status']
            });
            
            /*********************** COMBOBOX ********************************/
            var cbxTransferencia = Ext.create('Ext.data.JsonStore', {
                            model: 'catalog',
                            proxy: {
                                type: 'ajax',
                                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                                extraParams:{llave:'INGRESOS_TRANSFERENCIA'},
                                reader: {
                                    type: 'json',
                                    root: 'rows'
                                }
                            }
                        });
            
            var tbarTransferencia = new Ext.Toolbar({
                items:[
                new Ext.Button({
                text:'Guardar',
                iconCls: 'icon-save',
                handler: function(){                                
                    var json = winDatosTransferencia.getDatas(); 
                    //alert("guardar: "+json);
                    Ext.Msg.confirm('Agregar Transferencia', '¿Los datos son correctos?', function(btn, text){
                        if (btn == 'yes'){
                            Ext.getCmp('mainFormTransferencia').getForm().submit({
                                url: 'datosTransferenciaAC.do?method=agregarTransferencia&jsonData='+json+'&uid='+UID,
                                waitMsg: 'Guardando...',
                                success: function(form, action) {
                                    var info = Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                },
                                failure: function(form, action) {
                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                }
                            });                             
                        }
                    })                                
                }
                }),
                '-',
                    new Ext.Button({
                        text:'Salir',
                        iconCls: 'icon-salir',
                        handler: function(){    
                            winDatosTransferencia.close();                            
                        }
                    })
                ]
            }); //Cierra toolbar  
            
            //Creation Screen            
            Ext.define('donantes.datosTransferencia', {
                extend: 'Ext.window.Window',                
                alias:'widget.datosTransferencia',                
                title: 'Pago con Transferencia',              
                width: 350,                
                height: 110,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                constrain : true,
                layout: 'fit',
                closeAction:'close',
                region:'center',
                initComponent: function() {
                    /*************************** INICIAR VARIABLES *********************************/
                    winDatosTransferencia = this;
                    UIDTransferencia = this.name;
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',  
                                id: 'mainFormTransferencia',
                                border: 'false',
                                tbar: tbarTransferencia,
                                items:[
                                    {
                                        xtype: 'container',
                                        margin: '8',
                                        items:[
                                            Ext.create('Ext.form.ComboBox', {
                                            fieldLabel: 'Transferencia',
                                            id: 'ID_TRANSFERENCIA',
                                            store: cbxTransferencia,
                                            emptyText: 'Seleccione la transferencia.',
                                            size: 30,
                                            displayField: 'nombre',
                                            valueField: 'id'
                                            }),
                                        ] //Cierra items container
                                    } // Cierra grupo items form
                                ] //Cierra items form
                            } //Cierra grupo items
                        ] //Cierra items apply
                    }) //Cierra ext.apply
                    donantes.datosTransferencia.superclass.initComponent.apply(this, arguments);
                }, //Cierra init component
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                        var camposName=['ID_TRANSFERENCIA']
                        var camposValue = {'ID_TRANSFERENCIA':0};                        
                            
                        var pos=0;
                        var value = '';             
                        
                        for(pos=0;pos<camposName.length;pos++){                            
                            value = Ext.getCmp(camposName[pos]).getValue();                                
                            camposValue[camposName[pos]] = value;                                                                                                                                         
                        }                                 
                        return Ext.encode(camposValue);
                    }
            }); //Cierra ext.define
            
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
