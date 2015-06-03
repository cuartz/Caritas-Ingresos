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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="ext-3.0.0/resources/css/ext-all.css" />
<script type="text/javascript" src="ext-3.0.0/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="ext-3.0.0/ext-all.js"></script>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <script type="text/javascript">                    
            /************************ VARIABLES GLOBALES ******************************/
            var ID_DONA                 = ''; //Variable para la busqueda del donante
            var person                  = ''; //Variable el guardado del donante
            var ID_DONANTE              = '';            
            var contPermisos            = 0;
            var errores                 = '';
            var idUsuarioTmp            = '<%=idusersession%>';
            var idUsuarioSplit          = idUsuarioTmp.split(":");
            var idUsuario               = idUsuarioSplit[0];
            var idCoorporativo          = 0;
            var idGrupo                 = 0;                        
            var id_Direccion            = 0;
            var nameTest                = /^[a-z\sA-Z]/i;
            var numTest                 = /^[0-9]/i;
            var moneyTest               = /^(-)?\d+(\.\d\d)?$/;
            var ID_DIRECCION_DONANTE;
            var winDonantes;
            
            /************************ MODELS *****************************/
            Ext.define('donanteMdl',{// create the Data donanteMdl
                id:'donanteMdl',
                extend: 'Ext.data.Model',
                fields: [
                    'ID_DONANTE',
                    'ID_AB_DONANTE',
                    'ID_PA_DONANTE',
                    'A_PATERNO',
                    'A_MATERNO',
                    'NOMBRE',
                    'ID_TITULO',
                    'RAZON_SOCIAL',
                    'ID_TIPO_DONANTE',
                    'DESCRIPCION',
                    'FECHA_NAC',
                    'EMAIL',
                    'ID_CLASIFICACION',
                    'TEL_CASA',
                    'TEL_OFICINA',
                    'TEL_MOVIL',
                    'ANT_DONANTE',
                    'CURP',
                    'PERSONALMENTE',
                    'DONANTE_ESPECIAL',
                    'DONANTE_FACTURA'
                ]
            });
            
            Ext.define('direccionDonantes',{// create the Data direccionDonantes
                id:'direccionDonantes',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_DIRECCION'},
                    {name: 'ID_DONANTE'},
                    {name: 'ID_TIPO_DIRECCION'},
                    {name: 'CALLE'},
                    {name: 'NUMERO'},
                    {name: 'COLONIA'},
                    {name: 'ID_ESTADO'},
                    {name: 'ID_MUNICIPIO'},
                    {name: 'COD_POSTAL'},
                    {name: 'ID_USUARIO'},
                    {name: 'FECHA_CREACION'},
                    {name: 'REFERENCIA'},
                    {name: 'ID_ZONA'}
                ]
            });
            
            Ext.define('stDonante',{// create the Data stDonante
                id:'stDonante',
                extend: 'Ext.data.Model',
                fields: ['id','name']
            });
            
            Ext.define('catalog',{// create the Data Titulo
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('catalog',{// create the Data  Tipo Donante
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('catalog',{// create the Data  Clasificacion de Donante
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('DonantesCoo',{// create the Data Corportativo
                id:'DonantesCoo',
                extend: 'Ext.data.Model',
                fields: ['ID_DONANTE','NOMBRE']
            });
            
            Ext.define('catalog',{// create the Data Empresa
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('catalog2',{// create the Data Corportativo2
                id:'catalog2',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            /************************ STORES *****************************/    
            var storedonante = Ext.create('Ext.data.JsonStore', {// create the Store donanteMdl
                model: 'donanteMdl',
                pageSize: 50,
                id:'storedonante',
                name:'storedonante',
                proxy: {
                    type: 'ajax',
                    url: 'donanteAC.do',
                    extraParams: {method: 'getdonante'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
    
            var comboSearchDonante = Ext.create('Ext.data.JsonStore', {// create the Store stDonante
                model: 'stDonante',
                proxy: {
                    type: 'ajax',
                    url: 'donanteAC.do?method=getSearchDonante',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });            
                   
            var DonanteSearchTPL = new Ext.XTemplate(
                '<tpl for="."><div  class="search-item">',
                '<h5 style="color: #0000cc;">{id}</h5>{name} {funcion}<br>',
                '</div>',
                '</tpl>'
            );
            
            var storedireccionDonantes = Ext.create('Ext.data.JsonStore', {// create the Store direccionDonantes
                model: 'direccionDonantes',
                pageSize: 50,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'donanteAC.do?method=getAlldireccionDonantes', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                
                    }
                }
            });
            
            var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
                clicksToMoveEditor: 1,
                autoCancel: true
            }); 
            
            var statestitulo = Ext.create('Ext.data.JsonStore', {// create the Store Titulo
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', 
                    extraParams:{llave:'INGRESOS_TITULO'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });            
            
            var statestipoDonante = Ext.create('Ext.data.JsonStore', {// create the Store Tipo Donante
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', 
                    extraParams:{llave:'INGRESOS_TIPO_DONANTE'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var statesclasificacionDonante = Ext.create('Ext.data.JsonStore', {// create the Store Clasificacion de Donante
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_CLASIFICACION_DONANTE'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });            
            
            var statesDonantesAB = Ext.create('Ext.data.JsonStore', {// create the Store Corportativo 2
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave',
                    extraParams:{llave:'INGRESOS_COORPORATIVO'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var statesDonantesPA = Ext.create('Ext.data.JsonStore', {// create the Store Empresa
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', 
                    extraParams:{llave:'INGRESOS_EMPRESA'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var statesDonantesPADos = Ext.create('Ext.data.JsonStore', {// create the Store Corportativo2
                model: 'catalog2',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByNombre',    
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  
            
            /************************ FUNCTIONS *****************************/
            function loadRegister(ID_DONANTE){
                ID_DONA = ID_DONANTE;
                if(ID_DONANTE!=""){                    
                    storedonante.proxy.extraParams.ID_DONANTE = ID_DONANTE;                    
                    storedonante.load({callback: function(records,o,s){                            
                        if(records.length>0){                                
                            var ID_AB_DONANTE = records[0].data.ID_AB_DONANTE;
                            var ID_PA_DONANTE = records[0].data.ID_PA_DONANTE;                            
                            var A_PATERNO = records[0].data.A_PATERNO;
                            var A_MATERNO = records[0].data.A_MATERNO;
                            var NOMBRE = records[0].data.NOMBRE;
                            var ID_TITULO = records[0].data.ID_TITULO;
                            var RAZON_SOCIAL = records[0].data.RAZON_SOCIAL;
                            var ID_TIPO_DONANTE = records[0].data.ID_TIPO_DONANTE;
                            var DESCRIPCION = records[0].data.DESCRIPCION;
                            var FECHA_NAC = records[0].data.FECHA_NAC;
                            var EMAIL = records[0].data.EMAIL;
                            var ID_CLASIFICACION = records[0].data.ID_CLASIFICACION;
                            var TEL_CASA = records[0].data.TEL_CASA;
                            var TEL_OFICINA = records[0].data.TEL_OFICINA;
                            var TEL_MOVIL = records[0].data.TEL_MOVIL;
                            var ANT_DONANTE = records[0].data.ANT_DONANTE;
                            var CURP = records[0].data.CURP;

                            Ext.getCmp('ID_DONANTE').setValue(records[0].data.ID_DONANTE);
                            statesDonantesAB.load({callback: function(records,o,s){
                                Ext.getCmp('ID_AB_DONANTE').setValue(parseInt(ID_AB_DONANTE,10));
                                statesDonantesPADos.proxy.extraParams.nombre = Ext.getCmp('ID_AB_DONANTE').getDisplayValue();                                
                                statesDonantesPADos.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_PA_DONANTE').setValue(parseInt(ID_PA_DONANTE,10));                                    
                                }});
                            }});
                                                        
                            Ext.getCmp('A_PATERNO').setValue(records[0].data.A_PATERNO);
                            Ext.getCmp('A_MATERNO').setValue(records[0].data.A_MATERNO);
                            Ext.getCmp('NOMBRE').setValue(records[0].data.NOMBRE);
                            statestitulo.load({callback: function(records,o,s){
                                Ext.getCmp('ID_TITULO').setValue(ID_TITULO);
                                statestipoDonante.load({callback: function(records,o,s){
                                    Ext.getCmp('ID_TIPO_DONANTE').setValue(parseInt(ID_TIPO_DONANTE,10));
                                    statesclasificacionDonante.load({callback: function(records,o,s){
                                            Ext.getCmp('ID_CLASIFICACION').setValue(parseInt(ID_CLASIFICACION,10));
                                        }});
                                }});
                            }});
                            Ext.getCmp('RAZON_SOCIAL').setValue(records[0].data.RAZON_SOCIAL);
                            Ext.getCmp('DESCRIPCION').setValue(records[0].data.DESCRIPCION);
                            Ext.getCmp('FECHA_NAC').setValue(records[0].data.FECHA_NAC);
                            Ext.getCmp('EMAIL').setValue(records[0].data.EMAIL);
                            Ext.getCmp('TEL_CASA').setValue(records[0].data.TEL_CASA);
                            Ext.getCmp('TEL_OFICINA').setValue(records[0].data.TEL_OFICINA);
                            Ext.getCmp('TEL_MOVIL').setValue(records[0].data.TEL_MOVIL);
                            Ext.getCmp('ANT_DONANTE').setValue(records[0].data.ANT_DONANTE);
                            Ext.getCmp('CURP').setValue(records[0].data.CURP);                                
                            if(records[0].data.PERSONALMENTE == 1) Ext.getCmp('PERSONALMENTE_DON').setValue(true); else Ext.getCmp('PERSONALMENTE_DON').setValue(false);
                            if(records[0].data.DONANTE_ESPECIAL == 1) Ext.getCmp('ESPECIAL_DON').setValue(true); else Ext.getCmp('ESPECIAL_DON').setValue(false);
                            if(records[0].data.DONANTE_FACTURA == 1) Ext.getCmp('FACTURA_DONANTE').setValue(true); else Ext.getCmp('FACTURA_DONANTE').setValue(false);
                            storedireccionDonantes.setProxy({
                                type: 'ajax',
                                url: 'donanteAC.do?method=getAlldireccionDonantes&ID_DONANTE='+ID_DONA, 
                                reader: {
                                    type: 'json',
                                    root: 'rows'
                                }
                            })
                            storedireccionDonantes.load();
                        }
                    }});
                }
                ajax_loaded_callback();
            } 
           
            function validaDatosDonante(){             
                var camposName=['ID_AB_DONANTE',
                    'ID_PA_DONANTE',
                    'ID_TITULO',
                    'NOMBRE',
                    'A_PATERNO',
                    'A_MATERNO',
                    'ID_TIPO_DONANTE',
                    'FECHA_NAC',
                    'ID_CLASIFICACION',
                    'TEL_CASA',
                    'TEL_OFICINA',
                    'TEL_MOVIL',
                    'RAZON_SOCIAL',
                    'EMAIL',
                    'DESCRIPCION',
                    'ANT_DONANTE'
//                    'CURP'
                ]                       
                
                //alert(Ext.getCmp("ID_TIPO_DONANTE").getValue());
               
                if(Ext.getCmp(camposName[3]).getValue() == ""){ //Validar el nombre
                    Ext.MessageBox.alert('Error','Ingresa el Nombre');
                    return false
                }else{
                    var x = Ext.getCmp(camposName[3]).getValue();
                    var n = x.replace("&","$");
                    Ext.getCmp(camposName[3]).setValue(n);
                }
                if(Ext.getCmp("ID_TIPO_DONANTE").getValue() == 2349 && Ext.getCmp(camposName[4]).getValue() == ""){ //Validar el nombre
                    Ext.MessageBox.alert('Error','Ingresa el Apellido Paterno');
                    return false
                }
                if(Ext.getCmp(camposName[7]).getValue() == null){ //Validar fecha nacimiento
                    Ext.MessageBox.alert('Error','Ingresa la fecha de Nacimiento, si no tiene ingresa 01/01/1900');
                    return false
                }
                
                if(Ext.getCmp(camposName[6]).getValue() == null){ //Validar el Tipo de Donante
                    Ext.MessageBox.alert('Error','Selecciona el Tipo de Donante');
                    return false
                }
                if(Ext.getCmp(camposName[8]).getValue() == null){ //Validar la Clasificacion
                    Ext.MessageBox.alert('Error','Selecciona el Tipo de Clasificacion');
                    return false
                }
                
                if(Ext.getCmp(camposName[9]).getValue() == null && Ext.getCmp(camposName[10]).getValue() == null && Ext.getCmp(camposName[11]).getValue() == null){ //Validar la Descripcion
                    Ext.MessageBox.alert('Error','Ingresa alguno de los telefonos (Casa, Oficina o Móvil)');
                    return false
                }                
               
                if(Ext.getCmp(camposName[14]).getValue() == ""){ //Validar la Descripcion
                    Ext.MessageBox.alert('Error','Ingresa Datos Clave');
                    return false
                }
                
                var x = Ext.getCmp('RAZON_SOCIAL').getValue();
                var n = x.replace("&","$");
                Ext.getCmp('RAZON_SOCIAL').setValue(n);
                
                if(Ext.getCmp('FACTURA_DONANTE').checked == true && Ext.getCmp('RAZON_SOCIAL').getValue() == ""){ //Validar la Descripcion
                    Ext.MessageBox.alert('Error','¡El R.F.C. es necesario para facturar!');
                    return false
                }
            
            }
            
            
            Ext.apply(Ext.form.field.VTypes, {
                name: function(val, field) {
                    return nameTest.test(val);
                },
                nameText: 'Este campo debe de contener un nombre de beneficiario que exista.<br>Favor de intentarlo de nuevo.',
                nameMask: /[a-z\sA-Z]/i,
        
                num: function(val, field) {
                    return numTest.test(val);
                },
                numText: 'Favor de capturar la cantidad de personas beneficiadas.<br>Favor de intentarlo de nuevo.',
                numMask: /^[0-9]/i, 
        
                money: function(val, field) {
                    return moneyTest.test(val);
                },
                moneyText: 'Favor de capturar el precio correspondiente.',
                moneyMask: moneyTest
        
            });
                        
            function ajax_loading_callback(){
                Ext.MessageBox.show({
                    title: 'Espera un momento',
                    progressText: 'Actualizando...',                   
                    width:300,
                    progress:true,
                    closable:false,
                    animEl: 'body'
                });
            
            var f = function(v){
                return function(){
                    if(v == 12){
                        Ext.MessageBox.hide();
                        Ext.example.msg('Éxito', 'Usuario Cargado!');
                    }else{
                        var i = v/11;
                        Ext.MessageBox.updateProgress(i, Math.round(100*i)+'% Completado');
                    }
                };
            };
                for(var i = 1; i < 13; i++){
                    setTimeout(f(i), i*50);
                }                   
            }            
            
            function newRegister(){
                Ext.getCmp('donantes.donantes').close();
                cleanRegisterDonante();
                ajax_loaded_callback();
            }            
            
            //Function of donor data
            function ajax_loaded_callback(){
                Ext.MessageBox.hide();
            }
            
            //Function to clean up Data
            function cleanRegisterDonante(){
                Ext.getCmp('pnlDonante').getForm().reset();
                storedireccionDonantes.removeAll();
                Ext.getCmp('comboSearchDonante').setValue("");                
                Ext.getCmp('AgregarNuevaDireccionDonante').disable();
                Ext.getCmp('ActualizarDireccionesDonante').disable();
                Ext.getCmp('BorrarDireccionesDonantes').disable();
                Ext.getCmp('btnDonantesSustitutos').disable();                
                Ext.getCmp('btnDonativos').disable();
                Ext.getCmp('btnActualizarDireccion').disable();
            }
            
            function conMayusculas(field) {
                field.value = field.value.toUpperCase()
            }
            
            //Inicia
            Ext.define('donantes.donantes', {
                extend: 'Ext.window.Window',                    
                alias:'widget.donantes',                
                title: 'Donantes',
                width: 1000,  
                height: 633,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                modal: true,
                layout: 'fit',
                closeAction:'close',
                autoDestroy:true,
                region:'center',
                constrain:true,
                initComponent: function() {                    
                    winDonantes = this;                    
                    var tbUno = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Guardar',
                                id:'saveDonante',
                                iconCls: 'icon-save',
                                handler: function(){
                                    if(validaDatosDonante() != false ){
                                        var json=winDonantes.getDatas(); 
//                                        alert("Guardar: "+json);
                                        Ext.Msg.confirm('Confirmar','¿Los datos son correctos?',function (btn){
                                            if(btn === 'yes'){
                                                var idDonanteTmp = 0;
                                                //alert(Ext.getCmp('ID_DONANTE').getValue());
                                                if(Ext.getCmp('ID_DONANTE').getValue() != null && Ext.getCmp('comboSearchDonante').getValue() != null){ //Modificar
//                                                    alert("Modificar: "+Ext.getCmp("ID_DONANTE").getValue())
                                                    Ext.getCmp('pnlDonante').getForm().submit({
                                                        url: 'donanteAC.do?method=updateDonante&jsonData='+json+'&idUsuario='+idUsuario+'&ID_DONANTE='+Ext.getCmp("ID_DONANTE").getValue(),
                                                        waitMsg: 'Actualizando...',
                                                        success: function(result,request){
                                                            var jsonData =  Ext.JSON.decode(request.response.responseText);
                                                            person = jsonData.data.salida;
                                                            idDonanteTmp = person;
    //                                                        alert("idDonante: "+Ext.getCmp('ID_DONANTE').getValue()); 
                                                            Ext.MessageBox.alert('Guardar','¡La información se ha actualizado exitósamente!');

                                                        },
                                                        failure: function(form, action) {
                                                            Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información, favor de validárla!');
                                                        }                                                   
                                                    });
                                                }else{ //Agregar
//                                                alert("Agregar")
                                                    Ext.getCmp('pnlDonante').getForm().submit({
                                                        url: 'donanteAC.do?method=savedonante&jsonData='+json+'&idUsuario='+idUsuario+'&ID_DONANTE='+Ext.getCmp("ID_DONANTE").getValue(),
                                                        waitMsg: 'Guardando...',
                                                        success: function(result,request){
                                                            var jsonData =  Ext.JSON.decode(request.response.responseText);
                                                            person = jsonData.data.salida;
                                                            idDonanteTmp = person;                                                          
                                                            if(idDonanteTmp.length > 1){
                                                                Ext.getCmp('comboSearchDonante').setValue(idDonanteTmp);
                                                                Ext.getCmp('ID_DONANTE').setValue(idDonanteTmp);                                            
                                                                Ext.getCmp('pnlDonante').doLayout();
                                                                loadRegister(Ext.getCmp('ID_DONANTE').getValue());
                                                                Ext.getCmp('AgregarNuevaDireccionDonante').enable();
                                                                Ext.getCmp('ActualizarDireccionesDonante').enable();
                                                                Ext.getCmp('BorrarDireccionesDonantes').enable();
                                                                Ext.getCmp('btnDonantesSustitutos').enable();                                                                
                                                                Ext.getCmp('btnDonativos').enable();
                                                                Ext.getCmp('btnActualizarDireccion').enable();
                                                                Ext.MessageBox.alert('Guardar','¡La información se ha guardado exitosamente!');
                                                            }else if(person.length == 1 && person == 1){                                                            
                                                                Ext.MessageBox.alert('Error','¡Ya existe un registro con el mismo nombre!');                                                            
                                                            }        
                                                        },
                                                        failure: function(form, action) {
                                                            Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información, favor de validárla!');
                                                        }                                                   
                                                    });
                                                }
                                                
                                                
                                            }
                                        });
                                    }                                    
                                }
                            }),
                            '-',                      
                            new Ext.Button({
                                text:'Limpiar',
                                iconCls: 'icon-clear',
                                handler: function()
                                {
                                    cleanRegisterDonante();
                                    storedireccionDonantes.removeAll();
                                    Ext.getCmp('AgregarNuevaDireccionDonante').disable();
                                    Ext.getCmp('ActualizarDireccionesDonante').disable();
                                    Ext.getCmp('BorrarDireccionesDonantes').disable();
                                    Ext.getCmp('comboSearchDonante').reset();                                    
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Donativos',
                                id:'btnDonativos',
                                disabled:true,
                                iconCls: 'icon-money',
                                handler: function() {
                                    if(Ext.getCmp("comboSearchDonante").getValue() != null & Ext.getCmp("ANT_DONANTE").getValue() != null){
                                        ID_DONANTE=Ext.getCmp("comboSearchDonante").getValue();
                                        if(Ext.getCmp('donativos')==null){
                                            if(Ext.getCmp("comboSearchDonante").getValue() != null) {                                         
                                                ID_DONANTE=Ext.getCmp("comboSearchDonante").getValue();
                                                createNewObj2('donantes.donativos',ID_DONANTE);
                                            }else{
                                                createNewObj2('donantes.donativos',person);

                                            }                                            
                                        }else{
                                            Ext.getCmp('donativos').show()
                                        }
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Favor de cargar un donante!');
                                    }
                                    
                                }
                            }),
                            '-',
                            new Ext.Button({                                
                                id:'btnDonantesSustitutos',
                                disabled:true,
                                iconCls: 'icon-user',
                                handler: function() {
                                    if(Ext.getCmp("comboSearchDonante").getValue() != null & Ext.getCmp("ANT_DONANTE").getValue() != null){
                                        if(Ext.getCmp('verSustitutos')==null){
                                            if(Ext.getCmp("comboSearchDonante").getValue() != null) {
                                                ID_DONANTE = Ext.getCmp("comboSearchDonante").getValue();
                                                createNewObj2('donantes.verSustitutos',ID_DONANTE)
                                            }else{
                                                createNewObj2('donantes.verSustitutos',person);
                                            }
                                        }
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Favor de cargar un donante!');
                                    }
                                }
                            }),
                            '-',
                            Ext.create('Ext.form.ComboBox', ({
                                store: comboSearchDonante,                               
                                emptyText:'Busca y selecciona un Donante',
                                blankText:'Buscar o agregar Donante',
                                margin:'1 1 1 1',
                                id:'comboSearchDonante',
                                name:'comboSearchDonante',
                                minChars:2,
                                displayField:'name',
                                valueField:'id',
                                typeAhead: false,
                                loadingText: 'Buscando...',
                                fieldLabel: 'Buscar Donante',
                                width: 500,
                                labelWidth: 110,
                                pageSize:10,
                                hideTrigger:false,
                                triggerAction: 'all',
                                queryParam : 'keyword',
                                triggerCls:'x-form-search-trigger',
                                tpl:  DonanteSearchTPL,
                                itemSelector: 'div.search-item',                                            
                                listeners:{
                                    select:function( combo,  record, index ){                                   
                                        ajax_loading_callback();
//                                      Ext.getCmp('comboSearchDonante').selectedIndex = 173
                                        Ext.getCmp('comboSearchDonante').selectedRecord = record;
                                        if(Ext.getCmp('comboSearchDonante').getValue()!=null && Ext.getCmp('comboSearchDonante').getValue()!="" ){ 
                                            Ext.getCmp('ID_DONANTE').setValue(Ext.getCmp('comboSearchDonante').getValue());                                            
                                            Ext.getCmp('pnlDonante').doLayout();
                                            loadRegister(Ext.getCmp('ID_DONANTE').getValue());
                                            Ext.getCmp('AgregarNuevaDireccionDonante').enable();
                                            Ext.getCmp('ActualizarDireccionesDonante').enable();
                                            Ext.getCmp('BorrarDireccionesDonantes').enable();
                                            Ext.getCmp('btnDonantesSustitutos').enable();                                            
                                            Ext.getCmp('btnDonativos').enable();
                                            Ext.getCmp('btnActualizarDireccion').enable();                                            
                                        } else {                                                      
                                            Ext.getCmp('comboSearchDonante').setValue("");
                                            Ext.getCmp('AgregarNuevaDireccionDonante').disable();
                                            Ext.getCmp('ActualizarDireccionesDonante').disable();
                                            Ext.getCmp('BorrarDireccionesDonantes').disable();
                                            Ext.getCmp('btnDonantesSustitutos').disable();                                            
                                            Ext.getCmp('btnDonativos').disable();
                                            Ext.getCmp('btnActualizarDireccion').disable();
                                        }
                                    }                                    
                                }
                            })),
                            Ext.create('Ext.Button', {
                                text: 'Donantes ',
                                hidden:false,
                                tooltip: 'Muestra Los Donantes ',
                                iconCls:'icon-registro',
                                hidden:true,
                                handler: function() {
                      
                                    createNewObj('donantes.misDonantes'); 
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    storedireccionDonantes.removeAll();
                                    winDonantes.destroy();
                                }
                            })                            
                        ]
                    }); //Termina Toolbar
                    //Toolbar Direcciones
                    var tbDos = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Agregar',
                                id:'AgregarNuevaDireccionDonante',
                                disabled:true,
                                iconCls: 'icon-add',
                                handler: function() {
                                    if(Ext.getCmp("comboSearchDonante").getValue() != null){
                                        ID_DONANTE=Ext.getCmp("comboSearchDonante").getValue();
                                    }
                                    if(Ext.getCmp('direccionDonante')==null){
                                        if(Ext.getCmp("comboSearchDonante").getValue() != null){
                                            ID_DONANTE=Ext.getCmp("comboSearchDonante").getValue();
                                            createNewObj2('donantes.direccionDonante',ID_DONANTE);

                                        }else{
                                            createNewObj2('donantes.direccionDonante',person);
                                        }
                                    }else{Ext.getCmp('direccionDonante').show()
                                    }
                                }  
                            }),
                            '-',                      
                            new Ext.Button({
                                text:'Borrar',
                                id:'BorrarDireccionesDonantes',
                                disabled:true,
                                iconCls: 'icon-delete',
                                handler: function() {
                                    if(idUsuario == 'RNUNEZ' || idUsuario == 'MMENDOZA'){
                                        var selectedRow=Ext.getCmp('gridDirecciones').selModel.selected.items[0]; 
                                        if(selectedRow!=undefined){
                                            Ext.Msg.confirm('Eliminar Dirección', '¿Esta seguro de eliminar esta dirección? Esta acción podria perjudicar procesos posteriores.', function(btn, text){
                                                if (btn == 'yes'){
                                                    Ext.Ajax.request({  
                                                        url : 'donanteAC.do?method=deleteDireccion' ,
                                                        params : { 
                                                            ID_DIRECCION:selectedRow.data.ID_DIRECCION
                                                        },
                                                        method: 'GET',
                                                        success: function ( result, request ) {
                                                            Ext.MessageBox.alert('Guardado','La dirección se elimino correctamente');
                                                            storedireccionDonantes.load();
                                                        },
                                                        failure: function ( result, request) {
                                                            Ext.MessageBox.alert('Error','¡Ocurrio un error al eliminar la dirección!');                                                
                                                        }
                                                    });
                                                }                                            
                                            });                                        
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Seleccione la dirección que desea eliminar!');
                                        }
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Usted no cuenta con permisos para hacer esta acción!');
                                    }                                    
                                }                                        
                            }),
                            '-',
                            Ext.create('Ext.Button', {
                                text: 'Actualizar',
                                id:'ActualizarDireccionesDonante',
                                tooltip: 'Actualiza los registros',
                                disabled:true,
                                iconCls:'icon-reload',
                                hidden:false,
                                handler: function() {
                                    storedireccionDonantes.load();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Actualizar Direccion',
                                id:'btnActualizarDireccion',
                                disabled:true,
                                iconCls: 'icon-grid',
                                handler:function(){
                                    var selectedRow = Ext.getCmp('gridDirecciones').selModel.selected.items[0];
                                    if(selectedRow!=undefined){
                                        ID_DONANTE = Ext.getCmp("comboSearchDonante").getValue();
                                        ID_DIRECCION_DONANTE = selectedRow.data.ID_DIRECCION;
                                        createNewObj3('donantes.direccionDonante',ID_DONANTE,ID_DIRECCION_DONANTE);
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione la dirección que desea modificar!');
                                    }                                   
                                }
                            }),
                        ]
                    }); //Termina Toolbar direcciones                        
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'pnlDonante',
                                tbar: tbUno,
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        title: 'Agregar Donante', 
                                        height: 340,
                                        items:[
                                            { //container principal
                                                xtype: 'container',                                                  
                                                layout: {
                                                    type: 'hbox'
                                                }, 
                                                items:[
                                                    {    //containter izq
                                                        xtype: 'container',
//                                                        height: 250,                                     
//                                                        width: 382,
                                                        flex: 0.5,
                                                        items:[
                                                            {
                                                                xtype: 'textfield',
                                                                fieldLabel:'Donante',
                                                                id:'ID_DONANTE',
                                                                name:'ID_DONANTE',
                                                                labelWidth: 100,
                                                                width:190,
                                                                size: 30,
                                                                anchor: '100%',
                                                                readOnly:true,
                                                                value:''                                            
                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Titulo',
                                                                name:'titulo',
                                                                id:'ID_TITULO',
                                                                emptyText:'Favor de seleccionar el titulo del Donante.',
                                                                editable:false,
                                                                anchor: '900%',
                                                                labelWidth: 100,
                                                                size: 10,
                                                                store: statestitulo,
                                                                queryMode: 'local',
                                                                displayField: 'nombre',
                                                                valueField: 'id'
//                                                                listeners: {
//                                                                    beforeshow: function() {
//                                                                        alert("jajaja");
//                                                                    }
////                                                                    
//////                                                                    beforerender: function(){
//////                                                                        if(contPermisos = 1){
//////                                                                            alert("SIII");
//////                                                                        }else{
//////                                                                            alert("NOOO");
//////                                                                        }
//////                                                                    }
//                                                                }
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Corporativo',
                                                                name:'ABUELO',
                                                                id:'ID_AB_DONANTE',
                                                                emptyText:'Favor de seleccionar el Coorportativo del Donante.',
                                                                editable:true,
                                                                anchor: '900%',
                                                                labelWidth: 100,
                                                                size: 45,
                                                                store: statesDonantesAB,
                                                                triggerAction: 'all',
                                                                queryMode: 'local',
                                                                displayField: 'nombre',
                                                                valueField: 'id',                                                                
                                                                listeners: {                                                                        
                                                                    blur: function(){
                                                                        Ext.getCmp('ID_PA_DONANTE').setValue('');                                                                                                                                                     
                                                                        var me = this 
                                                                        statesDonantesPADos.proxy.extraParams.nombre = me.getDisplayValue(); //Obtener el valueField y agregarlo como parametro al store
                                                                        statesDonantesPADos.load();                                                                            
                                                                    },
                                                                    select:function( combo, record, index ){
                                                                        Ext.getCmp('ID_AB_DONANTE').selectedRecord = record;
                                                                    },
                                                                    specialkey:function ( field, e ){
                                                                        if (e.getKey() == e.ENTER) {
                                                                            var wtsc = Ext.getCmp('ID_AB_DONANTE');
                                                                            var rec = wtsc.selectedRecord;
                                                                            if (rec){
                                                                                var n = statesDonantesAB.find('id',rec.data.id);

                                                                                if (n==-1){
                                                                                    statesDonantesAB.insert(0,rec);
                                                                                }
                                                                            }
                                                                        }
                                                                    } 
                                                                }  
                                                            }),
                                                           
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Titulo',
                                                                name:'titulo',
                                                                id:'ID_TITULO',
                                                                emptyText:'Favor de seleccionar el titulo del Donante.',
                                                                editable:false,
                                                                anchor: '900%',
                                                                labelWidth: 100,
                                                                size: 10,
                                                                store: statestitulo,
                                                                queryMode: 'local',
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            {
                                                                xtype: 'textfield',   
                                                                id:'NOMBRE',
                                                                name: 'NOMBRE',
                                                                fieldLabel: 'Nombre',
                                                                emptyText: 'Nombre',
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:100,
                                                                enforceMaxLength:true,
                                                                allowBlank:false,
                                                                size: 30
//                                                                handler:function(){
//                                                                    this.disable(true);
//                                                                }
                                                            },                                                            
                                                            {
                                                                xtype: 'textfield', 
                                                                id:'A_PATERNO',
                                                                fieldLabel: 'Apellido Paterno',
                                                                emptyText: 'Apellido Paterno',
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:100,
                                                                enforceMaxLength:true,
                                                                size: 30
                                                            },
                                                            {
                                                                xtype: 'textfield',  
                                                                id:'A_MATERNO',
                                                                fieldLabel: 'Apellido Materno',
                                                                emptyText: 'Apellido Materno',
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:100,
                                                                enforceMaxLength:true,
                                                                size: 30
                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Tipo',
                                                                name:'id_Tipo_Donante',
                                                                id:'ID_TIPO_DONANTE',
                                                                emptyText:'Seleccione el tipo de donante...',                                                               
                                                                anchor: '900%',
                                                                labelWidth: 100,
                                                                editable:false,
                                                                size: 30,
                                                                store: statestipoDonante,
                                                                queryMode: 'local',
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            {
                                                                xtype: 'datefield', 
                                                                id:'FECHA_NAC',
                                                                fieldLabel: 'Fecha Nacimiento'
                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Clasificación',
                                                                name:'ID_CLASIFICACION',
                                                                id:'ID_CLASIFICACION',
                                                                emptyText:'Seleccione la clasificación...',
                                                                allowBlank:false,
                                                                editable:false,
                                                                anchor: '900%',
                                                                labelWidth: 100,
                                                                size: 30,
                                                                store: statesclasificacionDonante,
                                                                queryMode: 'local',
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            {
                                                                xtype: 'checkbox',
                                                                fieldLabel: 'Viene Personalmente',
                                                                id: 'PERSONALMENTE_DON',
                                                                labelWidth: 130
                                                            },
                                                            {
                                                                xtype: 'checkbox',
                                                                fieldLabel: 'Donante Especial',
                                                                id: 'ESPECIAL_DON',
                                                                labelWidth: 130
                                                            },
                                                            {
                                                                xtype: 'checkbox',
                                                                fieldLabel: 'Requiere Factura',
                                                                id: 'FACTURA_DONANTE',
                                                                labelWidth: 130,
                                                                handler: function(){                                                                    
                                                                    if(this.checked == false && idUsuario == 'MMENDOZA'){ 
                                                                        Ext.Msg.confirm('Alerta', 'Esta acción afectará a otros procesos. ¿Desea continuar?', function(btn, text){
                                                                            if (btn == 'yes'){
                                                                                Ext.getCmp('FACTURA_DONANTE').setValue(false);
                                                                            }else{
                                                                                Ext.getCmp('FACTURA_DONANTE').setValue(true);
                                                                            }
                                                                        })                                                                       
                                                                    }
                                                                }
                                                            }
                                                        ]
                                                    }, //Cierra items container izq
                                                    {
                                                        xtype: 'container',
//                                                        height: 280,                                     
//                                                        width: 500,
                                                        flex: 0.5,
                                                        items:[
                                                            {
                                                                xtype: 'numberfield',
                                                                fieldLabel: 'Donante Antiguo',
                                                                id:'ANT_DONANTE',
                                                                emptyText: 'No de Donante',                                                                
                                                                hideTrigger: true,
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:10,                                                                
                                                                size: 30,
                                                                labelWidth: 100
                                                            },
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Empresa',
                                                                store: statesDonantesPADos,
                                                                id:'ID_PA_DONANTE',
                                                                emptyText:'Favor de seleccionar el Grupo del Donante.',
                                                                size: 45,                                                                
                                                                displayField: 'nombre',
                                                                valueField: 'id'
                                                            }),
                                                            {
                                                                xtype: 'numberfield',
                                                                fieldLabel: 'Tel. Casa',
                                                                id:'TEL_CASA',
                                                                emptyText: 'Ingrese telefono de Casa',
                                                                hideTrigger: true,
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:10,
                                                                enforceMaxLength:true,
                                                                size: 30
                                                            },
                                                            {
                                                                xtype: 'numberfield',                                           
                                                                fieldLabel: 'Tel. Oficina',
                                                                id:'TEL_OFICINA',
                                                                emptyText: 'Ingrese teléfono de Oficina',
                                                                hideTrigger: true,
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:10,
                                                                enforceMaxLength:true,
                                                                size: 30
                                                            },
                                                            {
                                                                xtype: 'numberfield',                                         
                                                                fieldLabel: 'Tel. Móvil',
                                                                id:'TEL_MOVIL',
                                                                emptyText: 'Ingrese teléfono de Celular',
                                                                hideTrigger: true,
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:13,
                                                                enforceMaxLength:true,
                                                                size: 30
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                id:'RAZON_SOCIAL',
                                                                emptyText:'Ingrese RFC',
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:100,
                                                                enforceMaxLength:true,
                                                                fieldLabel: 'R.F.C',
                                                                size: 40,
                                                                listeners: {
                                                                    blur: function(){                                                                        
                                                                        if(Ext.getCmp('FACTURA_DONANTE').checked == true && this.getValue() == ''){
                                                                            Ext.MessageBox.alert('Alerta','¡Este campo es necesario ya que el donante requiere factura!');
                                                                        }
                                                                    }    
                                                                }
                                                            },
                                                            {
                                                                xtype: 'textfield',
                                                                id:'CURP',
                                                                emptyText:'Ingrese CURP',
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:100,
                                                                enforceMaxLength:true,
                                                                fieldLabel: 'CURP',
                                                                size: 40,
                                                                blur: function(){                                                                        
                                                                    if(Ext.getCmp('FACTURA_DONANTE').checked == true && this.getValue() == ''){
                                                                        Ext.MessageBox.alert('Alerta','¡Este campo es necesario ya que el donante requiere factura!');
                                                                    }
                                                                }
                                                            },
                                                            {
                                                                xtype: 'textfield', 
                                                                id:'EMAIL',
                                                                fieldLabel: 'Email',
                                                                emptyText: 'Favor de Agregar el email',
                                                                maxLengthText:'Es el Limite de Datos',
                                                                maxLength:50,
                                                                enforceMaxLength:true,
                                                                size: 40,
                                                                blur: function(){                                                                        
                                                                    if(Ext.getCmp('FACTURA_DONANTE').checked == true && this.getValue() == ''){
                                                                        Ext.MessageBox.alert('Alerta','¡Este campo es necesario ya que el donante requiere factura!');
                                                                    }
                                                                }
                                                            },
                                                            {
                                                                xtype: 'textarea',
                                                                id:'DESCRIPCION',
                                                                fieldLabel: 'Datos Clave',
                                                                width: 390,
                                                                height: 80
//                                                                listeners: {
//                                                                    blur: function(){
//                                                                        var value = this.getValue().toUpperCase();                                                                        
//                                                                        alert("MAYUSCULAS!!!"+value);
//                                                                        this.value(this.getValue().toUpperCase());
//                                                                    }    
//                                                                }
                                                            }
                                                        ]
                                                    } //Cierra items container derecho
                                                ]//cierra items containter principal                                                   
                                            } //Cierra 1er grupo de items de fieldset
                                               
                                        ] //Cierra items de fieldset                                           
                                    },//Cierra 1er grupo de items de panel principal
                                    {
                                        xtype: 'grid',
                                        height: 220,
                                        title: 'Direcciones',
                                        id:'gridDirecciones',
                                        tbar: tbDos,
                                        store: storedireccionDonantes,
                                        columns:[
                                            {
                                                dataIndex: 'ID_DIRECCION',
                                                text: 'Id Direccion',
                                                flex: .03,
                                                hidden:true,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'ID_DONANTE',
                                                text: 'Donante',
                                                flex: .08,
                                                hidden:true,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'ID_TIPO_DIRECCION',
                                                text: 'Tipo Dirección',
                                                flex: .08,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'CALLE',
                                                text: 'Calle',
                                                flex: .1,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'NUMERO',
                                                text: '# Casa',
                                                flex: .05,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'COLONIA',
                                                text: 'Colonia',
                                                flex: .1,
                                                align:'left'
                                            },
                                            {
                                                dataIndex: 'ID_MUNICIPIO',
                                                text: 'Municipio',
                                                flex: .05,
                                                align:'center'
                                            },
                                            {
                                                dataIndex: 'ID_ESTADO',
                                                text: 'Estado',
                                                flex: .05,
                                                align:'center'
                                            }
                                            ,
                                            {
                                                dataIndex: 'COD_POSTAL',
                                                text: 'CP',
                                                flex: .05,
                                                align:'center'
                                            }
                                            ,
                                            {
                                                dataIndex: 'ID_USUARIO',
                                                text: 'Usuario',
                                                flex: .05,
                                                align:'center'
                                            }
                                            ,
                                            {
                                                dataIndex: 'FECHA_CREACION',
                                                text: 'Fecha Alta',
                                                flex: .05,
                                                align:'center'
                                            }
                                            ,
                                            {
                                                dataIndex: 'REFERENCIA',
                                                text: 'Referencia',
                                                flex: .05,
                                                align:'center'
                                            }
                                            ,
                                            {
                                                dataIndex: 'ID_ZONA',
                                                text: 'Zona',
                                                flex: .05,
                                                align:'center'
                                            }
                                           
                                        ],
                                        viewConfig: {
                                
                                        },
                                        selModel: Ext.create('Ext.selection.CheckboxModel', {

                                        }),
                                        bbar: new Ext.PagingToolbar({
                                            pageSize: 1000,
                                            store: storedireccionDonantes,
                                            displayInfo: true
                                        })
                                    } //Cierra 2do grupo de items de panel principal
                                ]//Cierra items del panel principal                                   
                            } //Cierra 1er grupo de items del Ext.apply
                        ]
                    });//Cierra Ext.apply
                    donantes.donantes.superclass.initComponent.apply(this, arguments); 
                    statestitulo.load();
                    statestipoDonante.load();
                    statesclasificacionDonante.load();
                    statesDonantesAB.load();
//                    statesDonantesPA.load();
                    //statesDonantesPADos.load();
                } //Cierra initComponent
                ,
                getDatas:function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['ID_AB_DONANTE',
                            'ID_PA_DONANTE',
                            'ID_TITULO',
                            'NOMBRE',
                            'A_PATERNO',
                            'A_MATERNO',
                            'ID_TIPO_DONANTE',
                            'FECHA_NAC',
                            'ID_CLASIFICACION',
                            'TEL_CASA',
                            'TEL_OFICINA',
                            'TEL_MOVIL',
                            'RAZON_SOCIAL',
                            'EMAIL',
                            'DESCRIPCION',
                            'ANT_DONANTE',
                            'CURP',
                            'PERSONALMENTE_DON', 
                            'ESPECIAL_DON',
                            'FACTURA_DONANTE']

                    var camposValue = {'ID_AB_DONANTE':0,
                        'ID_PA_DONANTE':'',
                        'ID_TITULO':0,
                        'NOMBRE':'',
                        'A_PATERNO':'',
                        'A_MATERNO':'',
                        'ID_TIPO_DONANTE':0,
                        'FECHA_NAC':'',
                        'ID_CLASIFICACION':0,
                        'TEL_CASA':'',
                        'TEL_OFICINA':'',
                        'TEL_MOVIL':'',
                        'RAZON_SOCIAL':'',
                        'EMAIL':'',
                        'DESCRIPCION':'',
                        'ANT_DONANTE':0,
                        'CURP':'', 
                        'PERSONALMENTE_DON':0, 
                        'ESPECIAL_DON':0,
                        'FACTURA_DONANTE':0};
                   
                    var pos=0;
                    var value='';
                    
                    /************************************/
                    // 0 - ID_AB_DONANTE 
                    
                    for(pos=0;pos<camposName.length;pos++){ 
                        if(pos == 17){
                            value = Ext.getCmp(camposName[17]).getValue()
                            if(value == true) camposValue[camposName[17]] = 1;
                            if(value == false) camposValue[camposName[17]] = 0;
                        }else if(pos == 18){
                            value = Ext.getCmp(camposName[18]).getValue();
                            if(value == true) camposValue[camposName[18]] = 1;
                            if(value == false) camposValue[camposName[18]] = 0;
                        }else if(pos == 19){
                            value = Ext.getCmp(camposName[19]).getValue();
                            if(value == true) camposValue[camposName[19]] = 1;
                            if(value == false) camposValue[camposName[19]] = 0;
                        }else if(pos == 7){
                            value = Ext.getCmp(camposName[7]).getValue()
                            if(value == null) camposValue[camposName[7]] = "01/01/1900";
                            else camposValue[camposName[7]] = value;
                        }else if(Ext.getCmp(camposName[pos]).getValue() == null){
                            camposValue[camposName[pos]] = 0; 
                        }else{                            
                            value = Ext.getCmp(camposName[pos]).getValue();
                            camposValue[camposName[pos]] = value;                                                          
                        }  
                    }
                    return Ext.encode(camposValue);
                }
            }); //Cierra principal                
            //            });
        </script>
    </head>
    <body>
        <div id="contenedor"></div>                    
    </table>
</body>
</html>
