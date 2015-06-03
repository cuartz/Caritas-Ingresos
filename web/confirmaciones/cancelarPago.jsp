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
        /********************* VARIABLES GLOBALES ***********************/
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        
        /*************Data Combo Motivo Cancelacion ****************************************/
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });

        /*************Store Combo Motivo Cancelacion****************************************/
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

        //Variables
        var idBitacora          = 0;
        var precancelado        = 0;
        
        //Creation Screen            
        Ext.define('confirmaciones.cancelarPago', {
            extend: 'Ext.window.Window',                
            alias:'widget.cancelarPago',                
            title: 'Cancelacion de Pago',               
            width: 400,                
            height: 200,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy',
            region:'center',
            modal: true,
            initComponent: function() {
                //Inicializar las variables
                var winCancelar = this;
                idBitacora = this.name;                   
                precancelado = this.nameDos;
                
                if(precancelado == 0){ //Cancelado Directo                    
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'frmCancelarPago',
                                items: [
                                    {
                                        xtype: 'panel',
                                        border:false,
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
                                                            var json = winCancelar.getDatas();
                                                            //alert("Guardar: "+json);
                                                            Ext.Msg.confirm('Cancelar Pago', '¿Los datos son correctos?', function(btn, text){ 
                                                                if (btn == 'yes'){
                                                                    Ext.getCmp('frmCancelarPago').getForm().submit({                                                            
                                                                    url: 'cancelarPagoAC.do?method=cancelarPago&jsonData='+json+'&idBitacora='+idBitacora+'&precancelacion=0&idUsuario='+idUsuario,                                                           
                                                                    waitMsg: 'Guardando...',
                                                                    success: function(form, action) {
                                                                        Ext.MessageBox.alert('Guardado','¡La información se actualizó correctamente!'); 
                                                                        Ext.getCmp('gridBitacora').getStore().load();
                                                                        winCancelar.close();
                                                                    },
                                                                    failure: function(form, action) {
                                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                                    }
                                                                    }); 
                                                                }
                                                            });
                                                        }
                                                    },
                                                    {
                                                        xtype: 'tbseparator'
                                                    },
                                                    Ext.create('Ext.Button',{
                                                        text:'Salir',
                                                        iconCls:'icon-salir',
                                                        handler:function(){
                                                            winCancelar.close();
                                                        }
                                                    })
                                                ]
                                            }]
                                    },
                                    {
                                        xtype: 'panel',
                                        border:false,
                                        items: [
                                            {
                                                xtype: 'displayfield',
                                                width: 390,                            
                                                value: 'Debido a su nivel de permisos, este recibo se cancelará de forma directa sin aprobación.',
                                                labelWidth: 80                            
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
                                                triggerAction: 'all',
                                                emptyText: '¡Seleccione un motivo!',
                                                selectOnFocus: true                                               
                                            }),
                                            {
                                                xtype: 'textareafield',
                                                height: 60,
                                                width: 350,
                                                id: 'COMENTARIOS_CANCELACION',
                                                fieldLabel: 'Descripción'
                                            }]
                                    }] //Cierra panel
                            }] //Cierra items ext apply
                    }); //Cierra Ext apply
                }else{ //Precancelación                
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'frmCancelarPago',
                                items: [
                                    {
                                        xtype: 'panel',
                                        border:false,
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
                                                            var json = winCancelar.getDatas();
                                                            //alert("Guardar: "+json);
                                                            Ext.Msg.confirm('Cancelar Pago', '¿Los datos son correctos?', function(btn, text){ 
                                                                if (btn == 'yes'){
                                                                    Ext.getCmp('frmCancelarPago').getForm().submit({                                                            
                                                                    url: 'cancelarPagoAC.do?method=cancelarPago&jsonData='+json+'&idBitacora='+idBitacora+'&precancelacion=1&idUsuario='+idUsuario,                                                           
                                                                    waitMsg: 'Guardando...',
                                                                    success: function(form, action) {
                                                                        Ext.MessageBox.alert('Guardado','¡La información se actualizó correctamente!'); 
                                                                        Ext.getCmp('gridBitacora').getStore().load();
                                                                        winCancelar.close();
                                                                    },
                                                                    failure: function(form, action) {
                                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                                    }
                                                                    }); 
                                                                }
                                                            });
                                                        }
                                                    },
                                                    {
                                                        xtype: 'tbseparator'
                                                    },
                                                    Ext.create('Ext.Button',{
                                                        text:'Salir',
                                                        iconCls:'icon-salir',
                                                        handler:function(){
                                                            winCancelar.close();
                                                        }
                                                    })
                                                ]
                                            }]
                                    },
                                    {
                                        xtype: 'panel',
                                        border:false,
                                        items: [
                                            {
                                                xtype: 'displayfield',
                                                width: 390,                            
                                                value: 'Esta solicitud de cancelación se enviará a la persona correspondiente para ser aprobada.',
                                                labelWidth: 80                            
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
                                                triggerAction: 'all',
                                                emptyText: '¡Seleccione un motivo!',
                                                selectOnFocus: true                                               
                                            }),
                                            {
                                                xtype: 'textareafield',
                                                height: 60,
                                                width: 350,
                                                id: 'COMENTARIOS_CANCELACION',
                                                fieldLabel: 'Descripción'
                                            }]
                                    }] //Cierra panel
                            }] //Cierra items ext apply
                    }); //Cierra Ext apply
                }
                confirmaciones.confirmacionPago.superclass.initComponent.apply(this, arguments); 
            }, //Cierra init component
            getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['ID_MOTIVO_CANCELACION',
                                    'COMENTARIOS_CANCELACION']

                    var camposValue = {'ID_MOTIVO_CANCELACION':0,
                                        'COMENTARIOS_CANCELACION':''};                                        

                    var pos=0;
                    var value = '';                    

                    for(pos=0;pos<camposName.length;pos++){
                        if(pos == 1){
                            value = Ext.getCmp(camposName[pos]).getValue();                                
                            if(value == ''){
                                camposValue[camposName[pos]] = 'SIN ASIGNAR'; 
                            }else{
                                camposValue[camposName[pos]] = value;
                            }
                        }else{
                            value = Ext.getCmp(camposName[pos]).getValue();
                            camposValue[camposName[pos]] = value;
                        }                                                                                                      
                    }                                 
                    return Ext.encode(camposValue);
                } //Cierra getData(); 
        }); //Cierra Ext
        </script>
    </head>
    <body>
    </body>
</html>
