<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
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
<html>
    <head>       
        <script type="text/javascript">
        //Variables            
        var idBitacoraConfirmacion;
        var winConfirmPago;
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];  

        //Busqueda de Caso en Donativos
        Ext.define('beneficiario',{// create the Data beneficiario
            id:'beneficiario',
            extend: 'Ext.data.Model',
            fields: ['ID_DONANTE_TMP','RAZON_SOCIAL']
        });

        var comboSearchSustituto = Ext.create('Ext.data.JsonStore', {// create the Store beneficiario
            model: 'beneficiario',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getSearchSustituto',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var comboSearchSustitutoTPL = new Ext.XTemplate(
        '<tpl for="."><div  class="search-item">',
        '<h5 style="color: #0000cc;">{id}</h5>{name} {funcion}<br>',
        '</div>',
        '</tpl>'
    );  

        /*************COMBO Unidad****************************************/
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });

        Ext.define('direccionesMdl',{
            id:'direccionesMdl',
            extend: 'Ext.data.Model',
            fields: ['id','nombre', 'idZona']
        });
        Ext.define('Sustituto',{
            id:'Sustituto',
            extend: 'Ext.data.Model',
            fields: ['ID_DONANTE_TMP','RAZON_SOCIAL']
        });
        Ext.define('infoFacturacion',{
            id:'infoFacturacion',
            extend: 'Ext.data.Model',
            fields: ['DONANTE_FACTURA']
        });
        Ext.define('infoDireccion',{
            id:'infoDireccion',
            extend: 'Ext.data.Model',
            fields: ['ID_DIRECCION','ID_ESTADO']
        });
        
        Ext.define('recolectores',{// create the Data TIPO DE DIRECCION
            id:'recolectores',
            extend: 'Ext.data.Model',
            fields: ['id','nombre','idZona','idTipoRecolector']
        });

        // The data store containing the list of states
        var cbxFormaEnvio = Ext.create('Ext.data.JsonStore', {
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
        
        var storeInfoFacturacion = Ext.create('Ext.data.JsonStore', {
            model: 'infoFacturacion',
            pageSize: 50,
            id:'storeInfoFacturacion',
            name:'storeInfoFacturacion',
            proxy: {
                type: 'ajax',
                url: 'confirmacionPagoAC.do',
                extraParams: {method: 'getInfoFacturacion'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeInfoDireccion = Ext.create('Ext.data.JsonStore', {
            model: 'infoDireccion',
            pageSize: 50,
            id:'storeInfoDireccion',
            name:'storeInfoDireccion',
            proxy: {
                type: 'ajax',
                url: 'confirmacionPagoAC.do',
                extraParams: {method: 'getInfoDireccion'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeRecolectoress = Ext.create('Ext.data.JsonStore', {
            model: 'recolectores',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getRecolectoresByIdDireccion',                      
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var cbxDirecciones = Ext.create('Ext.data.JsonStore', {
            model: 'direccionesMdl',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getDireccionesDonante',
                extraParams:{ID_BITACORA:idBitacoraConfirmacion},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        /******************** FUNCIONES ************************/
        function validaConfirmacion(){
            var camposName=['FECHA_VISITA',
                'FACTURA_ELECTRONICA',
                'ID_FORMA_ENVIO',
                'COMENTARIOS',
                'ID_DIRECCION'
            ]

            if(Ext.getCmp(camposName[0]).getValue() == null){ //Validar la fecha de visita
                Ext.MessageBox.alert('Error','¡Selecciona la fecha de visita!');
                return false
            }
            if(Ext.getCmp(camposName[1]).getValue() == 1 && Ext.getCmp(camposName[2]).getValue() == null){ //Validar la forma de envio
                Ext.MessageBox.alert('Error','¡Selecciona una forma de envio!');
                return false
            }
            if(Ext.getCmp(camposName[3]).getValue() == ""){ //Validar la Descripcion
                Ext.MessageBox.alert('Error','¡Ingresa algun comentario!');
                return false
            }
            if(Ext.getCmp(camposName[4]).getValue() == null){ //Validar la Direccion de Cobro
                Ext.MessageBox.alert('Error','¡Selecciona una dirección para cobrar el donativo!');
                return false
            }
        }
        
        function loadInfoFacturacion(idBitacora){            
            storeInfoFacturacion.proxy.extraParams.ID_BITACORA = idBitacora;                
            storeInfoFacturacion.load({ callback: function(records,o,s){                        
                    if(records.length > 0){
                        var resultado = records[0].data.DONANTE_FACTURA;
                        if(resultado == 1){                            
                            Ext.getCmp('FACTURA_ELECTRONICA').setValue(true);
                            cbxFormaEnvio.load({callback: function(records,o,s){
                                Ext.getCmp('ID_FORMA_ENVIO').setValue(parseInt(2700,10));
                            }});
                            Ext.getCmp('FACTURA_ELECTRONICA').disable();
                            Ext.getCmp('ID_FORMA_ENVIO').disable();
                        }else{                            
                            Ext.getCmp('FACTURA_ELECTRONICA').enable();
                            Ext.getCmp('ID_FORMA_ENVIO').enable();
                            Ext.getCmp('FACTURA_ELECTRONICA').setValue(false);
                            Ext.getCmp('frmConfirmacionPago').reset();  
                        }                           
                    }
                }
            });
            cbxDirecciones.proxy.extraParams.ID_BITACORA = idBitacora;
            cbxDirecciones.load({callback: function(records,o,s){                
            }});
        }
        
        function loadInfoDireccion(idBitacora){            
            storeInfoDireccion.proxy.extraParams.ID_BITACORA = idBitacora;
            storeInfoDireccion.load({ callback: function(records,o,s){                        
                    if(records.length > 0){
                        var resultado = records[0].data.ID_ESTADO;
                        var ID_DIRECCIONN = records = records[0].data.ID_DIRECCION;                        
                        if(resultado != 175){ //Es fuera de NL                           
                            cbxDirecciones.load({callback: function(records,o,s){
                                Ext.getCmp('ID_DIRECCION').setValue(parseInt(ID_DIRECCIONN,10));
                            }});
                            Ext.getCmp('ID_DIRECCION').disable();
                            storeRecolectoress.load({callback: function(records,o,s){
                                Ext.getCmp('ID_RECOLECTOR_CPP').setValue(parseInt(13,10));
                            }});
                            Ext.getCmp('ID_RECOLECTOR_CPP').disable();
                        }else{ //Es dentro de NL                                                        
                            Ext.getCmp('ID_DIRECCION').enable();                            
                            Ext.getCmp('ID_RECOLECTOR_CPP').enable();                            
                        }                           
                    }
                }
            });
        }

        //Creation Screen            
        Ext.define('confirmaciones.confirmacionPago', {
            extend: 'Ext.window.Window',                   
            alias:'widget.confirmacionPago',                
            title: 'Asignar Fecha de Visita',
            constrain : true,
            width: 480,                
            height: 315,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy', 
            region:'center',
            modal: true,
            initComponent: function() {
                //Inicializar Variables
                winConfirmPago = this;
                idBitacoraConfirmacion = this.name; 
                loadInfoFacturacion(idBitacoraConfirmacion);
                loadInfoDireccion(idBitacoraConfirmacion);

                var cbxSustituto = Ext.create('Ext.data.JsonStore', {
                    model: 'Sustituto',
                    proxy: {
                        type: 'ajax',
                        url: 'comboboxAC.do?method=getSearchSustituto',
                        extraParams:{ID_BITACORA:idBitacoraConfirmacion},
                        reader: {
                            type: 'json',
                            root: 'rows'
                        }
                    }
                });                    

                Ext.apply(this, {
                    items: [
                        {   
                            xtype: 'form',
                            id: 'frmConfirmacionPago',                                
                            items: [
                                {                            
                                    xtype: 'datefield',
                                    format: 'd/m/y',
                                    fieldLabel: 'Fecha Visita',
                                    id: 'FECHA_VISITA',
                                    size: 30
                                },
                                {
                                    xtype: 'checkboxfield', 
                                    fieldLabel: 'Factura Elect.', 
                                    id: 'FACTURA_ELECTRONICA',
                                    handler: function(){
                                        if(this.checked){
                                            Ext.getCmp('ID_FORMA_ENVIO').enable();
                                        }else{
                                            Ext.getCmp('ID_FORMA_ENVIO').disable();
                                        }
                                    }
                                },                                    
                                {
                                    xtype: 'combo',
                                    fieldLabel: 'Forma de Envio',
                                    id: 'ID_FORMA_ENVIO',
                                    size: 30,
                                    store:cbxFormaEnvio,
                                    displayField: 'nombre',
                                    valueField: 'id',
                                    disabled: true
                                },
                                {
                                    xtype: 'textarea',
                                    id:'COMENTARIOS',
                                    fieldLabel: 'Comentarios',
                                    allowBlank: false,                                                                                                      
                                    width: 380,                                                                    
                                    height: 90 
                                },
//                                {
//                                    xtype: 'combo',
//                                    fieldLabel: 'Recoger en',
//                                    id: 'ID_DIRECCION',
//                                    size: 40,
//                                    store: cbxDirecciones,
//                                    displayField: 'nombre',
//                                    valueField: 'id'
//                                    //disabled: true
//                                },
//                                Ext.create('Ext.form.ComboBox', {
//                                    fieldLabel: 'Recolector',
//                                    name:'ID_RECOLECTOR',
//                                    id:'ID_RECOLECTOR_CPP',
//                                    emptyText:'Seleccione el Recolector',                                                            
//                                    editable:false,
//                                    width: 400,                                    
//                                    size: 30,
//                                    store: storeRecolectores,
//                                    queryMode: 'local',
//                                    displayField: 'nombre',
//                                    valueField: 'id'
//                                }),
                                Ext.create('Ext.form.ComboBox', {
                                    fieldLabel: 'Dirección',
                                    name:'ID_DIRECCION',
                                    id:'ID_DIRECCION',
                                    emptyText:'Seleccione una dirección!',                                    
                                    labelWidth: 100,
                                    size: 40,
                                    store: cbxDirecciones,
                                    queryMode: 'local',
                                    displayField: 'nombre',
                                    valueField: 'id',
                                    listeners:{
                                        blur: function(){
                                            Ext.getCmp('ID_RECOLECTOR_CPP').setValue('');
                                            storeRecolectoress.proxy.extraParams.ID_DIRECCION = Ext.getCmp('ID_DIRECCION').getValue();
                                            storeRecolectoress.load();
                                        },
                                        select:function( combo, record, index ){
                                            Ext.getCmp('ID_RECOLECTOR_CPP').selectedRecord = record;
                                        },
                                        specialkey:function ( field, e ){
                                            if (e.getKey() == e.ENTER) {
                                                var wtsc = Ext.getCmp('ID_RECOLECTOR_CPP');
                                                var rec = wtsc.selectedRecord;
                                                if (rec){
                                                    var n = storeRecolectoress.find('id',rec.data.id);

                                                    if (n==-1){
                                                        storeRecolectoress.insert(0,rec);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }),
                                Ext.create('Ext.form.ComboBox', {
                                    fieldLabel: 'Recolector',
                                    name:'ID_RECOLECTOR',
                                    id:'ID_RECOLECTOR_CPP',
                                    emptyText:'Seleccione el Recolector',                                                                      
                                    labelWidth: 100,
                                    size: 40,
                                    store: storeRecolectoress,
                                    queryMode: 'local',
                                    displayField: 'nombre',
                                    valueField: 'id'
                                })
//                                {
//                                    xtype: 'checkboxfield', 
//                                    fieldLabel: 'Sustituto', 
//                                    id: 'SUSTITUTO',
//                                    disabled:true,
//                                    handler: function(){
//                                        if(this.checked){
//                                            Ext.getCmp('ID_SUSTITUTO').enable();                                                
//                                        }else{
//                                            Ext.getCmp('ID_SUSTITUTO').disable();
//                                            Ext.getCmp('ID_SUSTITUTO').reset();
//                                        }
//                                    }
//                                },
//                                {
//                                    xtype: 'combo',
//                                    fieldLabel: 'Seleccionar',
//                                    id: 'ID_SUSTITUTO',
//                                    size: 40,
//                                    store:cbxSustituto,
//                                    displayField: 'RAZON_SOCIAL',
//                                    valueField: 'ID_DONANTE_TMP',
//                                    disabled: true
//                                }                                    
//                                    
                            ],
                            dockedItems: [
                                {
                                    xtype: 'toolbar',
                                    dock: 'top',
                                    items: [
                                        {
                                            xtype: 'button',
                                            text: 'Guardar',
                                            iconCls:'icon-save',
                                            handler: function(){                                                                                                       
                                                var json = winConfirmPago.getDatas(); 
//                                                alert("guardar: "+json);
                                                //alert("bitacora: "+idBitacoraConfirmacion);
                                                if(validaConfirmacion() != false){
                                                    Ext.Msg.confirm('Confirmar Pago', '¿Los datos son correctos?', function(btn, text){ 
                                                        if (btn == 'yes'){
                                                            Ext.getCmp('frmConfirmacionPago').getForm().submit({                                                            
                                                                url: 'confirmacionPagoAC.do?method=updateBitacora&jsonData='+json+'&idBitacora='+idBitacoraConfirmacion+'&idUsuario='+idUsuario,                                                           
                                                                waitMsg: 'Guardando...',
                                                                success: function(form, action) {
                                                                    Ext.getCmp('gridDonativosConfirmacion').getStore().load();
                                                                    winConfirmPago.close();
                                                                    Ext.MessageBox.alert('Guardado','¡Se grabo la información correctamente!');    
                                                                },
                                                                failure: function(form, action) {
                                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                                }
                                                            }); 
                                                        }
                                                    }); 
                                                }

                                            }
                                        },
                                        {
                                            xtype: 'tbseparator'
                                        },
                                        Ext.create('Ext.Button',{
                                            text: 'Salir',
                                            iconCls: 'icon-salir',
                                            handler: function(){
                                                winConfirmPago.close();
                                            }
                                        }) //Cierra boton cancelar
                                    ] //Cierra items toolbar
                                }//Cierra grupo items panel principal
                            ] //Cierra items de panel principal
                        } //Cierra grupo items Ext.apply
                    ] //Cierra items Ext.apply
                }); //Cierra Ext.apply
                cbxDirecciones.load();
//                storeRecolectoress.load();
                confirmaciones.confirmacionPago.superclass.initComponent.apply(this, arguments);                    
            }, //Cierra init component
            getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                var camposName=['FECHA_VISITA',
                    'FACTURA_ELECTRONICA',
                    'ID_FORMA_ENVIO',
                    'COMENTARIOS',
                    'ID_RECOLECTOR_CPP',
                    'ID_DIRECCION']

                var camposValue = {'FECHA_VISITA':'',
                    'FACTURA_ELECTRONICA':0,
                    'ID_FORMA_ENVIO':0,
                    'COMENTARIOS':'',
                    'ID_RECOLECTOR_CPP':0,
                    'ID_DIRECCION':0
                };                                        

                var pos=0;
                var value = '';                    

                for(pos=0;pos<camposName.length;pos++){
                    if(pos == 1){
                        value = Ext.getCmp(camposName[pos]).getValue();                                
                        if(value == true){
                            camposValue[camposName[pos]] = 1; 
                        }if(value == false){
                            camposValue[camposName[pos]] = 0; 
                        }
                    }else if(pos == 2){
                        value = Ext.getCmp(camposName[pos]).getValue();
                        if(value != null)
                            camposValue[camposName[pos]] = value;
                        else
                            camposValue[camposName[pos]] = 0;
                    }else if(pos == 5){
                        value = Ext.getCmp(camposName[pos]).getValue();
                        if(value != null)
                            camposValue[camposName[pos]] = value;
                        else
                            camposValue[camposName[pos]] = 0;
                    }else{
                        value = Ext.getCmp(camposName[pos]).getValue();
                        camposValue[camposName[pos]] = value;
                    }                                                                                                      
                }                                 
                return Ext.encode(camposValue);
            } //Cierra getData();     
        }); //Cierra Ext.define

        </script>
    </head>
    <body>
    </body>
</html>
