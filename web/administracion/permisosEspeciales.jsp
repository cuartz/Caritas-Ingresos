<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
        /********************* VARIABLES GLOBALES *************************/
        
        
        
        
        /********************* INICIA CODIGO DE LA PANTALLA ************************/
        Ext.define('administracion.permisosEspeciales', {
                extend: 'Ext.window.Window',                    
                alias:'widget.permisosEspeciales',                   
                title: 'Permisos Especiales',
                constrain : true,
                model: true,
                width: 1000,                
                height: 640,
                border: false,
                buttonAlign: 'left',
                closeAction:'close',
                autoDestroy:true,
                maximizable: true,
                layout: 'fit',                    
                region:'center',  
                modal: true,
                initComponent: function() {
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'frmPermisosEspeciales',                                
                                items:[
                                    {
                                        xtype: 'fieldset',
                                        height: 220,
                                        title: 'Impresión de Recibos',
                                        items:[
                                            
                                        ]
                                    }
                                ] //Cierra items mainForm
                            }
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                    administracion.permisosEspeciales.superclass.initComponent.apply(this, arguments);
                } //Cierra initComponent
        }); //Cierra Ext.define
            
        </script>   
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>