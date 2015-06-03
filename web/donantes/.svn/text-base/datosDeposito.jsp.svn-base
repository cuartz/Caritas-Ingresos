<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
            //Variables
            var winDatosDeposito;
            var idDonanteDeposito = 0;
            var UID; 
            var tbarDeposito = new Ext.Toolbar({
                items:[
                new Ext.Button({
                text:'Guardar',
                iconCls: 'icon-save',
                handler: function(){                                
                    var json = winDatosDeposito.getDatas(); 
                  //  alert("guardar: "+json);
                    Ext.Msg.confirm('Agregar Deposito', '¿Los datos son correctos?', function(btn, text){
                        if (btn == 'yes'){
                            Ext.getCmp('mainFormDeposito').getForm().submit({
                                url: 'datosDepositoAC.do?method=agregarDeposito&jsonData='+json+'&uid='+UID,
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
                            winDatosDeposito.close();                            
                        }
                    })
                ]
            }); //Cierra toolbar  
            
            //Creation Screen            
            Ext.define('donantes.datosDeposito', {
                extend: 'Ext.window.Window',                
                alias:'widget.datosDeposito',                
                title: 'Pago con Deposito',              
                width: 350,                
                height: 200,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                initComponent: function() {
//                    Inicializar variables
                    winDatosDeposito = this;
                    UID = this.name;
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',  
                                id: 'mainFormDeposito',
                                border: 'false',
                                tbar: tbarDeposito,
                                items:[
                                    {
                                        xtype: 'container',
                                        margin: '8',
                                        items:[
                                            {
                                                xtype: 'checkboxfield',
                                                fieldLabel: 'Cuenta # 55',
                                                id: 'CUENTA_55'
                                            },
                                            {
                                                xtype: 'checkboxfield',
                                                fieldLabel: 'Deposito Sorteos',
                                                id: 'DEPOSITO_SORTEOS'
                                            },
                                            {
                                                xtype: 'textfield',
                                                fieldLabel: 'Otras Cuentas',
                                                id: 'OTRAS_CUENTAS',
                                                size: '30'                                                
                                            }
                                        ] //Cierra items container
                                    } // Cierra grupo items form
                                ] //Cierra items form
                            } //Cierra grupo items
                        ] //Cierra items apply
                    }) //Cierra ext.apply
                    donantes.datosDeposito.superclass.initComponent.apply(this, arguments);
                }, //Cierra init component
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                        var camposName=['CUENTA_55',
                                        'DEPOSITO_SORTEOS',
                                        'OTRAS_CUENTAS']

                        var camposValue = {'CUENTA_55':0,
                                            'DEPOSITO_SORTEOS':0,
                                            'OTRAS_CUENTAS':''};                           
                            
                        var pos=0;
                        var value = '';             
//                       
                        for(pos=0;pos<camposName.length;pos++){
                            if(pos == 0 || pos == 1){
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == true)
                                    camposValue[camposName[pos]] = 1;
                                if(value == false)
                                    camposValue[camposName[pos]] = 0;
                            }else{
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == '')
                                    camposValue[camposName[pos]] = null;
                                else
                                    camposValue[camposName[pos]] = value;
                            }                                                                                                              
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
