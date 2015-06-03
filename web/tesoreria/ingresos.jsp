<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
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
<html>
    <head>       
        <script type="text/javascript">
        /******************** VARIABLES GLOBALES ***********************/
        var winIngresos;        
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        /******************** FUNCIONES ***********************/
        function render_money(v, p, record){
                return '$ '+v+'.00'
            }
            
        function render_money_ingresos(v, p, record){
            return '$ '+v+'.00'
        }
        
        /******************** MODELS ***********************/
        Ext.define('cobrosEfectivoMdl',{ 
            id:'cobrosEfectivoMdl',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'ID_BITACORA'},
                {name: 'ID_RECIBO'},
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
                {name: 'COMENTARIOS'},
                {name: 'FECHA_COBRO'},
                {name: 'FECHA_PAGO'},
                {name: 'FECHA_IMPRESION'},
                {name: 'FECHA_REPROGRAMACION'}
            ]
        });        
        
        Ext.define('cobrosEspecieMdl',{ 
            id:'cobrosEspecieMdl',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'ID_BITACORA'},
                {name: 'ID_RECIBO'},                             
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
                {name: 'COMENTARIOS'},
                {name: 'FECHA_COBRO'},
                {name: 'FECHA_PAGO'}
            ]
        });
        
        Ext.define('recibosEntregadosMdl',{ 
            id:'recibosEntregadosMdl',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'ID_BITACORA'},
                {name: 'ID_DONATIVO'},
                {name: 'ID_TIPO_DONATIVO'},                
                {name: 'TIPO_DONATIVO'},
                {name: 'ID_RECIBO'},
                {name: 'NOMBRE'},
                {name: 'IMPORTE'},
                {name: 'ID_TIPO_ENVIO'},
                {name: 'TIPO_ENVIO'},
                {name: 'DIRECCION'}                
            ]
        });
        
         Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });
        
        Ext.define('recolectoresIngresos',{// create the Data TIPO DE DIRECCION
            id:'recolectores',
            extend: 'Ext.data.Model',
            fields: ['id','nombre','idZona','idTipoRecolector']
        });
        
        
        var storeRecolectoresIngresos = Ext.create('Ext.data.JsonStore', {
            model: 'recolectoresIngresos',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getAllRecolectores',                      
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var stateszonasPC = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave',
                extraParams:{llave:'INGRESOS_ZONAS'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        /******************** INICIA PANTALLA ***********************/
        Ext.define('tesoreria.ingresos', {                    
            extend: 'Ext.window.Window',                    
            alias:'widget.ingresos',                
            title: 'Ingresos',
            width: 900,  
            constrain : true,
            height: 620,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            modal : true,
            closeAction : 'destroy',
            region:'center',
                initComponent: function() {
                    /******************** INICIALIZAR VALORES ***********************/
                    winIngresos = this;                    
                    /******************** STORE PARA GRIDS ***********************/
                    //Store para el grid de los cobros en efectivo
                    var storeCobrosEfectivo = Ext.create('Ext.data.JsonStore', {                   
                        model: 'cobrosEfectivoMdl',
                        pageSize: 50,
                        autoLoad: false,
                        proxy: {
                            type: 'ajax',                       
                            url: 'ingresosAC.do?method=getAllCobrosEfectivoPagados',                                     
                            reader: {
                                type: 'json',
                                root: 'rows',
                                totalProperty:'totalcount'//Paginacion                
                            }
                        }
                    });
                    
                    //Store para el grid de los cobros en ESPECIE
                    var storeCobrosEspecie = Ext.create('Ext.data.JsonStore', {                   
                        model: 'cobrosEspecieMdl',
                        pageSize: 50,
                        autoLoad: false,
                        proxy: {
                            type: 'ajax',                       
                            url: 'ingresosAC.do?method=getAllCobrosEspeciePagados',                                     
                            reader: {
                                type: 'json',
                                root: 'rows',
                                totalProperty:'totalcount'//Paginacion                
                            }
                        }
                    });
                    
                    //Store para el grid de los cobros en ESPECIE
                    var storeRecibosEntregados = Ext.create('Ext.data.JsonStore', {                   
                        model: 'recibosEntregadosMdl',
                        pageSize: 5,
                        autoLoad: false,
                        proxy: {
                            type: 'ajax',                       
                            url: 'ingresosAC.do?method=getAllRecibosEntregados',                                     
                            reader: {
                                type: 'json',
                                root: 'rows',
                                totalProperty:'totalcount'//Paginacion                
                            }
                        }
                    });                    
                    
                    /******************** TOOLBAR ***********************/
                    var tbUno = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Buscar',
                                iconCls: 'icon-find',
                                handler:function(){
                                    ID_RECOLECTOR_TMP = Ext.getCmp('ID_RECOLECTOR_INGRESOS_EFECTIVO').getValue();
                                    FECHA_VISITA_TMP = Ext.getCmp('FECHA_VISITA_INGRESOS_EFECTIVO').getValue();
                                    ID_ZONA_TMP = Ext.getCmp('ID_ZONA_INGRESOS_EFECTIVO').getValue();
                                    var FECHA_COBRO_1_TMP = Ext.getCmp('FECHA_COBRO_INGRESOS_EFECTIVO').getValue();
                                    var NOMBRE_DONANTE_1_TMP = Ext.getCmp('NOMBRE_DONANTE_INGRESOS_EFECTIVO').getValue();
                                    var NUM_RECIBO_1_TMP = Ext.getCmp('NUM_RECIBO_INGRESOS_EFECTIVO').getValue();                                    
                                    if(ID_RECOLECTOR_TMP == null) ID_RECOLECTOR_TMP = 0;
                                    if(ID_ZONA_TMP == null) ID_ZONA_TMP = 0;                                    
                                    if(NUM_RECIBO_1_TMP == null) NUM_RECIBO_1_TMP = null;
                                    //alert(FECHA_COBRO_1_TMP)
                                    storeCobrosEfectivo.proxy.extraParams = {
                                        ID_RECOLECTOR:ID_RECOLECTOR_TMP,
                                        FECHA_VISITA:FECHA_VISITA_TMP,
                                        ID_ZONA:ID_ZONA_TMP,
                                        FECHA_COBRO:FECHA_COBRO_1_TMP,
                                        NOMBRE_DONANTE:NOMBRE_DONANTE_1_TMP,
                                        NUM_RECIBO:NUM_RECIBO_1_TMP
                                    };
                                    storeCobrosEfectivo.load(); 
                                }
                            }),
                            '-',
                            Ext.create('Ext.Button',{
                                text:'Limpiar Filtros',
                                iconCls:'icon-clear',
                                handler: function(){                                                                                                                   
                                    Ext.getCmp('frmCobrosEfectivo').getForm().reset();
                                    ID_RECOLECTOR_TMP = Ext.getCmp('ID_RECOLECTOR_INGRESOS_EFECTIVO').getValue();
                                    FECHA_VISITA_TMP = Ext.getCmp('FECHA_VISITA_INGRESOS_EFECTIVO').getValue();
                                    if(FECHA_VISITA_TMP == null) FECHA_VISITA_TMP = null;
                                    if(ID_RECOLECTOR_TMP == null) ID_RECOLECTOR_TMP = 0;                                                       
                                    storeCobrosEfectivo.proxy.extraParams = {ID_RECOLECTOR:ID_RECOLECTOR_TMP,FECHA_VISITA:FECHA_VISITA_TMP};
                                    storeCobrosEfectivo.load();
                                }
                            }),
                            '-',
                            {
                                xtype: 'button',
                                text: 'Ver Información del donativo',
                                iconCls: 'icon-registro',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridCobrosEfectivo').selModel.selected.items[0];
                                    if(selectedRow!=undefined){                                       
                                        createNewObj2('donantes.bitacoraPagos',selectedRow.data.ID_DONATIVO);                                                                  
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea consultar!');
                                    }
                                }
                            },
                            '-',
                            new Ext.Button({
                                text:'Reenviar Dia Siguiente',
                                iconCls: 'icon-money',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridCobrosEfectivo').selModel.selected.items[0];
                                    var status = selectedRow.data.ID_ESTATUS_PAGO_TMP;                                 
                                    if(selectedRow!=undefined){
                                        if(status != 2777){ //Si no esta pagado
                                            createNewObj3('tesoreria.confirmacionCobro',selectedRow.data.ID_BITACORA,1);
                                        }else{
                                            if(idUsuario == 'RNUNEZ' || idUsuario == 'TMENDOZA' || idUsuario == 'AALVARADO'){
                                                createNewObj3('tesoreria.confirmacionCobro',selectedRow.data.ID_BITACORA,1);
                                            }else{
                                                Ext.MessageBox.alert('Error','¡Este recibo ya esta PAGADO!');
                                            }                                            
                                        }                                                                                                          
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
                                    }
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text:'Reenviar Despues',
                                iconCls: 'icon-money',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridCobrosEfectivo').selModel.selected.items[0];
                                    var status = selectedRow.data.ID_ESTATUS_PAGO_TMP;                                 
                                    if(selectedRow!=undefined){
                                        if(status != 2777){ //Si no esta pagado
                                            createNewObj3('tesoreria.confirmacionCobro',selectedRow.data.ID_BITACORA,0);
                                        }else{
                                            if(idUsuario == 'RNUNEZ' || idUsuario == 'TMENDOZA' || idUsuario == 'AALVARADO'){
                                                createNewObj3('tesoreria.confirmacionCobro',selectedRow.data.ID_BITACORA,0);
                                            }else{
                                                Ext.MessageBox.alert('Error','¡Este recibo ya esta PAGADO!');
                                            }                                            
                                        }                                                                                                          
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
                                    }
                                }
                            }),
                            '-',
                            Ext.create('Ext.Button',{
                                text:'Exportar Lista',
                                iconCls:'icon-xlsx',
                                handler:function(){
                                    window.open("ShowExcel?idOperationType=2");
                                }
                            }),
                            '-',
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    winIngresos.close();                            
                                }
                            })                            
                        ]
                    }); //Termina Toolbar
                    
                    var tbDos = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Buscar',
                                iconCls: 'icon-find',
                                handler:function(){                                                        
                                    ID_RECOLECTOR_TMP = Ext.getCmp('ID_RECOLECTOR_INGRESOS_ESPECIE').getValue();
                                    FECHA_VISITA_TMP = Ext.getCmp('FECHA_VISITA_INGRESOS_ESPECIE').getValue();
                                    ID_ZONA_TMP = Ext.getCmp('ID_ZONA_INGRESOS_ESPECIE').getValue();
                                    var NOMBRE_DONANTE_TMP = Ext.getCmp('NOMBRE_DONANTE_ICEE').getValue();
                                    var FECHA_COBRO_TMP = Ext.getCmp('FECHA_COBRO_INGRESOS_ESPECIE').getValue();
                                    var NUM_RECIBO_TMP = Ext.getCmp('NUM_RECIBO_INGRESOS_ESPECIE').getValue();
                                    if(FECHA_VISITA_TMP == null) FECHA_VISITA_TMP = null;
                                    if(ID_RECOLECTOR_TMP == null) ID_RECOLECTOR_TMP = 0;
                                    if(ID_ZONA_TMP == null) ID_ZONA_TMP = 0;                                                        
                                    storeCobrosEspecie.proxy.extraParams = {
                                        ID_RECOLECTOR:ID_RECOLECTOR_TMP,
                                        FECHA_VISITA:FECHA_VISITA_TMP,
                                        ID_ZONA:ID_ZONA_TMP,
                                        NOMBRE_DONANTE:NOMBRE_DONANTE_TMP,
                                        FECHA_COBRO:FECHA_COBRO_TMP,
                                        NUM_RECIBO:NUM_RECIBO_TMP
                                    };
                                    storeCobrosEspecie.load(); 
                                }
                            }),
                            '-',
                            Ext.create('Ext.Button',{
                                text:'Limpiar Filtros',
                                iconCls:'icon-clear',
                                handler: function(){                                                                                                                   
                                    Ext.getCmp('frmCobrosEspecie').getForm().reset();
                                    ID_RECOLECTOR_TMP = Ext.getCmp('ID_RECOLECTOR_INGRESOS_ESPECIE').getValue();
                                    FECHA_VISITA_TMP = Ext.getCmp('FECHA_VISITA_INGRESOS_ESPECIE').getValue();
                                    if(FECHA_VISITA_TMP == null) FECHA_VISITA_TMP = null;
                                    if(ID_RECOLECTOR_TMP == null) ID_RECOLECTOR_TMP = 0;                                                       
                                    storeCobrosEspecie.proxy.extraParams = {ID_RECOLECTOR:ID_RECOLECTOR_TMP,FECHA_VISITA:FECHA_VISITA_TMP};
                                    storeCobrosEspecie.load();
                                }
                            }),
                            '-', 
                            {
                                xtype: 'button',
                                text: 'Ver Información del donativo',
                                iconCls: 'icon-registro',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridCobrosEfectivo').selModel.selected.items[0];
                                    if(selectedRow!=undefined){                                       
                                        createNewObj2('donantes.bitacoraPagos',selectedRow.data.ID_DONATIVO);                                                                  
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea consultar!');
                                    }
                                }
                            },
                            new Ext.Button({
                                text:'Confirmar Cobro',
                                iconCls: 'icon-money',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridCobrosEfectivo').selModel.selected.items[0];
                                                                     
                                    if(selectedRow!=undefined){
                                        if(status != 2777){ //Si no esta pagado
                                            createNewObj3('tesoreria.confirmacionCobro',selectedRow.data.ID_BITACORA,0);
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Este recibo ya esta PAGADO!');
                                        }                                                                                                          
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
                                    }
                                    
                                    
                                    
                                    var selectedRow = Ext.getCmp('gridCobrosEspecie').selModel.selected.items[0];
                                    var status      = selectedRow.data.ID_ESTATUS_PAGO_TMP;
                                    if(selectedRow!=undefined){
                                        if(status != 2777){ //Si no esta pagado
                                            createNewObj2('tesoreria.confirmacionCobro',selectedRow.data.ID_BITACORA);
                                        }else{
                                            Ext.MessageBox.alert('Error','¡Este recibo ya esta PAGADO!');
                                        }                                                                                     
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
                                    }
                                }
                            }),
                            '-',                           
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    winIngresos.close();                            
                                }
                            })                            
                        ]
                    }); //Termina Toolbar
                    
                var tbTres = new Ext.Toolbar({
                        items:[                      
                            new Ext.Button({
                                text:'Buscar',
                                iconCls: 'icon-find'
                            }),
                            '-', 
                            {
                                xtype: 'button',
                                text: 'Ver Información del donativo',
                                iconCls: 'icon-registro',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('gridCobrosEfectivo').selModel.selected.items[0];
                                    if(selectedRow!=undefined){                                       
                                        createNewObj2('donantes.bitacoraPagos',selectedRow.data.ID_DONATIVO);                                                                  
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el pago que desea consultar!');
                                    }
                                }
                            },
                            new Ext.Button({
                                text:'Confirmar Entrega',
                                iconCls: 'icon-money',
                                handler: function(){
                                    var selectedRow = Ext.getCmp('griRecibos').selModel.selected.items[0];
                                    if(selectedRow!=undefined){                                       
                                        createNewObj2('tesoreria.confirmacionRecibos',selectedRow.data.ID_BITACORA);                                                                  
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea confirmar!');
                                    }
                                }
                            }),
                            '-',                                                      
                            new Ext.Button({
                                text: 'Salir',
                                iconCls:'icon-salir',
                                handler: function(){
                                    winIngresos.close();                            
                                }
                            })                            
                        ]
                    }); //Termina Toolbar                          
                    
                Ext.apply(this, {
                    items:[
                    {
                        xtype: 'tabpanel',
                        height: 890,                        
                        activeTab: 0,
                        border: false,
                        items:[
                            /**************************** PESTAÑA COBROS EN EFECTIVO *************************************/
                            {
                                xtype: 'panel',                          
                                border:false,
                                tbar: tbUno,
                                title: 'Cobros en Efectivo',
                                items: [
                                    {
                                        xtype: 'form',  
                                        id: 'frmCobrosEfectivo',
                                        border: false,
                                        items:[
                                            {
                                                xtype: 'fieldset',
                                                height: 193,
                                                title: 'Filtros',
                                                items:[
                                                    Ext.create('Ext.form.ComboBox',{
                                                        fieldLabel: 'Zona',
                                                        id:'ID_ZONA_INGRESOS_EFECTIVO',
                                                        store: stateszonasPC,                                                                                                                                                                                                                          
                                                        labelWidth: 130,
                                                        width: 400,                                                                        
                                                        valueField: 'id',
                                                        displayField: 'nombre',                                                                        
                                                        emptyText: 'Seleccione el tipo de Zona...',
                                                        selectOnFocus: true
                                                    }),
                                                    Ext.create('Ext.form.ComboBox', {
                                                        fieldLabel: 'Recolector',
                                                        name:'ID_RECOLECTOR',
                                                        id:'ID_RECOLECTOR_INGRESOS_EFECTIVO',
                                                        emptyText:'Seleccione el Recolector',                                                            
                                                        editable:false,
                                                        width: 400,
                                                        labelWidth: 130,
                                                        size: 30,
                                                        store: storeRecolectoresIngresos,
                                                        queryMode: 'local',
                                                        displayField: 'nombre',
                                                        valueField: 'id'
                                                    }),
                                                    {
                                                        xtype: 'datefield',
                                                        width: 325,
                                                        labelWidth: 130,
                                                        fieldLabel: 'Fecha Visita',
                                                        id: 'FECHA_VISITA_INGRESOS_EFECTIVO'                                                            
                                                    },
                                                    {                                                                    
                                                        xtype: 'datefield',
                                                        width: 325,                                                                    
                                                        fieldLabel: 'Fecha Cobro',
                                                        id: 'FECHA_COBRO_INGRESOS_EFECTIVO', 
                                                        labelWidth: 130
                                                    },
                                                    {
                                                        xtype: 'textfield',
                                                        fieldLabel:'Nombre',
                                                        id:'NOMBRE_DONANTE_INGRESOS_EFECTIVO',                                                                    
                                                        labelWidth: 130,
                                                        width: 500,
                                                        size: 250                                   
                                                    },
                                                    {
                                                        xtype: 'numberfield',
                                                        id: 'NUM_RECIBO_INGRESOS_EFECTIVO', 
                                                        fieldLabel: 'Recibo',
                                                        hideTrigger: true,
                                                        labelWidth: 130,
                                                        size: 10
                                                    }
                                                ] //Cierra items fieldset
                                            },
                                            {
                                                xtype: 'grid',                                                    
                                                height: 330,
                                                id: 'gridCobrosEfectivo',
                                                store: storeCobrosEfectivo,
                                                columns: [
                                                    {
                                                        dataIndex: 'ESTATUS_PAGO',
                                                        text: 'Estatus',
                                                        flex: .04,
                                                        align:'center'                                                               
                                                    },
                                                    {
                                                        dataIndex: 'ID_RECIBO',
                                                        text: 'Recibo',
                                                        flex: .03,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'NOMBRE',
                                                        text: 'Donante',
                                                        flex: .1
                                                    },
                                                    {
                                                        dataIndex: 'NUM_PAGO',
                                                        text: 'Pago',
                                                        flex: .02,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'IMPORTE',
                                                        text: 'Importe',
                                                        flex: .02,
                                                        align:'center',
                                                        renderer: render_moneyConfirma
                                                    },
                                                    {
                                                        dataIndex: 'ID_DONATIVO',
                                                        text: 'Donativo',
                                                        flex: .03,
                                                        align:'center'
                                                    },
                                                    {
                                                        dataIndex: 'FECHA_IMPRESION',
                                                        text: 'Fecha Impresión',
                                                        flex: .04,
                                                        align:'center'
                                                    },
                                                    {                                                        
                                                        dataIndex: 'FECHA_REPROGRAMACION',
                                                        text: 'F. Reprogramación',
                                                        flex: .04,
                                                        align:'center'
                                                    }   
                                                ], //Cierra columns grid
                                                viewConfig: {

                                                },
                                                selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                }),
                                                bbar: new Ext.PagingToolbar({
                                                    pageSize: 50,
                                                    store: storeCobrosEfectivo,
                                                    displayInfo: true,
                                                    displayMsg: '{0} - {1} of {2} Registros',  
                                                    emptyMsg: '¡No hay pagos confirmados el dia de hoy!'
                                                })
                                            }
                                        ] //Cierra items form
                                    }
                                ] //Cierra items cobros en efectivo
                            }                        
                        ] //Cierre items tabPanel
                    }  
                    ] //Cierra items ext.apply
                }); //Cierra Ext.apply 
                storeCobrosEfectivo.load();
                storeCobrosEspecie.load();
                storeRecibosEntregados.load();
                storeRecolectoresIngresos.load();
                tesoreria.ingresos.superclass.initComponent.apply(this, arguments);
               
                } //Cierra initComponent                        
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>
