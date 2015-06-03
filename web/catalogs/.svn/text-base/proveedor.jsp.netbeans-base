<%--
    Document   : Solicitud de Cheques
    Created on : 26/06/2011, 19:59:12 pm
    Author     : RCASTILLOC
--%>
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
 
            Ext.define('proveedor',{
        id:'proveedor',
        extend: 'Ext.data.Model',
        fields:     [
                    {name: 'ID'},
                    {name: 'NOMBRE'},
                    {name: 'Id_Direccion_Proveedor'},
                    {name: 'Prov_Direccion'},
                    {name: 'Prov_RFC'},
                    {name: 'Prov_Telefono'},
                    {name: 'Prov_Email'},
                    {name: 'Prov_Contacto'},
                    {name: 'Prov_Observaciones'},
                    {name: 'Id_Proveedor'},
                    {name: 'Id_CUENTA'},
                    {name: 'Prov_Numero_d_Cuenta'}
                ]
    });


    // create the Data Store
    var storeproveedor = Ext.create('Ext.data.JsonStore', {
        model: 'proveedor',
        pageSize: 50,
        autoLoad:false,
        proxy: {
            type: 'ajax',
            url: 'proveedorAC.do', 
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });   
    
    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 1,
        autoCancel: true
    });
    
    
    function uptproveedorDir(e){
        Ext.Ajax.request({  
//             url : 'proveedorAC.do',
             url : 'proveedorAC.do?method=getAllproveedoresDir',
//             url: 'citaEstudioAC.do?method=getAllcitasEs', 
             params : { 
                 ID:e.record.data.ID, 
                 Id_Direccion_Proveedor: e.record.data.Id_Direccion_Proveedor ,
                 Prov_Direccion:e.record.data.Prov_Direccion ,
                 Prov_RFC:e.record.data.Prov_RFC ,
                 Prov_Telefono:e.record.data.Prov_Telefono ,
                 Prov_Email:e.record.data.Prov_Email ,
                 Prov_Contacto:e.record.data.Prov_Contacto,
                 Prov_Observaciones:e.record.data.Prov_Observaciones,
                 Id_Proveedor:e.record.data.Id_Proveedor,//Comentar esta linea
                 Id_CUENTA:e.record.data.Id_CUENTA,
                 Prov_Numero_d_Cuenta:e.record.data.Prov_Numero_d_Cuenta
             },
             method: 'GET',
             success: function ( result, request ) {
                Ext.MessageBox.alert('Información',result.responseText);
                Ext.getCmp('gridproveedor').getStore().load();
             },
             failure: function ( result, request) {
                Ext.getCmp('gridproveedor').getStore().load();
             }
        });
    }

    function render_iva(v, p, record){
        return '$ '+record.get('sc_iva');
    }
    
    function render_monto(v, p, record){
        return '$ '+record.get('sc_monto');
    }
    
    function render_donativo(v, p, record){
        return '$ '+record.get('sc_donativo');
    }    

    function render_status(v, p, record){
        return "<img src='img/status"+record.get('sc_status')+".png'>";
    }
    
            Ext.define('catalogs.proveedor', {
                extend: 'Ext.window.Window',
                id:'proveedor',
                name: 'proveedor',
                alias:'widget.proveedor',                
                title: 'Proveedores',
                width: 1200,                
                height: 400,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',    
                region:'center',
                modal:true,
                autoScroll:true,
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'grid',
                                store: storeproveedor,
                                id:'gridproveedor',
                                name: 'gridproveedor',
                                plugins: [rowEditing],
                                columns: [
                                    {
                                        dataIndex: 'ID',
                                        text :'ID',
                                        width:50,//flex utiliza decimales y width utiliza %
                                        align:'center'
//                                        hidden: false
                                    },
                                    {
                                        dataIndex: 'NOMBRE',
                                        text :'NOMBRE PROVEEDOR',
                                        flex: 1,
                                        align:'center'
                                    },
                                    {
                                        dataIndex: 'Id_Direccion_Proveedor',
                                        text :'Id_Dire_P',
                                        flex: .4
//                                        hidden: true
                                    },
                                    {
                                        dataIndex: 'Prov_Direccion',
//                                        flex: .7,
                                        text: 'Direccion',
                                        flex: 1,
                                        align: 'center',
                                        editor: {allowBlank: false}
//                                        renderer: render_status
                                    },
                                    {
                                        dataIndex: 'Prov_RFC',
//                                        flex: .3,
                                        text: 'RFC',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Prov_Telefono',
//                                        flex: .3,
                                        text: 'Telefono',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Prov_Email',
//                                        flex: .8,
                                        align: 'center',
                                        text: 'Email',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Prov_Contacto',
//                                        flex: .25,
                                        align: 'center',
                                        text: 'Contacto',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Prov_Observaciones',
//                                        flex: .3,
                                        text: 'Observaciones',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Id_Proveedor',
//                                        flex: .3,
//                                        editor: {allowBlank: false},
                                        text: 'ID Proveedor',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Id_CUENTA',
//                                        flex: .3,
//                                        editor: {allowBlank: false},
                                        text: 'Cuenta',
                                        editor: {allowBlank: true}
                                    },
                                    {
                                        dataIndex: 'Prov_Numero_d_Cuenta',
//                                        flex: .3,
                                        align:'center',
//                                        editor: { xtype: 'datefield', allowBlank: false },
                                        text: '# Cuenta',
                                        editor: {allowBlank: true}
                                    }
                                ]                        
                                ,tbar: {
                                    xtype: 'toolbar',
                                    items: [
                                        {
                                            xtype: 'combo',
                                            name: 'cmbbeneficiario',
                                            id: 'cmbbeneficiario',
                                            fieldLabel: 'Proveedor - Servicio',
                                            labelWidth: 180,
                                            store: storeSolBeneficiario,
                                            anchor: '98%',
                                            editable: true,
                                            valueField: 'id',
                                            allowBlank:false,
                                            displayField:'NOMBRE',
                                            hidden:true,
                                            triggerAction: 'all',
                                            listeners:
                                            {
                                                keypress: function(comboBox, e){
                                                    if (e.getCharCode() == e.ENTER) {
                                                        storeSolBeneficiario.proxy.extraParams = {query:Ext.getCmp('cmbbeneficiario').getValue()};
                                                        storeSolBeneficiario.load();
                                                    }
                                                },
                                                select : function(comboBox, e){
                                                    storeNoasignadas.proxy.extraParams = {id_proveedor:Ext.getCmp('cmbbeneficiario').getValue(),id_donante:Ext.getCmp('id_donante').getValue()};
                                                    storeNoasignadas.load();
                                                    storeAsignadas.proxy.extraParams = {id_solicitud:0};
                                                    storeAsignadas.load();
                                                    //alert(Ext.getCmp('cmbbeneficiario').getValue());
                                                }
                                            }
                                        },                                        
//                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'textfield',
                                            name: 'busqueda',
                                            id: 'busqueda',
                                            labelWidth: 45,
                                            fieldLabel: 'Buscar',
                                            hidden:false,
                                            listeners: {
                                                specialkey: function(f,e){
                                                if (e.getKey() == e.ENTER) {
                                                    storeproveedor.proxy.extraParams = {query:Ext.getCmp('busqueda').getValue()};
                                                    storeproveedor.load();
                                                }
                                              }
                                            }
                                            
                                        }
                                    ]
                                }
//                                ,
//                                listeners:
//                                {
//                                    select : function(comboBox, e){
//                                        var selectedRow=Ext.getCmp('gridproveedor').selModel.selected.items[0];
//                                        if(selectedRow!=undefined){
//                                            if(selectedRow.data.status==0||selectedRow.data.status==1){
//                                                Ext.getCmp('edit_oabtn').enable();
//                                                Ext.getCmp('cancel_oabtn').enable();
//                                            } else {
//                                                Ext.getCmp('edit_oabtn').disable();
//                                                Ext.getCmp('cancel_oabtn').disable();
//                                            }
//                                        }
//                                    }
//                                }
                            }
                        ]
                    });            
                    
                    catalogs.proveedor.superclass.initComponent.apply(this, arguments);
                    storeproveedor.load();
                    Ext.getCmp('gridproveedor').addListener('edit', uptproveedorDir);
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>