<%--
    Document   : nuevaCarta
    Created on : 10/04/2012, 14:14:12 pm
    Author     : Rnunez
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            //Toolbar
            var tbUno = new Ext.Toolbar({
                items:[                      
                    new Ext.Button({
                        text:'Guardar',
                        iconCls: 'icon-save'                            
                    }),                                                      
                    '-',
                    new Ext.Button({
                        text: 'Cancelar',
                        iconCls:'icon-salir',
                        handler: function(){
                            var win=Ext.getCmp('nuevaCarta');
                            win.close();                            
                        }
                    })                            
                ]
            }); //Termina Toolbar 


            //Creation Screen            
            
            Ext.define('cartas.nuevaCarta', {
                extend: 'Ext.window.Window',
                id:'nuevaCarta',
                name: 'Reportes.atenciones',
                alias:'widget.nuevaCarta',                
                title: 'Nuevo Formato de Carta',
                width: 700,                
                height: 550,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',    
                region:'center',
                modal:true,
                autoScroll:true,//modificacion
                closeAction : 'close',
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'panel',                        
                                border: false,
                                tbar: tbUno,
                                items: [
                                    {
                                        xtype: 'container',
                                        margin: '5',
                                        items:[
                                            {
                                                xtype: 'htmleditor',
                                                height: 150,
                                                anchor: '100%',
                                                style: 'background-color: white;',
                                                fieldLabel: 'Encabezado'
                                            }, //Cierra grupo 1 items container
                                            {
                                                xtype: 'htmleditor',
                                                height: 150,
                                                anchor: '100%',                                        
                                                style: 'background-color: white;',
                                                fieldLabel: 'Cuerpo'
                                            }, //Cierra grupo 2 items container
                                            {
                                                xtype: 'htmleditor',
                                                height: 150,
                                                anchor: '100%',
                                                style: 'background-color: white;',
                                                fieldLabel: 'Pie'
                                            } //Cierra grupo 3 items container
                                        ] //Cierra items container
                                    } //Cierra grupo 1 items panel
                                ] //Cierra items panel
                            }
                        ]
                    });            
                    cartas.nuevaCarta.superclass.initComponent.apply(this, arguments);
                }
            });

        </script>
    </head>
    <body>
    </body>
</html>
