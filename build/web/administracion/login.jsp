<%--
    Document   : Login
    Created on : 08/03/2012, 14:14:12 pm
    Author     : Ozamora
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%
    //obteniendo el usuario

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
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">

            var errores = '';
            var idUsuarioTmp = '<%=idusersession%>';
            var idUsuarioSplit = idUsuarioTmp.split(":");
            var idUsuario = idUsuarioSplit[0];
            
                     
            //Inicia
            //Creation Screen            
            Ext.define('administracion.login', {
                extend: 'Ext.window.Window',
                id:'login',
                alias:'widget.login',                
                title: 'Login',
                width: 300,
                height: 140,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                modal:true,
                region:'center',
                initComponent: function() {
                    Ext.apply(this, {
                        items: [{
                                xtype:'form',
                                title:'',
                                frame:true,
                                border:false,
                                items:[
                                    {
                                        xtype: 'textfield',
                                        name: 'idUsuario',
                                        id: 'idUsuario',
                                        fieldLabel: 'Usuario',
                                        allowBlank:false,
                                        value: ''
                                    },{
                                        xtype: 'textfield',
                                        name: 'password',
                                        id: 'password',
                                        allowBlank:false,
                                        inputType: 'password',
                                        fieldLabel: 'Password',
                                        value: ''
                                    }],
                                buttons: [{
                                        text:'Ok',
                                        handler: function(){
                                            if(Ext.getCmp('nidusuario').getValue()!=''&&Ext.getCmp('nnombreusuario').getValue()!=''&&Ext.getCmp('nemail').getValue()!=''&&Ext.getCmp('npassword').getValue()!=''&&Ext.getCmp('nprofile').getValue()!=''){
                                                Ext.Ajax.request({  
                                                    //                                                    url : 'adminusers.do' ,
                                                    params : { 
                                                        //                                                        addUser : '', 
                                                        id_user:Ext.getCmp('idUsuario').getValue(),
                                                        password: Ext.getCmp('password').getValue()
                                                      
                                                    },
                                                    method: 'GET',
                                                    success: function ( result, request ) {

                                                    },
                                                    failure: function ( result, request) {

                                                    }
                                                });
                                            }
                                        }
                                    },{
                                        text:'Cancelar',
                                        handler: function()
                                            {
                                                //Ext.MessageBox.alert('Solicitud de Investigacion','¡Accion Cancelada!');
                                                var win=Ext.getCmp('login');
                                                win.close();
                                            }   
                                    }
                                ]
                            }]
                    });
                    administracion.login.superclass.initComponent.apply(this, arguments); 
                    //storetotalRegistros.load();
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
