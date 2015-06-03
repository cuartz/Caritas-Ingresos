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
        /************************ VARIABLES GLOBALES ********************************/        
        var winConfirmCobro;
        var tbarConfirm;
        var idBitacoraTmp;        
        var fechaaa = new Date();
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        var coment = 'RECIBO REPROGRAMADO Y EN RUTA';
        var option = -1;
        
        /************************ FUNCIONES ********************************/
        function cleanRegConfirmCobro(){
            Ext.getCmp('frmConfirmCobro').getForm().reset();
            Ext.getCmp('CHKBOX_NO').enable(); 
            Ext.getCmp('CHKBOX_YES').enable();
            Ext.getCmp('MOTIVO_NO_COBRADO').enable();                
        }
        
        function validaDatosIngresosEfectivo(){              
            if(option == 1){ //reenviar dia siguiente
                if(Ext.getCmp('ID_DIRECCION_CCC').getValue() == null){
                    Ext.MessageBox.alert('Error','¡Seleciona una dirección!');
                    return false
                }
                if(Ext.getCmp('ID_RECOLECTOR_CCC').getValue() == null || Ext.getCmp('ID_RECOLECTOR_CCC').getValue() == "" || Ext.getCmp('ID_RECOLECTOR_CCC').getValue() == ''){
                    Ext.MessageBox.alert('Error','¡Seleciona un recolector!');
                    return false
                }
                if(Ext.getCmp('FECHA_REPROGRAMACION_CC').getValue() == null || Ext.getCmp('FECHA_REPROGRAMACION_CC').getValue() == "" || Ext.getCmp('FECHA_REPROGRAMACION_CC').getValue() == ''){
                    Ext.MessageBox.alert('Error','¡Selecciona una fecha!');
                    return false
                }
                if(Ext.getCmp('COMENTARIOS').getValue() == null || Ext.getCmp('COMENTARIOS').getValue() == "" || Ext.getCmp('COMENTARIOS').getValue() == ''){
                    Ext.MessageBox.alert('Error','¡Ingresa un comentario!');
                    return false
                }
            }
            if(option == 0){ //reenviar despues                
                if(Ext.getCmp('COMENTARIOS').getValue() == null || Ext.getCmp('COMENTARIOS').getValue() == "" || Ext.getCmp('COMENTARIOS').getValue() == ''){
                    Ext.MessageBox.alert('Error','¡Ingresa un comentario!');
                    return false
                }
            }            
        }
        
        function loadInfoReciboRep(idBitacora){
            cbxDirecciones.proxy.extraParams.ID_BITACORA = idBitacora;
            cbxDirecciones.load();
                        
            storeInfoRecibo.proxy.extraParams.ID_BITACORA = idBitacora;                
            storeInfoRecibo.load({ callback: function(records,o,s){                        
                    if(records.length > 0){
                        var ID_DIRECCION_COBRO    = records[0].data.ID_DIRECCION_COBRO;
                        var ID_RECOLECTOR         = records[0].data.ID_RECOLECTOR;                        
                        cbxDirecciones.load({callback: function(records,o,s){
                            Ext.getCmp('ID_DIRECCION_CCC').setValue(parseInt(ID_DIRECCION_COBRO,10));
                        }});
                        storeRecolectores.load({callback: function(records,o,s){
                            Ext.getCmp('ID_RECOLECTOR_CCC').setValue(parseInt(ID_RECOLECTOR,10));
                        }});
                    }
                }
            });
            
            var dt = new Date();                
            var month = dt.getMonth()+1;
            var day = dt.getDate();
            dt.setDate(day)
            var year = dt.getFullYear();                                
            fechaaa = dt;
            
        }
        
        Ext.define('direccionesMdl',{
            id:'direccionesMdl',
            extend: 'Ext.data.Model',
            fields: ['id','nombre']
        });
        
        Ext.define('infoReciboMdl',{
            id:'infoReciboMdl',
            extend: 'Ext.data.Model',
            fields: [                       
                'ID_DIRECCION_COBRO',
                'ID_RECOLECTOR'
            ]
        });
        
        Ext.define('recolectores',{// create the Data TIPO DE DIRECCION
            id:'recolectores',
            extend: 'Ext.data.Model',
            fields: ['id','nombre','idZona','idTipoRecolector']
        });
        
        var storeRecolectores = Ext.create('Ext.data.JsonStore', {
            model: 'recolectores',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getAllRecolectores',                      
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeInfoRecibo = Ext.create('Ext.data.JsonStore', {
            model: 'infoReciboMdl',
            pageSize: 50,
            id:'storeInfoRecibo',
            name:'storeInfoRecibo',
            proxy: {
                type: 'ajax',
                url: 'tesoreriaAC.do',
                extraParams: {method: 'reprogramacionLoadInfo'},
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
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        }); 
                     
        /************************ INICIA PANTALLA ********************************/         
        Ext.define('tesoreria.confirmacionCobro', {
            extend: 'Ext.window.Window',           
            alias:'widget.confirmacionCobro',                
            title: 'Reprogramación',
            width: 450,                
            height: 250,
            border: false,
            buttonAlign: 'left',
            layout: 'fit',
            maximizable: true,
            closeAction : 'close',
            region:'center',
            initComponent: function() {
                /************************ INICIALIZAR ********************************/ 
                winConfirmCobro = this;
                idBitacoraTmp = this.name; 
                option = this.nameDos
                fecha();
                loadInfoReciboRep(idBitacoraTmp);
                
                /************************ TOOLBAR ********************************/                
                tbarConfirm = new Ext.Toolbar({
                    items:[                      
                        {
                            xtype: 'button',
                            text: 'Guardar',
                            iconCls:'icon-save',
                            handler: function(){
                                if(option == 1){ //Reenviar dia siguiente                                    
                                var json = winConfirmCobro.getDatas1();
//                                    alert("Guardar: "+json);
                                    if(validaDatosIngresosEfectivo() != false){                                                                             
                                        Ext.Msg.confirm('Confirmar Cobro', '¿Los datos son correctos?', function(btn, text){
                                            if (btn == 'yes'){
                                                Ext.getCmp('frmConfirmCobro').getForm().submit({
                                                    url: 'tesoreriaAC.do?method=confirmacionCobro&jsonData='+json+'&idBitacora='+idBitacoraTmp+'&idUsuario='+idUsuario+'&opttion='+1,
                                                    waitMsg: 'Guardando...',
                                                    success: function(form, action) {
                                                        Ext.getCmp('gridCobrosEfectivo').getStore().load();                                                    
                                                        winConfirmCobro.destroy();
                                                        Ext.MessageBox.alert('Guardado','Se grabo la información correctamente'); 
                                                    },
                                                    failure: function(form, action) {
                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                    }
                                                });                             
                                            }
                                        })
                                    }
                                }else{ //reenviar despues
                                    var json = winConfirmCobro.getDatas2();                                    
                                    if(validaDatosIngresosEfectivo() != false){                                        
                                        Ext.Msg.confirm('Confirmar Cobro', '¿Los datos son correctos?', function(btn, text){
                                            if (btn == 'yes'){
                                                Ext.getCmp('frmConfirmCobro').getForm().submit({
                                                    url: 'tesoreriaAC.do?method=confirmacionCobro&jsonData='+json+'&idBitacora='+idBitacoraTmp+'&idUsuario='+idUsuario+'&opttion='+0,
                                                    waitMsg: 'Guardando...',
                                                    success: function(form, action) {
                                                        Ext.getCmp('gridCobrosEfectivo').getStore().load();                                                    
                                                        winConfirmCobro.destroy();
                                                        Ext.MessageBox.alert('Guardado','Se grabo la información correctamente'); 
                                                    },
                                                    failure: function(form, action) {
                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                    }
                                                });                             
                                            }
                                        })
                                    }                                    
                                }
                            }
                        },                        
                        '-',
                        {
                            xtype: 'button',
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){
                                winConfirmCobro.destroy();
                            }  
                        }                        
                    ]
                }); //Termina Toolbar
                
                
                if(option == 1){ //Reenviar dia siguiente
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'frmConfirmCobro',
                                border: false,                            
                                tbar: tbarConfirm,
                                layout: {
                                    type: 'anchor'
                                },
                                
                                items: [
                                    {
                                        xtype: 'panel',                                   
                                        region: 'center',
                                        border: false,
                                        items: [                                            
                                            {
                                                xtype: 'combo',
                                                fieldLabel: 'Recoger en',
                                                id: 'ID_DIRECCION_CCC',
                                                size: 40,
                                                labelWidth: 130,
                                                store:cbxDirecciones,
                                                displayField: 'nombre',
                                                valueField: 'id'                                        
                                            },
                                            Ext.create('Ext.form.ComboBox', {
                                                fieldLabel: 'Recolector',
                                                name:'ID_RECOLECTOR',
                                                id:'ID_RECOLECTOR_CCC',
                                                emptyText:'Seleccione el Recolector',                                                            
                                                editable:false,
                                                labelWidth: 130,
                                                                                    
                                                size: 40,
                                                store: storeRecolectores,
                                                queryMode: 'local',
                                                displayField: 'nombre',
                                                valueField: 'id'
                                            })
                                        ] //Cierra items panel 1
                                    },
                                    {
                                        xtype: 'datefield', 
                                        id:'FECHA_REPROGRAMACION_CC',
                                        labelWidth: 130,
                                        fieldLabel: 'Nueva Fecha Visita',
                                        format: 'd/m/Y',
                                        value: fechaaa
                                    },
                                    {
                                        xtype: 'textareafield',
                                        id: 'COMENTARIOS',
                                        labelWidth: 130,
                                        height: 100,
                                        width: 430,
                                        fieldLabel: 'Motivo',
                                        value: coment
                                    }
                                ] //Cierra items form                        
                            }
                        ] //Cierra items ext.apply
                    }); //Cierra Ext.apply
                }else{ //Reenviar despues
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'frmConfirmCobro',
                                border: false,                            
                                tbar: tbarConfirm,
                                layout: {
                                    type: 'anchor'
                                },
                                items: [                                                                        
                                    {
                                        xtype: 'textareafield',
                                        id: 'COMENTARIOS',
                                        labelWidth: 70,
                                        height: 170,
                                        width: 430,
                                        fieldLabel: 'Motivo'                                        
                                    }
                                ] //Cierra items form                        
                            }
                        ] //Cierra items ext.apply
                    }); //Cierra Ext.apply
                }
                
                
                
                storeRecolectores.load();
                tesoreria.confirmacionCobro.superclass.initComponent.apply(this, arguments); 
            }, //Cierra initComponent
            getDatas1: function (){
                var camposName=['FECHA_REPROGRAMACION_CC',
                                'ID_DIRECCION_CCC',
                                'ID_RECOLECTOR_CCC',
                                'COMENTARIOS']

                var camposValue = {'FECHA_REPROGRAMACION_CC':'',
                                    'ID_DIRECCION_CCC':0,
                                    'ID_RECOLECTOR_CCC':0,
                                    'COMENTARIOS':''};

                var pos=0;
                var value = '';             

                for(pos=0;pos<camposName.length;pos++){                    
                    value = Ext.getCmp(camposName[pos]).getValue();
                    if(value == '')
                        camposValue[camposName[pos]] = null;
                    else
                        camposValue[camposName[pos]] = value;                                                                                                                                  
                }                                 
                return Ext.encode(camposValue);
            },
            getDatas2: function (){
                var camposName=['COMENTARIOS']
                var camposValue = {'COMENTARIOS':''};

                var pos=0;
                var value = '';             

                for(pos=0;pos<camposName.length;pos++){                    
                    value = Ext.getCmp(camposName[pos]).getValue();
                    if(value == '')
                        camposValue[camposName[pos]] = null;
                    else
                        camposValue[camposName[pos]] = value;                                                                                                                                  
                }                                 
                return Ext.encode(camposValue);
            }
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>
