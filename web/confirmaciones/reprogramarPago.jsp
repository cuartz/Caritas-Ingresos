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
            /************************** Variables Globales ********************************/
            var idBitacora          = 0;
            var fechaPago           = '';
            var fechaCobro          = '';
            var winReprogramar      = '';
            var idUsuarioTmp    = '<%=idusersession%>';
            var idUsuarioSplit  = idUsuarioTmp.split(":");
            var idUsuario       = idUsuarioSplit[0];
            
            /************* Model para combos ************************/
            Ext.define('catalog',{
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('direccionesMdl',{
                id:'direccionesMdl',
                extend: 'Ext.data.Model',
                fields: ['id','nombre']
            });
            
            /************* Store Combo Opciones de Confirmacion **************************/
            var storeOpcionesConfirmacion = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_OPCIONES_CONFIRMACION'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });      
            
            /********************* FUNCIONES **************************/
            function loadInfoReprogramar(ID_BITACORA){
                storeInfoReprogramar.proxy.extraParams.ID_BITACORA = ID_BITACORA;
                storeInfoReprogramar.load({ callback: function(records,o,s){
                        if(records.length > 0){
                            Ext.getCmp('dfFechaCobro').setValue(records[0].data.FECHA_COBRO);
                            Ext.getCmp('dfFechaVisita').setValue(records[0].data.FECHA_VISITA);
                            
                        }
                    } 
                });
            }
            
            function validaDatosReprogramacion(){
                if(Ext.getCmp("NUEVA_FECHA_VISITA_PR").getValue() == null){ //Validar la fecha de visita
                    Ext.MessageBox.alert('Error','!Ingresa una fecha de visita!');                   
                    return false
                }
                
                if(Ext.getCmp("ID_DIRECCION_PR").getValue() == null){ //Validar la fecha de visita
                    Ext.MessageBox.alert('Error','!Selecciona una dirección para ir a cobrar!');                   
                    return false
                }
                
                if(Ext.getCmp("ID_RECOLECTOR_PR").getValue() == null){ //Validar la fecha de visita
                    Ext.MessageBox.alert('Error','!Selecciona un recolector!');                   
                    return false
                }
                
                if(Ext.getCmp("COMENTARIOS_REPROGRAMAR_PR").getValue() == null || Ext.getCmp("COMENTARIOS_REPROGRAMAR_PR").getValue() == ""){ //Validar la fecha de visita
                    Ext.MessageBox.alert('Error','!Ingresa un comentario!');                   
                    return false
                }                                
            }
            
            Ext.define('reprogramarInf',{
                    id:'reprogramarInf',
                    extend: 'Ext.data.Model',
                    fields: [
                        'FECHA_COBRO',
                        'FECHA_PAGO',
                        'FECHA_VISITA',                       
                    ]
                });
            
            var storeInfoReprogramar = Ext.create('Ext.data.JsonStore', {
                    model: 'reprogramarInf',
                    pageSize: 50,
                    id:'storeInfoReprogramar',
                    name:'storeInfoReprogramar',
                    proxy: {
                        type: 'ajax',
                        url: 'reprogramarPagoAC.do',
                        extraParams: {method: 'getFechas'},
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
                
            
            
            //Inicia
            //Creation Screen            
            Ext.define('confirmaciones.reprogramarPago', {
                extend: 'Ext.window.Window',                
                alias:'widget.reprogramarPago',               
                title: 'Reprogramar Pago',
                width: 400,                
                height: 290,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'destroy',
                region:'center',
                modal: true,
                initComponent: function() {
                    //Inicializar las variables
                    winReprogramar = this;                   
                    idBitacora = this.name;                     
                    loadInfoReprogramar(idBitacora);
                    
                    var cbxDirecciones = Ext.create('Ext.data.JsonStore', {
                        model: 'direccionesMdl',
                        proxy: {
                            type: 'ajax',
                            url: 'comboboxAC.do?method=getDireccionesDonante',
                            extraParams:{ID_BITACORA:idBitacora},
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
                                id: 'frmReprogramarPago',
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
                                                    var json = winReprogramar.getDatas(); 
                                                    if(validaDatosReprogramacion() != false ){
                                                        Ext.Msg.confirm('Reprogramar Pago', '¿Los datos son correctos?', function(btn, text){ 
                                                            if (btn == 'yes'){
                                                                Ext.getCmp('frmReprogramarPago').getForm().submit({                                                            
                                                                url: 'reprogramarPagoAC.do?method=updateFechaPago&jsonData='+json+'&idBitacora='+idBitacora+'&idUsuario='+idUsuario,                                                           
                                                                waitMsg: 'Guardando...',
                                                                success: function(form, action) {
                                                                    Ext.getCmp('gridPagosReprogramados').getStore().load();
                                                                    winReprogramar.close();
                                                                    Ext.MessageBox.alert('Guardado','¡La información se actualizó correctamente!');                                                                 
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
                                                text:'Salir',
                                                iconCls:'icon-salir',
                                                handler: function(){
                                                    winReprogramar.close();
                                                }
                                            })
                                        ] //Cierra items toolbar
                                }], //Cierra dockedItems
                                items: [
                                    {
                                        xtype: 'displayfield',
                                        width: 203,                                       
                                        id: 'dfFechaCobro',
                                        labelWidth: 130,
                                        fieldLabel: 'Fecha de Cobro'
                                    },
                                    {
                                        xtype: 'displayfield',
                                        width: 293,                                        
                                        id: 'dfFechaVisita',
                                        labelWidth: 130,
                                        fieldLabel: 'Fecha de Visita'
                                    },                                    
                                    {
                                        xtype: 'datefield',
                                        id:'NUEVA_FECHA_VISITA_PR',                                       
                                        format: 'd/m/Y',
                                        width: 350,
                                        labelWidth: 130,
                                        fieldLabel: 'Nueva Fecha de Visita'
                                    },
//                                    {
//                                        xtype: 'combo',
//                                        fieldLabel: 'Recoger en',
//                                        id: 'ID_DIRECCION_PR',
//                                        size: 30,
//                                        labelWidth: 130,
//                                        store:cbxDirecciones,
//                                        displayField: 'nombre',
//                                        valueField: 'id'                                        
//                                    },
//                                    Ext.create('Ext.form.ComboBox', {
//                                        fieldLabel: 'Recolector',
//                                        name:'ID_RECOLECTOR',
//                                        id:'ID_RECOLECTOR_PR',
//                                        emptyText:'Seleccione el Recolector',                                                            
//                                        editable:false,
//                                        labelWidth: 130,
//                                        width: 350,                                    
//                                        size: 30,
//                                        store: storeRecolectores,
//                                        queryMode: 'local',
//                                        displayField: 'nombre',
//                                        valueField: 'id'
//                                    }), 
                                    Ext.create('Ext.form.ComboBox', {
                                        fieldLabel: 'Dirección',
                                        name:'ID_DIRECCION_PR',
                                        id:'ID_DIRECCION_PR',
                                        emptyText:'Seleccione una dirección!',
                                        allowBlank:false,
                                        editable:false,                                    
                                        labelWidth: 130,
                                        size: 30,
                                        store: cbxDirecciones,
                                        queryMode: 'local',
                                        displayField: 'nombre',
                                        valueField: 'id',
                                        listeners:{
                                            blur: function(){
                                                Ext.getCmp('ID_RECOLECTOR_PR').setValue('');
                                                storeRecolectoress.proxy.extraParams.ID_DIRECCION = Ext.getCmp('ID_DIRECCION_PR').getValue();
                                                storeRecolectoress.load();
                                            },
                                            select:function( combo, record, index ){
                                                Ext.getCmp('ID_RECOLECTOR_PR').selectedRecord = record;
                                            },
                                            specialkey:function ( field, e ){
                                                if (e.getKey() == e.ENTER) {
                                                    var wtsc = Ext.getCmp('ID_RECOLECTOR_PR');
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
                                        id:'ID_RECOLECTOR_PR',
                                        emptyText:'Seleccione el Recolector',
                                        allowBlank:false,
                                        editable:false,                                    
                                        labelWidth: 130,
                                        size: 30,
                                        store: storeRecolectoress,
                                        queryMode: 'local',
                                        displayField: 'nombre',
                                        valueField: 'id'
                                    }),
                                    {
                                        xtype: 'textareafield',
                                        height: 60,
                                        width: 350,
                                        labelWidth: 130,
                                        fieldLabel: 'Comentarios',
                                        id: 'COMENTARIOS_REPROGRAMAR_PR'
                                    }
                                ] //Cierra items panel
                            } //Cierra grupo items Ext apply
                        ] //Cierra items Ext apply
                    }); //Cierra Ext Apply
                    cbxDirecciones.load();                    
                    confirmaciones.confirmacionPago.superclass.initComponent.apply(this, arguments); 
                }, //Cierra initComponent
                 getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                      var camposName=['NUEVA_FECHA_VISITA_PR',
                                        'ID_DIRECCION_PR',
                                        'ID_RECOLECTOR_PR',                                        
                                        'COMENTARIOS_REPROGRAMAR_PR'                                        
                                    ];
                                    
                        var camposValue = {'NUEVA_FECHA_VISITA_PR':'',
                                            'ID_DIRECCION_PR':0,
                                            'ID_RECOLECTOR_PR':0,                                            
                                            'COMENTARIOS_REPROGRAMAR_PR':''
                                          };          
                        var pos=0;
                        var value = '';                    
                     
                        for(pos=0;pos<camposName.length;pos++){                            
                            value = Ext.getCmp(camposName[pos]).getValue();
                            camposValue[camposName[pos]] = value;                                                                                                                                  
                        }  
                        return Ext.encode(camposValue);
                    } //Cierra getData(); 
            }); //Cierra Ext define

        </script>
    </head>
    <body>
    </body>
</html>
