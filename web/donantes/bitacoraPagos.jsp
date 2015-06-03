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
    //Variables Globales
    var idUsuarioTmp    = '<%=idusersession%>';
    var idUsuarioSplit  = idUsuarioTmp.split(":");
    var idUsuario       = idUsuarioSplit[0];
    var idDonativoTmp   = 0;
    var bitaPagos;
    var tipoDonativo;
    var idBitacoraTmp;
    var numDonante, 
    nombre, 
    tipoDonativoGral, 
    importe, 
    unidad, 
    producto, 
    formaPago, 
    pagoUnico, 
    frecuencia, 
    tipoFrecuencia, 
    numFrecuencia, 
    campFinanciera,
    categoria,
    asignacion, 
    caso, 
    cantidad,
    tipoDonante,
    telCasa,
    telOficina,
    telCel,
    email,
    datosClave;
    var idFormaPago;
    var storeBitacora;

    function render_moneyBP(v, p, record){
        return '$ '+v
    }

    function ajax_loaded_callback(){
        Ext.MessageBox.hide();
    }

    Ext.define('catalog',{
        id:'catalog',
        extend: 'Ext.data.Model',
        fields: ['nombre']
    }); 

    //Model
    Ext.define('bitacoraPagos',{
        id:'bitacoraPagos',
        extend: 'Ext.data.Model',
        fields: [
            {name: 'ID_BITACORA'},
            {name: 'ID_DONATIVO'},
            {name: 'ID_NUM_PAGO'},
            {name: 'FECHA_COBRO'},
            {name: 'FECHA_PAGO'},
            {name: 'FECHA_VISITA'},
            {name: 'ID_FORMA_PAGO'},
            {name: 'FORMA_PAGO'},
            {name: 'IMPORTE'},                        
            {name: 'ID_RECIBO'},
            {name: 'ID_ESTATUS_PAGO_TMP'},
            {name: 'ESTATUS_PAGO_TMP'},
            {name: 'ESTATUS_PAGO'},
            {name: 'ESTATUS_RECIBO'},
            {name: 'FECHA_IMPRESION'},
            {name: 'ID_MOTIVO_CANCELACION'},
            {name: 'MOTIVO_CANCELACION'},
            {name: 'FECHA_CANCELACION'},
            {name: 'COMENTARIOS'},
            {name: 'COMENTARIOS_CANCELACION'},
            {name: 'PERSONALMENTE_RECIBO'},
            {name: 'STATUS_IMPRESO'}
        ]
    });

    function loadInfo(ID_DONATIVO){
        storeDonativoInfo.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;
        storeDonativoInfo.load({ callback: function(records,o,s){
            if(records.length > 0){
                numDonante = records[0].data.ID_DONANTE;
                nombre = records[0].data.NOMBRE;
                tipoDonativoGral = records[0].data.TIPO_DONATIVO;
                importe = records[0].data.IMPORTE;
                unidad = records[0].data.UNIDAD_MEDIDA;
                producto = records[0].data.PRODUCTO;
                formaPago = records[0].data.FORMA_PAGO;
                idFormaPago = records[0].data.ID_FORMA_PAGO;
                //  idFormaPago = 2370;
                pagoUnico = records[0].data.PAGO_UNICO;
                frecuencia = records[0].data.FRECUENCIA;
                tipoFrecuencia = records[0].data.TIPO_FRECUENCIA;
                numFrecuencia = records[0].data.NUM_FRECUENCIA;
                campFinanciera = records[0].data.CAMPANA_FINANCIERA;
                categoria = records[0].data.CATEGORIA;
                asignacion = records[0].data.ASIGNACION;
                caso = records[0].data.NUM_CASO; 
                cantidad = records[0].data.CANTIDAD;
                tipoDonante = records[0].data.TIPO_DONANTE;
                telCasa = records[0].data.TEL_CASA;
                telOficina = records[0].data.TEL_OFICINA;
                telCel = records[0].data.TEL_CEL;
                email = records[0].data.EMAIL;
                datosClave = records[0].data.DATOS_CLAVE;

                Ext.getCmp('gralIdDonante').setValue(records[0].data.ID_DONANTE);
                Ext.getCmp('gralNombre').setValue(records[0].data.NOMBRE);
                Ext.getCmp('gralTipoDonativo').setValue(records[0].data.TIPO_DONATIVO);
                Ext.getCmp('gralImporte').setValue(records[0].data.IMPORTE);
                Ext.getCmp('gralUnidad').setValue(records[0].data.UNIDAD_MEDIDA);
                Ext.getCmp('gralProducto').setValue(records[0].data.PRODUCTO);
                Ext.getCmp('gralFormaPago').setValue(records[0].data.FORMA_PAGO);
                Ext.getCmp('gralPagoUnico').setValue(records[0].data.PAGO_UNICO);
                Ext.getCmp('gralFrecuencia').setValue(records[0].data.FRECUENCIA);
                Ext.getCmp('gralTipoFrecuencia').setValue(records[0].data.TIPO_FRECUENCIA);
                Ext.getCmp('gralNumFrecuencia').setValue(records[0].data.NUM_FRECUENCIA);
                Ext.getCmp('gralCampFinanciera').setValue(records[0].data.CAMPANA_FINANCIERA);
                Ext.getCmp('gralCategoria').setValue(records[0].data.CATEGORIA);
                Ext.getCmp('gralAsignacion').setValue(records[0].data.ASIGNACION);
                Ext.getCmp('gralNumCaso').setValue(records[0].data.NUM_CASO);
                Ext.getCmp('gralCantidad').setValue(records[0].data.CANTIDAD);
                Ext.getCmp('gralTipoDonante').setValue(records[0].data.TIPO_DONANTE);
                Ext.getCmp('gralTelCasa').setValue(records[0].data.TEL_CASA);
                Ext.getCmp('gralTelOficina').setValue(records[0].data.TEL_OFICINA);
                Ext.getCmp('gralTelCel').setValue(records[0].data.TEL_CEL);
                Ext.getCmp('gralEmail').setValue(records[0].data.EMAIL);
                Ext.getCmp('gralDatosClave').setValue(records[0].data.DATOS_CLAVE);
                Ext.getCmp('gralDireccion').setValue(records[0].data.DIRECCION);
                Ext.getCmp('gralFechaAlta').setValue(records[0].data.FECHA_ALTA);
                Ext.getCmp('gralFechaAltaDonativo').setValue(records[0].data.FECHA_ALTA_DONATIVO);
            }
            }
        }); //Cierra storeDonativoInfo 
    }

    Ext.define('donativoInf',{
        id:'donativoInf',
        extend: 'Ext.data.Model',
        fields: [
            'ID_DONANTE',
            'NOMBRE',
            'ID_TIPO_DONATIVO',
            'TIPO_DONATIVO',
            'ID_FORMA_PAGO',
            'FORMA_PAGO',
            'ID_FRECUENCIA',
            'FRECUENCIA',
            'NUM_FRECUENCIA',
            'CANTIDAD',
            'ID_PRODUCTO',
            'PRODUCTO',
            'ID_TIPO_FRECUENCIA',
            'TIPO_FRECUENCIA',
            'PAGO_UNICO',
            'ID_ASIGNACION',
            'ASIGNACION',
            'ID_CAMPANA_FINANCIERA',
            'CAMPANA_FINANCIERA',
            'ID_CATEGORIA',
            'CATEGORIA',
            'NUM_CASO',
            'ID_UNIDAD_MEDIDA',
            'UNIDAD_MEDIDA',
            'IMPORTE',
            'CANTIDAD',
            'TIPO_DONANTE',
            'TEL_CASA',
            'TEL_OFICINA',
            'TEL_CEL',
            'EMAIL',
            'DATOS_CLAVE',
            'DIRECCION',
            'FECHA_ALTA',
            'FECHA_ALTA_DONATIVO'
        ]
    });

    var storeDonativoInfo = Ext.create('Ext.data.JsonStore', {
        model: 'donativoInf',
        pageSize: 50,
        id:'storeDonativoInfo',
        name:'storeDonativoInfo',
        proxy: {
            type: 'ajax',
            url: 'bitacoraPagosAC.do',
            extraParams: {method: 'getDonativoInfo'},
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });

    //Inicio
    Ext.define('donantes.bitacoraPagos', {
        extend: 'Ext.window.Window',                    
        alias:'widget.bitacoraPagos',                    
        title: 'Bitacora de Pagos',
        modal: true,
        constrain : true,                    
        width: 1000,                
        height: 600,
        border: false,
        buttonAlign: 'left',
        maximizable: true,
        layout: 'fit',
        closeAction : 'close',
        region:'center', 
        initComponent: function() {
            //Inicialiar variables
            bitaPagos = this; 
            idDonativoTmp = this.name;
            loadInfo(idDonativoTmp);   
            //alert("idUsuario: "+idUsuario); 

            //ToolBar Superior
            var tbarBitacora = new Ext.Toolbar({
                items: [                            
                    new Ext.Button({
                        text: 'Ver datos de la forma de pago',
                        iconCls: 'icon-money',
                        handler:function(){
                            // 2369 - Cheque                                        
                            createNewObj3('donantes.formaPago',idFormaPago,idDonativoTmp);                                    


                        }
                    }),
                    '-',
                    new Ext.Button({
                        text:'Salir',
                        iconCls: 'icon-salir',
                        handler: function(){   
                            //  storeBitacora.close();
                            //    bitaPagos.modal = false;
                            bitaPagos.destroy();                            
                        }
                    })
                ]
            });

            var tbarRecibosBitacora = new Ext.Toolbar({
                items: [
                    new Ext.Button({
                        text: 'Cancelar Recibo',
                        iconCls: 'icon-reset',
                        handler: function(){ //CANCELADO DEFINITIVO
                            if(idUsuario == 'MMENDOZA' || idUsuario == 'RNUNEZ'|| idUsuario == 'OGARCIA'){
                                var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];
                                var precancelado = 0;
                                if(selectedRow!=undefined){
                                    createNewObj3('confirmaciones.cancelarPago',selectedRow.data.ID_BITACORA, precancelado);
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea cancelar!');
                                }                               
                            }else{ //PRE-CANCELADO ABIERTO A TODOS
                                var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];
                                var precancelado = 1;
                                if(selectedRow!=undefined){
                                    createNewObj3('confirmaciones.cancelarPago',selectedRow.data.ID_BITACORA, precancelado);
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea cancelar!');
                                }
                            }                                                                           
                        }
                    }),
                    '-',                            
                    new Ext.Button({
                        text: 'Ver Comentarios del Recibo',
                        iconCls: 'icon-edit-doc',
                        handler: function(){
                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];
                            var sizeSelected = Ext.getCmp('gridBitacora').selModel.selected.items.length;                                                                              
                            if(selectedRow != undefined){
                                if(sizeSelected == 1){                                             
                                    createNewObj2('confirmaciones.comentariosRecibo',selectedRow.data.ID_BITACORA); 
                                }else{
                                    Ext.MessageBox.alert('Error','¡Favor de seleccionar un solo pago!');
                                }                                           
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea consultar!');
                            }
                        }
                    }),                    
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Ver Historial de Envio',
                        iconCls: 'icon-grid',
                        handler:function(){
                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];
                            if(selectedRow!=undefined){
                                var idReciboTmppp = selectedRow.data.ID_RECIBO;                                                              
                                createNewObj2('confirmaciones.historialEnvioReprogramados',idReciboTmppp);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione un recibo!');
                            }

                        }
                    }),
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Bitacora Llamadas',
                        iconCls: 'icon-grid',
                        handler:function(){                                                            
                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                var idBitacoraCall = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.bitacoraLlamadas',idBitacoraCall);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione un donante!');
                            }
                        }
                    }),
                    '-',
                    new Ext.Button({
                        text: 'Pago Personal',
                        iconCls: 'icon-money',
                        handler: function(){
                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];                                                                                                             
                            if(selectedRow != undefined){                                                                                 
                                createNewObj2('donantes.pagoPersonal',selectedRow.data.ID_BITACORA);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea cobrar!');
                            }
                        }
                    }),
