<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
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

<!DOCTYPE html //@page contentType="text/html" pageEncoding="UTF-8" >
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <script type="text/javascript">
        /***************** VARIABLES GLOBALES *********************/
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        var winAddSustituto;
        var idDonantePadre;
        var tipoMovimientoSust;
//        var character       = /^(-)?\d+(\.\d\d)?&/;
        var character       = /^[a-zA-Z\s&_0-9]+$/;
        
       /******************** MODELS ******************************/
        Ext.define('reg_Estado',{// create the Data reg_Estado
            id:'reg_Estado',
            extend: 'Ext.data.Model',
            fields: ['nombre', 'id']
        });
        
        Ext.define('reg_Municipio',{// create the Data reg_Municipio
            id:'reg_Municipio',
            extend: 'Ext.data.Model',
            fields: ['nombre', 'id']
        });
        
        Ext.define('nameDonanteInf',{
            id:'nameDonanteInf',
            extend: 'Ext.data.Model',
            fields: [                       
                'NOMBRE'                        
            ]
        });
        
        Ext.define('donanteSustInfoMdl',{
            id:'donanteSustInfoMdl',
            extend: 'Ext.data.Model',
            fields: [ 
                {name: 'ID_DONANTE_TMP'},
                {name: 'RAZON_SOCIAL'},
                {name: 'RFC'},
                {name: 'CURP'},
                {name: 'TELEFONO'},
                {name: 'EMAIL'},
                {name: 'CALLE'},
                {name: 'NUMERO'},
                {name: 'COLONIA'},
                {name: 'CP'},
                {name: 'ID_ESTADO'},
                {name: 'ID_MUNICIPIO'}
            ]
        });
        
        /******************** STORES*****************************/                
        var storeCbEstado = Ext.create('Ext.data.JsonStore', {// create the Store reg_Estado
            model: 'reg_Estado',
            pageSize: 50,
            width: 300,
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do?method=getEstadosDos',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });       
        
        var storeCbMunicipios = Ext.create('Ext.data.JsonStore', {// create the Store reg_Municipio
            model: 'reg_Municipio',
            pageSize: 50,
            width: 300,
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do?method=getMunicipios',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeNameDonanteInfo = Ext.create('Ext.data.JsonStore', {
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
        
        var storeDonanteSustInfo = Ext.create('Ext.data.JsonStore', {
            model: 'donanteSustInfoMdl',
            pageSize: 50,
            id:'storeDonanteSustInfo',
            name:'storeDonanteSustInfo',
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do',
                extraParams: {method: 'getSustitutoInfo'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });  
        
        
        
        /******************** FUNCIONES JAVASCRIPT ************************/
        function loadNombreDonante(ID_DONANTE){
            storeNameDonanteInfo.proxy.extraParams.ID_DONANTE = ID_DONANTE;
            storeNameDonanteInfo.load({ callback: function(records,o,s){
                    if(records.length > 0){
                        Ext.getCmp('ID_DONANTE_PADRE').setValue(idDonantePadre);                        
                        Ext.getCmp('DONANTE_PADRE').setValue(records[0].data.NOMBRE);                        
                    }
                }
            });  
        }
        
        function loadDonanteSustInfo(ID_DONANTE_SUST){            
            storeDonanteSustInfo.proxy.extraParams.ID_DONANTE = ID_DONANTE_SUST;
            storeDonanteSustInfo.load({ callback: function(records,o,s){
                if(records.length > 0){
                    var ID_ESTADO_UP = records[0].data.ID_ESTADO;
                    var ID_MUNICIPIO_UP = records[0].data.ID_MUNICIPIO;                       
                    Ext.getCmp('ID_DONANTE_UP').setValue(records[0].data.ID_DONANTE_TMP);
                    Ext.getCmp('RAZON_SOCIAL_UP').setValue(records[0].data.RAZON_SOCIAL);
                    Ext.getCmp('RFC_UP').setValue(records[0].data.RFC);
                    Ext.getCmp('CURP_UP').setValue(records[0].data.CURP);
                    Ext.getCmp('TELEFONO_UP').setValue(records[0].data.TELEFONO);
                    Ext.getCmp('EMAIL_UP').setValue(records[0].data.EMAIL);
                    Ext.getCmp('CALLE_UP').setValue(records[0].data.CALLE);
                    Ext.getCmp('NUMERO_UP').setValue(records[0].data.NUMERO);
                    Ext.getCmp('COLONIA_UP').setValue(records[0].data.COLONIA);
                    Ext.getCmp('CP_UP').setValue(records[0].data.CP);                      
                    Ext.getCmp('ID_MUNICIPIO_UP').setValue(records[0].data.ID_MUNICIPIO);                        
                    storeCbEstado.load({callback: function(records,o,s){
                        Ext.getCmp('ID_ESTADO_UP').setValue(parseInt(ID_ESTADO_UP,10));
                        storeCbMunicipios.proxy.extraParams.idestado = ID_ESTADO_UP;
                        storeCbMunicipios.load({callback: function(records,o,s){
                        Ext.getCmp('ID_MUNICIPIO_UP').setValue(parseInt(ID_MUNICIPIO_UP,10));
                    }});
                    }});
                }
            }
            });  
        }
        
        function validaDatosFiscalesSustituto(){            
            if(Ext.getCmp("RAZON_SOCIAL").getValue() == ""){ //Validar la razon social
                Ext.MessageBox.alert('Error','¡Ingresa la Razón Social!');
                return false
            }else{
                var x = Ext.getCmp("RAZON_SOCIAL").getValue();
                var n = x.replace("&","$");
                Ext.getCmp("RAZON_SOCIAL").setValue(n);
            }
            if(Ext.getCmp("RFC").getValue() == ""){ //Validar el rfc
                Ext.MessageBox.alert('Error','¡Ingresa el R.F.C.!');
                return false
            }else{
                var x = Ext.getCmp("RFC").getValue();
                var n = x.replace("&","$");
                Ext.getCmp("RFC").setValue(n);                
            }
            if(Ext.getCmp("TELEFONO").getValue() == null){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el Teléfono!');
                return false
            }
            if(Ext.getCmp("EMAIL").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el Email!');
                return false
            }
            if(Ext.getCmp("CALLE").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa la calle!');
                return false
            }
            if(Ext.getCmp("NUMERO").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el numero!');
                return false
            }
            if(Ext.getCmp("COLONIA").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa la colonia!');
                return false
            }
            if(Ext.getCmp("CP").getValue() == null){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el Codigo Postal!');
                return false
            }
            if(Ext.getCmp("ID_ESTADO").getValue() == null || Ext.getCmp("ID_ESTADO").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Selecciona el Estado!');
                return false
            }
            if(Ext.getCmp("ID_MUNICIPIO").getValue() == null || Ext.getCmp("ID_MUNICIPIO").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Selecciona el Municipio!');
                return false
            }
        }
        
        function validaDatosFiscalesUpdateSustituto(){            
            if(Ext.getCmp("RAZON_SOCIAL_UP").getValue() == ""){ //Validar la razon social
                Ext.MessageBox.alert('Error','¡Ingresa la Razón Social!');
                return false
            }else{
                var x = Ext.getCmp("RAZON_SOCIAL_UP").getValue();
                var n = x.replace("&","$");
                Ext.getCmp("RAZON_SOCIAL_UP").setValue(n);
            }
            if(Ext.getCmp("RFC_UP").getValue() == ""){ //Validar el rfc
                Ext.MessageBox.alert('Error','¡Ingresa el R.F.C.!');
                return false
            }else{
                var x = Ext.getCmp("RFC_UP").getValue();
                var n = x.replace("&","$");
                Ext.getCmp("RFC_UP").setValue(n);
            }
            if(Ext.getCmp("TELEFONO_UP").getValue() == null){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el Teléfono!');
                return false
            }
            if(Ext.getCmp("EMAIL_UP").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el Email!');
                return false
            }
            if(Ext.getCmp("CALLE_UP").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa la calle!');
                return false
            }
            if(Ext.getCmp("NUMERO_UP").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el numero!');
                return false
            }
            if(Ext.getCmp("COLONIA_UP").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa la colonia!');
                return false
            }
            if(Ext.getCmp("CP_UP").getValue() == null){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Ingresa el Codigo Postal!');
                return false
            }
            if(Ext.getCmp("ID_ESTADO_UP").getValue() == null || Ext.getCmp("ID_ESTADO_UP").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Selecciona el Estado!');
                return false
            }
            if(Ext.getCmp("ID_MUNICIPIO_UP").getValue() == null || Ext.getCmp("ID_MUNICIPIO_UP").getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','¡Selecciona el Municipio!');
                return false
            }
        }
        
        /**************** INICIA PANTALLA ***********************/        
        Ext.define('donantes.addSustituto', {
            extend: 'Ext.window.Window',                    
            alias:'widget.addSustituto', 
            id: 'addSustituto',
            title: 'Agregar Donante Sustituto',
            width: 450,  
            height: 475,
            border: false,
            buttonAlign: 'left',
//            maximizable: true,
            modal: false,
            layout: 'fit',
            closeAction: 'destroy',
            //autoDestroy:true,
            region:'center',
            constrain:true,
            initComponent: function() {
            /************* INICIALIZAR VALORES ***********************/
            winAddSustituto = this;
            idDonantePadre = this.name;            
            tipoMovimientoSust = this.nameDos;
            
            var tbAddSustituto = new Ext.Toolbar({
                items:[                      
                    new Ext.Button({
                        text:'Guardar',
                        id:'saveDonante',
                        iconCls: 'icon-save',
                        handler: function(){                                      
                            if(validaDatosFiscalesSustituto() != false ){
                                var json = winAddSustituto.getDatas();                                                             
                                Ext.Msg.confirm('Confirmar','¿Los datos son correctos?',function (btn){
                                    if(btn === 'yes'){
                                        Ext.getCmp('pnlAddSustituto').getForm().submit({
                                            url: 'donanteAC.do?method=saveDonanteSustituto&jsonData='+json+'&idUsuario='+idUsuario,
                                            waitMsg: 'Guardando...',
                                            success: function(result,request){
                                                Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                                winAddSustituto.destroy();
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
                        text: 'Salir',
                        iconCls:'icon-salir',
                        handler: function(){                                
                            winAddSustituto.close();
                        }
                    })                            
                ]
            }); //Termina Toolbar
            
            if(tipoMovimientoSust == 1){ //Editar donante Sustituto
//                alert("modificar");
                var tbUpdateSustituto = new Ext.Toolbar({
                    items:[                      
                        new Ext.Button({
                            text:'Guardar',
                            id:'saveDonante',
                            iconCls: 'icon-save',
                            handler: function(){                                      
                                if(validaDatosFiscalesUpdateSustituto() != false ){
                                    var json = winAddSustituto.getDatasUpdate();
//                                    alert("modificar: "+json);
                                    Ext.Msg.confirm('Actualizar Datos','¿Los datos son correctos?',function (btn){
                                        if(btn === 'yes'){
                                            Ext.getCmp('pnlUpdateSustituto').getForm().submit({
                                                url: 'donanteAC.do?method=actualizarDatosSustituto&jsonData='+json+'&ID_DONANTE='+idDonantePadre,
                                                waitMsg: 'Guardando...',
                                                success: function(result,request){
                                                    Ext.MessageBox.alert('Guardado','Se actualizó la información correctamente');
                                                    Ext.getCmp('gridSustitutos').getStore().load();                                                    
                                                    winAddSustituto.destroy();
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al actualizar la información!');
                                                }
                                            });
                                        }
                                    });
                                }
                            }
                        }),      
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                
                                winAddSustituto.destroy();
                            }
                        })                            
                    ]
                }); //Termina Toolbar
                
                loadDonanteSustInfo(idDonantePadre)
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',
                            id: 'pnlUpdateSustituto',
                            tbar: tbUpdateSustituto,
                            items:[
                                {
                                    xtype: 'fieldset',
                                    title: 'Datos del Donante', 
                                    height: 210,
                                    items:[                                    
                                        {
                                            xtype: 'displayfield',
                                            id: 'ID_DONANTE_UP',
                                            width: 293,                                                                                                                              
                                            labelWidth: 150,
                                            fieldLabel: 'ID'
                                        },                                        
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Nombre / Razon Social',
                                            id:'RAZON_SOCIAL_UP',
                                            name:'RAZON_SOCIAL',
                                            labelWidth: 150,                                            
                                            size: 30,
                                            anchor: '100%'
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'R.F.C.',
                                            id:'RFC_UP',
                                            name:'RFC',
                                            labelWidth: 150,                                            
                                            size: 30
                                            //anchor: '100%' 
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'CURP.',
                                            id:'CURP_UP',
                                            name:'CURP',
                                            labelWidth: 150,                                            
                                            size: 30
                                            //anchor: '100%'
                                        },
                                        {
                                            xtype: 'numberfield',
                                            fieldLabel: 'Telefono',
                                            id:'TELEFONO_UP', 
                                            labelWidth: 150,
                                            hideTrigger: true,                                           
                                            size: 30
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Email',
                                            id:'EMAIL_UP',
                                            name:'EMAIL',
                                            labelWidth: 150,                                            
                                            size: 30
                                        }
                                    ] //Cierra items fieldset
                                },
                                {
                                    xtype: 'fieldset',
                                    title: 'Domicilio Fiscal', 
                                    height: 200,
                                    items:[
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Calle',
                                            id:'CALLE_UP',
                                            name:'CALLE',
                                            labelWidth: 150,                                            
                                            size: 30,
                                            anchor: '100%'
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel: 'Numero',
                                            id:'NUMERO_UP', 
                                            labelWidth: 150,
                                            hideTrigger: true,                                           
                                            size: 10
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Colonia',
                                            id:'COLONIA_UP',
                                            name:'COLONIA',
                                            labelWidth: 150,                                            
                                            size: 30
                                        },
                                        {
                                            xtype: 'numberfield',
                                            fieldLabel: 'CP.',
                                            id:'CP_UP', 
                                            labelWidth: 150,
                                            hideTrigger: true,                                           
                                            size: 10
                                        },
                                        Ext.create('Ext.form.ComboBox', ({
                                            fieldLabel: 'Estado',
                                            labelWidth: 150,
                                            id: 'ID_ESTADO_UP',
                                            anchor:'100%',
                                            store: storeCbEstado,
                                            queryMode: 'local',
                                            valueField: 'id',
                                            displayField: 'nombre',
                                            emptyText: 'Seleccione un Estado...',
                                            listeners:{
                                                blur: function(){
                                                    Ext.getCmp('ID_MUNICIPIO_UP').setValue('');
                                                    storeCbMunicipios.proxy.extraParams.idestado = Ext.getCmp('ID_ESTADO_UP').getValue();
                                                    storeCbMunicipios.load();
                                                },
                                                select:function( combo, record, index ){
                                                    Ext.getCmp('ID_ESTADO_UP').selectedRecord = record;
                                                },
                                                specialkey:function ( field, e ){
                                                    if (e.getKey() == e.ENTER) {
                                                        var wtsc = Ext.getCmp('ID_ESTADO_UP');
                                                        var rec = wtsc.selectedRecord;
                                                        if (rec){
                                                            var n = storeCbEstado.find('id',rec.data.id);

                                                            if (n==-1){
                                                                storeCbEstado.insert(0,rec);
                                                            }
                                                        }
                                                    }
                                                } 
                                            }
                                        })),
                                        Ext.create('Ext.form.ComboBox', ({
                                            fieldLabel: 'Municipio',
                                            labelWidth: 150,
                                            id: 'ID_MUNICIPIO_UP',   
                                            anchor:'100%',
                                            store: storeCbMunicipios,
                                            queryMode: 'local',
                                            valueField: 'id',
                                            displayField: 'nombre',
                                            emptyText: 'Seleccione un Municipio...'                                                            
                                        }))                                        
                                    ]
                                }
                            ] //Cierra items form
                        }
                    ] //Cierra items Ext.apply 
                }); //Cierra Ext.apply
            }else{ //Agregar donante Sustituto
            
//                alert("agregar");
            
                loadNombreDonante(idDonantePadre)
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',
                            id: 'pnlAddSustituto',
                            tbar: tbAddSustituto,
                            items:[
                                {
                                    xtype: 'fieldset',
                                    title: 'Datos del Donante', 
                                    height: 210,
                                    items:[                                    
                                        {
                                            xtype: 'displayfield',
                                            id: 'ID_DONANTE_PADRE',
                                            width: 293,                                                                                                                              
                                            labelWidth: 150,
                                            fieldLabel: 'Num. Donante Padre'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            fieldLabel:'Donante Padre',
                                            id:'DONANTE_PADRE',                                           
                                            labelWidth: 150,                                            
                                            size: 30,
                                            readOnly: true,
                                            anchor: '100%'                                           
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Nombre / Razon Social',
                                            id:'RAZON_SOCIAL',
                                            name:'RAZON_SOCIAL',
                                            labelWidth: 150,                                            
                                            size: 30,
                                            anchor: '100%'
//                                            regex: character
//                                            vtype: 'character',
//                                            regex: /^[a-zA-Z\s&_0-9]+$/
//                                            regexText:'Incorrect Text use: XXXX 999999-9'
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'R.F.C.',
                                            id:'RFC',
                                            name:'RFC',
                                            labelWidth: 150,                                            
                                            size: 30                                         
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'CURP.',
                                            id:'CURP',
                                            name:'CURP',
                                            labelWidth: 150,                                            
                                            size: 30
                                        },
                                        {
                                            xtype: 'numberfield',
                                            fieldLabel: 'Telefono',
                                            id:'TELEFONO', 
                                            labelWidth: 150,
                                            hideTrigger: true,                                           
                                            size: 30
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Email',
                                            id:'EMAIL',
                                            name:'EMAIL',
                                            labelWidth: 150,                                            
                                            size: 30
                                        }
                                    ] //Cierra items fieldset
                                },
                                {
                                    xtype: 'fieldset',
                                    title: 'Domicilio Fiscal', 
                                    height: 200,
                                    items:[
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Calle',
                                            id:'CALLE',
                                            name:'CALLE',
                                            labelWidth: 150,                                            
                                            size: 30,
                                            anchor: '100%'
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel: 'Numero',
                                            id:'NUMERO', 
                                            labelWidth: 150,
                                            hideTrigger: true,                                           
                                            size: 10
                                        },
                                        {
                                            xtype: 'textfield',
                                            fieldLabel:'Colonia',
                                            id:'COLONIA',
                                            name:'COLONIA',
                                            labelWidth: 150,                                            
                                            size: 30
                                        },
                                        {
                                            xtype: 'numberfield',
                                            fieldLabel: 'CP.',
                                            id:'CP', 
                                            labelWidth: 150,
                                            hideTrigger: true,                                           
                                            size: 10
                                        },
                                        Ext.create('Ext.form.ComboBox', ({
                                            fieldLabel: 'Estado',
                                            labelWidth: 150,
                                            id: 'ID_ESTADO',
                                            anchor:'100%',
                                            store: storeCbEstado,
                                            queryMode: 'local',
                                            valueField: 'id',
                                            displayField: 'nombre',
                                            emptyText: 'Seleccione un Estado...',
                                            listeners:{
                                                blur: function(){
                                                    Ext.getCmp('ID_MUNICIPIO').setValue('');
                                                    storeCbMunicipios.proxy.extraParams.idestado = Ext.getCmp('ID_ESTADO').getValue();
                                                    storeCbMunicipios.load();
                                                },
                                                select:function( combo, record, index ){
                                                    Ext.getCmp('ID_ESTADO').selectedRecord = record;
                                                },
                                                specialkey:function ( field, e ){
                                                    if (e.getKey() == e.ENTER) {
                                                        var wtsc = Ext.getCmp('ID_ESTADO');
                                                        var rec = wtsc.selectedRecord;
                                                        if (rec){
                                                            var n = storeCbEstado.find('id',rec.data.id);

                                                            if (n==-1){
                                                                storeCbEstado.insert(0,rec);
                                                            }
                                                        }
                                                    }
                                                } 
                                            }
                                        })),
                                        Ext.create('Ext.form.ComboBox', ({
                                            fieldLabel: 'Municipio',
                                            labelWidth: 150,
                                            id: 'ID_MUNICIPIO',   
                                            anchor:'100%',
                                            store: storeCbMunicipios,
                                            queryMode: 'local',
                                            valueField: 'id',
                                            displayField: 'nombre',
                                            emptyText: 'Seleccione un Municipio...'                                                            
                                        }))                                        
                                    ]
                                }
                            ] //Cierra items form
                        }
                    ] //Cierra items Ext.apply 
                }); //Cierra Ext.apply
            }
            
            donantes.addSustituto.superclass.initComponent.apply(this, arguments);
            storeCbEstado.load();
            storeCbMunicipios.load();
            }, //Cierra initComponent            
            getDatas:function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                var camposName=['ID_DONANTE_PADRE',
                                'RAZON_SOCIAL',
                                'RFC',
                                'CURP',
                                'TELEFONO',
                                'EMAIL',
                                'CALLE',
                                'NUMERO',
                                'COLONIA',
                                'CP',
                                'ID_ESTADO',
                                'ID_MUNICIPIO'                               
                            ]

                var camposValue = {'ID_DONANTE_PADRE':0,
                                'RAZON_SOCIAL':'',
                                'RFC':'',
                                'CURP':'',
                                'TELEFONO':'',
                                'EMAIL':'',
                                'CALLE':'',
                                'NUMERO':'',
                                'COLONIA':'',
                                'CP':0,
                                'ID_ESTADO':0,
                                'ID_MUNICIPIO':0                               
                            };

                var pos=0;
                var value='';
                
                for(pos=0;pos<camposName.length;pos++){ 
                    value = Ext.getCmp(camposName[pos]).getValue();                           
                    camposValue[camposName[pos]] = value;                                                                                                                     
                }
                return Ext.encode(camposValue);
            },
            getDatasUpdate:function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                var camposName=['ID_DONANTE_UP',
                                'RAZON_SOCIAL_UP',
                                'RFC_UP',
                                'CURP_UP',
                                'TELEFONO_UP',
                                'EMAIL_UP',
                                'CALLE_UP',
                                'NUMERO_UP',
                                'COLONIA_UP',
                                'CP_UP',
                                'ID_ESTADO_UP',
                                'ID_MUNICIPIO_UP'                               
                            ]

                var camposValue = {'ID_DONANTE_UP':0,
                                'RAZON_SOCIAL_UP':'',
                                'RFC_UP':'',
                                'CURP_UP':'',
                                'TELEFONO_UP':'',
                                'EMAIL_UP':'',
                                'CALLE_UP':'',
                                'NUMERO_UP':'',
                                'COLONIA_UP':'',
                                'CP_UP':0,
                                'ID_ESTADO_UP':0,
                                'ID_MUNICIPIO_UP':0                               
                            };

                var pos=0;
                var value='';
                
                for(pos=0;pos<camposName.length;pos++){ 
                    value = Ext.getCmp(camposName[pos]).getValue();                           
                    camposValue[camposName[pos]] = value;                                                                                                                     
                }
                return Ext.encode(camposValue);
            }
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </table>
</body>
</html>