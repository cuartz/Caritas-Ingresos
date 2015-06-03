<%-- 
    Document   : confirmarCarta
    Created on : 3/05/2012, 03:39:50 PM
    Author     : rnunez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            //Toolbar
            var tbRespuesta = new Ext.Toolbar({
                    items:[                      
                        new Ext.Button({
                            text:'Guardar',
                            iconCls: 'icon-save'                            
                        }),                                                      
                        '-',
                        new Ext.Button({
                        text: 'Salir',
                        iconCls:'icon-salir',
                        handler: function(){
                            var win=Ext.getCmp('nuevaCarta');
                            win.close();                            
                        }
                        })                            
                    ]
                }); //Termina Toolbar 
            // Empieza ventana
            Ext.define('cartas.respuestaCartas', {
                extend: 'Ext.window.Window',
                id:'respuestaCartas',
                alias:'widget.respuestaCartas',                
                title: 'Respuesta de Carta',
                width: 400,                
                height: 350,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
                initComponent: function() {
                    
                    items: [
                    {
                        xtype: 'panel',                        
                        border: false,
                        tbar: tbRespuesta,
                        items: [
                            {
                                xtype: 'container',
                                margin: '5',
                                items:[
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'Aceptó',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'No Aceptó',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'No Aceptó P. Económ',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'No llegó carta',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'Telefono No Existe',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'Telefono Fuera de Servicio',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'checkbox',                                            
                                        fieldLabel: 'Otros',
                                        labelWidth: '200'
                                    },
                                    {
                                        xtype: 'label',
                                        text: 'Comentarios'
                                    },
                                    {
                                        xtype: 'textarea',                                       
                                        width: 330,                                                                    
                                        height: 60                                         
                                    }
                                ] //Cierra items container
                            } //Cierra grupo 1 items panel
                        ] //Cierra items panel
                    }] //Cierra items init component
                } //Cierra init component
                
                    
            
                }); //Cierra Ext define
            cartas.respuestaCartas.superclass.initComponent.apply(this, arguments); 
            
        </script>        
    </head>
</html>