//                    '-',                            
//                    new Ext.Button({
//                        text: 'Actualizar datos del recibo',
//                        handler:function(){ 
//                            if(idUsuario == "KMARGARITA" || idUsuario == "RNUNEZ"){
//                                var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];
//                                if(selectedRow!=undefined){
//                                    idBitacoraTmp = selectedRow.data.ID_BITACORA; 
//                                    var numPago = selectedRow.data.ID_NUM_PAGO;
//                                    var importeTmp = selectedRow.data.IMPORTE;
//                                    createNewObj4('donantes.actualizarDatosPago',idBitacoraTmp, numPago, importeTmp);                                              
//                                }else{
//                                    Ext.MessageBox.alert('Error','¡Seleccione el pago que desea actualizar!');
//                                }
//                            }else{
//                                Ext.MessageBox.alert('Error','¡Usted no cuenta con los permisos necesarios!');
//                            }                                                                                                                                               
//                        }
//                    }),
//                    '-',
//                    new Ext.Button({
//                        text: 'Agregar recibo de pago permanente',
//                        handler:function(){
//                            createNewObj3('donantes.agregarDatosPago',idDonativoTmp,importe) 
//                            //createNewObj2('donantes.agregarDatosPago',32323) 
//                        }                                    
//                    }),
                    '-',
                    new Ext.Button({
                        text: 'Modificar Num Pago',
                        iconCls: 'icon-editar',
                        handler:function(){
                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];                                    
                            if(selectedRow != undefined){
                                var idBitacoraTmpp = selectedRow.data.ID_BITACORA; 
                                var numPago = selectedRow.data.ID_NUM_PAGO;
                                var tipoModificacion    = 1; //1 para modificar el numero de pago nadamas
                                createNewObj4('donantes.modificarRecibo',idBitacoraTmpp, numPago, tipoModificacion);                                              
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea modificar!');
                            }
                        }                                    
                    }),
                    '-',
