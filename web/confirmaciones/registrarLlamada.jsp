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
        /************* USUARIO *********************/    
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0]
         
         /************* VARIABLES GLOBALES *********************/
         var winAddCall;
         var idBitacoraAddCall;
         /************* FUNCIONES JAVASCRIPT *********************/
         function validaAddCall(){             
            //alert(Ext.getCmp('COMENTARIOS_ADDCALL').getValue());              
            if(Ext.getCmp('CALL_CHKBOX_NO').getValue() == true && Ext.getCmp('CALL_CHKBOX_YES').getValue() == true){
                Ext.MessageBox.alert('Error','¡Selecciona solo una opción [SI, NO]!');
                return false
            }
            
            if(Ext.getCmp('CALL_CHKBOX_NO').getValue() == false && Ext.getCmp('CALL_CHKBOX_YES').getValue() == false){
                Ext.MessageBox.alert('Error','¡Selecciona una opción [SI, NO]!');
                return false
            }
            
            if(Ext.getCmp('COMENTARIOS_ADDCALL').getValue() == null | Ext.getCmp('COMENTARIOS_ADDCALL').getValue() == ''){
                Ext.MessageBox.alert('Error','¡Ingresa algun comentario!');
                return false
            }
            
        }
         
         Ext.define('confirmaciones.registrarLlamada', {
            extend: 'Ext.window.Window',                   
            alias:'widget.registrarLlamada',                
            title: 'Registrar Llamada',
            constrain : true,
            width: 420,                
            height: 220,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy', 
            region:'center',
            modal: true,
            initComponent: function() {
                winAddCall =  this;
                idBitacoraAddCall =  this.name;
                
                /************* TOLLBAR *********************/
                var tbarRegistrarLlamadas = new Ext.Toolbar({ // toolbar Dos
                    items: [                        
                        {
                            xtype: 'button',
                            text: 'Guardar',
                            iconCls:'icon-save',
                            handler: function(){                                                                                                       
                                var json = winAddCall.getDatas(); 
//                                alert("guardar: "+json);
//                                alert("bitacora: "+idBitacoraAddCall);
                                if(validaAddCall() != false){
                                    Ext.Msg.confirm('Registrar Llamada', '¿Los datos son correctos?', function(btn, text){ 
                                        if (btn == 'yes'){
                                            Ext.getCmp('frmAddCall').getForm().submit({                                                            
                                                url: 'listaConfirmacionAC.do?method=addCall&jsonData='+json+'&idBitacora='+idBitacoraAddCall+'&idUsuario='+idUsuario,                                                           
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {
                                                    Ext.getCmp('gridDonativosConfirmacion').getStore().load();
                                                    winAddCall.close();
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
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                                            
                                winAddCall.close();
                            }
                        })
                    ]
                }); //termina toolbar dos
                
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',
                            id: 'frmAddCall', 
                            tbar: tbarRegistrarLlamadas,
                            items: [
                                {
                                    xtype: 'displayfield',
                                    width: 427,                            
                                    value: 'La fecha, hora y usuario se guardarán automaticamente.',
                                    labelWidth: 100                            
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    width: 427,
                                    labelWidth: 100,
                                    fieldLabel: '¿Contestó?',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            id: 'CALL_CHKBOX_NO',
                                            boxLabel: 'No'                                            
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            id: 'CALL_CHKBOX_YES',
                                            boxLabel: 'Si'                                            
                                        }
                                    ]
                                },                                
                                {
                                    xtype: 'textarea',
                                    id:'COMENTARIOS_ADDCALL',
                                    labelWidth: 100,
                                    fieldLabel: 'Comentarios',                                                                                                                                         
                                    width: 380,                                                                    
                                    height: 90 
                                }                                
                            ] //Cierra items form
                        }
                    ] //Cierra items ext.apply
                }); //Cierre Ext.apply
                confirmaciones.registrarLlamada.superclass.initComponent.apply(this, arguments);                    
            }, //Cierre initComponent
            getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                var camposName=['CALL_CHKBOX_NO',
                    'CALL_CHKBOX_YES',
                    'COMENTARIOS_ADDCALL']

                var camposValue = {'CALL_CHKBOX_NO':0,
                    'CALL_CHKBOX_YES':0,
                    'COMENTARIOS_ADDCALL':''
                };                                        

                var pos=0;
                var value = '';                    

                for(pos=0;pos<camposName.length;pos++){
                    if(pos == 0 || pos == 1){
                        value = Ext.getCmp(camposName[pos]).getValue();                                
                        if(value == true){
                            camposValue[camposName[pos]] = 1; 
                        }if(value == false){
                            camposValue[camposName[pos]] = 0; 
                        }
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