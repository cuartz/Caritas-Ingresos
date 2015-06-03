<%-- 
    Document   : direccionDonante
    Created on : 10/04/2012, 12:02:42 PM
    Author     : rnunez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">            
        Ext.onReady(function() {  
        /************************* VARIABLES GLOBALES ********************************/
        var person          = 0;
        var ID_DONANTE      = 0;
        var ID_DIRECCION    = 0;

        /************************* MODELS ********************************/
        Ext.define('DireccionUptInfo',{
            id:'DireccionUptInfo',
            extend: 'Ext.data.Model',
            fields: [
                'ID_DIRECCION',
                'ID_PAIS',
                'ID_ESTADO',
                'ID_MUNICIPIO',
                'CALLE',
                'NUMERO',
                'COLONIA',
                'COD_POSTAL',
                'ENTRE_CALLES',                        
                'ID_TIPO_DIRECCION',
                'ID_ZONA',
                'CONTACTO',
                'REFERENCIA',
                'ESTADO',
                'ID_RECOLECTOR'
            ]
        });

        Ext.define('catalog',{// create the Data ZONAS
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });

        Ext.define('catalogTres',{// create the Data ZONAS
            id:'catalogTres',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','nombre2','status']
        });

        Ext.define('catalogDos',{// create the Data TIPO DE DIRECCION
            id:'catalogDos',
            extend: 'Ext.data.Model',
            fields: ['id','nombre','idZona','idTipoRecolector']
        });

        Ext.define('reg_Pais',{// create the Data reg_Pais
            id:'reg_Pais',
            extend: 'Ext.data.Model',
            fields: ['nombre', 'id']
        });

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

        /************************* STORES ********************************/
        var storeDireccionUptInfo = Ext.create('Ext.data.JsonStore', {
            model: 'DireccionUptInfo',
            pageSize: 50,
            id:'storeDireccionUptInfo',
            name:'storeDireccionUptInfo',
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do',
                extraParams: {method: 'getDireccionUptInfo'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var statesZona = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', 
                extraParams:{llave:'INGRESOS_ZONAS'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var storeRecolectores = Ext.create('Ext.data.JsonStore', {
            model: 'catalogDos',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getRecolectores',                      
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var statestipoDireccion = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave',
                extraParams:{llave:'INGRESOS_TIPO_DIRECCION'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var storeCbPais = Ext.create('Ext.data.JsonStore', {
            model: 'reg_Pais',
            pageSize: 50,
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do?method=getPaises',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var storeCbEstado = Ext.create('Ext.data.JsonStore', {
            model: 'reg_Estado',
            pageSize: 50,
            width: 300,
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do?method=getEstados',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var storeCbMunicipios = Ext.create('Ext.data.JsonStore', {
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

        /************************* FUNCIONES JAVASCRIPT ********************************/
        function ajax_loaded_callbackUpt(){
            Ext.MessageBox.hide();
        }

        function loadInfouptd(ID_DIRECCION){         
        storeDireccionUptInfo.proxy.extraParams.ID_DIRECCION = ID_DIRECCION;
        storeDireccionUptInfo.load({ callback: function(records,o,s){
            if(records.length > 0){                
                var ID_PAIS = records[0].data.ID_PAIS;
                var ID_ESTADO = records[0].data.ID_ESTADO;
                var ID_MUNICIPIO = records[0].data.ID_MUNICIPIO;
                var CALLE = records[0].data.CALLE;
                var NUMERO = records[0].data.NUMERO;
                var COLONIA = records[0].data.COLONIA;
                var COD_POSTAL = records[0].data.COD_POSTAL;
                var ENTRE_CALLES = records[0].data.ENTRE_CALLES;
                var ID_TIPO_DIRECCION = records[0].data.ID_TIPO_DIRECCION;
                var ID_ZONA = records[0].data.ID_ZONA;
                var CONTACTO = records[0].data.CONTACTO;
                var REFERENCIA = records[0].data.REFERENCIA;
                var ESTADO = records[0].data.ESTADO;
                var ID_RECOLECTOR = records[0].data.ID_RECOLECTOR;
                
                storeCbPais.load({callback: function(records2,o,s){
                    Ext.getCmp('ID_PAIS').setValue(parseInt(ID_PAIS,10));
                    storeCbEstado.proxy.extraParams.idpais = ID_PAIS;
                    storeCbEstado.load({callback: function(records3,o,s){
                        Ext.getCmp('ID_ESTADO').setValue(parseInt(ID_ESTADO,10));
                        storeCbMunicipios.proxy.extraParams.idestado = ID_ESTADO;
                        storeCbMunicipios.load({callback: function(records4,o,s){
                            Ext.getCmp('ID_MUNICIPIO').setValue(parseInt(ID_MUNICIPIO,10));
                        }});
                    }});
                }});                
                       
                Ext.getCmp('CALLE').setValue(records[0].data.CALLE);
                Ext.getCmp('NUMERO').setValue(records[0].data.NUMERO);
                Ext.getCmp('COLONIA').setValue(records[0].data.COLONIA);
                Ext.getCmp('COD_POSTAL').setValue(records[0].data.COD_POSTAL);
                Ext.getCmp('ENTRE_CALLES').setValue(records[0].data.ENTRE_CALLES);
                statestipoDireccion.load({callback: function(records,o,s){
                    Ext.getCmp('ID_TIPO_DIRECCION').setValue(parseInt(ID_TIPO_DIRECCION,10));
                }});
                statesZona.load({callback: function(records,o,s){
                    Ext.getCmp('ID_ZONA').setValue(parseInt(ID_ZONA,10));
                    storeRecolectores.proxy.extraParams.ID_ZONA = ID_ZONA;
                    storeRecolectores.load({callback: function(records,o,s){
                        Ext.getCmp('ID_RECOLECTOR').setValue(parseInt(ID_RECOLECTOR,10));
                    }});
                }});
                
                Ext.getCmp('CONTACTO').setValue(records[0].data.CONTACTO);
                Ext.getCmp('REFERENCIA').setValue(records[0].data.REFERENCIA);
                if(ESTADO != ""){   //Extranjero
                    Ext.getCmp('ESTADO').setValue(records[0].data.ESTADO);
                }else{ //Mexico
                    Ext.getCmp('ESTADO').disable();
                    Ext.getCmp('ESTADO').setVisible(false)
                }                                    
            }                            
        }                        
        }); //Cierra storeDonativoInfo 
        }                

        function open_win(option){ //FUNCION PARA EL LICK DE PAGINA CODIGO POSTAL
            if(option == 1)
                window.open("http://tucodigo.mx/")
            if(option == 2)
                window.open("http://goo.gl/maps/j3DDz")
        }                

        function cleanDireccionDonante(){ //FUNCION PARA LIMPIAR
            Ext.getCmp('pnldireccionesDonante').getForm().reset();
        }            

        function validateValues(fldName, fldValue){ //FUNCION PARA LA VALIDACION DE CAMPOS REQUERIDOS
            if (fldValue==null || fldValue==''){
                if (errores==''){
                    errores = errores + 'Favor de proporcionar la siguiente información:<br><label style="color:red">-' + fldName + '</label><br>';
                }else{
                    errores = errores + '<label style="color:red">-' + fldName + '</label><br>';
                }
                return true;
            }
        }            

        function valida(){
            var camposName=[
                'ID_TIPO_DIRECCION',
                'CALLE',
                'NUMERO',
                'COLONIA',
                'ID_PAIS',
                'ID_ESTADO',
                'ID_MUNICIPIO',
                'COD_POSTAL',
                'ENTRE_CALLES',
                'REFERENCIA',
                'CONTACTO',
                'ID_ZONA',
                'ID_RECOLECTOR',
                'ESTADO'
            ]
            if(Ext.getCmp(camposName[1]).getValue() == ""){ //Validar el nombre
                Ext.MessageBox.alert('Error','Ingresa la calle');
                return false
            }
            if(Ext.getCmp(camposName[2]).getValue() == ""){ //Validar EL NUMERO DE CASA
                Ext.MessageBox.alert('Error','Ingresa el numero de casa');
                return false
            }

            if(Ext.getCmp(camposName[9]).getValue() == ""){ //Validar LA REFERENCIA
                Ext.MessageBox.alert('Error','Ingresa alguna referencia');
                return false
            }
            if(Ext.getCmp(camposName[10]).getValue() == ""){ //Validar EL CONTACTO
                Ext.MessageBox.alert('Error','Ingresa el contacto');
                return false
            }
            if(Ext.getCmp(camposName[11]).getValue() == ""){ //Validar LA ZONA
                Ext.MessageBox.alert('Error','Ingresa la zona');
                return false
            }
            if(Ext.getCmp(camposName[12]).getValue() == ""){ //Validar LA ZONA
                Ext.MessageBox.alert('Error','Selecciona el Recolector');
                return false
            }
        }

            /************************* INICIA PANTALLA ********************************/            
            Ext.define('donantes.direccionDonante', {
                name: 'Unknown',//varible de otra ventana
                extend: 'Ext.window.Window',
                id:'direccionDonante',
                alias:'widget.direccionDonante',                
                title: 'Direcciones del Donante',
                width: 420,                
                height: 540,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                autoDestroy:true,
                region:'center',
                constrain:true,
                initComponent: function() {
                    /************************* INICIALIZAR VALOREZ ********************************/
                    var windireccionDonante = this;
                    person = this.name;
                    ID_DIRECCION = this.nameDos; //Variable del donante para pasarla al momento de guardar                     
                    
                    if(ID_DIRECCION != undefined){ //Modificar Direccion                         
                        loadInfouptd(ID_DIRECCION);
                    }

                    /************************* TOOLBAR ********************************/
                    var tbarDir = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Guardar - ' + person, // + ' - ' + ID_DIRECCION ,
                                id:'saveDonanteDireccion',
                                iconCls: 'icon-save',
                                handler: function(){
                                    if(valida() != false ){                                            
                                        var json = windireccionDonante.getDatas();
//                                        alert("Actualizar Dirección");
                                        if(ID_DIRECCION != undefined){ //Actualizar
//                                            alert("Modificar: "+json);
                                            Ext.Msg.confirm('Modificar Dirección', '¿Los datos son correctos?', function(btn, text){
                                                if (btn == 'yes'){                                                    
                                                    Ext.getCmp('pnldireccionesDonante').getForm().submit({//Guardar Actualizar Direccion 
                                                        url: 'donanteAC.do?method=actualizardirecciondonante&jsonData='+json+'&idUsuario='+idUsuario+'&ID_DONANTE='+person + '&ID_DIRECCION='+ ID_DIRECCION, //Despues de pasarle el json con los datos, y el usuario validado por secion se le envia el person que es el ID_Donante traido desde los datos a guardar        //                                                    
                                                        waitMsg: 'Guardando...',
                                                        success: function(form, action) {
                                                            Ext.Msg.alert('Guardado','Se grabo la información correctamente');
                                                            Ext.getCmp('gridDirecciones').getStore().load();
                                                            storedireccionDonantes.load();
                                                            windireccionDonante.destroy();
                                                        },
                                                        failure: function(form, action) {
                                                            Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información Validar Informacion!');
                                                        }
                                                    });
                                                }
                                            })
                                        }else{ //Insertar
//                                            alert("Insertar nueva: "+json);
                                            Ext.Msg.confirm('Agregar Dirección', '¿Los datos son correctos?', function(btn, text){
                                                if (btn == 'yes'){
                                                    Ext.getCmp('pnldireccionesDonante').getForm().submit({
                                                        url: 'donanteAC.do?method=savedirecciondonante&jsonData='+json+'&idUsuario='+idUsuario+'&ID_DONANTE='+person, //Despues de pasarle el json con los datos, y el usuario validado por secion se le envia el person que es el ID_Donante traido desde los datos a guardar        //                                                    
                                                        waitMsg: 'Guardando...',
                                                        success: function(form, action) {
                                                            Ext.Msg.alert('Guardado','Se grabo la información correctamente');
                                                            Ext.getCmp('gridDirecciones').getStore().load();
                                                            storedireccionDonantes.load();
                                                            windireccionDonante.destroy();
                                                        },
                                                        failure: function(form, action) {
                                                            Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información Validar Informacion!');
                                                        }
                                                    });
                                                }
                                            })
                                        }                                           
                                    }
                                }
                            }),
                            '-',                      
                            new Ext.Button({
                                text:'Limpiar',
                                iconCls: 'icon-clear',
                                handler: function(){
                                    cleanDireccionDonante();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Salir',
                                iconCls: 'icon-salir',
                                handler: function(){                                        
                                    Ext.getCmp('gridDirecciones').getStore().load();
                                    storedireccionDonantes.load();
                                    windireccionDonante.destroy();
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Busqueda C.P.',
                                iconCls: 'icon-web-mail-icon',
                                handler: function(){
                                    open_win(1);
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Mapa',
                                iconCls: 'icon-web-mail-icon',
                                handler: function(){
                                    open_win(2);
                                }
                            })

                        ]
                    }); //Termina Toolbar direcciones

                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'pnldireccionesDonante',
                                border: false,
                                tbar: tbarDir,
                                items: [
                                    {
                                        xtype: 'container',
                                        margin: '8',
                                        items:[
                                            {
                                                layout:'anchor',
                                                columnWidth:.5,
                                                border:false,
                                                margin:'2 2 2 2',
                                                items:[Ext.create('Ext.form.ComboBox', ({
                                                        fieldLabel: 'Pais',
                                                        labelWidth:100,
                                                        id: 'ID_PAIS',
                                                        name: 'ID_PAIS',
                                                        anchor:'100%',
                                                        store: storeCbPais,
                                                        valueField: 'id',
                                                        displayField: 'nombre',
                                                        queryMode: 'local',
                                                        valueNotFoundText:'No se guardo con algun valor',//En caso de que no encuentre el valor
                                                        triggerAction: 'all',
                                                        emptyText: 'Seleccione un Pais...',
                                                        listeners:{
                                                            blur: function(){
                                                                Ext.getCmp('ID_ESTADO').setValue('');
                                                                Ext.getCmp('ID_MUNICIPIO').setValue('');
                                                                storeCbEstado.proxy.extraParams.idpais = Ext.getCmp('ID_PAIS').getValue();
                                                                storeCbEstado.load();                                                                                
                                                            }
                                                            ,
                                                            select:function( combo, record, index ){
                                                                if(this.getValue()!=196){
                                                                    Ext.getCmp('ID_ESTADO').disable();
                                                                    Ext.getCmp('ID_MUNICIPIO').disable();
                                                                    Ext.getCmp('ID_ESTADO').setVisible(false);
                                                                    Ext.getCmp('ID_MUNICIPIO').setVisible(false);

                                                                    Ext.getCmp('COLONIA').disable();
                                                                    Ext.getCmp('COLONIA').setVisible(false);

                                                                    Ext.getCmp('ESTADO').enable();
                                                                    Ext.getCmp('ESTADO').setVisible(true);

                                                                }else{

                                                                    Ext.getCmp('ID_ESTADO').enable();
                                                                    Ext.getCmp('ID_MUNICIPIO').enable();
                                                                    Ext.getCmp('ID_ESTADO').setVisible(true);
                                                                    Ext.getCmp('ID_MUNICIPIO').setVisible(true);

                                                                    Ext.getCmp('COLONIA').enable();
                                                                    Ext.getCmp('COLONIA').setVisible(true);
                                                                    Ext.getCmp('ESTADO').disable();
                                                                    Ext.getCmp('ESTADO').setVisible(false);

                                                                }
                                                                Ext.getCmp('ID_PAIS').selectedRecord = record;
                                                            }
                                                            ,
                                                            specialkey:function ( field, e ){//Funcion para obtener el valor de mexico por default
                                                                if (e.getKey() == e.ENTER) {
                                                                    var wtsc = Ext.getCmp('ID_PAIS');
                                                                    var rec = wtsc.selectedRecord;
                                                                    if (rec){
                                                                        var n = storeCbPais.find('id',rec.data.id);

                                                                        if (n==-1){
                                                                            storeCbPais.insert(0,rec);
                                                                        }
                                                                    }
                                                                }
                                                            } 

                                                        }

                                                    }))]
                                            },
                                            {
                                                layout:'anchor',
                                                columnWidth:.5,
                                                border:false,
                                                margin:'2 2 2 2',
                                                items:[Ext.create('Ext.form.ComboBox', ({
                                                        fieldLabel: 'Estado',
                                                        labelWidth:100,
                                                        id: 'ID_ESTADO',
                                                        name: 'ID_ESTADO',
                                                        bodyStyle: 'padding:5px;',
                                                        anchor:'100%',
                                                        store: storeCbEstado,
                                                        valueField: 'id',
                                                        displayField: 'nombre',
                                                        queryMode: 'local',
                                                        valueNotFoundText:'No se guardo con algun valor',//En caso de que no encuentre el valor
                                                        triggerAction: 'all',
                                                        emptyText: 'Seleccione un Estado...',
                                                        listeners:{
                                                            blur: function(){
                                                                Ext.getCmp('ID_MUNICIPIO').setValue('');
                                                                storeCbMunicipios.proxy.extraParams.idestado = Ext.getCmp('ID_ESTADO').getValue();
                                                                storeCbMunicipios.load();
                                                            }
                                                            ,
                                                            select:function( combo, record, index ){
                                                                Ext.getCmp('ID_ESTADO').selectedRecord = record;
                                                            }
                                                            ,
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
                                                    }))]
                                            },
                                            {
                                                layout:'anchor',
                                                columnWidth:.5,
                                                margin:'2 2 2 2',
                                                border:false,
                                                items:[Ext.create('Ext.form.ComboBox', ({
                                                        fieldLabel: 'Municipio',
                                                        labelWidth:100,
                                                        id: 'ID_MUNICIPIO',
                                                        name: 'ID_MUNICIPIO',
                                                        bodyStyle: 'padding:5px;',
                                                        anchor:'100%',
                                                        store: storeCbMunicipios,
                                                        valueField: 'id',
                                                        displayField: 'nombre',
                                                        queryMode: 'local',
                                                        valueNotFoundText:'No se guardo con algun valor',//En caso de que no encuentre el valor
                                                        triggerAction: 'all',
                                                        emptyText: 'Seleccione un Municipio...'                                                            
                                                    }))]
                                            },
                                            {
                                                xtype: 'textfield',
                                                id:'ESTADO',
                                                fieldLabel: 'Estado',  
                                                emptyText: 'Estado',
                                                maxLengthText:'Es el Limite de Datos',
                                                maxLength:100,
                                                enforceMaxLength:true,
                                                size: 30
                                            },
                                            {
                                                xtype: 'textfield',
                                                id:'CALLE',
                                                fieldLabel: 'Calle',  
                                                emptyText: 'Calle del Donante',
                                                allowBlank:false,
                                                maxLengthText:'Es el Limite de Datos',
                                                maxLength:100,
                                                enforceMaxLength:true,
                                                size: 30
                                            },
                                            {
                                                xtype: 'textfield', 
                                                fieldLabel: 'No',
                                                id:'NUMERO',
                                                emptyText: '# de Casa',
                                                allowBlank:false,
                                                hideTrigger: true,
                                                maxLengthText:'Es el Limite de Datos',
                                                maxLength:18,
                                                enforceMaxLength:true,
                                                size: 10
                                            },
                                            {
                                                xtype: 'textfield',                                           
                                                fieldLabel: 'Colonia',
                                                id:'COLONIA',
                                                emptyText: 'Colonia del Donante',
                                                allowBlank:false,
                                                maxLengthText:'Es el Limite de Datos',
                                                maxLength:100,
                                                enforceMaxLength:true,
                                                size: 30
                                            },
                                            {
                                                xtype: 'numberfield',                                           
                                                fieldLabel: 'C.P',
                                                id:'COD_POSTAL',
                                                emptyText: 'Codigo Postal',
                                                hideTrigger: true,
                                                size: 10
                                            },
                                            {
                                                xtype: 'textfield',                                           
                                                fieldLabel: 'Entre calles', 
                                                id:'ENTRE_CALLES',
                                                emptyText: 'Entre Calles',
                                                size: 30
                                            },
                                            Ext.create('Ext.form.ComboBox', {
                                                fieldLabel: 'Tipo Direccion',
                                                name:'ID_TIPO_DIRECCION',
                                                id:'ID_TIPO_DIRECCION',
                                                emptyText:'Seleccione el tipo de Direccion...',
                                                allowBlank:false,
                                                editable:false,
                                                anchor: '900%',
                                                labelWidth: 100,
                                                size: 30,
                                                store: statestipoDireccion,
                                                queryMode: 'local',
                                                displayField: 'nombre',
                                                maxLengthText:'Es el Limite de Datos',
                                                maxLength:18,
                                                enforceMaxLength:true,
                                                valueField: 'id',
                                                listeners:{
                                                    select:function(boton,event){ 
                                                        if(this.getValue() == 2387){ //Principal
                                                            Ext.getCmp('DIRECCION_PRINCIPAL').disable();
                                                            Ext.getCmp('DIRECCION_FISCAL').enable(); 
                                                            Ext.getCmp('DIRECCION_ENTREGA_COBRO').enable();
                                                        }else if(this.getValue() == 2389){ //Entrega/Cobro
                                                            Ext.getCmp('DIRECCION_ENTREGA_COBRO').disable();
                                                            Ext.getCmp('DIRECCION_PRINCIPAL').enable();
                                                            Ext.getCmp('DIRECCION_FISCAL').enable(); 
                                                        }else if(this.getValue() == 2388){ //Fiscal
                                                            Ext.getCmp('DIRECCION_FISCAL').disable();
                                                            Ext.getCmp('DIRECCION_ENTREGA_COBRO').enable();
                                                            Ext.getCmp('DIRECCION_PRINCIPAL').enable();                                                             
                                                        }
                                                    }
                                                }
                                            }),
                                            Ext.create('Ext.form.ComboBox', {
                                                fieldLabel: 'Tipo Zona',
                                                name:'ID_ZONA',
                                                id:'ID_ZONA',
                                                emptyText:'Seleccione el tipo de zona...',
                                                allowBlank:false,
                                                editable:false,
                                                anchor: '900%',
                                                labelWidth: 100,
                                                size: 30,
                                                store: statesZona,
                                                queryMode: 'local',
                                                displayField: 'nombre',
                                                valueField: 'id',
                                                listeners:{
                                                    blur: function(){
                                                        Ext.getCmp('ID_RECOLECTOR').setValue('');
                                                        storeRecolectores.proxy.extraParams.ID_ZONA = Ext.getCmp('ID_ZONA').getValue();
                                                        storeRecolectores.load();
                                                    },
                                                    select:function( combo, record, index ){
                                                        Ext.getCmp('ID_ZONA').selectedRecord = record;
                                                    },
                                                    specialkey:function ( field, e ){
                                                        if (e.getKey() == e.ENTER) {
                                                            var wtsc = Ext.getCmp('ID_ZONA');
                                                            var rec = wtsc.selectedRecord;
                                                            if (rec){
                                                                var n = statesZona.find('id',rec.data.id);

                                                                if (n==-1){
                                                                    statesZona.insert(0,rec);
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }),
                                            Ext.create('Ext.form.ComboBox', {
                                                fieldLabel: 'Recolector',
                                                name:'ID_RECOLECTOR',
                                                id:'ID_RECOLECTOR',
                                                emptyText:'Seleccione el Recolector',
                                                allowBlank:false,
                                                editable:false,
                                                anchor: '900%',
                                                labelWidth: 100,
                                                size: 30,
                                                store: storeRecolectores,
                                                queryMode: 'local',
                                                displayField: 'nombre',
                                                valueField: 'id'
                                            }),
                                            {
                                                xtype: 'textfield',                                           
                                                fieldLabel: 'Contacto', 
                                                id:'CONTACTO',
                                                emptyText: 'Preguntar por',
                                                allowBlank:false,
                                                maxLengthText:'Es el Limite de Datos',
                                                maxLength:50,
                                                enforceMaxLength:true,
                                                size: 30
                                            },
                                            {
                                                xtype: 'textarea',
                                                fieldLabel: 'Referencia',
                                                id:'REFERENCIA',
                                                emptyText: 'Puntos Claves de la Direccion',
                                                allowBlank:false,
                                                maxLengthText:'Es el Limite de Datos',
                                                width: 330,                                                                    
                                                height: 60                                                                                                                                                                                                       
                                            },
                                            {
                                                xtype: 'checkbox',
                                                fieldLabel: 'Principal',
                                                id: 'DIRECCION_PRINCIPAL'
                                            },
                                            {
                                                xtype: 'checkbox',
                                                fieldLabel: 'Dirección Fiscal',
                                                id: 'DIRECCION_FISCAL'
                                            },
                                            {
                                                xtype: 'checkbox',
                                                fieldLabel: 'Entrega/Cobro',
                                                id: 'DIRECCION_ENTREGA_COBRO'
                                            }
                                        ]
                                    } //Cierra 1er grupo de items de panel principal
                                ] //Cierra items de panel principal
                            } //Cierra 1er grupo de items de ventana
                        ] //Cierra items de ventana
                    })//Cierra Ext.apply
                    donantes.direccionDonante.superclass.initComponent.apply(this, arguments); 
                    storeCbPais.load();
                    storeCbEstado.load();
                    storeCbMunicipios.load();
                    storeRecolectores.load();
                    statestipoDireccion.load();
                    statesZona.load();
                },//Cierra initcomponent
                getDatas:function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['ID_TIPO_DIRECCION',
                        'CALLE',
                        'NUMERO',
                        'COLONIA',
                        'ID_PAIS',
                        'ID_ESTADO',
                        'ID_MUNICIPIO',
                        'COD_POSTAL',
                        'ENTRE_CALLES',
                        'REFERENCIA',
                        'CONTACTO',
                        'ID_ZONA',
                        'ID_RECOLECTOR',
                        'ESTADO',
                        'DIRECCION_PRINCIPAL',
                        'DIRECCION_FISCAL',
                        'DIRECCION_ENTREGA_COBRO'
                    ]

                    var camposValue = {'ID_TIPO_DIRECCION':0,
                        'CALLE':'',
                        'NUMERO':'',
                        'COLONIA':'',
                        'ID_PAIS':0,
                        'ID_ESTADO':0,
                        'ID_MUNICIPIO':0,
                        'COD_POSTAL':0,
                        'ENTRE_CALLES':'',
                        'REFERENCIA':'',
                        'CONTACTO':'',
                        'ID_ZONA':0,
                        'ID_RECOLECTOR':0,
                        'ESTADO':'',
                        'DIRECCION_PRINCIPAL':'',
                        'DIRECCION_FISCAL':'',
                        'DIRECCION_ENTREGA_COBRO':''
                    };

                    var pos=0;
                    var value='';
                    
                    // 0 - ID_TIPO_DIRECCION 
                    //                            'ID_TIPO_DIRECCION',//0
                    //                            'CALLE',//1
                    //                            'NUMERO',//2
                    //                            'COLONIA',//3
                    //                            'ID_PAIS',//4
                    //                            'ID_ESTADO',//5
                    //                            'ID_MUNICIPIO',//6
                    //                            'COD_POSTAL',//7
                    //                            'ENTRE_CALLES',//8
                    //                            'REFERENCIA',//9
                    //                            'CONTACTO',//10
                    //                            'ID_ZONA',//11
                    //                            'ID_RECOLECTOR',//12
                    //                            'ESTADO'//13
                    //                            'DIRECCION_PRINCIPAL'//14
                    //                            'DIRECCION_FISCAL'//15
                    //                            'DIRECCION_ENTREGA_COBRO'//16

                    for(pos=0;pos<camposName.length;pos++){   
                        if(pos == 5){
                            value = Ext.getCmp(camposName[5]).getValue();
                            if(value == '')
                                camposValue[camposName[5]] = 0; 
                            else
                                camposValue[camposName[5]] = value  
                        }else if(pos == 6){ // Motivo Cancelacion
                            value = Ext.getCmp(camposName[6]).getValue();
                            if(value == '')
                                camposValue[camposName[6]] = 0; 
                            else
                                camposValue[camposName[6]] = value
                        }else if(pos == 13){ //Estado
                            value = Ext.getCmp(camposName[13]).getValue();
                            if(value == '')
                                camposValue[camposName[13]] = null; 
                            else
                                camposValue[camposName[13]] = value
                        }else if(pos == 14){
                            value = Ext.getCmp(camposName[14]).getValue();
                            if(value == true)
                                camposValue[camposName[14]] = 1; 
                            if(value == false)
                                camposValue[camposName[14]] = 0
                        }else if(pos == 15){
                            value = Ext.getCmp(camposName[15]).getValue();
                            if(value == true)
                                camposValue[camposName[15]] = 1; 
                            if(value == false)
                                camposValue[camposName[15]] = 0                                                
                        }else if(pos == 16){
                            value = Ext.getCmp(camposName[16]).getValue();
                            if(value == true)
                                camposValue[camposName[16]] = 1; 
                            if(value == false)
                                camposValue[camposName[16]] = 0                                                
                        }else{
                            value = Ext.getCmp(camposName[pos]).getValue();                           
                            camposValue[camposName[pos]] = value;   
                        }                                                                                                                                                                
                    }                                 
                    return Ext.encode(camposValue);
                }
            });            
        });
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
