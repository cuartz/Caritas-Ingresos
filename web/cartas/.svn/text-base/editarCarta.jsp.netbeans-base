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
                            var win=Ext.getCmp('editarCarta');
                            win.close();                            
                        }
                        })                            
                    ]
                }); //Termina Toolbar             
            //Creation Screen            
            Ext.define('cartas.editarCarta', {
                extend: 'Ext.window.Window',
                id:'editarCarta',
                alias:'widget.editarCarta',                
                title: 'Editar Formato de Carta',
                width: 700,                
                height: 550,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',
                closeAction : 'close',
                region:'center',
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
                    }]
                    
            
                });
            cartas.nuevaCarta.superclass.initComponent.apply(this, arguments); 

        </script>
    </head>
    <body>
    </body>
</html>
