<%-- 
    Document   : donativos
    Created on : 10/04/2012, 12:08:27 PM
    Author     : rnunez
--%>

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
            // Ext.onReady(function() {               
            /********************* VARIABLES GLOBALES *************************/
                
            var idUsuarioTmp        = '<%=idusersession%>';
            var idUsuarioSplit      = idUsuarioTmp.split(":");
            var idUsuario           = idUsuarioSplit[0];
            var idDonanteTmp        = 0;
            var idDonativoBitacora  = 0;
            var UID                 = '';
            var campFin;
            var optionUpdate        = 0;
            var idDonativoTmp       = 0;
            var dateActual          = new Date();
                
            /********************* MODELS *************************/
            Ext.define('catalog',{
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
                
            Ext.define('donativosDonante',{
                id:'donativosDonante',
                extend: 'Ext.data.Model',
                fields:     [                   
                    {name: 'ID_DONATIVO'},
                    {name: 'ID_DONATIVO_ANTIGUO'},                        
                    {name: 'ID_DONANTE'},
                    {name: 'DONANTE'},
                    {name: 'ID_TIPO_DONATIVO'},
                    {name: 'TIPO_DONATIVO'},
                    {name: 'CANTIDAD'},
                    {name: 'IMPORTE'},
                    {name: 'ID_UNIDAD_MEDIDA'},
                    {name: 'UNIDAD_MEDIDA'},
                    {name: 'ID_PRODUCTO'},
                    {name: 'PRODUCTO'},
                    {name: 'ID_FORMA_PAGO'},
                    {name: 'FORMA_PAGO'},
                    {name: 'PAGO_UNICO'}, 
                    {name: 'ID_FRECUENCIA'},
                    {name: 'FRECUENCIA'},
                    {name: 'ID_TIPO_FRECUENCIA'},
                    {name: 'TIPO_FRECUENCIA'},
                    {name: 'NUM_FRECUENCIA'},
                    {name: 'ID_CAMPANA_FINANCIERA'},
                    {name: 'CAMPANA_FINANCIERA'},
                    {name: 'ID_ASIGNACION'},
                    {name: 'ASIGNACION'},
                    {name: 'NUM_CASO'},
                    {name: 'PAGOS_PENDIENTES'},
                    {name: 'PAGOS_COBRADOS'},
                    {name: 'PAGOS_CANCELADOS'},
                    {name: 'ESTATUS_DONATIVO'}
                    //{name: 'ASIGNACION_DOS'}
                ]
            });
            
            Ext.define('DonativoUpdateInfo',{
                id:'DonativoUpdateInfo',
                extend: 'Ext.data.Model',
                fields:     [                   
                    {name: 'ANT_DONATIVO'},
                    {name: 'ID_TIPO_DONATIVO'},                        
                    {name: 'IMPORTE'},
                    {name: 'CANTIDAD'},
                    {name: 'ID_UNIDAD_MEDIDA'},
                    {name: 'ID_PRODUCTO'},
                    {name: 'ID_FORMA_PAGO'},
                    {name: 'PERSONALMENTE'},
                    {name: 'PAGO_UNICO'},
                    {name: 'ID_FRECUENCIA'},
                    {name: 'ID_TIPO_FRECUENCIA'},
                    {name: 'NUM_FRECUENCIA'},
                    {name: 'ID_CAMPANA_FINANCIERA'},
                    {name: 'ID_CATEGORIA'},
                    {name: 'ID_ASIGNACION'}, 
                    {name: 'NUM_CASO'},
                    {name: 'CASO_NEW'},                    
                    {name: 'ID_SUSTITUTO_DONATIVO'}
                ]
            });
                
            Ext.define('nameDonanteInf',{
                id:'nameDonanteInf',
                extend: 'Ext.data.Model',
                fields: [                       
                    'NOMBRE',
                    'PERSONALMENTEE',
                    'DONANTEF'
                ]
            });
            
            Ext.define('sustitutoDonativoMdl',{
                id:'sustitutoDonativoMdl',
                extend: 'Ext.data.Model',
                fields: [                       
                    'ID_DONANTE_TMP',
                    'RAZON_SOCIAL'
                ]
            });
 
            //Busqueda de Caso en Donativos
            Ext.define('beneficiario',{// create the Data beneficiario
                id:'beneficiario',
                extend: 'Ext.data.Model',
                fields: ['id','name']
            });
    
            var comboSearchBeneficiario = Ext.create('Ext.data.JsonStore', {// create the Store beneficiario
                model: 'beneficiario',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getSearchBeneficiarioIngresos',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
    
            var beneficiarioSearchTPL = new Ext.XTemplate(
                '<tpl for="."><div  class="search-item">',
                '<h5 style="color: #0000cc;">{id}</h5>{name} {funcion}<br>',
                '</div>',
                '</tpl>'
            );    
              
            /********************* STORES PARA COMBOBOX *************************/
            var cbxTipoDonativo = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_TIPODONATIVO'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var noFrecuencias = Ext.create('Ext.data.Store', {
                fields: ['value', 'txt'],
                data : [
                    {"value":"1", "txt":"1"},{"value":"2", "txt":"2"},{"value":"3", "txt":"3"},{"value":"4", "txt":"4"},{"value":"5", "txt":"5"},
                    {"value":"6", "txt":"6"},{"value":"7", "txt":"7"},{"value":"8", "txt":"8"},{"value":"9", "txt":"9"},{"value":"10", "txt":"10"},
                    {"value":"11", "txt":"11"},{"value":"12", "txt":"12"},{"value":"13", "txt":"13"},{"value":"14", "txt":"14"},{"value":"15", "txt":"15"},
                    {"value":"16", "txt":"16"},{"value":"17", "txt":"17"},{"value":"18", "txt":"18"},{"value":"19", "txt":"19"},{"value":"20", "txt":"20"},
                    {"value":"21", "txt":"21"},{"value":"22", "txt":"22"},{"value":"23", "txt":"23"},{"value":"24", "txt":"24"},{"value":"25", "txt":"25"},
                    {"value":"26", "txt":"26"},{"value":"27", "txt":"27"},{"value":"28", "txt":"28"},{"value":"29", "txt":"29"},{"value":"30", "txt":"30"},
                    {"value":"31", "txt":"31"},{"value":"32", "txt":"32"},{"value":"33", "txt":"33"},{"value":"34", "txt":"34"},{"value":"35", "txt":"35"},
                    {"value":"36", "txt":"36"},{"value":"37", "txt":"37"},{"value":"38", "txt":"38"},{"value":"39", "txt":"39"},{"value":"40", "txt":"40"},
                    {"value":"41", "txt":"41"},{"value":"42", "txt":"42"},{"value":"43", "txt":"43"},{"value":"44", "txt":"44"},{"value":"45", "txt":"45"},
                    {"value":"46", "txt":"46"},{"value":"47", "txt":"47"},{"value":"48", "txt":"48"},{"value":"49", "txt":"49"},{"value":"50", "txt":"50"}
                    
                ]
            });


            var cbxUnidad = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'DONATIVO_UNIDAD'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  

            var cbxProducto = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'DONATIVO_PRODUCTO'},
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

            var cbxFrecuencia = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'DONATIVO_FRECUENCIA_PAGO'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  

            var cbxTipoFrecuencia = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'DONATIVO_TIPO_FRECUENCIA'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  

            var cbxCampFinanciera = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var cbxCategoria = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByNombre',    
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  

            var cbxAsignacion = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_ASIGNACIONES'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var cbxSustitutoDonativo = Ext.create('Ext.data.JsonStore', {
                model: 'sustitutoDonativoMdl',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getSearchSustitutoDonativos',
                    //extraParams:{ID_DONANTE:idDonanteTmp},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            /********************* FUNCIONES *************************/
            
            function cleanRegister(){
                Ext.getCmp('mainForm').getForm().reset();
                loadNombreDonativos(idDonanteTmp);
                Ext.getCmp('ID_UNIDAD_MEDIDA').enable(); 
                Ext.getCmp('ID_PRODUCTO').enable();
                Ext.getCmp('ID_FRECUENCIA').enable(); 
                Ext.getCmp('ID_TIPO_FRECUENCIA').enable();
                Ext.getCmp('NUM_FRECUENCIA').enable();
                Ext.getCmp('IMPORTE').enable();
                Ext.getCmp('ID_FORMA_PAGO').enable();
                Ext.getCmp('CANTIDAD').enable();
                Ext.getCmp('PAGO_UNICO').enable();
            }

            function render_moneyDON(v, p, record){
                return '$ '+v
            }
            
            function WUID(len){                
                var charSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                var randomString = '';
                for (var i = 0; i < len; i++) {
                    var randomPoz = Math.floor(Math.random() * charSet.length);
                    randomString += charSet.substring(randomPoz,randomPoz+1);
                }
                return randomString; 
            }
            
            function loadNombreDonativos(idDonante){                
                storeNameInfo.proxy.extraParams.ID_DONANTE = idDonante;                
                storeNameInfo.load({ callback: function(records,o,s){                        
                        if(records.length > 0){
//                            alert("DATOS: "+records[0].data.elements);
                            var DONANTE_FACTURAA            = records[0].data.DONANTEF;
                            var DONATIVO_PERSONALMENTEE     = records[0].data.PERSONALMENTEE;
                            Ext.getCmp('NOMBRE_DONANTE').setValue(records[0].data.NOMBRE);                             
                            if(records[0].data.PERSONALMENTE_D == 1) Ext.getCmp('PERSONALMENTE_DONATIVO').setValue(true); else Ext.getCmp('PERSONALMENTE_DONATIVO').setValue(false);            
//                            alert(DONANTE_FACTURAA)
//                            alert(DONATIVO_PERSONALMENTEE)
                            
                        }
                    }
                }); 
                cbxSustitutoDonativo.proxy.extraParams.ID_DONANTE = idDonante;
                cbxSustitutoDonativo.load();
            }
            
            function validaDonativo(){
                var camposName=['ID_DONATIVO_ANT',                        
                    'ID_TIPO_DONATIVO',                      
                    'IMPORTE',
                    'ID_CAMPANA_FINANCIERA',
                    'ID_CATEGORIA']
                
                //alert(Ext.getCmp("ID_ASIGNACION").getValue());
                
                if(Ext.getCmp(camposName[1]).getValue() == null){ //Validar el tipo de donativo
                    Ext.MessageBox.alert('Error','!Selecciona el tipo de Donativo que desea agregar!');                   
                    return false
                }
                if(Ext.getCmp(camposName[2]).getValue() == null){ //Validar el importe
                    Ext.MessageBox.alert('Error','!Ingresa el importe del donativo!');                   
                    return false
                }else{
                    if(Ext.getCmp("IMPORTE").getValue() < 0){
                        Ext.MessageBox.alert('Error','!El importe no puede ser negativo!');                   
                        return false
                    }
                }
                if(Ext.getCmp("ID_TIPO_DONATIVO").getValue() == 1826 && Ext.getCmp("ID_FORMA_PAGO").getValue() == null){
                    Ext.MessageBox.alert('Error','!Selecciona la forma de pago del donativo!');                   
                    return false
                }
                if(Ext.getCmp(camposName[3]).getValue() == null){ //Validar la campaña financiera
                    Ext.MessageBox.alert('Error','!Selecciona la campaña financiera!');                   
                    return false
                }
                if(Ext.getCmp("ID_CATEGORIA").getValue() == null || Ext.getCmp("ID_CATEGORIA").getValue() == ""){ //Validar la categoria
                    Ext.MessageBox.alert('Error','!Selecciona la categoria de la campaña financiera!');                   
                    return false
                }                
                if(Ext.getCmp("ID_ASIGNACION").getValue() == null){ //Validar la asignación
                    Ext.MessageBox.alert('Error','!Selecciona una asignación!');                   
                    return false
                }                
                if(Ext.getCmp("ID_TIPO_DONATIVO").getValue() ==  1827 && Ext.getCmp("CANTIDAD").getValue() == null){
                    Ext.MessageBox.alert('Error','!Ingresa la cantidad del donativo en especie!');                   
                    return false
                }                
                if(Ext.getCmp("ID_TIPO_DONATIVO").getValue() ==  1827 && Ext.getCmp("ID_UNIDAD_MEDIDA").getValue() == null){
                    Ext.MessageBox.alert('Error','!Selecciona la unidad del donativo!');                   
                    return false
                }                
                if(Ext.getCmp("ID_TIPO_DONATIVO").getValue() ==  1827 && Ext.getCmp("ID_PRODUCTO").getValue() == null){
                    Ext.MessageBox.alert('Error','!Selecciona el producto del donativo!');                   
                    return false
                }
                if(Ext.getCmp("PAGO_UNICO").getValue() == false && Ext.getCmp("ID_FRECUENCIA").getValue() == null){
                    Ext.MessageBox.alert('Error','!Selecciona la frecuencia del donativo!');                   
                    return false
                }
                if(Ext.getCmp("PAGO_UNICO").getValue() == false && Ext.getCmp("ID_TIPO_FRECUENCIA").getValue() == null){
                    Ext.MessageBox.alert('Error','!Selecciona el tipo de frecuencia del donativo!');                   
                    return false
                }
                if(Ext.getCmp("PAGO_UNICO").getValue() == false && Ext.getCmp("ID_FRECUENCIA").getValue() == 2370 && (Ext.getCmp("NUM_FRECUENCIA").getValue() == null || Ext.getCmp("NUM_FRECUENCIA").getValue() == "" || Ext.getCmp("NUM_FRECUENCIA").getValue() == 0)){
                    Ext.MessageBox.alert('Error','!Ingresa el numero de frecuencia del donativo!');                   
                    return false
                }
            }
            
            function loadInfoDonativoUpdate(ID_DONATIVO){                
                storeDonativoUpdateInfo.proxy.extraParams.ID_DONATIVO = ID_DONATIVO;
                storeDonativoUpdateInfo.load({ callback: function(records,o,s){
                        if(records.length > 0){
                            var ID_TIPO_DONATIVO    = records[0].data.ID_TIPO_DONATIVO;
                            var ID_UNIDAD_MEDIDA    = records[0].data.ID_UNIDAD_MEDIDA;
                            var ID_PRODUCTO         = records[0].data.ID_PRODUCTO;
                            var ID_FORMA_PAGO       = records[0].data.ID_FORMA_PAGO;
                            var ID_CAMPANA_FINANCIERA       = records[0].data.ID_CAMPANA_FINANCIERA;
                            var ID_CATEGORIA       = records[0].data.ID_CATEGORIA;
                            var ID_ASIGNACION       = records[0].data.ID_ASIGNACION;
                            var ID_FRECUENCIA       = records[0].data.ID_FRECUENCIA;
                            var ID_TIPO_FRECUENCIA  = records[0].data.ID_TIPO_FRECUENCIA;
                            var ID_SUSTITUTO_DONA   = records[0].data.ID_SUSTITUTO_DONATIVO;
//                            alert(records[0].data.ID_TIPO_DONATIVO);
                            Ext.getCmp('ID_DONATIVO_ANT').setValue(records[0].data.ANT_DONATIVO);
                            cbxTipoDonativo.load({callback: function(records,o,s){
                                Ext.getCmp('ID_TIPO_DONATIVO').setValue(parseInt(ID_TIPO_DONATIVO,10));
                            }});                            
                            Ext.getCmp('IMPORTE').setValue(records[0].data.IMPORTE);
                            Ext.getCmp('IMPORTE').disable();
                            
                            cbxCampFinanciera.load({callback: function(records,o,s){
                                Ext.getCmp('ID_CAMPANA_FINANCIERA').setValue(parseInt(ID_CAMPANA_FINANCIERA,10));
                                var nameCampFin = Ext.getCmp('ID_CAMPANA_FINANCIERA');                                
                                cbxCategoria.proxy.extraParams.nombre = nameCampFin.getDisplayValue();
                                cbxCategoria.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_CATEGORIA').setValue(parseInt(ID_CATEGORIA,10));
                                }});                            
                            }});
                            cbxAsignacion.load({callback: function(records,o,s){
                                Ext.getCmp('ID_ASIGNACION').setValue(parseInt(ID_ASIGNACION,10));
                            }});
                            //alert("Asignacion: "+ID_ASIGNACION);
                            if(ID_ASIGNACION == 2392 || ID_ASIGNACION == 2393){ //Casos o Casos 186
                                Ext.getCmp('comboSearchBeneficiario').enable();
                                Ext.getCmp('NUM_CASO').enable();
                                Ext.getCmp('NUM_CASO').setValue(records[0].data.NUM_CASO);
                            }else{
                                Ext.getCmp('comboSearchBeneficiario').disable();
                                Ext.getCmp('NUM_CASO').disable();

                            }
                            if(records[0].data.PERSONALMENTE == 1) Ext.getCmp('PERSONALMENTE_DONATIVO').setValue(true); else Ext.getCmp('PERSONALMENTE_DONATIVO').setValue(false);
                            if(records[0].data.PAGO_UNICO == 1){
                                Ext.getCmp('PAGO_UNICO').setValue(true);
                            }else{
                                Ext.getCmp('PAGO_UNICO').setValue(false);
                                cbxFrecuencia.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_FRECUENCIA').setValue(parseInt(ID_FRECUENCIA,10));
                                }});
                                Ext.getCmp('ID_FRECUENCIA').disable();
                                cbxTipoFrecuencia.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_TIPO_FRECUENCIA').setValue(parseInt(ID_TIPO_FRECUENCIA,10));
                                }});
                                Ext.getCmp('ID_TIPO_FRECUENCIA').disable();
                                Ext.getCmp('NUM_FRECUENCIA').setValue(records[0].data.NUM_FRECUENCIA);
                                Ext.getCmp('NUM_FRECUENCIA').disable();
                            }
                            Ext.getCmp('PAGO_UNICO').disable();
                            if(ID_TIPO_DONATIVO == 1827){ //Si es donativo en especie
                                Ext.getCmp('CANTIDAD').setValue(records[0].data.CANTIDAD);                                
                                cbxUnidad.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_UNIDAD_MEDIDA').setValue(parseInt(ID_UNIDAD_MEDIDA,10));
                                }});
                                cbxProducto.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_PRODUCTO').setValue(parseInt(ID_PRODUCTO,10));
                                }});
                                Ext.getCmp('ID_FORMA_PAGO').setValue(2836);
                                Ext.getCmp('ID_FORMA_PAGO').disable();
                            }else{
                                Ext.getCmp('CANTIDAD').disable();
                                Ext.getCmp('ID_UNIDAD_MEDIDA').disable();
                                Ext.getCmp('ID_PRODUCTO').disable();
                                cbxFormaPago.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_FORMA_PAGO').setValue(parseInt(ID_FORMA_PAGO,10));
                                }});
                            }
                            optionUpdate = 1;
                            idDonativoTmp = ID_DONATIVO;                            
                            if(ID_SUSTITUTO_DONA != 0){
                                cbxSustitutoDonativo.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_SUSTITUTO_DONATIVO').setValue(parseInt(ID_SUSTITUTO_DONA,10));
                                }});
                            }
                        }                            
                    } 
                    
                }); //Cierra storeDonativoInfo 
            }
            
            function calcularFechaDiaSiguiente(){            
                var dt = new Date();                
                var month = dt.getMonth()+1;
                var day = dt.getDate()+1;
                dt.setDate(day)
                var year = dt.getFullYear();                                
                dateActual = dt;                
            }
            
            /*********************** STORES *******************************/
            var storeNameInfo = Ext.create('Ext.data.JsonStore', {
                model: 'nameDonanteInf',
                pageSize: 50,
                id:'storeNameInfo',
                name:'storeNameInfo',
                proxy: {
                    type: 'ajax',
                    url: 'donativoAC.do',
                    extraParams: {method: 'getNameDonante'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var storeDonativoUpdateInfo = Ext.create('Ext.data.JsonStore', {
                model: 'DonativoUpdateInfo',
                pageSize: 50,
                id:'storeDonativoUpdateInfo',
                name:'storeDonativoUpdateInfo',
                proxy: {
                    type: 'ajax',
                    url: 'donativoAC.do',
                    extraParams: {method: 'getDonativoInfoUpdate'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
                
                
            /*********************** INICIA CODIGO DE LA PANTALLA *******************************/
            Ext.define('donantes.donativos', {
                extend: 'Ext.window.Window',                    
                alias:'widget.donativos',                   
                title: 'Donativos',
                constrain : true,
                model: true,
                width: 1000,                
                height: 640,
                border: false,
                buttonAlign: 'left',
                closeAction:'close',
                autoDestroy:true,
                maximizable: true,
                layout: 'fit',                    
                region:'center',  
                modal: true,
                initComponent: function() {
                    /************** INICIALIZAR ******************/
                   var winDonativos = this;                     
                    idDonanteTmp = this.name;                         
                    UID = WUID(20);    
                    loadNombreDonativos(idDonanteTmp);                         
                    calcularFechaDiaSiguiente();
                    //alert(idDonanteTmp)     
                         
                    var storeDonativos = Ext.create('Ext.data.JsonStore', {                   
                        model: 'donativosDonante',
                        pageSize: 100,
                        autoLoad:false,
                        proxy: {
                            type: 'ajax',                       
                            url: 'donativoAC.do?method=getAllDonativos', 
                            extraParams:{idDonante:idDonanteTmp},
                            reader: {
                                type: 'json',
                                root: 'rows',
                                totalProperty:'totalcount'//Paginacion                
                            }
                        }
                    });  
                               
                    var tbarDos = new Ext.Toolbar({ // toolbar Dos
                        items: [
                            new Ext.Button({
                                text: 'Cancelar Donativo',
                                iconCls: 'icon-reset',
                                handler: function(){
                                    if(idUsuario == 'MMENDOZA' || idUsuario == 'RNUNEZ'){ //Cancelado Directo
                                        var selectedRow = Ext.getCmp('gridDonativos').selModel.selected.items[0];
                                        var precancelado = 0;
                                        if(selectedRow!=undefined){                                        
                                            if(selectedRow.data.ESTATUS_DONATIVO == 'ACTIVO'){
                                                Ext.Msg.confirm('Canelar Donativo', '¿Esta seguro de Cancelar este donativo? Esta acción cancelará tambien los recibos con estatus NO CONFIRMADO.', function(btn, text){
                                                    if (btn == 'yes'){
                                                        var idDonativoo = selectedRow.data.ID_DONATIVO;
                                                        createNewObj3('donantes.cancelarDonativo',idDonativoo,precancelado);
                                                    }
                                                })                                                
                                            }else{
                                                Ext.MessageBox.alert('Error','¡No se puede realizar esta acción! El Donativo esta Cancelado y/o Terminado.'); 
                                            }                                                                                  
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea cancelar!');
                                        }
                                    }else if(idUsuario == 'GMALDONADO' || idUsuario == 'MALVAREZ' || idUsuario == 'RNUNEZ'){ //Cancelado por autorización
                                        var selectedRow = Ext.getCmp('gridDonativos').selModel.selected.items[0];
                                        var precancelado = 1;
                                        if(selectedRow!=undefined){                                        
                                            if(selectedRow.data.ESTATUS_DONATIVO == 'ACTIVO'){
                                                Ext.Msg.confirm('Canelar Donativo', '¿Esta seguro de Cancelar este donativo? Esta acción cancelará tambien los recibos con estatus NO CONFIRMADO.', function(btn, text){
                                                    if (btn == 'yes'){
                                                        var idDonativoo = selectedRow.data.ID_DONATIVO;
                                                        createNewObj3('donantes.cancelarDonativo',idDonativoo,precancelado);
                                                    }
                                                })                                                
                                            }else{
                                                Ext.MessageBox.alert('Error','¡No se puede realizar esta acción! El Donativo esta Cancelado y/o Terminado.'); 
                                            }                                                                                  
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea cancelar!');
                                        }                                    
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Usted no tiene permisos para ejecutar esta acción!');
                                    }
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Editar Donativo',
                                iconCls: 'icon-editar',
                                handler: function(){
                                    var idUsuarioTmp = idUsuario;
                                    if(idUsuario == 'MMENDOZA' || idUsuario == 'RNUNEZ'){
                                        var selectedRow = Ext.getCmp('gridDonativos').selModel.selected.items[0];
                                        if(selectedRow!=undefined){
                                            if(selectedRow.data.ESTATUS_DONATIVO == 'ACTIVO'){
                                                var idDonativoo = selectedRow.data.ID_DONATIVO;
                                                loadInfoDonativoUpdate(idDonativoo);
                                            }else{
                                               Ext.MessageBox.alert('Error','¡No se puede realizar esta acción! El Donativo esta Cancelado y/o Terminado.'); 
                                            }                                            
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea editar!');
                                        }
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Usted no tiene permisos para modificar donativos!');
                                    }
                                    
                                }   
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Donativo Terminado',                                                                
                                iconCls: 'icon-reset',
                                handler: function() {
                                    if(idUsuario == 'MMENDOZA' || idUsuario == 'RNUNEZ'){
                                        var selectedRow = Ext.getCmp('gridDonativos').selModel.selected.items[0]; 
                                        if(selectedRow!=undefined){                                        
                                            if(selectedRow.data.ESTATUS_DONATIVO != 'CANCELADO' && selectedRow.data.ESTATUS_DONATIVO != 'TERMINADO'){
                                                Ext.Msg.confirm('Terminar Donativo', '¿Esta seguro de Terminar este donativo? Esta acción afectará a los recibos no cobrados.', function(btn, text){
                                                    if (btn == 'yes'){
                                                        Ext.Ajax.request({  
                                                            url : 'donativoAC.do?method=terminarDonativo' ,
                                                            params : {                                                         
                                                                ID_DONATIVO:selectedRow.data.ID_DONATIVO
                                                            },
                                                            method: 'GET',
                                                            success: function ( result, request ) {
                                                                Ext.MessageBox.alert('Guardado','El donativo se ha Terminado correctamente');
                                                                storeDonativos.load();
                                                            },
                                                            failure: function ( result, request) {
                                                                Ext.MessageBox.alert('Error','¡Ocurrio un error al Terminar el donativo!');                                                
                                                            }
                                                        });
                                                    }                                            
                                                });
                                            }else{
                                                Ext.MessageBox.alert('Error','¡No se puede realizar esta acción! El Donativo esta Cancelado y/o Terminado.');
                                            }                                                                                
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea Terminar!');
                                        }
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Usted no tiene permisos para modificar donativos!');
                                    }
                                }
                                        
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Bitacora de Pagos',
                                iconCls: 'icon-grid',
                                handler:function(){
                                    var selectedRow = Ext.getCmp('gridDonativos').selModel.selected.items[0];
                                    if(selectedRow!=undefined){
                                        idDonativoBitacora = selectedRow.data.ID_DONATIVO;
                                        createNewObj2('donantes.bitacoraPagos',idDonativoBitacora);  
                                        // Ext.getCmp('gridDonativosConfirmacion').getStore().load();
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea consultar!');
                                    }
                                    //                                        createNewObj2('donantes.bitacoraPagos',2);
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Trasladar Donativo',
                                iconCls: 'icon-expediente',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridDonativos').selModel.selected.items[0];
                                    if(selectedRow!=undefined){
                                        var idDonativoo = selectedRow.data.ID_DONATIVO;
                                        createNewObj2('donantes.moverDonativo',idDonativoo);
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el donativo que desea mover!');
                                    }
                                }
                            })                            
                        ]
                    }); //termina toolbar dos                   
                        
                    var tbarUno = new Ext.Toolbar({ 
                        items: [
                            new Ext.Button({
                                text: 'Guardar',
                                iconCls: 'icon-save',
                                handler: function(){
                                    if(optionUpdate == 1){ //Modificar
                                       var json = winDonativos.getDatas();
//                                       alert("Modificar: "+json);
//                                       alert("idDonativo: "+idDonativoTmp);
                                       Ext.Msg.confirm('Modificar Donativo', '¿Los datos son correctos?', function(btn, text){
                                            if (btn == 'yes'){
                                                //Donativo
                                                Ext.getCmp('mainForm').getForm().submit({
                                                    url: 'donativoAC.do?method=updateDonativo&jsonData='+json+'&idUsuario='+idUsuario+'&idDonativo='+idDonativoTmp,
                                                    waitMsg: 'Actualizando...',
                                                    success: function(form, action) {
                                                        Ext.MessageBox.alert('Modificado','Se actualizó la información correctamente');                                                        
                                                        cleanRegister();
                                                        loadNombreDonativos(idDonanteTmp);
                                                        storeDonativos.load();                                                        
                                                    },
                                                    failure: function(form, action) {
                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al actualizar la información!');
                                                        storeDonativos.load();
                                                    }
                                                });                                               
                                            }
                                        })
                                        optionUpdate = 0;
                                    }else{ //Guardar
                                        var json = winDonativos.getDatas();
//                                      alert("guardar: "+json);
                                        if(validaDonativo() != false ){
                                            Ext.Msg.confirm('Agregar Donativo', '¿Los datos son correctos?', function(btn, text){
                                                if (btn == 'yes'){
                                                    //Donativo
                                                    Ext.getCmp('mainForm').getForm().submit({
                                                        url: 'donativoAC.do?method=saveDonativo&jsonData='+json+'&uid='+UID+'&idUsuario='+idUsuario,
                                                        waitMsg: 'Guardando...',
                                                        success: function(form, action) {
                                                            Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');                                                        
                                                            cleanRegister();
                                                            loadNombreDonativos(idDonanteTmp);
                                                            storeDonativos.load();                                                        
                                                        },
                                                        failure: function(form, action) {
                                                            Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                            storeDonativos.load();
                                                        }
                                                    });                                               
                                                }
                                            }); 
                                        }
                                    }//                                                              
                                }                                    
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Limpiar',
                                iconCls: 'icon-clear',
                                handler: function(){
                                    cleanRegister();
                                    optionUpdate = 0;
                                }
                            }),
                            '-',                                
                            new Ext.Button({
                                text: 'Salir',
                                iconCls: 'icon-salir',
                                handler: function(){
//                                    Ext.getCmp('gridDirecciones').getStore().load();
//                                    storedireccionDonantes.load();
                                    winDonativos.destroy();                            
                                }   
                            })
                        ]
                    }); //termina toolbar uno 
                        
                    /************** FINALIZA SECCION DE INICIO Y CONTINUA CODIGO DE PANTALLA ******************/
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'mainForm',
                                tbar: tbarUno,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Agregar Donativo',
                                        items:[
                                            {
                                                xtype: 'container',
                                                layout: {
                                                    type: 'hbox'
                                                },
                                                items:[
                                                    { //container izq
                                                        xtype: 'container',
                                                        flex: 0.5,
                                                        items: [
                                                            {
                                                                xtype: 'textfield',
                                                                readOnly: 'true',
                                                                id: 'ID_DONANTE_DONATIVO',
                                                                fieldLabel: 'No. Donante',
                                                                value: ID_DONANTE,
                                                                size: 10                                                                    
                                                            },
                                                            {
                                                                xtype: 'textfield',                                                                    
                                                                id: 'ID_DONATIVO_ANT',
                                                                fieldLabel: 'No. Donativo Ant',                                                                    
                                                                size: 10                                                                   
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                readOnly: 'true',
                                                                id: 'NOMBRE_DONANTE',
                                                                fieldLabel: 'Donante',                                                                    
                                                                size: 30                                                                    
                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Tipo de Donativo',
                                                                store: cbxTipoDonativo,
                                                                id: 'ID_TIPO_DONATIVO',
                                                                emptyText: 'Seleccione tipo de donativo',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',
                                                                listeners:{
                                                                    select:function(boton,event){                                             
                                                                        if(this.getValue() == 1826){ //Efectivo 
                                                                            Ext.getCmp('ID_UNIDAD_MEDIDA').disable(); 
                                                                            Ext.getCmp('ID_PRODUCTO').disable();
                                                                            Ext.getCmp('CANTIDAD').disable();
                                                                            Ext.getCmp('ID_FORMA_PAGO').enable();
                                                                        }else if(this.getValue() == 1827){ //Especie
                                                                            Ext.getCmp('ID_UNIDAD_MEDIDA').enable(); 
                                                                            Ext.getCmp('ID_PRODUCTO').enable();
                                                                            Ext.getCmp('IMPORTE').enable();
                                                                            Ext.getCmp('CANTIDAD').enable();
                                                                            Ext.getCmp('ID_FORMA_PAGO').setValue(2836);
                                                                            Ext.getCmp('ID_FORMA_PAGO').disable();
                                                                        }                                                                                                            
                                                                    }
                                                                }  
                                                            }),
                                                            {
                                                                xtype: 'numberfield',
                                                                emptyText: 'Importe',
                                                                fieldLabel: 'Importe',
                                                                id: 'IMPORTE',
                                                                hideTrigger: true,
                                                                size: 10
                                                            },
                                                            {
                                                                xtype: 'numberfield',
                                                                emptyText: 'Ingrese la cantidad',
                                                                fieldLabel: 'Cantidad',
                                                                id: 'CANTIDAD',
                                                                size: 10
                                                            },                                                                
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Unidad',
                                                                id: 'ID_UNIDAD_MEDIDA',
                                                                store: cbxUnidad,
                                                                emptyText: 'Seleccione la unidad',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Producto',
                                                                store: cbxProducto,
                                                                emptyText: 'Seleccione el producto',
                                                                size: 30,
                                                                id: 'ID_PRODUCTO',
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Forma de Pago',
                                                                store: cbxFormaPago,
                                                                emptyText: 'Seleccione la forma de pago',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',
                                                                id: 'ID_FORMA_PAGO',
                                                                listeners:{
                                                                    select:function(boton,event){                                             
                                                                        if(this.getValue() == 2368){ //tarjeta de credito
                                                                           if(Ext.getCmp('datosTarjeta')==null){                                                                                 
                                                                                createNewObj4('donantes.datosTarjeta',1,UID,idDonanteTmp);
                                                                            }else{                                                                                
                                                                                Ext.getCmp('datosTarjeta').destroy()                                                                               
                                                                                createNewObj4('donantes.datosTarjeta',1,UID,idDonanteTmp);
                                                                            }                                                                                                               
                                                                        }else if(this.getValue() == 2369) //Cheque
                                                                            createNewObj2('donantes.datosCheque',UID);
                                                                        else if(this.getValue() == 2366) //Depositos
                                                                            createNewObj2('donantes.datosDeposito',UID);
                                                                        else if(this.getValue() == 2684)                                                                               
                                                                            createNewObj2('donantes.datosTransferencia',UID);
                                                                        else if(this.getValue() == 2685)                                                                               
                                                                            createNewObj2('donantes.datosTarjetaDebito',UID);
                                                                    }
                                                                }   
                                                            }),
                                                            {
                                                                xtype: 'checkbox',
                                                                fieldLabel: 'Personalmente',
                                                                id: 'PERSONALMENTE_DONATIVO'                                                                
                                                            },
                                                            {
                                                                xtype: 'datefield', 
                                                                id: 'FECHA_INICIO',
                                                                name: 'FECHA_INICIO',
                                                                fieldLabel: 'Fecha Inicio',
                                                                size: 15,
                                                                format: 'd/m/Y',
                                                                value: dateActual
                                                            }
                                                        ] //Cierra items de container izq
                                                    }, //Cierra 1er grupo de items container principal
                                                    {
                                                        xtype: 'container',
                                                        flex: 0.5,
                                                        items: [                                                                
                                                            {
                                                                xtype: 'checkbox',
                                                                fieldLabel: 'Pago Unico',
                                                                id: 'PAGO_UNICO',                                                                  
                                                                handler: function(){    
                                                                    if(this.checked){ 
                                                                        Ext.getCmp('ID_FRECUENCIA').disable(); 
                                                                        Ext.getCmp('ID_TIPO_FRECUENCIA').disable();
                                                                        Ext.getCmp('NUM_FRECUENCIA').disable();
                                                                        Ext.getCmp('NUM_FRECUENCIA').setValue(1);
                                                                    }else{ 
                                                                        Ext.getCmp('ID_FRECUENCIA').enable(); 
                                                                        Ext.getCmp('ID_TIPO_FRECUENCIA').enable();
                                                                        Ext.getCmp('NUM_FRECUENCIA').enable();  
                                                                        Ext.getCmp('NUM_FRECUENCIA').setValue(0);
                                                                    }   
                                                                }  
                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Frecuencia',
                                                                store: cbxFrecuencia,
                                                                emptyText: 'Seleccione la frecuencia de pago',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',
                                                                id: 'ID_FRECUENCIA',
                                                                listeners:{
                                                                    select:function(boton,event){                                             
                                                                        if(this.getValue() == 2371){ //Permanente
                                                                            Ext.getCmp('NUM_FRECUENCIA').disable();
                                                                            
                                                                        }else if(this.getValue() == 2370){ //Temporal
                                                                            Ext.getCmp('NUM_FRECUENCIA').enable();
                                                                            
                                                                        }                                                                                                            
                                                                    }
                                                                }
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Tipo Frecuencia',
                                                                store: cbxTipoFrecuencia,
                                                                id: 'ID_TIPO_FRECUENCIA',
                                                                emptyText: 'Seleccione el tipo de frecuencia',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
//                                                            {
//                                                                xtype: 'numberfield',
//                                                                id: 'NUM_FRECUENCIA', 
//                                                                fieldLabel: 'No. Frecuencia',
//                                                                hideTrigger: true,                                                                
//                                                                size: 10
//                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                id: 'NUM_FRECUENCIA',
                                                                fieldLabel: 'No. Frecuencia',
                                                                store: noFrecuencias,
                                                                queryMode: 'local',
                                                                displayField: 'txt',
                                                                valueField: 'value'                                                                ,
                                                                size: 10
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Campaña Financiera',
                                                                store: cbxCampFinanciera,
                                                                id: 'ID_CAMPANA_FINANCIERA',
                                                                emptyText: 'Seleccione la campaña',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',                                                                    
                                                                listeners: {                                                                        
                                                                    blur: function(){
                                                                        Ext.getCmp('ID_CATEGORIA').setValue('');                                                                                                                                                     
                                                                        var me = this                                                               
                                                                        cbxCategoria.proxy.extraParams.nombre = me.getDisplayValue(); //Obtener el valueField y agregarlo como parametro al store
                                                                        cbxCategoria.load();                                                                            
                                                                    },
                                                                    select:function( combo, record, index ){
                                                                        Ext.getCmp('ID_CAMPANA_FINANCIERA').selectedRecord = record;
                                                                    },
                                                                    specialkey:function ( field, e ){
                                                                        if (e.getKey() == e.ENTER) {
                                                                            var wtsc = Ext.getCmp('ID_CAMPANA_FINANCIERA');
                                                                            var rec = wtsc.selectedRecord;
                                                                            if (rec){
                                                                                var n = cbxCampFinanciera.find('id',rec.data.id);

                                                                                if (n==-1){
                                                                                    cbxCampFinanciera.insert(0,rec);
                                                                                }
                                                                            }
                                                                        }
                                                                    } 
                                                                }                                                                    
                                                                   
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Categoria',
                                                                store: cbxCategoria,
                                                                id: 'ID_CATEGORIA',
                                                                emptyText: 'Seleccione la categoria',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Asignación',
                                                                store: cbxAsignacion,
                                                                emptyText: 'Seleccione la asignación',
                                                                size: 30,
                                                                displayField: 'nombre',
                                                                valueField: 'id',
                                                                id: 'ID_ASIGNACION',
                                                                listeners:{
                                                                    select:function(boton,event){                                             
                                                                        if(this.getValue() == 2392 || this.getValue() == 2393){ //Casos o Casos 186
                                                                            Ext.getCmp('comboSearchBeneficiario').enable();
                                                                            Ext.getCmp('NUM_CASO').enable();
                                                                        }else{
                                                                            Ext.getCmp('comboSearchBeneficiario').disable();
                                                                            Ext.getCmp('NUM_CASO').disable();
                                                                            
                                                                        }                                                                                                            
                                                                    }
                                                                }
                                                            }),
                                                            {
                                                                xtype: 'combo',
                                                                fieldLabel: 'Sustituto',
                                                                id: 'ID_SUSTITUTO_DONATIVO',
                                                                emptyText: 'Seleccione un Sustituto',
                                                                size: 30,                                                                
                                                                store:cbxSustitutoDonativo,
                                                                displayField: 'RAZON_SOCIAL',
                                                                valueField: 'ID_DONANTE_TMP',
                                                                disabled:true
                                                            },
                                                            new Ext.form.ComboBox({
                                                                store: comboSearchBeneficiario,
                                                                emptyText:'Busca y selecciona un Beneficiario',
                                                                blankText:'Buscar o agregar beneficiario',
                                                                margin:'1 1 1 1',
                                                                id:'comboSearchBeneficiario',
                                                                name:'comboSearchBeneficiario',
                                                                minChars:2,
                                                                displayField:'name',
                                                                valueField:'id',
                                                                typeAhead: false,
                                                                loadingText: 'Buscando...',
                                                                fieldLabel: 'Buscar Caso',
                                                                width: 450,
                                                                labelWidth: 100,
                                                                pageSize:10,
                                                                hideTrigger:false,
                                                                disabled:true,
                                                                queryParam : 'keyword',
                                                                triggerCls:'x-form-search-trigger',
                                                                tpl:  beneficiarioSearchTPL,
                                                                itemSelector: 'div.search-item'                                            
                                                            })
                                                            ,                                       
                                                            {
                                                                xtype: 'numberfield',
                                                                fieldLabel: 'Caso Ant.',
                                                                id: 'NUM_CASO',
                                                                disabled:true,
                                                                emptyText: 'Ingrese el numero de caso',
                                                                size: 25
                                                            }
                                                        ] //Cierra items de container der
                                                    }
                                                ] //Cierra items de container principal
                                            } //Cierra primer grupo de items de fieldset
                                        ] //Cierra items fieldset
                                    }, //Cierra 1er grupo de items de panel
                                    { //Gridpanel donativos
                                        xtype: 'grid',
                                        height: 240,
                                        title: 'Donativos',
                                        id: 'gridDonativos',
                                        tbar: tbarDos,
                                        store: storeDonativos,
                                        columns:[
                                            {
                                                dataIndex: 'ID_DONATIVO',
                                                text: 'Folio',
                                                flex: .04,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'ID_DONATIVO_ANTIGUO',
                                                text: 'ID Ant',
                                                flex: .04,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'ESTATUS_DONATIVO',
                                                text: 'Status',
                                                flex: .05,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'NUM_CASO',
                                                text: 'Fecha Alta',
                                                flex: .06,
                                                align: 'center'
                                            },
                                            {
                                                dataIndex: 'TIPO_DONATIVO',
                                                text: 'Tipo',
                                                flex: .05,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'IMPORTE',
                                                text: 'Importe',
                                                flex: .04,
                                                align:'left',
                                                renderer: render_moneyDON
                                            },                                                
                                            {
                                                dataIndex: 'FORMA_PAGO',
                                                text: 'Forma de pago',
                                                flex: .08,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'PAGO_UNICO',
                                                text: 'Unico',
                                                flex: .03,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'FRECUENCIA',
                                                text: 'Frecuencia',
                                                flex: .07,
                                                align:'left'
                                            },
                                            {
                                                dataIndex:'TIPO_FRECUENCIA',
                                                text: 'Tipo Frecuencia',
                                                flex: .07,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'NUM_FRECUENCIA',
                                                text: 'Pagos',
                                                flex: .03,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'PAGOS_PENDIENTES',
                                                text: 'Pendientes',
                                                flex: .05,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'PAGOS_COBRADOS',
                                                text: 'Cobrados',
                                                flex: .05,
                                                align:'left'
                                            },
//                                            {
//                                                dataIndex: 'PAGOS_CANCELADOS',
//                                                text: 'Cancelados',
//                                                flex: .05,
//                                                align:'left'
//                                            },
                                            {                                                
                                                dataIndex: 'ASIGNACION',
                                                text: 'Asignación',
                                                flex: .05,
                                                align:'left'
                                            }                                            
                                        ],
                                        viewConfig: {
                                
                                        },
                                        selModel: Ext.create('Ext.selection.CheckboxModel', {

                                        }),
                                        bbar: new Ext.PagingToolbar({
                                            pageSize: 100,
                                            store: storeDonativos,
                                            displayInfo: true,
                                            emptyMsg: '¡No hay donativos de este donante!'                                                                                            
                                        })
                                    } //Cierra 2do grupo de items de panel (grid panel)
                                ] //Cierra items panel
                            } //Cierra primer grupo de items ext.apply
                        ] //Cierra items ext.apply
                    }); //Cierra Ext.apply
                    donantes.donativos.superclass.initComponent.apply(this, arguments); 
                    storeDonativos.load();
                    cbxTipoDonativo.load();
                    cbxUnidad.load();
                    cbxProducto.load();
                    cbxFormaPago.load();
                    cbxFrecuencia.load();
                    cbxTipoFrecuencia.load();
                    cbxCampFinanciera.load();
                    cbxAsignacion.load();                    
                }, //Cierra init component
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['ID_DONANTE',
                        'ID_TIPO_DONATIVO',
                        'CANTIDAD',
                        'ID_UNIDAD_MEDIDA',
                        'ID_PRODUCTO',
                        'ID_FORMA_PAGO',
                        'PAGO_UNICO',
                        'ID_FRECUENCIA',                           
                        'ID_TIPO_FRECUENCIA',
                        'NUM_FRECUENCIA',
                        'ID_CAMPANA_FINANCIERA',
                        'ID_CATEGORIA',
                        'ID_ASIGNACION',                                        
                        'NUM_CASO',
                        'IMPORTE',
                        'ID_DONATIVO_ANT',
                        'comboSearchBeneficiario',
                        'PERSONALMENTE_DONATIVO',
                        'ID_SUSTITUTO_DONATIVO',
                        'FECHA_INICIO'
                    ]

                    var camposValue = {'ID_DONANTE':0,
                        'ID_TIPO_DONATIVO':0,
                        'CANTIDAD':0,
                        'ID_UNIDAD_MEDIDA':0,
                        'ID_PRODUCTO':0,
                        'ID_FORMA_PAGO':0,
                        'PAGO_UNICO':0,
                        'ID_FRECUENCIA':0,
                        'ID_TIPO_FRECUENCIA':0,
                        'NUM_FRECUENCIA':0,
                        'ID_CAMPANA_FINANCIERA':0,
                        'ID_CATEGORIA':0,
                        'ID_ASIGNACION':0,                                            
                        'NUM_CASO':0,
                        'IMPORTE':0,
                        'ID_DONATIVO_ANT':0,
                        'comboSearchBeneficiario':0,
                        'PERSONALMENTE_DONATIVO':0,
                        'ID_SUSTITUTO_DONATIVO':0,
                        'FECHA_INICIO':''
                    };
                                        
                    //Id Donante            - 0                            
                    //Id Tipo Donativo      - 1                                                    
                    //Cantidad              - 2                                                     
                    //Id Unidad Medida      - 3                                                   
                    //Id Producto           - 4                                                    
                    //Id Forma de Pago      - 5                           
                    //Pago unico            - 6                            
                    //Id Frecuencia         - 7                           
                    //Id Tipo Frecuencia    - 8                           
                    //Num Frecuencia        - 9                                                   
                    //Id Campaña Financiera - 10 
                    //Id Categoria          - 11                                                 
                    //Id Asignacion         - 12                                                        
                    //Num Caso              - 13 
                    //Importe               - 14 
                    //Id Donativo Ant       - 15 
                    //comboSearchBeneficiario - 16
                    //PERSONALMENTE_DONATIVO - 17
                    //fecha inicio - 18
                            
                    var pos=0;
                    var value = '';                         
                        
                    for(pos=0;pos<camposName.length;pos++){
                        if(Ext.getCmp(camposName[pos]).getValue() == null){
                            camposValue[camposName[pos]] = 0; 
                        }else{
                            if(pos == 6){                                
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == false)                                    
                                    camposValue[camposName[pos]] = 0;
                                if(value == true)                                    
                                    camposValue[camposName[pos]] = 1;
                            }else if(pos == 15){
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == null || value == "")
                                    camposValue[camposName[pos]] = 0;
                                else
                                    camposValue[camposName[pos]] = value;
                            }else if(pos == 17){
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
                    }                                               
                    return Ext.encode(camposValue);
                }
            }); //Cierra Ext.define                 
            //   });    
        </script>   
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
