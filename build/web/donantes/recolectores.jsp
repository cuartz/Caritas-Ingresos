<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
            /********************* VARIABLES GLOBALES *************************/
            var winRecolectores;
            
            
            /********************* MODELS *************************/
            Ext.define('catalog',{
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            Ext.define('pagosConfirmadosCat',{   //Grid de Pagos Confirmados
                id:'pagosConfirmadosCat',
                extend: 'Ext.data.Model',
                fields:[
                    {name: 'ID_BITACORA'},
                    {name: 'ID_DONATIVO'},                        
                    {name: 'NOMBRE'},
                    {name: 'NUM_PAGO'},
                    {name: 'IMPORTE'},
                    {name: 'ID_FORMA_PAGO'},
                    {name: 'FORMA_PAGO'},
                    {name: 'DIRECCION'},
                    {name: 'ID_ESTATUS_PAGO_TMP'},
                    {name: 'ESTATUS_PAGO'},
                    {name: 'FECHA_VISITA'},
                    {name: 'ID_TIPO_DONATIVO'},
                    {name: 'REFERENCIA'},
                    {name: 'COMENTARIOS'}                
                ]
            });
            
            Ext.define('catalogDos',{
                id:'catalogDos',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','nombre2','status']
            });
            
            Ext.define('recolectoresCat',{
                id:'recolectoresCat',
                extend: 'Ext.data.Model',
                fields: ['ID_RECOLECTOR','NOMBRE','ID_ZONA','ID_TIPO_RECOLECTOR']
            });
            
            Ext.define('recolectoresMdl',{
                id:'recolectoresMdl',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_RECOLECTOR'},
                    {name: 'NOMBRE'},                        
                    {name: 'ID_ZONA'},
                    {name: 'ZONA'},
                    {name: 'ID_TIPO_RECOLECTOR'},
                    {name: 'TIPO_RECOLECTOR'},
                    {name: 'ESTATUS'}
                ]
            });
            
            Ext.define('getInfoRecolectoresMdl',{
                id:'getInfoRecolectoresMdl',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_RECOLECTOR'},
                    {name: 'NOMBRE'},                        
                    {name: 'ID_ZONA'},
                    {name: 'ZONA'},
                    {name: 'ID_TIPO_RECOLECTOR'},
                    {name: 'TIPO_RECOLECTOR'},
                    {name: 'ESTATUS'}
                ]
            });
            
            /********************* STORES *************************/
            var statesZona = Ext.create('Ext.data.JsonStore', {
                model: 'catalogDos',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlaveDos', 
                    extraParams:{llave:'INGRESOS_ZONAS'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var storesTipoRecolectorPC = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_TIPO_RECOLECTOR'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var storeRecolectoresCat = Ext.create('Ext.data.JsonStore', {
                model: 'recolectoresCat',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getRecolectoresEspeciales',                      
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var storeRecolectoresAlta = Ext.create('Ext.data.JsonStore', {                   
                model: 'recolectoresMdl',
                pageSize: 5,
                autoLoad:false,
                proxy: {
                    type: 'ajax',                       
                    url: 'donanteAC.do?method=getAllRecolectores', 
                    //extraParams:{idDonante:idDonanteTmp},
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'//Paginacion                
                    }
                }
            });
            
            var storeRecolectorUpdateInfo = Ext.create('Ext.data.JsonStore', {
                model: 'getInfoRecolectoresMdl',
                pageSize: 50,
                id:'storeRecolectorUpdateInfo',
                name:'storeRecolectorUpdateInfo',
                proxy: {
                    type: 'ajax',
                    url: 'donanteAC.do',
                    extraParams: {method: 'getInfoRecolector'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
            
            var storeRecibosEspeciales = Ext.create('Ext.data.JsonStore', {                   
                model: 'pagosConfirmadosCat',
                pageSize: 5,
                autoLoad:false,
                proxy: {
                    type: 'ajax',                       
                    url: 'donanteAC.do?method=getRecibosEspeciales',
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'//Paginacion                
                    }
                }
            });
            
            var storeEstatus = Ext.create('Ext.data.Store', {
                fields: ['nombre', 'id'],
                data : [
                    {"nombre":"Activo", "id":"1"},
                    {"nombre":"Inactivo", "id":"0"}
                ]
            });
            
            function loadInfoRecolectorUpdate(ID_RECOLECTOR){                
                storeRecolectorUpdateInfo.proxy.extraParams.ID_RECOLECTOR = ID_RECOLECTOR;
                storeRecolectorUpdateInfo.load({ callback: function(records,o,s){
                        if(records.length > 0){
                            var ID_TIPO_RECOLECTOR      = records[0].data.ID_TIPO_RECOLECTOR;
//                            var ID_ZONA                 = records[0].data.ID_ZONA;
                            var estatusRec              = records[0].data.ESTATUS;
                            
                            
                            Ext.getCmp('NOMBRE').setValue(records[0].data.NOMBRE);
                            storesTipoRecolectorPC.load({callback: function(records,o,s){
                                Ext.getCmp('ID_TIPO_RECOLECTOR').setValue(parseInt(ID_TIPO_RECOLECTOR,10));                                
                                storeEstatus.load({callback: function(records,o,s){                                
                                    Ext.getCmp('ESTATUS_REC').setValue(estatusRec);
                                }});
                                
                            }});                        
                            storeEstatus.load({callback: function(records,o,s){                                
                                Ext.getCmp('ESTATUS_REC').setValue(parseInt(estatusRec,10));                                
                            }});
//                            statesZona.load({callback: function(records,o,s){
//                                Ext.getCmp('ID_ZONA').setValue(parseInt(2,10));
//                            }});
                            
                        }                            
                    } 
                    
                }); //Cierra storeDonativoInfo 
            }
            
            /********************* INICIA PANTALLA *************************/
            Ext.define('donantes.recolectores', {
                extend: 'Ext.window.Window',                    
                alias:'widget.recolectores',                   
                title: 'Recolectores',
                constrain : true,
                model: true,
                width: 1000,                
                height: 600,
                border: false,
                buttonAlign: 'left',
                closeAction:'destroy',
                maximizable: true,
                layout: 'fit',                    
                region:'center',
                initComponent: function() {
                    /********************* INICIALIZAR VALORES *************************/
                    winRecolectores = this;                  
                    
                    /********************* TOOLBAR *************************/
                    tbarAltaRecolectores = new Ext.Toolbar({
                        items: [
                            new Ext.Button({
                                text: 'Guardar',
                                iconCls: 'icon-save',
                                handler: function(){
                                    var json = winRecolectores.getDatas();
//                                    alert("Guardar: "+json);
                                    Ext.Msg.confirm('Agregar Recolector', '¿Los datos son correctos?', function(btn, text){
                                        if (btn == 'yes'){
                                            Ext.getCmp('frmRecolectores').getForm().submit({
                                                url: 'donanteAC.do?method=saveRecolector&jsonData='+json,
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {
                                                    Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                                    storeRecolectoresAlta.load();
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                }
                                            });
                                        }
                                    })
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Modificar',
                                iconCls: 'icon-editar',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridRecolectores').selModel.selected.items[0];
                                    if(selectedRow!=undefined){                                        
                                        var idRecolectorr = selectedRow.data.ID_RECOLECTOR;
                                        loadInfoRecolectorUpdate(idRecolectorr);                                        
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el recolector que desea modificar!');
                                    }
                                }   
                            }),
                            '-',
                            new Ext.Button({
                                text:'Eliminar',                                                                
                                iconCls: 'icon-delete',
                                handler: function() {
                                    var selectedRow=Ext.getCmp('gridRecolectores').selModel.selected.items[0]; 
                                    if(selectedRow!=undefined){                                        
                                        Ext.Msg.confirm('Eliminar Recolector', '¿Esta seguro de eliminar este recolector y su historial?', function(btn, text){
                                            if (btn == 'yes'){
                                                Ext.Ajax.request({  
                                                    url : 'donanteAC.do?method=deleteRecolector' ,
                                                    params : { 
                                                        ID_RECOLECTOR:selectedRow.data.ID_RECOLECTOR
                                                    },
                                                    method: 'GET',
                                                    success: function ( result, request ) {
                                                        Ext.MessageBox.alert('Guardado','El recolector se elimino correctamente');
                                                        storeRecolectoresAlta.load();
                                                    },
                                                    failure: function ( result, request) {
                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al eliminar el recolector!');                                                
                                                    }
                                                });
                                            }                                            
                                        });                                        
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el recolector que desea eliminar! ¡Su historial se eliminará tambien!');
                                    }
                                }
                                        
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls: 'icon-salir',
                                handler: function(){                                            
                                    winRecolectores.close();                            
                                }   
                            })
                        ]
                    }); //termina toolbar dos
                    
                    tbarRecEspeciales = new Ext.Toolbar({
                        items: [
                            Ext.create('Ext.Button',{
                                text:'Buscar',
                                iconCls:'icon-find',
                                handler:function(){
                                    var FECHA_VISITA_TMP = Ext.getCmp('FECHA_VISITA').getValue();                                    
                                    //alert("Fecha: "+FECHA_VISITA_TMP);                                    
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Guardar',
                                iconCls: 'icon-save',
                                handler:function(){
                                    var selectedRow = Ext.getCmp('gridEspeciales').selModel.selected.items[0];
                                    var json = winRecolectores.getDatasEspeciales();
                                    var ID_BITACORA_TMP;
//                                    alert("selectedRow: "+selectedRow.data.ID_BITACORA);
//                                    alert("Guardar: "+json);
                                    Ext.Msg.confirm('Asignar','¿Desea asignar este recibo a este recolector?',function (btn){
                                        ID_BITACORA_TMP = selectedRow.data.ID_BITACORA;
                                        if(btn === 'yes'){                                            
                                            Ext.getCmp('frmEspeciales').getForm().submit({
                                                url: 'donanteAC.do?method=asignarReciboARecolectorEspecial&jsonData='+json+'&ID_BITACORA='+ID_BITACORA_TMP,
                                                waitMsg: 'Asignando...',
                                                success: function(result,request){                                                                                       
                                                    Ext.MessageBox.alert('Guardar','¡El recibo se ha asignado exitosamente!');
                                                    storeRecibosEspeciales.load();
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al asignar el recibo!');
                                                }
                                            });
                                        }
                                    });
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls: 'icon-salir',
                                handler: function(){                                            
                                    winRecolectores.close();                            
                                }   
                            })
                        ]
                    }); //termina toolbar dos
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'tabpanel',
                                height: 890,
                                width: 1000,
                                activeTab: 0,
                                border:false,
                                items:[
                                    /********************* INICIA TAB ALTA DE RECOLECTORES *************************/
                                    {
                                        xtype: 'panel',
                                        width: 989,
                                        height: 700,
                                        border:false,
                                        tbar: tbarAltaRecolectores,
                                        title: 'Alta de Recolectores',
                                        items:[
                                            {
                                                xtype: 'form',
                                                id: 'frmRecolectores',                                                
                                                items:[
                                                    {
                                                        xtype: 'fieldset',
                                                        height: 140,                                                
                                                        title: 'Agregar Recolector',
                                                        items:[
                                                            {
                                                                xtype: 'textfield',                                                        
                                                                id: 'NOMBRE',
                                                                fieldLabel: 'Nombre',                                                                    
                                                                size: 40,
                                                                labelWidth: 130
                                                            },
                                                            Ext.create('Ext.form.ComboBox',{
                                                                fieldLabel: 'Tipo de Recolector',
                                                                store: storesTipoRecolectorPC,
                                                                id: 'ID_TIPO_RECOLECTOR',
                                                                labelWidth: 130,
                                                                size: 40,                                                       
                                                                valueField: 'id',
                                                                displayField: 'nombre',                                                                
                                                                emptyText: 'Seleccione el tipo de Recolector...',
                                                                selectOnFocus: true                                                             
                                                            }),
                                                            Ext.create('Ext.form.ComboBox', {
                                                                fieldLabel: 'Zona',
                                                                name:'ID_ZONA',
                                                                id:'ID_ZONA',
                                                                emptyText:'Seleccione la zona...',
                                                                allowBlank:false,
                                                                editable:false,                                                        
                                                                labelWidth: 130,
                                                                size: 40,
                                                                store: statesZona,
                                                                queryMode: 'local',
                                                                displayField: 'nombre',
                                                                valueField: 'nombre2'
                                                            }),
                                                            Ext.create('Ext.form.ComboBox',{
                                                                fieldLabel: 'Estatus',
                                                                store: storeEstatus,
                                                                id: 'ESTATUS_REC',
                                                                labelWidth: 130,
                                                                size: 40,                                                       
                                                                valueField: 'id',
                                                                displayField: 'nombre',                                                                
                                                                emptyText: 'Seleccione...',
                                                                selectOnFocus: true                                                             
                                                            })                                                            
                                                        ] //Cierra items fieldset
                                                    }
                                                ]                                                
                                            },
                                            {
                                                xtype: 'grid',
                                                height: 363,                                                
                                                title: 'Recolectores',
                                                id: 'gridRecolectores',                                                
                                                store: storeRecolectoresAlta,
                                                columns: [
                                                    {
                                                        dataIndex: 'ID_RECOLECTOR',
                                                        text: 'ID',
                                                        flex: .02,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'NOMBRE',
                                                        text: 'Nombre',
                                                        flex: .1,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'ZONA',
                                                        text: 'Zona',
                                                        flex: .07,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'TIPO_RECOLECTOR',
                                                        text: 'Tipo',
                                                        flex: .04,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'ESTATUS',
                                                        text: 'Status',
                                                        flex: .03,
                                                        align:'center'
                                                    }
                                                ],  //Cierra columns
                                                viewConfig: {
                                                },
                                                selModel: Ext.create('Ext.selection.CheckboxModel', {
                                                }),
                                                bbar: new Ext.PagingToolbar({
                                                    pageSize: 10,
                                                    store: storeRecolectoresAlta,
                                                    displayInfo: true
                                                })
                                            }
                                        ] //Cierra items panel                                        
                                    },
                                    /********************* INICIA TAB LISTAS DE ESPECIALES *************************/
//                                    {
//                                        xtype: 'form',
//                                        width: 989,                                        
//                                        height: 650,
//                                        border:false,
//                                        id: 'frmEspeciales',
//                                        title: 'Lista de Especiales',
//                                        tbar: tbarRecEspeciales,                                        
//                                        items:[
//                                            {
//                                                xtype: 'container',
//                                                layout: {
//                                                    type: 'hbox'
//                                                },
//                                                items:[
//                                                    { //Container izq
//                                                        xtype: 'container',
//                                                        flex: 0.4,                                                
//                                                        margin: 1,
//                                                        items:[
//                                                            {
//                                                                xtype: 'fieldset',
//                                                                height: 70,
//                                                                title: 'Recolectores Especiales',
//                                                                items:[                                                                    
//                                                                    Ext.create('Ext.form.ComboBox', {
//                                                                        fieldLabel: 'Recolector',
//                                                                        name:'ID_RECOLECTOR',
//                                                                        id:'ID_RECOLECTOR',
//                                                                        emptyText:'Seleccione el Recolector',                                                            
//                                                                        editable:false,
//                                                                        width: 400,
//                                                                        labelWidth: 130,
//                                                                        size: 30,
//                                                                        store: storeRecolectoresCat,
//                                                                        queryMode: 'local',
//                                                                        displayField: 'NOMBRE',
//                                                                        valueField: 'ID_RECOLECTOR'
//                                                                    })                                                                    
//                                                                ]
//                                                            }
//                                                        ] //Cierra items container izq
//                                                    }, //Cierra container izq
//                                                    { //Container derecho
//                                                        xtype: 'container',
//                                                        flex: 0.4,                                                
//                                                        margin: 1,
//                                                        items:[
//                                                            {
//                                                                xtype: 'fieldset',
//                                                                height: 70,
//                                                                title: 'Filtros',
//                                                                items:[
//                                                                    {
//                                                                        xtype: 'datefield', 
//                                                                        id:'FECHA_VISITA',
//                                                                        labelWidth: 130,
//                                                                        size: 40,
//                                                                        fieldLabel: 'Fecha Visita'
//                                                                    }
//                                                                ]
//                                                            }
//                                                        ] //Cierra items container der
//                                                    } //Cierra container derecho
//                                                ] //Cierra items container principal
//                                            },
//                                            {
//                                                xtype: 'grid',
//                                                height: 428,                                                
//                                                title: 'Recibos Especiales',
//                                                id: 'gridEspeciales',                                                
//                                                store: storeRecibosEspeciales,
//                                                columns: [
//                                                    {
//                                                        dataIndex: 'ESTATUS_PAGO',
//                                                        text: 'Estatus',
//                                                        flex: .03,
//                                                        align:'center'                                                               
//                                                    },
//                                                    {
//                                                        dataIndex: 'NOMBRE',
//                                                        text: 'Donante',
//                                                        flex: .06
//                                                    },
//                                                    {
//                                                        dataIndex: 'NUM_PAGO',
//                                                        text: 'Pago',
//                                                        flex: .02
//
//                                                    },
//                                                    {
//                                                        dataIndex: 'IMPORTE',
//                                                        text: 'Importe',
//                                                        flex: .03,
//                                                        renderer: render_moneyConfirma
//                                                    },
//                                                    {
//                                                        dataIndex: 'DIRECCION',
//                                                        text: 'Direccion',
//                                                        flex: .1
//                                                    },                                                            
//                                                    {
//                                                        dataIndex: 'FORMA_PAGO',
//                                                        text: 'Forma de Pago',
//                                                        flex: .04
//                                                    },                                                            
//                                                    {
//                                                        dataIndex: 'REFERENCIA',
//                                                        text: 'Referencia',
//                                                        flex: .05
//                                                    }
//                                                ],  //Cierra columns
//                                                viewConfig: {
//                                                },
//                                                selModel: Ext.create('Ext.selection.CheckboxModel', {
//                                                }),
//                                                bbar: new Ext.PagingToolbar({
//                                                    pageSize: 10,
//                                                    store: storeRecibosEspeciales,
//                                                    displayInfo: true
//                                                })
//                                            }
//                                        ]//Cierra Items panel      
//                                    }
                                ] //Cierra items tabPanel
                            }
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                    donantes.recolectores.superclass.initComponent.apply(this, arguments);
                    statesZona.load();
                    storesTipoRecolectorPC.load();
                    storeRecolectoresAlta.load();
//                    storeRecibosEspeciales.load();
                    storeRecolectoresCat.load();
                    storeEstatus.load();
                }, //Cierra initComponent
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['NOMBRE',
                        'ID_TIPO_RECOLECTOR',
                        'ID_ZONA'
                    ]

                    var camposValue = {'NOMBRE':'',
                        'ID_TIPO_RECOLECTOR':0,
                        'ID_ZONA':0
                    };   
                            
                    var pos=0;
                    var value = '';                         
                        
                    for(pos=0;pos<camposName.length;pos++){
                        value = Ext.getCmp(camposName[pos]).getValue();
                        camposValue[camposName[pos]] = value;                                                         
                    }                                               
                    return Ext.encode(camposValue);
                },
                getDatasEspeciales: function(){
                    var camposName = [
                        'ID_RECOLECTOR'
                    ]
                    var camposValue = {
                        'ID_RECOLECTOR':0
                    }
                    var pos = 0;
                    var value = '';
                    
                    for(pos=0;pos<camposName.length;pos++){
                        value = Ext.getCmp(camposName[pos]).getValue();
                        camposValue[camposName[pos]] = value;                                                         
                    }                                               
                    return Ext.encode(camposValue);
                }
            }); //Cierra Ext.define
        </script>   
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