//                    new Ext.Button({
//                        text: 'Cobranza',
//                        handler:function(){
//                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];                                    
//                            if(selectedRow != undefined){
//                                var idBitacoraTmpp = selectedRow.data.ID_BITACORA;                                         
//                                createNewObj3('tesoreria.confirmacionCobro',idBitacoraTmpp,1);
//                            }else{
//                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
//                            }
//                        }                                    
//                    }),
//                    '-',
//                    new Ext.Button({
//                        text: 'Pago Unico',
//                        handler:function(){
//                            var selectedRow = Ext.getCmp('gridBitacora').selModel.selected.items[0];                                    
//                            if(selectedRow != undefined){
//                                var idBitacoraTmpp = selectedRow.data.ID_BITACORA;                                         
//                                Ext.Msg.confirm('Generar Pago Único', '¿Está seguro que desea generar como pago único este recibo?', function(btn, text){
//                                    if (btn == 'yes'){
//                                        Ext.Ajax.request({  
//                                            url : 'bitacoraPagosAC.do?method=generarPagoUnico' ,
//                                            params : { 
//                                                ID_BITACORA:idBitacoraTmpp
//                                            },
//                                            method: 'GET',
//                                            success: function ( result, request ) {
//                                                Ext.MessageBox.alert('Generar Pago Único','¡El recibo se ha generado correctamente!');
//                                                bitaPagos.destroy();
//                                                Ext.getCmp('gridDonativos').getStore().load();
//                                            },
//                                            failure: function ( result, request) {
//                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al generar el recibo!');                                                        
//                                            }
//                                        });
//                                    }
//                                })
//                            }else{
//                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
//                            }
//                        }                                    
//                    }),
                ]
            });

            //Data Stores                                  
            var storeBitacora = Ext.create('Ext.data.JsonStore', {                   
                model: 'bitacoraPagos',
                pageSize: 5000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',                       
                    url: 'bitacoraPagosAC.do?method=getBitacoraPagosListByDonativo',
                    extraParams:{idDonativo:idDonativoTmp},
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'//Paginacion                
                    }
                }
            }); 


            Ext.apply(this, {
                items:[
                    {
                        xtype: 'form',
                        id: 'frmBitacoraPagos',   
                        tbar: tbarBitacora,
                        items:[
                            {
                                xtype: 'container',
                                layout: {
                                    type: 'hbox'
                                },
                                items:[
                                    { //Container Izq
                                        xtype: 'container',
                                        flex: 0.4,                                                
                                        margin: 1,
                                        items:[
                                            {
                                                xtype: 'fieldset',
                                                height: 270,
                                                title: 'Datos del Donante',
                                                items: [
                                                    {
                                                        xtype: 'displayfield',
                                                        width: 293,
                                                        id: 'gralIdDonante',
                                                        value: numDonante,
                                                        labelWidth: 100,
                                                        fieldLabel: 'Num. Donante'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralFechaAlta',
                                                        width: 293,                                                                                                                              
                                                        labelWidth: 100,
                                                        fieldLabel: 'Fecha Alta'
                                                    },                                                           
                                                    {
                                                        xtype: 'displayfield',
                                                        width: 400,
                                                        id: 'gralNombre',
                                                        value: nombre,
                                                        labelWidth: 100,
                                                        fieldLabel: 'Nombre'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralTipoDonante',
                                                        width: 293,                                                                                                                              
                                                        labelWidth: 100,
                                                        fieldLabel: 'Tipo'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralTelCasa',
                                                        width: 293,                                                                                                                               
                                                        labelWidth: 100,
                                                        fieldLabel: 'Tel. Casa'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralTelOficina',
                                                        width: 293,                                                                                                                              
                                                        labelWidth: 100,
                                                        fieldLabel: 'Tel. Oficina'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralTelCel',
                                                        width: 293,                                                                                                                               
                                                        labelWidth: 100,
                                                        fieldLabel: 'Tel. Cel'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralEmail',
                                                        width: 400,                                                                                                                              
                                                        labelWidth: 100,
                                                        fieldLabel: 'Email'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralDatosClave',
                                                        width: 400,                                                                                                                              
                                                        labelWidth: 100,
                                                        fieldLabel: 'Datos Clave'
                                                    },
                                                    {
                                                        xtype: 'displayfield',
                                                        id: 'gralDireccion',
                                                        width: 400,                                                                                                                              
                                                        labelWidth: 100,
                                                        fieldLabel: 'Dirección'
                                                    }
                                                ] //Cierra items fieldset izq
                                            } 
                                        ]
                                    },
                                    { //Container Derecho
                                        xtype: 'container',
                                        flex: 0.5,
                                        margin: 1,
                                        items:[
                                            {
                                                xtype: 'fieldset',
                                                height: 270,
                                                title: 'Datos del Donativo',
                                                items:[
                                                    {
                                                        xtype: 'container',
                                                        layout: {
                                                            type: 'hbox'
                                                        },
                                                        items:[
                                                            { //Container izq
                                                                xtype: 'container',
                                                                flex: 0.6,
                                                                items: [                                                                            
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        id: 'gralFechaAltaDonativo',
                                                                        width: 293,                                                                                                                              
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Fecha Alta'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralTipoDonativo',
                                                                        value: tipoDonativoGral,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Tipo Donativo'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralImporte',
                                                                        value: importe,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Importe'                                                   
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralCantidad',
                                                                        value: cantidad,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Cantidad' 
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralUnidad',
                                                                        value: unidad,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Unidad'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralProducto',
                                                                        value: producto,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Producto'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralFormaPago',
                                                                        value: formaPago,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Forma Pago'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 400,
                                                                        id: 'gralCampFinanciera',
                                                                        value: campFinanciera,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Camp. Financiera'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 400,
                                                                        id: 'gralCategoria', 
                                                                        value: categoria,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Categoria'
                                                                    }
                                                                ]   //Cierra items container principal izq  
                                                            }, //Cierra grupo items container izq                                              
                                                            { //Container derecho
                                                                xtype: 'container',
                                                                flex: 0.5,
                                                                items: [                                                            
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        value: pagoUnico,
                                                                        id: 'gralPagoUnico',
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Pago Unico'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralFrecuencia',
                                                                        value: frecuencia,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Frecuencia'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralTipoFrecuencia',
                                                                        value: tipoFrecuencia,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Tipo Frecuencia'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralNumFrecuencia',
                                                                        value: numFrecuencia,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Num. Pagos'
                                                                    },

                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 400,
                                                                        id: 'gralAsignacion',
                                                                        value: asignacion,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Asignación'
                                                                    },
                                                                    {
                                                                        xtype: 'displayfield',
                                                                        width: 293,
                                                                        id: 'gralNumCaso',
                                                                        value: caso,
                                                                        labelWidth: 100,
                                                                        fieldLabel: 'Caso'
                                                                    }
                                                                ]
                                                            } //Cierra container derecho
                                                        ] //Cierra items container 
                                                    }
                                                ] //Cierra items fieldset
                                            }
                                        ] //Cierra items container derecho
                                    } //Cierra container derecho
                                ] //Cierra items container principal
                            }, //Cierra grupo de items form
                            {
                                xtype: 'grid',
                                title: 'Bitacora de Pagos',                                          
                                id: 'gridBitacora',
                                height: 250,
                                store: storeBitacora,
                                tbar: tbarRecibosBitacora,
                                columns:[
                                    {
                                        dataIndex: 'ID_NUM_PAGO',
                                        text: 'Num. Pago',
                                        flex: .03,
                                        align:'center'
                                    },
                                    {
                                        dataIndex: 'ID_RECIBO',
                                        text: 'Recibo',
                                        flex: .03,
                                        align:'left'
                                    },
                                    {
                                        dataIndex: 'ESTATUS_PAGO_TMP',
                                        text: 'Estatus',
                                        flex: .05,
                                        align:'left'
                                    },
                                    {
                                        dataIndex: 'IMPORTE',
                                        text: 'Importe',
                                        flex: .03,
                                        align:'left',
                                        renderer: render_moneyBP
                                    },
                                    {
                                        dataIndex: 'FECHA_COBRO',
                                        text: 'Fecha de Cobro',
                                        flex: .05,
                                        align:'left'
                                    },
                                    {
                                        dataIndex: 'FECHA_PAGO',
                                        text: 'Fecha de Pago',
                                        flex: .05,
                                        align:'left'
                                    },
                                    {
                                        dataIndex: 'FECHA_VISITA',
                                        text: 'Fecha de Visita',
                                        flex: .05,
                                        align:'left'
                                    },
                                    {                                                
                                        dataIndex: 'PERSONALMENTE_RECIBO',
                                        text: 'Personal',
                                        flex: .03,
                                        align:'center'
                                    },
                                    {
                                        dataIndex: 'STATUS_IMPRESO',
                                        text: 'Impreso',
                                        flex: .03,
                                        align:'center'
                                    },
                                    {
                                        dataIndex: 'COMENTARIOS',
                                        text: 'Comentarios Generales',
                                        flex: .10,
                                        align:'left'
                                    }

                                ], //Cierra columns
                                viewConfig: {

                                },
                                selModel: Ext.create('Ext.selection.CheckboxModel', {

                                }),
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 5000,
                                    store: storeBitacora,
                                    displayInfo: true,
                                    emptyMsg: '¡No hay pagos para este donativo!'                                                                                            
                                })
                            }
                        ] //Cierra items form
                    }
                ] //Cierra items ext apply
            }); //Cierra Ext Apply
            donantes.bitacoraPagos.superclass.initComponent.apply(this, arguments); 
            storeBitacora.load();
        } //Cierra initComponent
    }); //Cierra Ext.define             
    </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
