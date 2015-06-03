<%-- 
    Document   : adminProvDireccion
    Created on : 1/02/2012, 03:35:15 PM
    Author     : jzamora
--%>


<script>
    function cr_status(v, p, record){
        var checked = (v==1)?'checked':'';
        var val = (v==1)?"0":"1";
        return "<input type='checkbox' "+checked+" class='chk' onclick='uptvalueStatus("+record.get('id')+","+val+",\""+record.get('nombre')+"\");'>";
    }
    
    Ext.define('ImageModel', {
        extend: 'Ext.data.Model',
        fields: ['id','nombre']
    });
    var store1 = Ext.create('Ext.data.JsonStore', {
        model: 'ImageModel',
        proxy: {
            type: 'ajax',
//            url: 'catalogs.do?list=1',
                url: 'helpServicesAC.do?method=getProveedores',
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });
    store1.load();

    var listView = Ext.create('Ext.grid.Panel', {
        //width:350,
        height:400,
        collapsible:false,
        title:'',
        //renderTo: 'stage',
        store: store1,
        multiSelect: false,
        columns: [
            {
                text: 'ID',
                hidden:true,
                dataIndex: 'id'
            },{
                text: 'Proveedor',
                flex: 100,
                dataIndex: 'nombre'
            }
        ],
        tbar: [
            {
                text: 'Nuevo Proveedor',
                iconCls: 'icon-add',
                handler : function() {
                    winAddCatalog = Ext.create('widget.window', {
                        title: 'Nuevo Proveedor',
                        id:'winAddDirecProveedor',
                        closable: false,
                        closeAction: 'destroy',
                        maximizable: true,
                        width: 400,
                        height: 130,
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
                                        name: 'newCatalog',
                                        id: 'newCatalog',
                                        fieldLabel: 'Proveedor a Insertar',
                                        value: ''
                                    }],
                                    buttons: [{
                                        text:'Guardar',
                                        handler: function(){
                                            if(Ext.getCmp('newCatalog').getValue()){
                                               Ext.Ajax.request({  
                                                     url : 'catalogs.do' ,
                                                     params : { 
                                                         addCatalog : '', 
                                                         value:Ext.getCmp('newCatalog').getValue() 
                                                     },
                                                     method: 'GET',
                                                     success: function ( result, request ) {
                                                        winAddCatalog.close();
                                                        listView.getStore().load();
                                                     },
                                                     failure: function ( result, request) {
                                                        listView.getStore().load();
                                                      }
                                                });
                                            }
                                        }
                                    },{
                                        text:'Cancelar',
                                        handler: function(){
                                            winAddCatalog.close();
                                        }
                                    }]
                                }
                            ]
                        }]
                    });
                    winAddCatalog.show();

                }
            }
        ]
    });

    
    listView.on("cellclick", function(listView, rowIndex, columnIndex, e){
                    var selectedRow=listView.selModel.selected.items[0];
                    document.getElementById('cat_label_v').innerHTML = selectedRow.data.nombre;
                    store.proxy.extraParams = {idcatalog:selectedRow.data.id};
                    store.load();
        });

    
    Ext.define('Book',{
        extend: 'Ext.data.Model',
        fields: ['id','nombre','status']
    });
    
    Ext.Loader.setConfig({
        enabled: true
    });
    Ext.Loader.setPath('Ext.ux', 'js/ext-4/ux');

    Ext.require([
        'Ext.grid.*',
        'Ext.data.*',
        'Ext.util.*',
        'Ext.state.*',
        'Ext.form.*',
        'Ext.ux.CheckColumn'
    ]);
    
    Ext.grid.CheckColumn = function(config){
    Ext.apply(this, config);
    if(!this.id){
    this.id = Ext.id();
    }
    this.renderer = this.renderer.createDelegate(this);
    };

    Ext.grid.CheckColumn.prototype ={
    init : function(grid){
    this.grid = grid;
    this.grid.on('render', function(){
    var view = this.grid.getView();
    view.mainBody.on('mousedown', this.onMouseDown, this);
    }, this);
    },

    onMouseDown : function(e, t){
    if(t.className && t.className.indexOf('x-grid3-cc-'+this.id) != -1){
    e.stopEvent();
    var index = this.grid.getView().findRowIndex(t);
    var record = this.grid.store.getAt(index);
    record.set(this.dataIndex, !record.data[this.dataIndex]);
    }
    },

    renderer : function(v, p, record){
    p.css += ' x-grid3-check-col-td'; 
    return '<div class="x-grid3-check-col'+(v==1?'-on':'')+' x-grid3-cc-'+this.id+'">&#160;</div>';
    }
    };

    var store = Ext.create('Ext.data.JsonStore', {
        model: 'Book',
        //autoLoad: true,
        proxy: {
            type: 'ajax',
            url: 'catalogs.do?val=1',
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });

    var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
        clicksToMoveEditor: 1,
        autoCancel: false
    });

    // create the grid
    var grid = Ext.create('Ext.grid.Panel', {
        store: store,
        columns: [
            {text: "ID", hidden:true, dataIndex: 'id', sortable: true},
            {text: "DIRECCION", editor: {allowBlank: false}, flex: 1, dataIndex: 'nombre', sortable: true},
            
            {
                header: 'RFC',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                header: 'TELEFONO',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                //xtype: 'checkcolumn',
                header: 'EMAIL',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                header: 'CONTACTO',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                header: 'observaciones',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                header: 'observaciones',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                header: 'Cuenta',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
            ,
            {
                header: 'Numero Cuenta',
                dataIndex: 'status',
                width: 60,
                renderer: cr_status
            }
        ],
        frame: true,
        plugins: [rowEditing],
        //renderTo:'stage',
        //width: 540,
        height: 400,
        tbar: [
            {
                text: 'Nuevo valor',
                iconCls: 'icon-add',
                handler : function() {
                    var selectedRow=listView.selModel.selected.items[0];
                    if(selectedRow!=undefined){
                        winAddValue = Ext.create('widget.window', {
                            title: 'Nuevo Valor',
                            id:'winAddDireccion',
                            closable: true,
                            closeAction: 'destroy',
                            maximizable: true,
                            width: 900,
                            height: 130,
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
                                            name: 'newValue',
                                            id: 'newValue',
                                            fieldLabel: 'DIRECCION DEL PROVEEDOR',
                                            value: ''
                                        }
                                    ],
                                        buttons: [{
                                            text:'Guardar',
                                            handler: function(){
                                                var selectedRow=listView.selModel.selected.items[0];
                                                if(Ext.getCmp('newValue').getValue()!=''&&selectedRow!=null&&selectedRow.data.id!=''){
                                                   Ext.Ajax.request({  
                                                         url : 'catalogs.do' ,
                                                         params : { 
                                                             addValue : '', 
                                                             idcatalog:selectedRow.data.id, 
                                                             value:Ext.getCmp('newValue').getValue() 
                                                         },
                                                         method: 'GET',
                                                         success: function ( result, request ) {
                                                            winAddValue.close();
                                                            grid.getStore().load();
                                                         },
                                                         failure: function ( result, request) {
                                                            grid.getStore().load();
                                                          }
                                                    });
                                                }
                                            }
                                        },{
                                            text:'Cancelar',
                                            handler: function(){
                                                winAddValue.close();
                                            }
                                        }]
                                    }
                                ]
                            }]
                        });
                        winAddValue.show();
                    }
                }
            },{
                text: 'Borrar valor',
                iconCls: 'icon-delete',
                handler : function() {
                    var selectedRow=grid.selModel.selected.items[0];
                    if(selectedRow!=null&&selectedRow.data.id!=''){
                       Ext.Ajax.request({  
                             url : 'catalogs.do' ,
                             params : { 
                                 delValue : '', 
                                 idvalue:selectedRow.data.id
                             },
                             method: 'GET',
                             success: function ( result, request ) {
                                grid.getStore().load();
                             },
                             failure: function ( result, request) {
                                grid.getStore().load();
                              }
                        });
                    }
                }
            },
            '->',{xtype:'tbspacer'},
            {
                xtype: 'box',
                autoEl: {
                    html: '<div id="cat_label_v"><div>'
                },
                width:120
            },
            {xtype:'tbspacer'}
        ]
        
    });
    
    grid.addListener('edit', uptValue);

    function uptValue(e) {
        var selectedRow=grid.selModel.selected.items[0];
        if(selectedRow.data.id!=''&&e.record.data.nombre!=''){
           Ext.Ajax.request({  
                 url : 'catalogs.do' ,
                 params : { 
                     uptValue : '', 
                     idvalue:selectedRow.data.id, 
                     value:e.record.data.nombre 
                 },
                 method: 'GET',
                 success: function ( result, request ) {
                    grid.getStore().load();
                 },
                 failure: function ( result, request) {
                    grid.getStore().load();
                  }
            });
        }
    };
    
     function uptvalueStatus(id,status,value) {
        if(id!=''){
           Ext.Ajax.request({  
                 url : 'catalogs.do' ,
                 params : { 
                     uptValue : '', 
                     idvalue:id, 
                     value:value,
                     status:status
                 },
                 method: 'GET',
                 success: function ( result, request ) {
                    grid.getStore().load();
                 },
                 failure: function ( result, request) {
                    grid.getStore().load();
                  }
            });
        }
    };
    
    
    
    var stagePanel = Ext.create('Ext.Panel', {
        layout:'column',
        autoScroll:false,
        renderTo:'stage',
        defaults: {
            layout: 'anchor',
            defaults: {
                anchor: '100%'
            }
        },
        items: [
            {
                    columnWidth: 1/3,
                    baseCls:'x-plain',
                    bodyStyle:'padding:0px 0 0px 0px',
                    items:[listView]
            },{
                    columnWidth: 2/3,
                    baseCls:'x-plain',
                    bodyStyle:'padding:0px 0 0px 0px',
                    items:[grid]
            }
        ]
    });
    
</script>