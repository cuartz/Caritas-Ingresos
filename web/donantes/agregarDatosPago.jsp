<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String idusersession = "";
    try {
        if (sesion.getAttribute("idusersession") != null) {
            idusersession = sesion.getAttribute("idusersession").toString();
        }
        
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
        /**************** VARIABLES GLOBALES ****************************/
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        var winAddRecibo;
        var idDonativoWinAddRecibo;
        var importeAddRecibo;
        
        /************************** MODELS *******************************/
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });
        
        var statusPagoBitacora = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                extraParams:{llave:'ESTATUS_PAGO_TMP'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var cbxFormaPago = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                extraParams:{llave:'DONATIVO_FORMA_PAGO'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        /******************* FUNCIONES ***********************/
        function validaAgregarDatosPago(){
            var camposName=['ID_RECIBO',            // 0                                   
                'NUM_PAGO',             // 1
                'FECHA_VENCIMIENTO',    // 2
                'FECHA_PAGO',           // 3
                'IMPORTE',              // 4
                'ID_FORMA_PAGO',        // 5                                
                'ID_ESTATUS_PAGO',      // 6
                'COMENTARIOS',          // 7                              
                'FECHA_CANCELACION',    // 8
                'ID_MOTIVO_CANCELACION',//9
                'COMENTARIOS_CANCELACION']  //10
            
            var cadena  = "";
            var folio   = "";
            var longitud = 0;                   
            var ubicacion
            var enter = "\n"
            var caract_extra = "";
            var caracteres = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var contador = 0
            
            if(Ext.getCmp(camposName[1]).getValue() == null){ //numero de pago
                Ext.MessageBox.alert('Error','¡Ingresa el número del pago!');
                return false
            }else{
                cadena = Ext.getCmp(camposName[0]).getValue();
                folio = cadena.charAt(0)
                longitud = cadena.length
                if(longitud != 7){
                    Ext.MessageBox.alert('Error','¡El recibo debe tener 7 caracteres [1 letra y 6 numeros]!');
                    return false
                }else{
                    for (var i=0; i < cadena.length; i++) {
                        ubicacion = cadena.substring(i, i + 1)
                        if (caracteres.indexOf(ubicacion) != -1) {
                            contador++
                            if(!(isNaN(folio))){
                                Ext.MessageBox.alert('Error','¡El recibo debe iniciar con una letra!');
                                return false
                            }                                
                        }else{
                            Ext.MessageBox.alert('Error','¡Caractér inválido! ['+ubicacion+']');                                    
                            return false
                        }
                    }
                }
            }
            
            if(Ext.getCmp(camposName[0]).getValue() == ""){ //recibo
                Ext.MessageBox.alert('Error','¡Ingresa el número de recibo!');
                return false
            }
            
            if(Ext.getCmp(camposName[6]).getValue() == null){ //Status
                Ext.MessageBox.alert('Error','¡Selecciona el Estatus!');
                return false
            }
            
            if(Ext.getCmp(camposName[2]).getValue() == null){ //fecha de vencimiento
                Ext.MessageBox.alert('Error','¡Ingresa la fecha de Vencimiento!');
                return false
            }         
            
            if(Ext.getCmp(camposName[6]).getValue() != 2778 && Ext.getCmp(camposName[3]).getValue() == null){ //FECHA DE PAGO
                Ext.MessageBox.alert('Error','¡Ingresa la fecha de Pago!');
                return false
            }
            
            if(Ext.getCmp(camposName[6]).getValue() == 2778 && Ext.getCmp(camposName[9]).getValue() == null){ //motivo cancelacion
                Ext.MessageBox.alert('Error','¡Selecciona un motivo de Cancelacion!');
                return false
            }
            
            if(Ext.getCmp(camposName[6]).getValue() == 2778 && Ext.getCmp(camposName[10]).getValue() == ""){ //Comentarios cancelacion
                Ext.MessageBox.alert('Error','¡Ingresa un comentario de cancelación!');
                return false
            }
        }
        
        //Creation Screen            
        Ext.define('donantes.agregarDatosPago', {
            extend: 'Ext.window.Window',                
            alias:'widget.agregarDatosPago',                
            title: 'Agregar Recibo',              
            width: 430,                
            height: 470,
            modal: true,
            border: false,
            constrain : true,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'close',               
            region:'center',
            initComponent: function() {
            /******************* INICIAR VALORES **************************/
            winAddRecibo = this;
            idDonativoWinAddRecibo = this.name;
            importeAddRecibo = this.nameDos;
            
            /******************* TOOLBAR **************************/
            var tbarAddRecibo = new Ext.Toolbar({
                items:[
                new Ext.Button({
                text:'Guardar',
                iconCls: 'icon-save',
                handler: function(){   
                    var json = winAddRecibo.getDatas();
                    //alert("guardar: "+json);
                    if(validaAgregarDatosPago() != false){
                        Ext.Msg.confirm('Actualizar Datos', '¿Los datos son correctos?', function(btn, text){
                            if (btn == 'yes'){
                                Ext.getCmp('mainFormAddPago').getForm().submit({
                                    url: 'agregarDatosPagoAC.do?method=agregarDatos&jsonData='+json+'&idUsuario='+idUsuario,
                                    waitMsg: 'Guardando...',
                                    success: function(form, action) {    
                                        var info = Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                        Ext.getCmp('gridBitacora').getStore().load();
                                        winAddRecibo.destroy();                                        
                                    },
                                    failure: function(form, action) {
                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                    }
                                }); 
                            }
                        })
                    }
                }
                }),
                '-',
                new Ext.Button({
                    text:'Salir',
                    iconCls: 'icon-salir',
                    handler: function(){                                    
                        winAddRecibo.destroy();
                    }
                })
                ]
            }); //Cierra toolbar
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',  
                            id: 'mainFormAddPago',
                            border: 'false',
                            tbar: tbarAddRecibo,
                            items:[
                               {
                                   xtype: 'container',
                                   margin: '8',
                                   items:[
                                       {
                                           xtype: 'displayfield',
                                            width: 293,
                                            id: 'ID_DONATIVO',
                                            value: idDonativoWinAddRecibo,
                                            labelWidth: 130,
                                            fieldLabel: 'Donativo'
                                       },
                                       {
                                            xtype: 'numberfield',                                                
                                            fieldLabel: 'Num. Pago',
                                            emptyText:'Num. Pago',
                                            labelWidth: 130,
                                            id: 'NUM_PAGO',
                                            size: 15
                                       },
                                       {
                                            xtype: 'textfield',                                                
                                            fieldLabel: 'Num. de Recibo',
                                            emptyText:'Num. de Recibo',
                                            labelWidth: 130,
                                            id: 'ID_RECIBO',
                                            size: 15
                                       },
                                       Ext.create('Ext.form.ComboBox', {
                                            fieldLabel: 'Estatus',
                                            store: statusPagoBitacora,
                                            labelWidth: 130,
                                            emptyText: 'Seleccione el estatus',
                                            size: 30,
                                            displayField: 'nombre',
                                            valueField: 'id',
                                            id: 'ID_ESTATUS_PAGO',
                                            listeners:{
                                                select:function(boton,event){ 
                                                    if(this.getValue() == 2778){ //Cancelado
                                                        Ext.getCmp('FECHA_CANCELACION').enable();
                                                        Ext.getCmp('ID_MOTIVO_CANCELACION').enable();
                                                        Ext.getCmp('COMENTARIOS_CANCELACION').enable();                                                            
                                                        Ext.getCmp('FECHA_PAGO').setValue('01/01/1900');
                                                        Ext.getCmp('FECHA_PAGO').disable();
                                                        Ext.getCmp('ID_FORMA_PAGO').disable();
                                                        Ext.getCmp('FECHA_CANCELACION').setValue('01/01/1900');
                                                    }else{ 
                                                        Ext.getCmp('ID_MOTIVO_CANCELACION').disable();
                                                        Ext.getCmp('COMENTARIOS_CANCELACION').disable();
                                                        Ext.getCmp('FECHA_CANCELACION').disable(); 
                                                        Ext.getCmp('ID_MOTIVO_CANCELACION').reset();
                                                        Ext.getCmp('COMENTARIOS_CANCELACION').reset();
                                                        Ext.getCmp('FECHA_CANCELACION').reset();
                                                        Ext.getCmp('FECHA_PAGO').enable();
                                                        Ext.getCmp('FECHA_PAGO').reset();
                                                        Ext.getCmp('ID_FORMA_PAGO').enable();
                                                    }
                                                }
                                            }
                                       }),
                                       {
                                            xtype: 'datefield', 
                                            id:'FECHA_VENCIMIENTO',
                                            labelWidth: 130,
                                            fieldLabel: 'Fecha Vencimiento'
                                        },
                                        {
                                            xtype: 'datefield', 
                                            id:'FECHA_PAGO',
                                            labelWidth: 130,
                                            fieldLabel: 'Fecha Pago'
                                       },
                                       {
                                            xtype: 'displayfield',
                                            width: 293,
                                            id: 'IMPORTE',
                                            value: importeAddRecibo,
                                            labelWidth: 130,
                                            fieldLabel: 'Importe'
                                       },
                                       Ext.create('Ext.form.ComboBox', {
                                            fieldLabel: 'Forma de Pago',
                                            store: cbxFormaPago,
                                            emptyText: 'Seleccione la forma de pago',
                                            size: 30,
                                            labelWidth: 130,
                                            displayField: 'nombre',
                                            valueField: 'id',
                                            id: 'ID_FORMA_PAGO'                                                
                                        }),
                                        {
                                            xtype: 'textarea',
                                            id:'COMENTARIOS',
                                            fieldLabel: 'Comentarios',
                                            allowBlank:false,                                                
                                            labelWidth: 130,                                               
                                            width: 350,                                                                    
                                            height: 60                                                                                                                                                                                                       
                                        },
                                        {
                                            xtype: 'datefield', 
                                            id:'FECHA_CANCELACION',
                                            labelWidth: 130,
                                            fieldLabel: 'Fecha Cancelación',
                                            disabled: 'true'
                                        },                                            
                                        Ext.create('Ext.form.ComboBox',{
                                            fieldLabel: 'Motivo',
                                            store: storesMotivoCancelacion,                                               
                                            id: 'ID_MOTIVO_CANCELACION',
                                            width:350,  
                                            valueField: 'id',
                                            displayField: 'nombre',
                                            typeAhead: true,
                                            mode: 'local',
                                            labelWidth: 130,
                                            triggerAction: 'all',
                                            emptyText: '¡Seleccione el un motivo!',
                                            selectOnFocus: true,
                                            disabled: 'true'
                                        }),
                                        {
                                            xtype: 'textareafield',
                                            height: 60,
                                            width: 350,
                                            labelWidth: 130,
                                            id: 'COMENTARIOS_CANCELACION',
                                            fieldLabel: 'Desc. Cancelación',
                                            disabled: 'true'
                                        }                                       
                                   ] //Cierra items container
                               } 
                            ] //Cierra items form
                        }
                    ] //Cierra items init Component
                }); //Cierra Ext.apply
                donantes.agregarDatosPago.superclass.initComponent.apply(this, arguments);
            }, //Cierra init component
            getDatas: function (){
                var camposName=['ID_DONATIVO',              // 0                                   
                                'NUM_PAGO',                 // 1
                                'ID_RECIBO',                // 2
                                'ID_ESTATUS_PAGO',          // 3
                                'FECHA_VENCIMIENTO',        // 4
                                'FECHA_PAGO',               // 5                                
                                'IMPORTE',                  // 6
                                'ID_FORMA_PAGO',            // 7                              
                                'COMENTARIOS',              // 8
                                'FECHA_CANCELACION',        //9
                                'ID_MOTIVO_CANCELACION',    //10
                                'COMENTARIOS_CANCELACION']  //11

                var camposValue = {'ID_DONATIVO':0,
                        'NUM_PAGO':0,
                        'ID_RECIBO':'',
                        'ID_ESTATUS_PAGO':0,                                            
                        'FECHA_VENCIMIENTO':'',
                        'FECHA_PAGO':'',
                        'IMPORTE':'',
                        'ID_FORMA_PAGO':0,
                        'COMENTARIOS':'',
                        'FECHA_CANCELACION':'',
                        'ID_MOTIVO_CANCELACION':0,
                        'COMENTARIOS_CANCELACION':''};
                                
                var pos=0;
                var value = '';
                
                for(pos=0;pos<camposName.length;pos++){   
                    if(pos == 3){ //Estatus
                        value = Ext.getCmp(camposName[3]).getValue();
                        if(value == null)
                            camposValue[camposName[3]] = 0; 
                        else
                            camposValue[camposName[3]] = value  
                    }else if(pos == 5){ //Fecha de Pago
                        value = Ext.getCmp(camposName[5]).getValue();
                        if(value == null)
                            camposValue[camposName[5]] = '01/01/1900'; 
                        else
                            camposValue[camposName[5]] = value                                
                    }else if(pos == 7){ //Forma de pago
                        value = Ext.getCmp(camposName[7]).getValue();
                        if(value == null)
                            camposValue[camposName[7]] = 0; 
                        else
                            camposValue[camposName[7]] = value  
                    }else if(pos == 9){ //fecha cancelacion
                        value = Ext.getCmp(camposName[9]).getValue();
                        if(value == null)
                            camposValue[camposName[9]] = '01/01/1900'; 
                        else
                            camposValue[camposName[9]] = value  
                    }else if(pos == 10){ //motivo cancelacion
                        value = Ext.getCmp(camposName[10]).getValue();
                        if(value == null)
                            camposValue[camposName[10]] = 0; 
                        else
                            camposValue[camposName[10]] = value  
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
