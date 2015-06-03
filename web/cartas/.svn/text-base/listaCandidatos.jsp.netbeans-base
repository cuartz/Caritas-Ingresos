<%-- 
    Document   : listaCandidatos
    Created on : 17/04/2012, 11:58:38 AM
    Author     : rnunez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            // store grid
              var storeCandidatos = Ext.create('Ext.data.JsonStore', ({
                fields:[{name: 'idCandidato'},
                    {name: 'nombre'},
                    {name: 'telefono'},
                    {name: 'direccion'},
                    {name: 'rfc'},
                    {name: 'activo'}],
                data: [
                    {idCandidato:'210', telefono: '81103499', nombre:'FERNANDO JUAREZ', rfc:'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas', activo:'Si'},
                    {idCandidato:'211', telefono: '17882204', nombre:'PEDRO ALONZO', rfc: 'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas',   activo:'No'},
                    {idCandidato:'212', telefono: '83550493', nombre:'JAIME GONZALEZ', rfc: 'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas', activo:'No'},
                    {idCandidato:'213', telefono: '81103499', nombre:'ARMANDO SOSA', rfc: 'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas',  activo:'No'},
                    {idCandidato:'214', telefono: '83550493', nombre:'JESUS ARMANDO', rfc: 'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas',  activo:'No'},
                    {idCandidato:'215', telefono: '17882204', nombre:'LUIS ESPINOZA', rfc: 'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas',  activo:'Si'},
                    {idCandidato:'216', telefono: '81103499', nombre:'WALTER MORALES', rfc: 'RSK99234K3', direccion:'Sierra Altamira 221 San. Nicolas', activo:'Si'}
                ]
            }));   
            
            //Toolbar
                var tbUno = new Ext.Toolbar({
                    items:[                      
                        new Ext.Button({
                            text:'Seleccionar',
                            iconCls: 'icon-grid'                            
                        }),                                                      
                        '-',
                        new Ext.Button({
                            text:'Agregar',
                            iconCls: 'icon-add'                            
                        }),                                                      
                        '-',
                        new Ext.Button({
                        text: 'Salir',
                        iconCls:'icon-salir',
                        handler: function(){
                            var win=Ext.getCmp('listaCandidatos');
                            win.close();                            
                        }
                        })                            
                    ]
                }); //Termina Toolbar    
              
             Ext.define('cartas.listaCandidatos', {
                extend: 'Ext.window.Window',
                id:'listaCandidatos',
                alias:'widget.listaCandidatos',                
                title: 'Lista de Candidatos',
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
                        tbar: tbUno,
                        items:[
                            {
                                xtype: 'grid',
                                store: storeCandidatos,
                                columns:[
                                    {
                                        dataIndex: 'idCandidato',
                                        text: 'ID',
                                        flex: .03
                                    },
                                    {
                                        dataIndex: 'nombre',
                                        text: 'Nombre',
                                        flex: .1
                                    },
                                    {
                                        dataIndex: 'telefono',
                                        text: 'Telefono',
                                        flex: .05
                                    },
                                    {
                                        dataIndex: 'direccion',
                                        text: 'Dirección',
                                        flex: .2
                                    },
                                    {
                                        dataIndex: 'rfc',
                                        text: 'R.F.C.',
                                        flex: .06
                                    },
                                    {
                                        dataIndex: 'activo',
                                        text: 'Donante Activo',
                                        flex: .07
                                    }
                                ],
                                selModel: Ext.create('Ext.selection.CheckboxModel', {
                        
                                }),
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 1000,
                                    store: storeCandidatos,
                                    displayInfo: true
                                })
                            } //Cierra grupo 1 items panel
                        ] //Cierra items panel
                    } //Cierra grupo 1 items ventana
                ] //Cierra items ventnaa
             });
             cartas.nuevaCarta.superclass.initComponent.apply(this, arguments); 
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
