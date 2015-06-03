<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            /*********************** VARIABLES GLOBALES ********************************/
            var winTarjetaDebito;
            var UIDTarjetaDebito; 
            
            /*********************** MODELS **************************************/
            Ext.define('catalog',{
                    id:'catalog',
                    extend: 'Ext.data.Model',
                    fields: ['id','id_catalog','nombre','status']
            });
            
            var cbxBancos = Ext.create('Ext.data.JsonStore', {
                            model: 'catalog',
                            proxy: {
                                type: 'ajax',
                                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                                extraParams:{llave:'INGRESOS_BANCOS'},
                                reader: {
                                    type: 'json',
                                    root: 'rows'
                                }
                            }
                        });
            
            var tbarTarjetaDebito = new Ext.Toolbar({
                items:[
                new Ext.Button({
                text:'Guardar',
                iconCls: 'icon-save',
                handler: function(){                                
                    var json = winTarjetaDebito.getDatas(); 
                    //alert("guardar: "+json);
                    Ext.Msg.confirm('Agregar Tarjeta de Débito', '¿Los datos son correctos?', function(btn, text){
                        if (btn == 'yes'){
                            Ext.getCmp('mainFormTarjetaDebito').getForm().submit({
                                url: 'datosTarjetaDebitoAC.do?method=agregarTarjetaDebito&jsonData='+json+'&uid='+UID,
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
                            winTarjetaDebito.close();                            
                        }
                    })
                ]
            }); //Cierra toolbar 
            
            Ext.define('donantes.datosTarjetaDebito', {
                extend: 'Ext.window.Window',                
                alias:'widget.datosTarjetaDebito',                
                title: 'Pago con Tarjeta de Débito',              
                width: 350,                
                height: 250,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                constrain : true,
                layout: 'fit',
                closeAction:'close',
                region:'center',
                initComponent: function() {
                    /******************* INICIAR VARIABLES ************************/
                    winTarjetaDebito = this;
                    UIDTarjetaDebito = this.name;
                    //alert("uid "+UIDTarjetaDebito);
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',  
                                id: 'mainFormTarjetaDebito',
                                border: 'false',
                                tbar: tbarTarjetaDebito,
                                items:[
                                    {
                                        xtype: 'container',
                                        margin: 8,
                                        items:[
                                            {
                                                xtype: 'numberfield',
                                                emptyText: 'Ingrese el numero de la tarjeta',
                                                fieldLabel: 'Num. Tarjeta',
                                                id: 'NUM_TARJETA',
                                                size: 30
                                            },
                                            {
                                                xtype: 'datefield',
                                                fieldLabel: 'F. Vencimiento',
                                                format: 'm/y',
                                                id: 'FECHA_VENCIMIENTO',
                                                emptyText: 'Ingrese la fecha de vencimiento',
                                                size: '20'
                                            },
                                            {
                                                xtype: 'numberfield',
                                                emptyText: 'Ingrese el CVV',
                                                fieldLabel: 'Código Seguridad',
                                                id: 'CODIGO_SEGURIDAD',
                                                size: 20
                                            },
                                            Ext.create('Ext.form.ComboBox', {
                                                fieldLabel: 'Banco',
                                                id: 'ID_BANCO',
                                                store: cbxBancos,
                                                emptyText: 'Seleccione el Banco',
                                                size: 30,
                                                displayField: 'nombre',
                                                valueField: 'id'
                                            }),
                                            {
                                                xtype: 'textfield',
                                                fieldLabel: 'R.F.C.',
                                                id: 'RFC',                                               
                                                size: '30'                                                                                     
                                            },
                                            {
                                                xtype: 'checkboxfield',
                                                fieldLabel: 'IFE',
                                                id: 'IFE'
                                            }
                                        ] //Cierra items container
                                    }
                                ] //Cierra items form
                            }
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                    donantes.datosTarjetaDebito.superclass.initComponent.apply(this, arguments);
                }, //Cierra initComponent
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['NUM_TARJETA',
                                        'FECHA_VENCIMIENTO',
                                        'CODIGO_SEGURIDAD',
                                        'ID_BANCO',
                                        'RFC',
                                        'IFE']

                        var camposValue = {'NUM_TARJETA':0,
                                            'FECHA_VENCIMIENTO':'',
                                            'CODIGO_SEGURIDAD':0,
                                            'ID_BANCO':0,
                                            'RFC':'',
                                            'IFE':0};                       

                    var pos=0;
                    var value = '';             

                    for(pos=0;pos<camposName.length;pos++){
                        if(pos == 5){
                            value = Ext.getCmp(camposName[pos]).getValue();
                            if(value == true)
                                camposValue[camposName[pos]] = 1; 
                            else
                                camposValue[camposName[pos]] = 0; 
                        }else{
                            value = Ext.getCmp(camposName[pos]).getValue();                           
                            camposValue[camposName[pos]] = value; 
                        }                                                                                                                                                                
                    }                                 
                    return Ext.encode(camposValue);
                }
            }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>
