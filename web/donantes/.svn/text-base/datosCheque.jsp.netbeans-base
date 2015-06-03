<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            //Variables
           var winCheque;
           var idDonante = 0;
           var UID;
            
            
            /*************COMBO CAMPAÑA FINANCIERA****************************************/
                    Ext.define('catalog',{
                    id:'catalog',
                    extend: 'Ext.data.Model',
                    fields: ['id','id_catalog','nombre','status']
                });
//                
                var cbxBanco = Ext.create('Ext.data.JsonStore', {
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
                        
                var tbarCheque = new Ext.Toolbar({
                         items:[
                            new Ext.Button({
                            text:'Guardar',
                            iconCls: 'icon-save',
                            handler: function(){                                
                                var json = winCheque.getDatas();                    
                                Ext.Msg.confirm('Agregar Cheque', '¿Los datos son correctos?', function(btn, text){
                                    if (btn == 'yes'){
                                        Ext.getCmp('mainFormCheque').getForm().submit({
                                            url: 'datosChequeAC.do?method=agregarCheque&jsonData='+json+'&uid='+UID,
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
                                    iconCls: 'icon-cancelar',
                                    handler: function(){    
                                        winCheque.close();                            
                                    }
                                })
                         ]
                     }); //Cierra toolbar  
            
            //Creation Screen            
            Ext.define('donantes.datosCheque', {
                extend: 'Ext.window.Window',                
                alias:'widget.datosCheque',                
                title: 'Pago en Cheque', 
               // id: 'datosCheque',
                width: 350,                
                height: 150,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                 initComponent: function() {
                     //Inicializar Variables
                     winCheque = this;
                     UID = this.name;
                  //   alert("UID en Cheque: "+UID);
                 //    idDonante = this.name
                     Ext.apply(this, {
                         items:[
                            {
                                xtype: 'form',  
                                id: 'mainFormCheque',
                                border: 'false',
                                tbar: tbarCheque,
                                items:[
                                    {
                                        xtype: 'container',
                                        margin: '8',
                                        items:[
                                            {
                                                xtype: 'textfield',
                                                fieldLabel: 'No. Cheque',
                                                id: 'NUM_CHEQUE',
                                                size: '30',
                                                emptyText: 'Ingrese el numero de Cheque.'
                                            },
                                                Ext.create('Ext.form.ComboBox', {
                                                fieldLabel: 'Banco',
                                                store: cbxBanco,
                                                emptyText: 'Seleccione el Banco',
                                                size: 30,
                                                id: 'ID_BANCO',
                                                displayField: 'nombre',
                                                valueField: 'id'
                                            })
                                        ] //Cierra items container
                                    }//Cierra grupo items form
                                ] //Cierra items form
                            } //Cierra grupo items ext apply
                         ] //Cierra items ext.apply
                     }) //Cierra Ext.Apply  
                     donantes.datosCheque.superclass.initComponent.apply(this, arguments); 
                 }, //Cierra initComponent
                 getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                        var camposName=['NUM_CHEQUE',
                                        'ID_BANCO']

                        var camposValue = {'NUM_CHEQUE':0,
                                            'ID_BANCO':0};                           
                            
                        var pos=0;
                        var value = '';             
                       
                        for(pos=0;pos<camposName.length;pos++){
                            value = Ext.getCmp(camposName[pos]).getValue();
                            camposValue[camposName[pos]] = value;                                                                   
                        }                                 
                        return Ext.encode(camposValue);
                    }
            }); //CIerra Ext.Define
        </script>
    </head>
    <body>
       
    </body>
</html>
