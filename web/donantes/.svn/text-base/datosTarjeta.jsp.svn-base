<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            /*********************** VARIABLES GLOBALES **************************************/            
            var idTarjetaTmp = 0;
            var winTarjetaC;
            
            /*********************** MODELS **************************************/
            Ext.define('catalog',{
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('datosTarjetaCreditoMdl',{// create the Data direccionDonantes
                id:'datosTarjetaCreditoMdl',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_DONANTE'},
                    {name: 'ID_DONATIVO'},
                    {name: 'TITULAR'},
                    {name: 'ID_BANCO'},
                    {name: 'NUM_TARJETA'},
                    {name: 'FECHA_VENCIMIENTO'},
                    {name: 'CVV'},
                    {name: 'NUM_INICIAL'},
                    {name: 'VISA'},
                    {name: 'MASTER_CARD'},
                    {name: 'AM_EXPRESS'}                   
                ]
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
            
            var storeInfoTarjetaCreditoTmp = Ext.create('Ext.data.JsonStore', {
                model: 'datosTarjetaCreditoMdl',
                pageSize: 50,
                id:'storeInfoTarjetaCreditoTmp',
                name:'storeInfoTarjetaCreditoTmp',
                proxy: {
                    type: 'ajax',
                    url: 'datosTCAC.do',
                    extraParams: {method: 'getDatosTarjetaCredito'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            function loadNombre(idDonante){
                storeNameInfo.proxy.extraParams.ID_DONANTE = idDonante;
                storeNameInfo.load({ callback: function(records,o,s){
                        if(records.length > 0){
                            Ext.getCmp('DONANTE').setValue(records[0].data.NOMBRE);
                            storeDonativos.load();
                        }
                    }
                });               
            }
            
            function loadInfoTarjetaCreditoUpdate(idTarjeta){
                storeInfoTarjetaCreditoTmp.proxy.extraParams.ID_TARJETA_TMP = idTarjeta;
                storeInfoTarjetaCreditoTmp.load({ callback: function(records,o,s){
                    if(records.length > 0){
                        var idBancoTmp = records[0].data.ID_BANCO;
                        Ext.getCmp('ID_DONANTE').setValue(records[0].data.ID_DONANTE);
                        Ext.getCmp('TITULAR').setValue(records[0].data.TITULAR);
                        Ext.getCmp('ID_BANCO').setValue(records[0].data.ID_BANCO);                        
                        cbxBancos.load({callback: function(records,o,s){
                            Ext.getCmp('ID_BANCO').setValue(idBancoTmp);                            
                        }});                        
                        Ext.getCmp('NUM_TARJETA_CREDITO').setValue(records[0].data.NUM_TARJETA);
                        Ext.getCmp('FECHA_VENCIMIENTO').setValue(records[0].data.FECHA_VENCIMIENTO);
                        Ext.getCmp('CVV').setValue(records[0].data.CVV);
                        Ext.getCmp('NUM_INICIAL').setValue(records[0].data.NUM_INICIAL);
                        if(records[0].data.VISA == 1) Ext.getCmp('VISA').setValue(true); else Ext.getCmp('VISA').setValue(false);
                        if(records[0].data.MASTER_CARD == 1) Ext.getCmp('MASTER_CARD').setValue(true); else Ext.getCmp('MASTER_CARD').setValue(false);
                        if(records[0].data.AM_EXPRESS == 1) Ext.getCmp('AM_EXPRESS').setValue(true); else Ext.getCmp('AM_EXPRESS').setValue(false);
                    }
                }
                });
            }
            
            function validaDatosTCredito(){
                //alert(Ext.getCmp("NUM_TARJETA_CREDITO").getValue().length);                
                if(Ext.getCmp("TITULAR").getValue() == ""){ //Validar el titular
                    Ext.MessageBox.alert('Error','!Ingrése el nombre del Titular!');                   
                    return false
                }
                if(Ext.getCmp("AM_EXPRESS").getValue() == false && (Ext.getCmp("ID_BANCO").getValue() == null || Ext.getCmp("ID_BANCO").getValue() == 0) ){ //Validar el titular
                    Ext.MessageBox.alert('Error','!Seleccione el Banco!');                   
                    return false
                }
                if(Ext.getCmp("NUM_TARJETA_CREDITO").getValue() == ""){ //Validar el numero de tarjeta
                    Ext.MessageBox.alert('Error','!Ingrése el numero de tarjeta!');                   
                    return false                
                }else{
                    if(Ext.getCmp("AM_EXPRESS").getValue() == true){
                        if(Ext.getCmp("NUM_TARJETA_CREDITO").getValue().length < 15 || Ext.getCmp("NUM_TARJETA_CREDITO").getValue().length > 15){ //Validar que sean 16 digitos 
                            Ext.MessageBox.alert('Error','!El numero de tarjeta es inválido!');                   
                            return false
                        }
                    }else{
                        if(Ext.getCmp("NUM_TARJETA_CREDITO").getValue().length < 16 || Ext.getCmp("NUM_TARJETA_CREDITO").getValue().length > 16){ //Validar que sean 16 digitos 
                            Ext.MessageBox.alert('Error','!El numero de tarjeta es inválido!');                   
                            return false
                        }
                    }                    
                    
                }
                if(Ext.getCmp("FECHA_VENCIMIENTO").getValue() == null){ //Validar la fecha de vencimiento
                    Ext.MessageBox.alert('Error','!Ingrése la fecha de vencimiento!');                   
                    return false
                }
                if(Ext.getCmp("CVV").getValue() == null){ //Validar el CVV
                    Ext.MessageBox.alert('Error','!Ingrése el Codigo de Seguridad (CVV)!');                   
                    return false
                }
                if(Ext.getCmp("NUM_INICIAL").getValue() == null){ //Validar el CVV
                    Ext.MessageBox.alert('Error','!Ingrése el campo A partir de!');                   
                    return false
                }
            }
            
            //Creation Screen            
            Ext.define('donantes.datosTarjeta', {
                extend: 'Ext.window.Window',                
                alias:'widget.datosTarjeta',                
                title: 'Tarjeta de Crédito', 
                id: 'datosTarjeta',
                width: 350,                
                height: 350,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                autoDestroy:true,
                region:'center',
                initComponent: function() {
                    winTarjetaC = this;                    
                    var option = this.name                    
                    var uid = '';
                    var idDonante = '';
                    idTarjetaTmp = 0;
                    
                    if(option == 0){ //Entrar por forma de pago (modificar)
                        idTarjetaTmp = this.nameDos
                        loadInfoTarjetaCreditoUpdate(idTarjetaTmp);
                    }else{ //Entrar por donativos (Agregar)
                        uid = this.nameDos;
                        idDonante = this.nameTres;
                        loadNombre(idDonante);                        
                    }
                    
                    //alert("option: "+option+" | UID: "+uid+" | idDonante: "+idDonante);                    
                   
                    //Toolbar Direcciones
                    var tbarDir = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Guardar',
                                iconCls: 'icon-save',
                                handler: function(){                               
                                    var json = winTarjetaC.getDatas();
//                                    alert("guardar: "+json);
                                    if(validaDatosTCredito() != false){
                                        Ext.Msg.confirm('Guardar Tarjeta de Crédito', '¿Los datos son correctos?', function(btn, text){
                                            if (btn == 'yes'){
                                                Ext.getCmp('mainFormTC').getForm().submit({
                                                    url: 'datosTCAC.do?method=saveTarjetaCredito&jsonData='+json+'&uid='+uid+'&idTarjeta='+idTarjetaTmp,
                                                    waitMsg: 'Guardando...',
                                                    success: function(form, action) {
                                                        var info = Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                                        winTarjetaC.close();
                                                        winFormaPago.destroy();
                                                    },
                                                    failure: function(form, action) {
                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                    }
                                                });
                                            }
                                        });
                                    }
                                }
                            }),
                            '-',                      
                            new Ext.Button({
                                text:'Limpiar',
                                iconCls: 'icon-clear'
                            }),
                            '-',
                            new Ext.Button({
                                text:'Salir',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winTarjetaC.close();
//                                    Ext.getCmp('datosTarjeta').destroy();
                                }
                            })
                        ]
                    }); //Termina Toolbar direcciones
                
                Ext.apply(this, {                
                items:[
                    {
                        xtype: 'form',  
                        id: 'mainFormTC',
                        border: 'false',
                        tbar: tbarDir,
                        items:[
                            {
                                xtype: 'container',
                                margin: '8',
                                items:[
                                    {
                                        xtype: 'checkboxfield',
                                        fieldLabel: 'Visa',                                        
                                        id: 'VISA'
                                    },
                                    {
                                        xtype: 'checkboxfield',
                                        fieldLabel: 'Master Card',
                                        id: 'MASTER_CARD'                                       
                                    },
                                    {
                                        xtype: 'checkboxfield',
                                        fieldLabel: 'American Express',
                                        id: 'AM_EXPRESS',
                                        handler: function(){    
                                            if(this.checked){ 
                                                Ext.getCmp('ID_BANCO').disable();
                                                Ext.getCmp('ID_BANCO').reset();
                                            }else{ 
                                                Ext.getCmp('ID_BANCO').enable();                                                
                                            }   
                                        }
                                    },
                                    {
                                        xtype: 'textfield',
                                        fieldLabel: 'Donante',
                                        id: 'ID_DONANTE',
                                        readOnly: 'true',
                                        size: '30',
                                        value : idDonante                                        
                                    },
                                    {
                                        xtype: 'textfield',
                                        fieldLabel: 'Titular',
                                        id: 'TITULAR',
                                        size: '30',
                                        emptyText: 'Ingrese el nombre del Titular.'
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
                                        fieldLabel: 'No. de Tarjeta',
                                        id: 'NUM_TARJETA_CREDITO',
                                        emptyText: 'Ingrese el numero de tarjeta',
                                        size: '30'
//                                        maxLength: 16,
//                                        maxLengthText: 'El numero de tarjeta debe ser de 16 digitos',
//                                        minLength : 16,
//                                        minLengthText: 'El numero de tarjeta debe ser de 16 digitos'
                                    },
                                    {
                                        xtype: 'datefield',
                                        fieldLabel: 'F. Vencimiento',
                                        format: 'm/y',
                                        id: 'FECHA_VENCIMIENTO',
                                        emptyText: 'Ingrese la fecha de vencimiento',
                                        size: '30'
                                    },
                                    {
                                        xtype: 'numberfield',
                                        fieldLabel: 'Codigo Seguridad',                                       
                                        size: 5,
                                        id: 'CVV'
                                    },
                                    {
                                        xtype: 'numberfield',
                                        fieldLabel: 'A partir de',
                                        id: 'NUM_INICIAL',
                                        emptyText: 'Ingrese el numero inicial',
                                        size: '25'
                                    }                                    
                                ]//Cierra items container                                
                            } //Cierra 1er grupo de items de panel
                        ]//Cierra items panel
                    } //Cierra items de ventana
                ] //Cierra ventana
                })//Cierra Ext.apply
                donantes.datosTarjeta.superclass.initComponent.apply(this, arguments); 
                },//Cierra initcomponent
                 getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                        var camposName=['ID_DONANTE',
                            'TITULAR',
                            'ID_BANCO',
                            'NUM_TARJETA_CREDITO',
                            'FECHA_VENCIMIENTO',
                            'CVV',
                            'NUM_INICIAL',
                            'VISA',
                            'MASTER_CARD',                           
                            'AM_EXPRESS'
                        ]

                        var camposValue = {'ID_DONANTE':0,
                            'TITULAR':'',
                            'ID_BANCO':0,
                            'NUM_TARJETA_CREDITO':'',
                            'FECHA_VENCIMIENTO':'',
                            'CVV':0,
                            'NUM_INICIAL':0,
                            'VISA':0,
                            'MASTER_CARD':0,
                            'AM_EXPRESS':0
                        };
                              
                            //Id Donante            - 0
                            //Titular               - 1                            
                            //Banco                 - 2                                                    
                            //Num Tarjeta           - 3                                                     
                            //Fecha Vencimiento     - 4                                                   
                            //CVV                   - 5                                                    
                            //Num Inicial           - 6                           
                            //Visa                  - 7                            
                            //Master Card           - 8                           
                            //American Express      - 9                 
                            
                        var pos=0;
                        var value = '';             
                       
                        for(pos=0;pos<camposName.length;pos++){
                            if(pos == 2){ //Banco
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == null || value == "")
                                    camposValue[camposName[pos]] = 0;
                                else
                                    camposValue[camposName[pos]] = value;
                            }else if(pos == 7 || pos == 8 || pos == 9){ //Visa, MasterCard, American Express                                
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == false)                                    
                                    camposValue[camposName[pos]] = 0;
                                if(value == true)                                    
                                    camposValue[camposName[pos]] = 1;
                            }else{
                                value = Ext.getCmp(camposName[pos]).getValue();
                                camposValue[camposName[pos]] = value;
                            }                                                                                                                        
                        }                                 
                        return Ext.encode(camposValue);
                    }
            }); //CIerra Ext define
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
