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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
        /********************* VARIABLES GLOBALES ***********************/
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        var winCancelarDonativo;
        var idDonativoCD;
        var precancelado;
        
        /********************** MODELS ****************************/
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        })
        
        /********************** FUNCIONES JAVASCRIPT ****************************/
        function vCancelaDonativo(){
            if(Ext.getCmp("MOTIVO_CANCELACION").getValue() == ""){
                Ext.MessageBox.alert('Error','!Ingresa el motivo de la cancelación!');                   
                return false
            }
        }
        
        /********************** STORES ****************************/
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
        
        /********************** INICIA PANTALLA ****************************/
        Ext.define('donantes.cancelarDonativo', {
                extend: 'Ext.window.Window',                    
                alias:'widget.cancelarDonativo',                   
                title: 'Cancelar Donativo',
                constrain : true,
                model: true,
                width: 430,                
                height: 220,
                border: false,
                buttonAlign: 'left',
                closeAction:'close',
                autoDestroy:true,
                maximizable: true,
                layout: 'fit',                    
                region:'center',
                modal: true,
                initComponent: function() {                
                /*************** INICIALIZAR VALORES*******************/
                idDonativoCD = this.name;
                winCancelarDonativo = this;
                precancelado        = this.nameDos;                
                    
                var tbarCancelarD = new Ext.Toolbar({ 
                    items: [
                        new Ext.Button({
                            text: 'Guardar',
                            iconCls: 'icon-save',
                            handler: function(){                                                                   
                                var json = winCancelarDonativo.getDatas();;
                                if(vCancelaDonativo() != false ){
                                    Ext.Msg.confirm('Cancelar Donativo', '¿Los datos son correctos?', function(btn, text){
                                        if (btn == 'yes'){
                                            //Donativo
                                            Ext.getCmp('mainFormCancelar').getForm().submit({
                                                url: 'donativoAC.do?method=cancelarDonativo&jsonData='+json+'&idDonativo='+idDonativoCD+'&idUsuario='+idUsuario+'&precancelacion='+precancelado,
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {
                                                    if(precancelado == 1){
                                                        Ext.MessageBox.alert('Éxito','La solicitud de cancelación se ha enviado correctamente');
                                                    }else{
                                                        Ext.MessageBox.alert('Éxito','El donativo se canceló correctamente');
                                                    }                                                    
                                                    Ext.getCmp('gridDonativos').getStore().load();
                                                    winCancelarDonativo.destroy();
                                                    
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al cancelar el donativo!');                                                    
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
                            iconCls: 'icon-salir',
                            handler: function(){                                   
                                winCancelarDonativo.destroy();                            
                            }   
                        })
                    ]
                }); //termina toolbar uno
                
                if(precancelado == 0){ //Cancelado Directo
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'mainFormCancelar',
                                tbar: tbarCancelarD,
                                items:[
                                    {
                                        xtype: 'displayfield',
                                        width: 390,                            
                                        value: 'Debido a su nivel de permisos, este donativo se cancelará de forma directa sin aprobación.',
                                        labelWidth: 80                            
                                    },
                                    Ext.create('Ext.form.ComboBox',{
                                        fieldLabel: 'Motivo',
                                        store: storesMotivoCancelacion,                                               
                                        id: 'ID_MOTIVO_CANCELACION_DONATIVO',
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
                                        xtype: 'textarea',
                                        id:'MOTIVO_CANCELACION',
                                        fieldLabel: 'Comentarios',
                                        labelWidth: 100,
                                        width: 400,
                                        height: 80                                                                                                                                                                           
                                    }
                                ] //Cierra items form principal
                            }
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                }else{ //Cancelado por autorización
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'mainFormCancelar',
                                tbar: tbarCancelarD,
                                items:[
                                    {
                                        xtype: 'displayfield',
                                        width: 390,                            
                                        value: 'Esta solicitud de cancelación se enviará a la persona correspondiente para ser aprobada.',
                                        labelWidth: 80                            
                                    },
                                    Ext.create('Ext.form.ComboBox',{
                                        fieldLabel: 'Motivo',
                                        store: storesMotivoCancelacion,                                               
                                        id: 'ID_MOTIVO_CANCELACION_DONATIVO',
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
                                        xtype: 'textarea',
                                        id:'MOTIVO_CANCELACION',
                                        fieldLabel: 'Comentarios',
                                        labelWidth: 100,
                                        width: 400,
                                        height: 80                                                                                                                                                                           
                                    }
                                ] //Cierra items form principal
                            }
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                } //Cierra if de condicion    
                donantes.cancelarDonativo.superclass.initComponent.apply(this, arguments); 
                }, //Cierra initComponent
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['MOTIVO_CANCELACION', 'ID_MOTIVO_CANCELACION_DONATIVO']

                    var camposValue = {'MOTIVO_CANCELACION':'',
                                'ID_MOTIVO_CANCELACION_DONATIVO':0};                           

                    var pos=0;
                    var value = '';             
//                       
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
    </body>
</html>
