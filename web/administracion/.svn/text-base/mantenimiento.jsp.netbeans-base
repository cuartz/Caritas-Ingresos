<%-- 
    Document   : eorganizacional
    Created on : 25/05/2011, 10:26:06 AM
    Author     : RCastilloc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>    
    Ext.require([
        'Ext.tree.*',
        'Ext.data.*',
        'Ext.window.MessageBox'
    ]);
    
    Ext.define('userZona', {
        extend: 'Ext.data.Model',
        fields: ['ID','NOMBRE']
    });
    Ext.define('userProfile', {
        extend: 'Ext.data.Model',
        fields: ['id','descripcion','total']
    });
    
    Ext.define('Permisos', {
        extend: 'Ext.data.Model',
        fields: [
            {name: 'id',     type: 'string'},
            {name: 'text',     type: 'string'}
        ]
    });
    
    //data del apps
    Ext.define('userApp', {
        extend: 'Ext.data.Model',
        fields: ['ID_APLICACION','NOMBRE','TOTAL']
    });
    
    
    Ext.define('userDescription', {
        extend: 'Ext.data.Model',
        fields: ['id','nombre','email','password','id_perfil','perfil','id_zona']
    });    
    
    
    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 1,
        autoCancel: false
    });

    function uptUser(e) {
        if(e.record.data.id!=''&&e.record.data.nombre!=''&&e.record.data.password!=''&&e.record.data.email!=''&&e.record.data.perfil!=''&&e.record.data.id_zona!=''){
            //        if(e.record.data.id!=''&&e.record.data.nombre!=''&&e.record.data.password!=''&&e.record.data.email!=''&&e.record.data.perfil!=''){
            Ext.Ajax.request({  
                url : 'adminusers.do' ,
                params : { 
                    uptUser : '', 
                    id_user:e.record.data.id, 
                    name:e.record.data.nombre ,
                    password:e.record.data.password ,
                    email:e.record.data.email ,
                    perfil:((e.record.data.id_perfil-Ext.getCmp('uperfil').getValue())!=0)?((e.record.data.id_perfil-Ext.getCmp('uperfil').getValue())>0||(e.record.data.id_perfil-Ext.getCmp('uperfil').getValue())<0?Ext.getCmp('uperfil').getValue():e.record.data.id_perfil):e.record.data.id_perfil,
                    id_zona:((e.record.data.id_zona-Ext.getCmp('uzona').getValue())!=0)?((e.record.data.id_zona-Ext.getCmp('uzona').getValue())>0||(e.record.data.id_zona-Ext.getCmp('uzona').getValue())<0?Ext.getCmp('uzona').getValue():e.record.data.id_zona):e.record.data.id_zona
                },
                method: 'GET',
                success: function ( result, request ) {
                    gridusers.getStore().load();
                    gridprofile.getStore().load();
                },
                failure: function ( result, request) {
                    gridusers.getStore().load();
                    gridprofile.getStore().load();
                }
            });
        }
    }

    function cr_status(v, p, record){
        var checked = (v==1)?'checked':'';
        var val = (v==1)?"0":"1";
        return "<input type='checkbox' "+checked+" class='chk' onclick='uptvalueStatus("+record.get('id')+","+val+",\""+record.get('nombre')+"\");'>";
    }
    
    var storeusers = Ext.create('Ext.data.JsonStore', {
        model: 'userDescription',
        //autoLoad: true,
        proxy: {
            type: 'ajax',
            url: 'adminusers.do?getusers=1',
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });
    
    var storeZona = Ext.create('Ext.data.JsonStore', {
        model: 'userZona',
        proxy: {
            type: 'ajax',
            url: 'adminusers.do?getZona=1',
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });    
    
    var storeProfile = Ext.create('Ext.data.JsonStore', {
        model: 'userProfile',
        proxy: {
            type: 'ajax',
            url: 'adminusers.do?getprofiles=1',
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });    
    
    //storeApps        
    var storeApp = Ext.create('Ext.data.JsonStore', {
        model: 'userApp',
        proxy: {
            type: 'ajax',
            url: 'adminusers.do?getApps=1',
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    }); 
    
    var gridprofile = Ext.create('Ext.grid.Panel', {
        store: storeProfile,
        columns: [
            {text: "ID", hidden:true, dataIndex: 'id', sortable: true},
            {text: "Perfil", editor: {allowBlank: false}, flex: .7, dataIndex: 'descripcion', sortable: true},
            {text: "T. Usu", editor: {allowBlank: false}, flex: .3, dataIndex: 'total', sortable: true}          
        ],
        frame: true,
        plugins: [rowEditing],
        title: 'Lista de perfiles',
        height:365,
        tbar: [
            {
                text: 'Nuevo perfil',
                iconCls: 'icon-add',
                handler : function() {
                    var storepermisos = Ext.create('Ext.data.TreeStore', {
                        model: 'Permisos',
                        proxy: {
                            type: 'ajax',
                            url: 'adminusers.do?getPermisos=1'/*,
                            reader: {
                                type: 'json',
                                root: 'rows'
                            }*/
                        },
                        folderSort: true
                    });
        

                    var treepermisos = Ext.create('Ext.tree.Panel', {
                        store: storepermisos,
                        rootVisible: false,
                        useArrows: true,
                        frame: true,
                        title: 'Permisos',
                        singleExpand: false,
                        width: 800,
                        height: 450,
                        columns: [
                            {
                                xtype: 'treecolumn', //this is so we know which column will show the tree
                                text: 'Modulo',
                                flex: 2,
                                sortable: true,
                                dataIndex: 'text'
                            }]
                    });                    
                    if(Ext.getCmp('winAddValue')==null){
                        var winAddProfile = Ext.create('widget.window', {
                            title: 'Nuevo Perfil',
                            id:'winAddValue',
                            closable: true,
                            closeAction: 'destroy',
                            maximizable: false,
                            width: 300,
                            height: 400,
                            autoScroll:true,
                            layout: 'fit',
                            bodyStyle: 'padding: 5px;',
                            items: [{
                                    xtype:'form',
                                    title:'',
                                    layout: {
                                        type: 'fit'
                                    },
                                    items:[
                                        {
                                            xtype:'panel',
                                            frame: true,
                                            title: '',
                                            width: 400,
                                            bodyPadding: 5,

                                            fieldDefaults: {
                                                labelAlign: 'left',
                                                labelWidth: 200,
                                                anchor: '100%'
                                            },
                                            items: [{
                                                    xtype: 'textfield',
                                                    name: 'nameProfile',
                                                    id: 'nameProfile',
                                                    fieldLabel: 'Nombre',
                                                    value: ''
                                                },treepermisos],
                                            buttons: [{
                                                    text:'Guardar',
                                                    handler: function(){
                                                        var records = treepermisos.getView().getChecked(),
                                                        names = [];

                                                        Ext.Array.each(records, function(rec){
                                                            names.push(rec.get('id'));
                                                        });
                                                    
                                                        if(Ext.getCmp('nameProfile').getValue()!=''&&names.join(';')!=''){
                                                            Ext.Ajax.request({  
                                                                url : 'adminusers.do' ,
                                                                params : { 
                                                                    addprofile : '', 
                                                                    name:Ext.getCmp('nameProfile').getValue(),
                                                                    permissions:names.join(';')
                                                                },
                                                                method: 'GET',
                                                                success: function ( result, request ) {
                                                                    winAddProfile.close();
                                                                    gridprofile.getStore().load();
                                                                },
                                                                failure: function ( result, request) {
                                                                    gridprofile.getStore().load();
                                                                }
                                                            });
                                                        }
                                                    }
                                                },{
                                                    text:'Cancelar',
                                                    handler: function(){
                                                        winAddProfile.close();
                                                    }
                                                }]
                                        }
                                    ]
                                }]
                        });
                    }
                    Ext.getCmp('winAddValue').show();
                }
            },{
                text: 'Borrar perfil',
                iconCls: 'icon-delete',
                handler : function() {
                    var selectedRow=gridprofile.selModel.selected.items[0];
                    if(selectedRow!=null&&selectedRow.data.id!=''){
                        Ext.Ajax.request({  
                            url : 'adminusers.do' ,
                            params : { 
                                delProfile : '', 
                                perfil:selectedRow.data.id
                            },
                            method: 'GET',
                            success: function ( result, request ) {
                                gridprofile.getStore().load();
                            },
                            failure: function ( result, request) {
                                gridprofile.getStore().load();
                            }
                        });
                    }
                }
            }
        ]
    });  
    //GRID ADMINISTRADOR DE APLICACIONES
    var gridAdminprofile = Ext.create('Ext.grid.Panel', {
        store: storeApp,
        //        store: storeProfile,
        columns: [
            {text: "ID_APLICACION", hidden:true, dataIndex: 'ID_APLICACION', sortable: true},
            {text: "Sitema", editor: {allowBlank: false}, flex: .3, dataIndex: 'NOMBRE', sortable: true},
            {text: "Total", editor: {allowBlank: false}, flex: .3, dataIndex: 'TOTAL', sortable: true}          
        ],
        frame: true,
        plugins: [rowEditing],
        title: 'Administracion de Aplicaciones',
        height:365,
        tbar: [
            {
                text: 'Nueva Aplicacion',
                iconCls: 'icon-add',
                handler : function() {
                    var storepermisos = Ext.create('Ext.data.TreeStore', {
                        model: 'Permisos',
                        proxy: {
                            type: 'ajax',
                            url: 'adminusers.do?getprofiles=1'/*,
                            url: 'adminusers.do?getPermisos=1'/*,
                            reader: {
                                type: 'json',
                                root: 'rows'
                            }*/
                        },
                        folderSort: true
                    });

                    var treepermisos = Ext.create('Ext.tree.Panel', {
                        store: storepermisos,
                        rootVisible: false,
                        useArrows: true,
                        frame: true,
                        title: 'Permisos',
                        singleExpand: false,
                        width: 250,
                        height: 300,
                        columns: [
                            {
                                xtype: 'treecolumn', //this is so we know which column will show the tree
                                text: 'Modulo',
                                flex: 2,
                                sortable: true,
                                dataIndex: 'text'
                            }]
                    });                    
                    if(Ext.getCmp('winAddValue')==null){
                        var winAddProfile = Ext.create('widget.window', {
                            title: 'Nuevo Perfil',
                            id:'winAddValueADM',
                            closable: true,
                            closeAction: 'destroy',
                            maximizable: false,
                            width: 300,
                            height: 400,
                            autoScroll:true,
                            layout: 'fit',
                            bodyStyle: 'padding: 5px;',
                            items: [{
                                    xtype:'form',
                                    title:'',
                                    layout: {
                                        type: 'fit'
                                    },
                                    items:[
                                        {
                                            xtype:'panel',
                                            frame: true,
                                            title: '',
                                            width: 400,
                                            bodyPadding: 5,

                                            fieldDefaults: {
                                                labelAlign: 'left',
                                                labelWidth: 200,
                                                anchor: '100%'
                                            },
                                            items: [{
                                                    xtype: 'textfield',
                                                    name: 'nameProfile',
                                                    id: 'nameProfile',
                                                    fieldLabel: 'Nombre',
                                                    value: ''
                                                },treepermisos],
                                            buttons: [{
                                                    text:'Guardar',
                                                    handler: function(){
                                                        var records = treepermisos.getView().getChecked(),
                                                        names = [];

                                                        Ext.Array.each(records, function(rec){
                                                            names.push(rec.get('id'));
                                                        });
                                                    
                                                        if(Ext.getCmp('nameProfile').getValue()!=''&&names.join(';')!=''){
                                                            Ext.Ajax.request({  
                                                                url : 'adminusers.do' ,
                                                                params : { 
                                                                    addprofile : '', 
                                                                    name:Ext.getCmp('nameProfile').getValue(),
                                                                    permissions:names.join(';')
                                                                },
                                                                method: 'GET',
                                                                success: function ( result, request ) {
                                                                    winAddProfile.close();
                                                                    gridprofile.getStore().load();
                                                                },
                                                                failure: function ( result, request) {
                                                                    gridprofile.getStore().load();
                                                                }
                                                            });
                                                        }
                                                    }
                                                },{
                                                    text:'Cancelar',
                                                    handler: function(){
                                                        winAddProfile.close();
                                                    }
                                                }]
                                        }
                                    ]
                                }]
                        });
                    }
                    Ext.getCmp('winAddValue').show();
                }
            },{
                text: 'Borrar',
                //                text: 'Borrar Aplicacion',
                iconCls: 'icon-delete',
                handler : function() {
                    var selectedRow=gridprofile.selModel.selected.items[0];
                    if(selectedRow!=null&&selectedRow.data.id!=''){
                        Ext.Ajax.request({  
                            url : 'adminusers.do' ,
                            params : { 
                                delProfile : '', 
                                perfil:selectedRow.data.id
                            },
                            method: 'GET',
                            success: function ( result, request ) {
                                gridprofile.getStore().load();
                            },
                            failure: function ( result, request) {
                                gridprofile.getStore().load();
                            }
                        });
                    }
                }
            }
        ]
    });    
    
    var gridusers = Ext.create('Ext.grid.Panel', {
        store: storeusers,
        columns: [
            {text: "ID", hidden:false, dataIndex: 'id', sortable: true},
            {text: "Nombre", editor: {allowBlank: false}, flex: 1, dataIndex: 'nombre', sortable: true},
            {text: "Email", editor: {allowBlank: false}, flex: 1, dataIndex: 'email', sortable: true},
            {text: "Contraseña", editor: {allowBlank: false}, flex: 1, dataIndex: 'password', sortable: true},            
            {text: "ID_PERFIL", dataIndex: 'id_perfil',hidden:true },            
            {text: "Perfil", editor: {
                    xtype: 'combo',
                    store: storeProfile,
                    editable: false,
                    name: 'uperfil',
                    id: 'uperfil',
                    dataIndex:'perfil',
                    valueField: 'id',
                    hiddenName:'huperfil',
                    displayField:'descripcion',
                    triggerAction: 'all'
                } , flex: 1, dataIndex: 'perfil', sortable: true},
            {text: "ID_ZONA", dataIndex: 'id_zona',hidden:true },
            {text: "Zona", editor: {
                    xtype: 'combo',
                    store: storeZona,
                    editable: false,
                    name: 'uzona',
                    id: 'uzona',
                    dataIndex:'id_zona',
                    valueField: 'ID',
                    hiddenName:'huzona',
                    displayField:'NOMBRE',
                    triggerAction: 'all'
                } , flex: 1, dataIndex: 'id_zona', sortable: true}
        ],
        frame: true,
        plugins: [rowEditing],
        //renderTo:'stage',
        //width: 540,
        title: 'Lista de usuarios',
        height:365,
        tbar: [
            {
                text: 'Nuevo usuario',
                iconCls: 'icon-add',
                handler : function() {
                    winAddUser = Ext.create('widget.window', {
                        title: 'Nuevo usuario',
                        id:'winAddUser',
                        closable: true,
                        closeAction: 'destroy',
                        maximizable: false,
                        width: 300,
                        height: 260,
                        autoScroll:true,
                        layout: 'fit',
                        bodyStyle: 'padding: 5px;',
                        items: [{
                                xtype:'form',
                                title:'',
                                frame:true,
                                border:false,
                                items:[
                                    {
                                        xtype: 'textfield',
                                        name: 'nidusuario',
                                        id: 'nidusuario',
                                        fieldLabel: 'ID',
                                        allowBlank:false,
                                        value: ''
                                    },{
                                        xtype: 'textfield',
                                        name: 'nnombreusuario',
                                        id: 'nnombreusuario',
                                        fieldLabel: 'Nombre',
                                        allowBlank:false,
                                        value: ''
                                    },{
                                        xtype: 'textfield',
                                        name: 'nemail',
                                        id: 'nemail',
                                        vtype:'email',
                                        allowBlank:false,
                                        fieldLabel: 'Email',
                                        value: ''
                                    },{
                                        xtype: 'textfield',
                                        name: 'npassword',
                                        id: 'npassword',
                                        allowBlank:false,
                                        inputType: 'password',
                                        fieldLabel: 'Contraseña',
                                        value: ''
                                    },{
                                        xtype: 'combo',
                                        name: 'nprofile',
                                        id: 'nprofile',
                                        fieldLabel: 'Perfil',
                                        store: storeProfile,
                                        editable: false,
                                        valueField: 'id',
                                        allowBlank:false,
                                        displayField:'descripcion',
                                        triggerAction: 'all',
                                        listeners:{
                                            select:function( combo, record, index ){
                                                if(this.getValue()==28){
//                                                    alert(this.getValue());
                                                    Ext.getCmp('nzona').enable();
                                                    Ext.getCmp('nzona').setVisible(true);
                                                }else{
//                                                    alert(this.getValue());
                                                    Ext.getCmp('nzona').disable();
                                                    Ext.getCmp('nzona').setVisible(false);            
                                                    
                                                }
//                                                Ext.getCmp('nprofile').selectedRecord = record;
                                            }
                                        }
                                    },
                                    {
                                        xtype: 'combo',
                                        name: 'nzona',
                                        id: 'nzona',
                                        fieldLabel: 'Zona',
                                        store: storeZona,
                                        editable: false,
                                        valueField: 'ID',
                                        allowBlank:false,
                                        displayField:'NOMBRE',
                                        triggerAction: 'all'
                                    }],
                                buttons: [{
                                        text:'Guardar',
                                        handler: function(){
                                            if(Ext.getCmp('nidusuario').getValue()!=''&&Ext.getCmp('nnombreusuario').getValue()!=''&&Ext.getCmp('nemail').getValue()!=''&&Ext.getCmp('npassword').getValue()!=''&&Ext.getCmp('nprofile').getValue()!=''&&Ext.getCmp('nzona').getValue()!=''){
//                                            if(Ext.getCmp('nidusuario').getValue()!=''&&Ext.getCmp('nnombreusuario').getValue()!=''&&Ext.getCmp('nemail').getValue()!=''&&Ext.getCmp('npassword').getValue()!=''&&Ext.getCmp('nprofile').getValue()!=''){
//                                            alert(Ext.getCmp('nidusuario').getValue());
//                                            alert(Ext.getCmp('nnombreusuario').getValue());
//                                            alert(Ext.getCmp('nemail').getValue());
//                                            alert(Ext.getCmp('npassword').getValue());
//                                            alert(Ext.getCmp('nprofile').getValue());
//                                            alert(Ext.getCmp('nzona').getValue());
                                                Ext.Ajax.request({  
                                                    url : 'adminusers.do' ,
                                                    params : { 
                                                        addUser : '', 
                                                        id_user:Ext.getCmp('nidusuario').getValue(), 
                                                        name:Ext.getCmp('nnombreusuario').getValue(),
                                                        email: Ext.getCmp('nemail').getValue(), 
                                                        password: Ext.getCmp('npassword').getValue(), 
                                                        perfil: Ext.getCmp('nprofile').getValue(),
                                                        id_zona: Ext.getCmp('nzona').getValue()
                                                    },
                                                    method: 'GET',
                                                    success: function ( result, request ) {
                                                        winAddUser.close();
                                                        gridusers.getStore().load();
                                                        gridprofile.getStore().load();
                                                    },
                                                    failure: function ( result, request) {
                                                        gridusers.getStore().load();
                                                    }
                                                });
                                            }
                                        }
                                    },{
                                        text:'Cancelar',
                                        handler: function(){
                                            winAddUser.close();
                                        }
                                        //                                        }]
                                    }
                                ]
                            }]
                    });
                    winAddUser.show();
                }
            },{
                text: 'Borrar usuario',
                iconCls: 'icon-delete',
                handler : function() {
                    var selectedRow=gridusers.selModel.selected.items[0];
                    if(selectedRow!=null&&selectedRow.data.id!=''){
                        Ext.Ajax.request({  
                            url : 'adminusers.do' ,
                            params : { 
                                delUser : '', 
                                id_user:selectedRow.data.id
                            },
                            method: 'GET',
                            success: function ( result, request ) {
                                gridusers.getStore().load();
                                gridprofile.getStore().load();
                            },
                            failure: function ( result, request) {
                                gridusers.getStore().load();
                            }
                        });
                    }
                }
            },{
                text: 'Mostrar todos',
                iconCls: 'icon-user',
                handler : function() {
                    gridusers.getStore().proxy.extraParams = {perfil:''};
                    gridusers.getStore().load();
                    gridprofile.getStore().load();
                    document.getElementById('label_users').innerHTML="";
                }
            },
            '->',{xtype:'tbspacer'},
            {
                xtype: 'box',
                autoEl: {
                    html: '<div id="label_users"><div>'
                },
                width:120
            },
            {xtype:'tbspacer'}
        ]
        
    });    
    
    var stagePanelMantenimiento = Ext.create('Ext.Panel', {
        layout:'column',
        autoScroll:true,
        renderTo:'stage',
        defaults: {
            layout: 'anchor',
            defaults: {
                anchor: '100%'
            }
        },
        items: [
            {
                columnWidth: 1/2,
                baseCls:'x-plain',
                bodyStyle:'padding:0px 0 0px 0px',      
                items:[gridusers]
            },
            {
                columnWidth: 1/4,
                baseCls:'x-plain',
                bodyStyle:'padding:0px 0 0px 0px',
                items:[gridprofile]
            } ,           
            {
                columnWidth: 1/5,
                baseCls:'x-plain',
                bodyStyle:'padding:0px 0 0px 0px',
                items:[gridAdminprofile]
            }            
        ]
    });
    
    
    
    var tabMantenimiento = Ext.createWidget('tabpanel', {
        renderTo: 'stage',
        activeTab: 0,
        anchor: '100%',
        width: 1000,
        height: 400,
        plain: true,
        defaults :{
            autoScroll: true,
            bodyPadding: 4
        },
        items: [
            {
                title:'Usuarios',
                items:[
                    stagePanelMantenimiento 
                ]
            }
        ]
    });
    
    gridusers.addListener('edit', uptUser);
    
    gridprofile.on("cellclick", function(gridprofile, rowIndex, columnIndex, e){
        var selectedRow=gridprofile.selModel.selected.items[0];
        document.getElementById('label_users').innerHTML = selectedRow.data.descripcion;
        gridusers.getStore().proxy.extraParams = {perfil:selectedRow.data.id};
        gridusers.getStore().load();
    });    
    
    gridprofile.on("celldblclick", function(gridprofile, rowIndex, columnIndex, e){
        var selectedRow=gridprofile.selModel.selected.items[0];
        var storepermisos_perfil = Ext.create('Ext.data.TreeStore', {
            model: 'Permisos',
            proxy: {
                type: 'ajax',
                url: 'adminusers.do?getPermisos=1&perfil='+selectedRow.data.id
            },
            folderSort: true
        });

        var treepermisos = Ext.create('Ext.tree.Panel', {
            store: storepermisos_perfil,
            rootVisible: false,
            useArrows: true,
            frame: true,
            title: 'Permisos',
            singleExpand: false,
            //width: 250,
            anchor:'100%',
            height: 300,
            columns: [
                {
                    xtype: 'treecolumn', //this is so we know which column will show the tree
                    text: 'Modulo',
                    flex: 2,
                    sortable: true,
                    dataIndex: 'text'
                }]
        });                    
        if(Ext.getCmp('winUptProfile')==null){
            var winUptProfile = Ext.create('widget.window', {
                title: 'Editar Perfil',
                id:'winUptProfile',
                closable: true,
                closeAction: 'destroy',
                maximizable: false,
                width: 300,
                height: 300,
                autoScroll:true,
                layout: 'fit',
                bodyStyle: 'padding: 5px;',
                items: [treepermisos],
                buttons: [{
                        text:'Guardar',
                        handler: function(){
                            var records = treepermisos.getView().getChecked(), names = [];

                            Ext.Array.each(records, function(rec){
                                names.push(rec.get('id'));
                            });

                            Ext.Ajax.request({  
                                url : 'adminusers.do' ,
                                params : { 
                                    uptprofile : '',
                                    perfil: selectedRow.data.id,
                                    permissions:names.join(';')
                                },
                                method: 'GET',
                                success: function ( result, request ) {
                                    winUptProfile.close();
                                    gridprofile.getStore().load();
                                },
                                failure: function ( result, request) {
                                    gridprofile.getStore().load();
                                }
                            });                                                    

                        }
                    },{
                        text:'Cancelar',
                        handler: function(){
                            winUptProfile.close();
                        }
                    }]

            });
        }
        Ext.getCmp('winUptProfile').show();
    });     
    
    storeProfile.load();
    storeZona.load();
    storeusers.load();
    storeApp.load();
</script>    