<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
            /************************ VARIABLES GLOBALES ********************************/        
            var winConfirmCobro;
            var tbarRecibosConfirm;
            var idBitacoraTmpRecibos;
            
                     
            //Inicia
            //Creation Screen            
            Ext.define('tesoreria.confirmacionRecibos', {
                extend: 'Ext.window.Window',
                id:'confirmacionRecibos',
                alias:'widget.confirmacionRecibos',                
                title: 'Confirmacion Recibos',
                width: 450,                
                height: 200,
                border: false,
                buttonAlign: 'left',
                layout: 'fit',
                maximizable: true,
                closeAction : 'close',
                region:'center',
                initComponent: function() {
                     /************************ INICIALIZAR ********************************/ 
                    winConfirmCobro = this;
                    idBitacoraTmpRecibos = this.name;
                    /************************ TOOLBAR ********************************/ 
                    tbarRecibosConfirm = new Ext.Toolbar({
                        items:[                      
                            {
                                xtype: 'button',
                                text: 'Guardar',
                                iconCls:'icon-save',
                                handler: function(){
                                    var json = winConfirmCobro.getDatas();
                                    //alert("guardar: "+json);
                                    Ext.Msg.confirm('Agregar Deposito', '¿Los datos son correctos?', function(btn, text){
                                        if (btn == 'yes'){
                                            Ext.getCmp('frmConfirmCobro').getForm().submit({
                                                url: 'tesoreriaAC.do?method=confirmacionCobro&jsonData='+json+'&idBitacora='+idBitacoraTmp,
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {
                                                    var info = Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                }
                                            });                             
                                        }
                                    }) 
                                }
                            },                        
                            '-',
                            {
                                xtype: 'button',
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function()
                                {                                                
                                    winConfirmCobro.close();
                                }  
                            }                        
                        ]
                    }); //Termina Toolbar
                    
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'form',
                                id: 'frmConfirmRecibo',
                                border: false,                            
                                tbar: tbarRecibosConfirm,
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
                                                xtype: 'checkboxgroup',
                                                width: 427,
                                                fieldLabel: 'Cobrado',
                                                items: [
                                                    {
                                                        xtype: 'checkboxfield',
                                                        id: 'CHKBOX_YES',
                                                        boxLabel: 'Si',
                                                        handler: function(){   
                                                            if(this.checked){ 
                                                                Ext.getCmp('CHKBOX_NO').disable();
                                                                Ext.getCmp('COMENTARIOS').disable();                                                            
                                                            }else{
                                                                Ext.getCmp('CHKBOX_NO').enable();                                                           
                                                            }
                                                        }
                                                    },
                                                    {
                                                        xtype: 'checkboxfield',
                                                        id: 'CHKBOX_NO',
                                                        boxLabel: 'No',
                                                        handler: function(){   
                                                            if(this.checked){ 
                                                                Ext.getCmp('CHKBOX_YES').disable();
                                                                Ext.getCmp('COMENTARIOS').enable();
                                                            }else{
                                                                Ext.getCmp('CHKBOX_YES').enable();
                                                                Ext.getCmp('COMENTARIOS').disable();
                                                            }
                                                        }
                                                    }
                                                ]
                                            }
                                        ] //Cierra items panel 1
                                    },
                                    {
                                        xtype: 'panel',                                    
                                        border: false,
                                        layout: {
                                            type: 'column'
                                        },                                    
                                        items: [
                                            {
                                                xtype: 'textareafield',
                                                id: 'COMENTARIOS',
                                                height: 100,
                                                width: 430,
                                                fieldLabel: 'Motivo',
                                                disabled: true
                                            }
                                        ] //Cierra items panelDos
                                    }
                                ] //Cierra items form
                            }] //Cierra items Ext.apply
                    }); //Cierra ext.apply
                    tesoreria.confirmacionRecibos.superclass.initComponent.apply(this, arguments); 
                }, //Cierra init component
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['CHKBOX_YES',
                                    'CHKBOX_NO',
                                    'COMENTARIOS']

                    var camposValue = {'CHKBOX_YES':0,
                                        'CHKBOX_NO':0,
                                        'COMENTARIOS':''};                           

                    var pos=0;
                    var value = '';             

                    for(pos=0;pos<camposName.length;pos++){
                        if(pos == 0 || pos == 1){
                            value = Ext.getCmp(camposName[pos]).getValue();
                            if(value == true)
                                camposValue[camposName[pos]] = 1;
                            if(value == false)
                                camposValue[camposName[pos]] = 0;
                        }else{
                            value = Ext.getCmp(camposName[pos]).getValue();
                            if(value == '')
                                camposValue[camposName[pos]] = null;
                            else
                                camposValue[camposName[pos]] = value;
                        }                                                                                                              
                    }                                 
                    return Ext.encode(camposValue);
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
