<%--
    Document   : confirmaciones.confirmacionPagoEsp
    Created on : 02/06/2012, 14:14:12 pm
    Author     : Ozamora
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%//Obtenemos los datos de la cita programanda
           /*
     * HttpSession sesion = request.getSession(); Person infoUser = (Person)
     * sesion.getAttribute("infoSesion"); if (infoUser == null) { infoUser = new
     * Person(); }
     */
%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
   
      
                     
            //Inicia
            //Creation Screen            
            Ext.define('confirmaciones.confirmacionCobroEsp', {
                extend: 'Ext.window.Window',
                id:'confirmacionCobroEsp',
                alias:'widget.confirmacionCobroEsp',                
                title: 'Confirmacion Cobro Especie',
                height: 225,
                width: 422,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                initComponent: function() {
//                   var winconfirmacionCobroEsp=this;
                    Ext.apply(this, {
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
                                                iconCls: 'icon-save'
                                            },
                                            {
                                                xtype: 'tbseparator'
                                            },
                                            new Ext.Button({
                                                text:'Salir',
                                                iconCls:'icon-salir',
                                                handler:function(){
//                                                   winconfirmacionCobroEsp.close(); 
                                                     Ext.getCmp('confirmacionCobroEsp').close();
                                                }
                                            })
                                        ]
                                    }
                                ],
                                items: [
                                    {
                                        xtype: 'panel',
                                        border:false,
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border:false,
                                                items: [
                                                    {
                                                        xtype: 'checkboxgroup',
                                                        width: 400,
                                                        fieldLabel: 'Cobrado',
                                                        items: [
                                                            {
                                                                xtype: 'checkboxfield',
                                                                boxLabel: 'Box Label'
                                                            },
                                                            {
                                                                xtype: 'checkboxfield',
                                                                boxLabel: 'Box Label'
                                                            }
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                border:false,
                                                items: [
                                                    {
                                                        xtype: 'textfield',
                                                        fieldLabel: 'Folio'
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                border:false,
                                                items: [
                                                    {
                                                        xtype: 'textareafield',
                                                        fieldLabel: 'Motivo'
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                ]
                            }
              
                        ]
                    });
                    confirmaciones.confirmacionCobroEsp.superclass.initComponent.apply(this, arguments); 
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
