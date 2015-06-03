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
            var winDatosPagoUpdate;
            var idBitacora;
            var numPagoTmp;
            var importeTmp;
            var UID; 
            
            
            Ext.define('catalog',{
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
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
            
            var storesMotivoCancelacion = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_TIPO_CANCELACION'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
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
            
            function inicio(){
               Ext.getCmp('ID_MOTIVO_CANCELACION').disable(); 
            }
            
            function validaDatosPago(){
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
                
                if(Ext.getCmp(camposName[0]).getValue() == ""){ //Validar el id recibo
                    Ext.MessageBox.alert('Error','¡Ingresa el número del recibo!');
                    return false
                }
//                    cadena = Ext.getCmp(camposName[0]).getValue(); //Obtener la cadena
//                    folio = cadena.charAt(0) //Obtener el primer caracter
//                    longitud = cadena.length //Obtener la longitud
//                    if(longitud != 7){
//                        Ext.MessageBox.alert('Error','¡El recibo debe tener 7 caracteres [1 letra y 6 numeros]!');
//                        return false
//                    }
//                        for (var i=0; i < cadena.length; i++) {
//                            ubicacion = cadena.substring(i, i + 1)
//                            if (caracteres.indexOf(ubicacion) != -1) {
//                                contador++
//                                if(!(isNaN(folio))){
//                                    Ext.MessageBox.alert('Error','¡El recibo debe iniciar con una letra!');
//                                    return false
//                                }                                
//                            }else{
//                                Ext.MessageBox.alert('Error','¡Caractér inválido! ['+ubicacion+']');                                    
//                                return false
//                            }
//                        }
                     
//                }
                
                if(Ext.getCmp(camposName[6]).getValue() == null){ //Validar el status del pago
                    Ext.MessageBox.alert('Error','¡Selecciona el estatus del recibo!');
                    return false
                }
                
                if(Ext.getCmp(camposName[2]).getValue() == null){ //Validar la fecha de vencimiento
                    Ext.MessageBox.alert('Error','¡Selecciona la fecha de vencimiento!');
                    return false
                }
                
                if(Ext.getCmp(camposName[7]).getValue() == null){ //Validar el comentario
                    Ext.MessageBox.alert('Error','¡Ingresa algun comentario!');
                    return false
                }
            }
            
            //Creation Screen            
            Ext.define('donantes.actualizarDatosPago', {
                extend: 'Ext.window.Window',                
                alias:'widget.actualizarDatosPago',                
                title: 'Actualización de Datos del Pago',              
                width: 430,                
                height: 465,
                modal: true,
                border: false,
                constrain : true,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',               
                region:'center',               
                initComponent: function() {
                    /************* INICIAR VARIABLES *****************/
                    winDatosPagoUpdate = this;
                    idBitacora = this.name;
                    numPagoTmp = this.nameDos;    
                    importeTmp = this.nameTres;
                    
                    var tbarPago = new Ext.Toolbar({
                        items:[
                        new Ext.Button({
                        text:'Guardar',
                        iconCls: 'icon-save',
                        handler: function(){   
                            if(validaDatosPago() != false ){
                            var json = winDatosPagoUpdate.getDatas();
                            // alert("guardar: "+json);
                                Ext.Msg.confirm('Actualizar Datos', '¿Los datos son correctos?', function(btn, text){
                                    if (btn == 'yes'){
                                        Ext.getCmp('mainFormUpdatePago').getForm().submit({
                                            url: 'actualizarDatosPagoAC.do?method=actualizarDatos&jsonData='+json+'&idBitacora='+idBitacora+'&idUsuario='+idUsuario,
                                            waitMsg: 'Guardando...',
                                            success: function(form, action) {    
                                                Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                                Ext.getCmp('gridBitacora').getStore().load();
                                                winDatosPagoUpdate.close();                                        
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
                                    winDatosPagoUpdate.destroy();                            
                                }
                            })
                        ]
                    }); //Cierra toolbar 
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',  
                                id: 'mainFormUpdatePago',
                                border: 'false',
                                tbar: tbarPago,
                                items:[
                                    {
                                        xtype: 'container',
                                        margin: '8',
                                        items:[
                                            {
                                                xtype: 'displayfield',
                                                width: 293,
                                                id: 'NUM_PAGO',
                                                value: numPagoTmp,
                                                labelWidth: 130,
                                                fieldLabel: 'Num. Pago'
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
                                                            Ext.getCmp('ID_MOTIVO_CANCELACION').enable();
                                                            Ext.getCmp('COMENTARIOS_CANCELACION').enable();
                                                            Ext.getCmp('FECHA_CANCELACION').enable();
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
                                                value: importeTmp,
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
                                    } // Cierra grupo items form
                                ] //Cierra items form
                            } //Cierra grupo items
                        ] //Cierra items apply
                    }) //Cierra ext.apply
                    donantes.actualizarDatosPago.superclass.initComponent.apply(this, arguments);
                }, //Cierra init component
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
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

                        var camposValue = {'ID_RECIBO':'',
                                            'NUM_PAGO':0,
                                            'FECHA_VENCIMIENTO':'',
                                            'FECHA_PAGO':'',                                            
                                            'IMPORTE':0,
                                            'ID_FORMA_PAGO':0,
                                            'ID_ESTATUS_PAGO':0,
                                            'COMENTARIOS':'',
                                            'FECHA_CANCELACION':'',
                                            'ID_MOTIVO_CANCELACION':0,
                                            'COMENTARIOS_CANCELACION':''                                            
                                            };                           
                            
                        var pos=0;
                        var value = '';             
//                       
                        for(pos=0;pos<camposName.length;pos++){   
                            if(pos == 3){
                                value = Ext.getCmp(camposName[3]).getValue();
                                if(value == null)
                                    camposValue[camposName[3]] = '01/01/1900'; 
                                else
                                    camposValue[camposName[3]] = value  
                            }else if(pos == 9){ // Motivo Cancelacion
                                value = Ext.getCmp(camposName[9]).getValue();
                                if(value == null)
                                   camposValue[camposName[9]] = 0; 
                                else
                                    camposValue[camposName[9]] = value                                
                            }else if(pos == 5){ //forma Pago
                                value = Ext.getCmp(camposName[5]).getValue();
                                if(value == null)
                                    camposValue[camposName[5]] = 0; 
                                else
                                    camposValue[camposName[5]] = value  
                            }else if(pos == 8){ //fecha cancelacion
                                value = Ext.getCmp(camposName[8]).getValue();
                                if(value == null)
                                    camposValue[camposName[8]] = '01/01/1900'; 
                                else
                                    camposValue[camposName[8]] = value  
                            }else{
                                value = Ext.getCmp(camposName[pos]).getValue();                           
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
