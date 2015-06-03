<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
        /************************ VARIABLES GLOBALES *******************************/
        var winModificarRecibos;
        var idBitacoraTmpMP;
        var numPagoMP;
        var tipoModificacionMP;       
        
        
        /************************ MODELS *******************************/
        Ext.define('modificarPagoInf',{
            id:'modificarPagoInf',
            extend: 'Ext.data.Model',
            fields: [
                {name: 'ID_NUM_PAGO'},
                {name: 'FECHA_COBRO'}                                
            ]
        });
        
        
        
        /************************ FUNCIONES JAVASCRIPT *******************************/
        function loadInfoModificarPago(idBitacora){            
            storeInfoModificarPago.proxy.extraParams.ID_BITACORA = idBitacora;          
            storeInfoModificarPago.load({ callback: function(records,o,s){
                if(records.length > 0){
                    Ext.getCmp('NUM_PAGO_MP').setValue(records[0].data.ID_NUM_PAGO);
                    Ext.getCmp('FECHA_COBRO_MP').setValue(records[0].data.FECHA_COBRO);
                }                            
            }                        
            }); //Cierra storeDonativoInfo 
        }
        
        /************************ STORE *******************************/
        var storeInfoModificarPago = Ext.create('Ext.data.JsonStore', {
            model: 'modificarPagoInf',
            pageSize: 50,
            id:'storeInfoModificarPago',
            name:'storeInfoModificarPago',
            proxy: {
                type: 'ajax',
                url: 'bitacoraPagosAC.do',
                extraParams: {method: 'getInfoModificarPago'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        
        /************************ INICIO *******************************/
        Ext.define('donantes.modificarRecibo', {
                extend: 'Ext.window.Window',                    
                alias:'widget.bitacoraPagos',                    
                title: 'Modificar Datos del Recibo',
                modal: true,
                constrain : true,                    
                width: 400,                
                height: 160,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                initComponent: function() {
                    winModificarRecibos = this;
                    idBitacoraTmpMP     = this.name;
                    numPagoMP           = this.nameDos;
                    tipoModificacionMP  = this.nameTres;
                    //alert("idBitacora: "+idBitacoraTmpMP+" | numPago: "+numPagoMP+" | Tipo de Modificación: "+tipoModificacionMP);
                    loadInfoModificarPago(idBitacoraTmpMP);
                    
                    var tbarEditNumPago = new Ext.Toolbar({
                        items: [
                            new Ext.Button({
                                text: 'Guardar',
                                iconCls: 'icon-save',
                                handler: function(){
                                    var json = winModificarRecibos.getDatas();
                                    //alert("Guardar: "+json);
                                    Ext.Msg.confirm('Actualizar Datos', '¿Los datos son correctos?', function(btn, text){
                                        if (btn == 'yes'){
                                            Ext.getCmp('frmModificarRecibos').getForm().submit({
                                                url: 'bitacoraPagosAC.do?method=updateInfoRecibo&jsonData='+json+'&idBitacora='+idBitacoraTmpMP,
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {    
                                                    Ext.MessageBox.alert('Actualizando','Se actualizó la información correctamente');
                                                    Ext.getCmp('gridBitacora').getStore().load();
                                                    winModificarRecibos.destroy();
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al actualizar la información!');
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
                                    winModificarRecibos.destroy();                            
                                }
                            })                            
                        ]
                    });                    
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmModificarRecibos',
                                tbar: tbarEditNumPago,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Modificar Datos',
                                        items:[
                                            {
                                                xtype: 'numberfield',                                        
                                                fieldLabel: 'Num. Pago',
                                                id: 'NUM_PAGO_MP',
                                                size: 10
                                            },
                                            {
                                                xtype: 'datefield', 
                                                id:'FECHA_COBRO_MP',                                               
                                                fieldLabel: 'Fecha Cobro'                                                
                                            }
                                        ] //Cierre items fieldset
                                    }
                                ] //Cierre items form
                            }
                        ] //Cierre items Ext.apply
                    }) //Cierre Ext.apply
                    donantes.modificarRecibo.superclass.initComponent.apply(this, arguments); 
                    //storeInfoModificarPago.load();
                }, //Cierre initComponent
                getDatas: function(){
                        var camposName = ['NUM_PAGO_MP',
                                            'FECHA_COBRO_MP'] 

                        var camposValue = {'NUM_PAGO_MP':0,
                                            'FECHA_COBRO_MP':''};                           
                            
                        var pos = 0;
                        var value = ''; 
                        
                        for(pos=0;pos<camposName.length;pos++){                               
                                value = Ext.getCmp(camposName[pos]).getValue();                           
                                camposValue[camposName[pos]] = value;                                                                                                                                                                                               
                        }                                 
                        return Ext.encode(camposValue);                        
                }
        }); //Cierre Ext.define
        
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
    