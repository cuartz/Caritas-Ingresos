<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
        /********************VARIABLES GLOBALES****************/
        var winFormaPago;
        var idFormaPago;
        var idDonativo;
        var leyendaFormaPago = 'El donativo fue mediante EFECTIVO.';
        var idTarjetaCredito = 0;
            
        /******************** FUNCIONES ****************/
        function loadInfoCheque(ID_DONATIVO){
            storeInfoCheque.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;
            storeInfoCheque.load({ callback: function(records,o,s){
                    if(records.length > 0){
                        Ext.getCmp('flIdCheque').setValue(records[0].data.ID_CHEQUE);
                        Ext.getCmp('flNumCheque').setValue(records[0].data.NUM_CHEQUE);
                        Ext.getCmp('flBanco').setValue(records[0].data.BANCO);
                    }else{
                        Ext.MessageBox.alert('Error','¡No existen los datos!');
                    }                      
                }    
            }); //Cierra store
        }
        
        function loadInfoDeposito(ID_DONATIVO){
             storeInfoDeposito.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;
             storeInfoDeposito.load({ callback: function(records,o,s){
                     if(records.length > 0){
                        Ext.getCmp('flIdDeposito').setValue(records[0].data.ID_DEPOSITO);
                        Ext.getCmp('flCuenta55').setValue(records[0].data.CUENTA_55);
                        Ext.getCmp('flDepositoSorteos').setValue(records[0].data.DEPOSITO_SORTEOS);
                        Ext.getCmp('flOtrasCuentas').setValue(records[0].data.OTRAS_CUENTAS);
                    }else{
                        Ext.MessageBox.alert('Error','¡No existen los datos!');
                    }
                }    
             }); //Cierra store
        }
        
        function loadInfoTarjetaCredito(ID_DONATIVO){           
            storeInfoTarjetaCredito.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;            
            storeInfoTarjetaCredito.load({ callback: function(records,o,s){                    
                    if(records.length > 0){                        
                        Ext.getCmp('tCTitular').setValue(records[0].data.TITULAR);
                        Ext.getCmp('tCBanco').setValue(records[0].data.BANCO);
                        Ext.getCmp('tCNumTarjeta').setValue(records[0].data.NUM_TARJETA);
                        Ext.getCmp('tCFechaVencimiento').setValue(records[0].data.FECHA_VENCIMIENTO);
                        Ext.getCmp('tCCodigoSeguridad').setValue(records[0].data.CVV);
                        Ext.getCmp('tCTipoTarjeta').setValue(records[0].data.TIPO);                        
                        idTarjetaCredito = records[0].data.ID_TARJETA;
                    }else{
                       Ext.MessageBox.alert('Error','¡No existen los datos!');
                    }                    
                }                
            }); //Cierra store                
        }
        
        function loadInfoTarjetaDebito(ID_DONATIVO){           
            storeInfoTarjetaDebito.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;            
            storeInfoTarjetaDebito.load({ callback: function(records,o,s){                    
                    if(records.length > 0){                        
                        Ext.getCmp('tDID').setValue(records[0].data.ID_TARJETA_DEBITO);
                        Ext.getCmp('tDFolioDonativo').setValue(records[0].data.ID_DONATIVO);
                        Ext.getCmp('tDNumTarjeta').setValue(records[0].data.NUM_TARJETA);
                        Ext.getCmp('tDFechaVencimiento').setValue(records[0].data.FECHA_VENCIMIENTO);
                        Ext.getCmp('tDCodigoSeguridad').setValue(records[0].data.CVV);                        
                        Ext.getCmp('tDBanco').setValue(records[0].data.BANCO);                        
                        Ext.getCmp('tDIFE').setValue(records[0].data.IFE);                        
                    }else{
                       Ext.MessageBox.alert('Error','¡No existen los datos!');
                    }                    
                }                
            }); //Cierra store                
        }
        
        function loadInfoTransferencia(ID_DONATIVO){           
            storeInfoTransferencia.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;            
            storeInfoTransferencia.load({ callback: function(records,o,s){                    
                    if(records.length > 0){                        
                        Ext.getCmp('transfID').setValue(records[0].data.ID_TRANSFERENCIA);
                        Ext.getCmp('transfFolio').setValue(records[0].data.ID_DONATIVO);
                        Ext.getCmp('transfCuenta').setValue(records[0].data.CUENTA);                                                
                    }else{
                        Ext.MessageBox.alert('Error','¡No existen los datos!');
                    }                    
                }                
            }); //Cierra store                
        }
        
        /******************** MODELS ****************/
        Ext.define('infoChequeMdl',{
            id:'infoChequeMdl',
            extend: 'Ext.data.Model',
            fields: [
                'ID_CHEQUE',
                'NUM_CHEQUE',
                'ID_BANCO',
                'BANCO'                                               
            ]
        });
        
        Ext.define('infoDepositoMdl',{
            id:'infoDepositoMdl',
            extend: 'Ext.data.Model',
            fields: [
                'ID_DEPOSITO',
                'CUENTA_55',
                'DEPOSITO_SORTEOS',
                'OTRAS_CUENTAS'                                               
            ]
        });
        
        Ext.define('infoTarjetaCreditoMdl',{
            id:'infoTarjetaCreditoMdl',
            extend: 'Ext.data.Model',
            fields: [
                {name: 'ID_TARJETA'},
                {name: 'TITULAR'},
                {name: 'BANCO'},
                {name: 'NUM_TARJETA'},
                {name: 'FECHA_VENCIMIENTO'},
                {name: 'CVV'},
                {name: 'NUM_INICIAL'},
                {name: 'TIPO'}
            ]
        });
        
        Ext.define('infoTarjetaDebitoMdl',{
            id:'infoTarjetaDebitoMdl',
            extend: 'Ext.data.Model',
            fields: [
                {name: 'ID_TARJETA_DEBITO'},
                {name: 'ID_DONATIVO'},
                {name: 'NUM_TARJETA'},
                {name: 'FECHA_VENCIMIENTO'},
                {name: 'CVV'},
                {name: 'BANCO'},
                {name: 'IFE'}               
            ]
        });
        
        Ext.define('infoTransferenciaMdl',{
            id:'infoTransferenciaMdl',
            extend: 'Ext.data.Model',
            fields: [
                'ID_TRANSFERENCIA',
                'ID_DONATIVO',
                'CUENTA'                                              
            ]
        });
                
        /******************** STORES ****************/
        var storeInfoCheque = Ext.create('Ext.data.JsonStore', {
            model: 'infoChequeMdl',
            pageSize: 50,
            id:'storeInfoCheque',
            name:'storeInfoCheque',
            proxy: {
                type: 'ajax',
                url: 'bitacoraPagosAC.do',
                extraParams: {method: 'getInfoCheque'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeInfoDeposito = Ext.create('Ext.data.JsonStore', {
            model: 'infoDepositoMdl',
            pageSize: 50,
            id:'storeInfoDeposito',
            name:'storeInfoDeposito',
            proxy: {
                type: 'ajax',
                url: 'bitacoraPagosAC.do',
                extraParams: {method: 'getInfoDeposito'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeInfoTarjetaCredito = Ext.create('Ext.data.JsonStore', {
            model: 'infoTarjetaCreditoMdl',
            pageSize: 50,
            id:'storeInfoTarjetaCredito',
            name:'storeInfoTarjetaCredito',
            proxy: {
                type: 'ajax',
                url: 'bitacoraPagosAC.do',
                extraParams: {method: 'getInfoTarjetaCredito'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeInfoTarjetaDebito = Ext.create('Ext.data.JsonStore', {
            model: 'infoTarjetaDebitoMdl',
            pageSize: 50,
            id:'storeInfoTarjetaDebito',
            name:'storeInfoTarjetaDebito',
            proxy: {
                type: 'ajax',
                url: 'bitacoraPagosAC.do',
                extraParams: {method: 'getInfoTarjetaDebito'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeInfoTransferencia = Ext.create('Ext.data.JsonStore', {
            model: 'infoTransferenciaMdl',
            pageSize: 50,
            id:'storeInfoTransferencia',
            name:'storeInfoTransferencia',
            proxy: {
                type: 'ajax',
                url: 'bitacoraPagosAC.do',
                extraParams: {method: 'getInfoTransferencia'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        //Creation Screen            
            Ext.define('donantes.formaPago', {
                extend: 'Ext.window.Window',                
                alias:'widget.formaPago',                
                title: 'Detalles de la forma de Pago', 
               // id: 'datosCheque',
                width: 500,                
                height: 350,
                modal: true,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                constrain:true,
                initComponent: function() {
                /******************** Inicializar ****************/                
                winFormaPago = this;
                idFormaPago = this.name;   
                idDonativo = this.nameDos;

                
                
                if(idFormaPago == 2369){ // Cheque
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar
                    
                    loadInfoCheque(idDonativo);
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoCheque',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Datos del Cheque',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flIdCheque',                                                
                                                labelWidth: 130,
                                                fieldLabel: 'ID' 
                                            },                                            
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flNumCheque',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Num. Cheque'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flBanco',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Banco'
                                            }
                                        ] //Cierre items fieldset
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply
                }else if(idFormaPago == 2366){ //Deposito
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar
                    
                    loadInfoDeposito(idDonativo);
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoDeposito',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Datos del Deposito',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flIdDeposito',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'ID' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flCuenta55',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Cuenta Num. 55' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flDepositoSorteos',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Deposito Sorteos'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'flOtrasCuentas',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Otras Cuentas'
                                            }
                                        ] //Cierre items fieldset
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply
                }else if(idFormaPago == 2368){ //Tarjeta de Crédito
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[
                            new Ext.Button({
                                text:'Modificar Datos',
                                iconCls: 'icon-reload',
                                handler: function(){
                                    if(Ext.getCmp('datosTarjeta')==null){                                                                                 
                                        createNewObj3('donantes.datosTarjeta',0,idTarjetaCredito);
                                    }else{                                                                                
                                        Ext.getCmp('datosTarjeta').destroy()
                                        createNewObj3('donantes.datosTarjeta',0,idTarjetaCredito);
                                    }                                    
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                   
                    loadInfoTarjetaCredito(idDonativo)                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoTarjetaCredito',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Datos de la Tarjeta de Crédito',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tCTitular',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Titular'
                                                //value: pruebaaa
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tCBanco',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Banco' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tCNumTarjeta',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Num. Tarjeta'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tCFechaVencimiento',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Fecha Vencimiento'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tCCodigoSeguridad',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Código Seguridad'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tCTipoTarjeta',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Tipo Tarjeta'
                                            }
                                        ] //Cierre items fieldset
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                
                }else if(idFormaPago == 2367){ //Efectivo
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[                            
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                  
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoEfectivo',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Pago',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,                            
                                                value: 'El donativo fue en EFECTIVO.',
                                                labelWidth: 110                                                
                                            }
                                        ]
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                
                }else if(idFormaPago == 2845){ //NO ESPECIFICADO
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[                            
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                  
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoEfectivo',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Pago',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,                            
                                                value: 'La forma de pago es NO ESPECIFICADO.',
                                                labelWidth: 110                                                
                                            }
                                        ]
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                 
                }else if(idFormaPago == 2836){ //ESPECIE
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[                            
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                  
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoEspecie',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Pago',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,                            
                                                value: 'La forma de pago fue en ESPECIE.',
                                                labelWidth: 110                                                
                                            }
                                        ]
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                 
                }else if(idFormaPago == 2684){ //TRANSFERENCIA
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[                            
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                    
                    loadInfoTransferencia(idDonativo)
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoTransferencia',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Datos de la Transferencia',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'transfID',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'ID'                                                
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'transfFolio',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Folio Donativo'                                                
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'transfCuenta',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Cuenta'                                                
                                            }
                                        ]
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                 
                }else if(idFormaPago == 2686){ //DEPOSITO FACTURA
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[                            
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                                        
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoDepositoFactura',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Forma de Pago',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 400,                            
                                                value: 'La forma de pago fue en DEPOSITO FACTURA.',
                                                labelWidth: 110                                                
                                            }
                                        ]
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                 
                }else if(idFormaPago == 2685){ //TARJETA DE DEBITO
                    var tbarFormaPago = new Ext.Toolbar({
                        items:[                            
                            new Ext.Button({
                                text:'Cerrar Ventana',
                                iconCls: 'icon-salir',
                                handler: function(){    
                                    winFormaPago.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar                     
                    loadInfoTarjetaDebito(idDonativo)
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmFormaPagoTarjetaDebito',
                                tbar: tbarFormaPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Datos de la Tarjeta de Débito',
                                        items:[                                            
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDID',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'ID' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDFolioDonativo',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Folio Donativo' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDBanco',                                               
                                                labelWidth: 130,
                                                fieldLabel: 'Banco' 
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDNumTarjeta',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Num. Tarjeta'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDFechaVencimiento',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Fecha Vencimiento'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDCodigoSeguridad',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'Código Seguridad'
                                            },
                                            {
                                                xtype: 'displayfield',
                                                width: 400,
                                                id: 'tDIFE',                                              
                                                labelWidth: 130,
                                                fieldLabel: 'IFE'
                                            }                                            
                                        ]
                                    }
                                ] //Cierra items forma Pago
                            }
                        ] //Cierra items Ext.apply
                    }) //Cierra Ext.apply                 
                }
                    
                   donantes.formaPago.superclass.initComponent.apply(this, arguments);                   
                } //Cierra initComponent
            }); //Cierra Ext.define
        
        </script>
    </head>
    <body>
       
    </body>
</html>