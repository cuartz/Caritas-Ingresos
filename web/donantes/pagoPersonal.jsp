<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
        
        
        /********************* MODELS ******************************/
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });
        
        Ext.define('Sustituto',{
            id:'Sustituto',
            extend: 'Ext.data.Model',
            fields: ['ID_DONANTE_TMP','RAZON_SOCIAL']
        });        
        
        /********************* STORES ******************************/
        var cbxFormaEnvioPagoPersonal = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                extraParams:{llave:'INGRESOS_TIPO_ENVIO'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        Ext.define('donantes.pagoPersonal', {
            extend: 'Ext.window.Window',                    
            alias:'widget.pagoPersonal',                    
            title: 'Pago Personal',
            modal: true,
            constrain : true,                    
            width: 450,                
            height: 300,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'close',
            region:'center',
            initComponent: function() {
                var winPagoPersonal             = this;
                var idBitacoraPagoPersonal      = this.name;

                /******************** TOOLBAR *****************************/
                var tbarPagoPersonal = new Ext.Toolbar({
                    items: [                            
                        new Ext.Button({
                            text: 'Guardar',
                            iconCls: 'icon-save',
                            handler:function(){
                                var json = winPagoPersonal.getDatas();
                                //alert("Guardar: "+json);
                                Ext.Msg.confirm('Confirmar Pago', '¿Los datos son correctos?', function(btn, text){ 
                                    if (btn == 'yes'){
                                        Ext.getCmp('frmPagoPersonal').getForm().submit({                                                            
                                            url: 'bitacoraPagosAC.do?method=cobrarPagoPersonal&jsonData='+json+'&idBitacora='+idBitacoraPagoPersonal,                                                           
                                            waitMsg: 'Guardando...',
                                            success: function(form, action) {                                                
                                                winPagoPersonal.destroy();
                                                Ext.getCmp('gridBitacora').getStore().load();
                                                Ext.MessageBox.alert('Guardado','¡Se grabo la información correctamente!');    
                                            },
                                            failure: function(form, action) {
                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                            }
                                        }); 
                                    }
                                });
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Salir',
                            iconCls: 'icon-salir',
                            handler: function(){ 
                                winPagoPersonal.destroy();                            
                            }
                        })
                    ]
                });

                var cbxSustitutoPagoPersonal = Ext.create('Ext.data.JsonStore', {
                    model: 'Sustituto',
                    proxy: {
                        type: 'ajax',
                        url: 'comboboxAC.do?method=getSearchSustituto',
                        extraParams:{ID_BITACORA:idBitacoraPagoPersonal},
                        reader: {
                            type: 'json',
                            root: 'rows'
                        }
                    }
                });


                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',
                            id: 'frmPagoPersonal',   
                            tbar: tbarPagoPersonal,
                            items:[
                                {
                                    xtype: 'checkboxfield', 
                                    fieldLabel: 'Factura Elect.', 
                                    id: 'FACTURA_ELECTRONICA_PAGO_PERSONAL',
                                    handler: function(){
                                        if(this.checked){
                                            Ext.getCmp('ID_FORMA_ENVIO_PAGO_PERSONAL').enable();
                                        }else{
                                            Ext.getCmp('ID_FORMA_ENVIO_PAGO_PERSONAL').disable();
                                            Ext.getCmp('ID_FORMA_ENVIO_PAGO_PERSONAL').reset();
                                        }
                                    }
                                },
                                {
                                    xtype: 'combo',
                                    fieldLabel: 'Forma de Envio',
                                    id: 'ID_FORMA_ENVIO_PAGO_PERSONAL',
                                    size: 30,
                                    store: cbxFormaEnvioPagoPersonal,
                                    displayField: 'nombre',
                                    valueField: 'id',
                                    disabled: true
                                },
                                {
                                    xtype: 'textarea',
                                    id:'COMENTARIOS_PAGO_PERSONAL',
                                    fieldLabel: 'Comentarios',
                                    allowBlank: false,                                                                                                      
                                    width: 380,                                                                    
                                    height: 90 
                                },
                                {
                                    xtype: 'checkboxfield', 
                                    fieldLabel: 'Sustituto', 
                                    id: 'SUSTITUTO_PAGO_PERSONAL',
                                    handler: function(){
                                        if(this.checked){
                                            Ext.getCmp('ID_SUSTITUTO_PAGO_PERSONAL').enable();                                                
                                        }else{
                                            Ext.getCmp('ID_SUSTITUTO_PAGO_PERSONAL').disable();
                                            Ext.getCmp('ID_SUSTITUTO_PAGO_PERSONAL').reset();
                                        }
                                    }
                                },
                                {
                                    xtype: 'combo',
                                    fieldLabel: 'Seleccionar',
                                    id: 'ID_SUSTITUTO_PAGO_PERSONAL',
                                    size: 40,
                                    store: cbxSustitutoPagoPersonal,
                                    displayField: 'RAZON_SOCIAL',
                                    valueField: 'ID_DONANTE_TMP',
                                    disabled: true
                                },
                                {
                                    xtype: 'datefield', 
                                    id:'FECHA_PAGO_PERSONAL',
                                    fieldLabel: 'Fecha Pago',
                                    format:'d/m/Y',
                                    value: new Date()
                                }
                            ] //Cierra items form
                        }                            
                    ] //Cierra items ext.apply                        
                }) //Cierra Ext.apply
                donantes.pagoPersonal.superclass.initComponent.apply(this, arguments);
            }, //Cierra initComponent
            getDatas: function (){
                var camposName=['FACTURA_ELECTRONICA_PAGO_PERSONAL',
                    'ID_FORMA_ENVIO_PAGO_PERSONAL',
                    'COMENTARIOS_PAGO_PERSONAL',
                    'SUSTITUTO_PAGO_PERSONAL',
                    'ID_SUSTITUTO_PAGO_PERSONAL',
                    'FECHA_PAGO_PERSONAL'
                ]

                var camposValue = {'FACTURA_ELECTRONICA_PAGO_PERSONAL':0,
                    'ID_FORMA_ENVIO_PAGO_PERSONAL':0,
                    'COMENTARIOS_PAGO_PERSONAL':'',
                    'SUSTITUTO_PAGO_PERSONAL':0,
                    'ID_SUSTITUTO_PAGO_PERSONAL':0,
                    'FECHA_PAGO_PERSONAL':''
                };
                
                var pos = 0;
                var value = '';
                
                for(pos=0;pos<camposName.length;pos++){
                    if(pos == 0){ //Checkbox de factura electronica
                        value = Ext.getCmp(camposName[pos]).getValue();                                
                        if(value == true){
                            camposValue[camposName[pos]] = 1; 
                        }if(value == false){
                            camposValue[camposName[pos]] = 0; 
                        }
                    }else if(pos == 3){ //Checkbox sustituto
                        value = Ext.getCmp(camposName[pos]).getValue();                                
                        if(value == true){
                            camposValue[camposName[pos]] = 1; 
                        }if(value == false){
                            camposValue[camposName[pos]] = 0; 
                        }
                    }else if(pos == 1 || pos == 4){
                        value = Ext.getCmp(camposName[pos]).getValue();
                        if(value == null)
                            camposValue[camposName[pos]] = 0; 
                        else
                            camposValue[camposName[pos]] = value;                        
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
        <div id="contenedor"></div>
    </body>
</html>
