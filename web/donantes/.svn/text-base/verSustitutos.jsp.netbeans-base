<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
        /***************** VARIABLES GLOBALES *********************/
        var winSustitutos
        var idDonanteLocal
        
        
        /***************** MODELS *********************/
        Ext.define('SustitutosMdl',{// create the Data direccionDonantes
            id:'SustitutosMdl',
            extend: 'Ext.data.Model',
            fields:     [
                {name: 'ID_DONANTE_SUSTITUTO'},
                {name: 'ID_DONANTE_PADRE'},
                {name: 'RAZON_SOCIAL'},
                {name: 'RFC'},
                {name: 'CURP'},
                {name: 'TELEFONO'},
                {name: 'EMAIL'},
                {name: 'CALLE'},
                {name: 'NUMERO'},
                {name: 'COLONIA'},
                {name: 'CP'},
                {name: 'ESTADO'},
                {name: 'MUNICIPIO'}                               
            ]
        });
        
        Ext.define('nameDonanteInf',{
            id:'nameDonanteInf',
            extend: 'Ext.data.Model',
            fields: [                       
                'NOMBRE'                        
            ]
        });
        
        Ext.define('DonantePadreMdl',{// create the Data direccionDonantes
            id:'DonantePadreMdl',
            extend: 'Ext.data.Model',
            fields:     [
                {name: 'ID_DONANTE_SUSTITUTO'},
                {name: 'ID_DONANTE_PADRE'},
                {name: 'RAZON_SOCIAL'},
                {name: 'RFC'},
                {name: 'CURP'},
                {name: 'TELEFONO'},
                {name: 'EMAIL'},
                {name: 'CALLE'},
                {name: 'NUMERO'},
                {name: 'COLONIA'},
                {name: 'CP'},
                {name: 'ESTADO'},
                {name: 'MUNICIPIO'}                               
            ]
        });
        
        var storeInfoDonantePadre  = Ext.create('Ext.data.JsonStore', {
            model: 'DonantePadreMdl',
            pageSize: 50,
            id:'storeInfoDonantePadre',
            name:'storeInfoDonantePadre',
            proxy: {
                type: 'ajax',
                url: 'donanteAC.do',
                extraParams: {method: 'getDonativoInfo'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
       /***************** FUNCIONES JAVASCRIPT *********************/
       function loadNombreSustitutos(idDonante){
            storeNameInfo.proxy.extraParams.ID_DONANTE = idDonante;
            storeNameInfo.load({ callback: function(records,o,s){
                    if(records.length > 0){
                        Ext.getCmp('gralNombre').setValue(records[0].data.NOMBRE);
                        Ext.getCmp('gralIdDonante').setValue(idDonante);                        
                    }
                }
            });               
        }
        
        /*********************** STORES *******************************/
        var storeNameInfo = Ext.create('Ext.data.JsonStore', {
            model: 'nameDonanteInf',
            pageSize: 50,
            id:'storeNameInfo',
            name:'storeNameInfo',
            proxy: {
                type: 'ajax',
                url: 'donativoAC.do',
                extraParams: {method: 'getNameDonante'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
       
       
       
       
       /***************** INICIA PANTALLA *********************/
       Ext.define('donantes.verSustitutos', {
            extend: 'Ext.window.Window',                    
            alias:'widget.verSustitutos',                
            title: 'Donantes Sustitutos',
            width: 950,  
            height: 320,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            modal: true,
            layout: 'fit',
            closeAction:'close',
            autoDestroy:true,
            region:'center',
            constrain:true,
            initComponent: function() {
                winSustitutos = this;
                idDonanteLocal = this.name;
                loadNombreSustitutos(idDonanteLocal);
                /************ TOOLBAR ***************/
                var tbVerSustituto = new Ext.Toolbar({
                    items:[ 
                        new Ext.Button({
                            text: 'Actualizar Datos',
                            iconCls:'icon-reload',
                            disabled: true,
                            handler: function(){                                
                                var selectedRow = Ext.getCmp('gridSustitutos').selModel.selected.items[0];
                                //alert("idDonanteSustituto: "+selectedRow.data.ID_DONANTE_SUSTITUTO);
                                if(selectedRow!=undefined){
                                    createNewObj3('donantes.addSustituto',selectedRow.data.ID_DONANTE_SUSTITUTO,1);                            
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el sustituto que desea modificar!');
                                }
                                //createNewObj2('donantes.addSustituto',ID_DONANTE);
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text:'Eliminar',                                                                
                            iconCls: 'icon-delete',
                            handler: function() {
                                var selectedRow=Ext.getCmp('gridSustitutos').selModel.selected.items[0]; 
                                if(selectedRow!=undefined){                                     
                                    Ext.Msg.confirm('Eliminar Sustituto', '¿Esta seguro de eliminar el sustituto? Esta acción podria afectar/fallar en los recibos asignados y en reportes.', function(btn, text){
                                        if (btn == 'yes'){
                                            Ext.Ajax.request({  
                                                url : 'donanteAC.do?method=deleteSustituto' ,
                                                params : { 
                                                    ID_SUSTITUTO:selectedRow.data.ID_DONANTE_SUSTITUTO
                                                },
                                                method: 'GET',
                                                success: function ( result, request ) {
                                                    Ext.MessageBox.alert('Guardado','El sustituto se elimino correctamente');
                                                    storeDonantesSustitutos.load();
                                                },
                                                failure: function ( result, request) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al eliminar el sustituto!');                                                
                                                }
                                            });
                                        }                                            
                                    });                                        
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el sustituto que desea eliminar!');
                                }
                            }
                        }),
                        '-',
                        new Ext.Button({
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                
                                winSustitutos.destroy();
                            }
                        })                            
                    ]
                }); //Termina Toolbar                
                
                /***************** STORES *********************/
                var storeDonantesSustitutos = Ext.create('Ext.data.JsonStore', {// create the Store direccionDonantes
                    model: 'SustitutosMdl', 
                    pageSize: 50,
                    autoLoad:false, 
                    proxy: {
                        type: 'ajax',
                        url: 'donanteAC.do?method=getDonantesSustitutos',
                        extraParams:{idDonante:idDonanteLocal},
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty:'totalcount'

                        }
                    }
                });
                
                Ext.apply(this, {
                    items:[
                        {
                            xtype: 'form',
                            id: 'pnlVerSustitutos',
                            tbar: tbVerSustituto,
                            items:[
                                {
                                    xtype: 'fieldset',
                                    title: 'Datos Fiscales', 
                                    height: 80,
                                    items:[
                                        {
                                            xtype: 'displayfield',
                                            width: 293,
                                            id: 'gralIdDonante',//                                          
                                            labelWidth: 100,
                                            fieldLabel: 'ID'
                                        },
                                        {
                                            xtype: 'displayfield',
                                            width: 293,
                                            id: 'gralNombre',//                                          
                                            labelWidth: 100,
                                            fieldLabel: 'Donante'
                                        }
                                    ] //Cierra items fieldset superior
                                },
                                {
                                    xtype: 'grid',
                                    height: 170,
                                    title: 'Donantes Sustitutos',
                                    id:'gridSustitutos',                                   
                                    store: storeDonantesSustitutos,
                                    columns:[
                                        {
                                            dataIndex: 'ID_DONANTE_SUSTITUTO',
                                            text: 'Id',
                                            flex: .02,                                            
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'RAZON_SOCIAL',
                                            text: 'Razon Social',
                                            flex: .1,                                            
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'RFC',
                                            text: 'RFC',
                                            flex: .05,                                            
                                            align:'left'
                                        },
                                        {
                                            dataIndex: 'CURP',
                                            text: 'CURP',
                                            flex: .05,                                            
                                            align:'left'
                                        },
                                        {
                                            dataIndex: 'TELEFONO',
                                            text: 'Telefono',
                                            flex: .04,                                            
                                            align:'left'
                                        },
                                        {
                                            dataIndex: 'CALLE',
                                            text: 'Calle',
                                            flex: .05,                                            
                                            align:'left'
                                        },
                                        {
                                            dataIndex: 'NUMERO',
                                            text: 'Numero',
                                            flex: .03,                                            
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'COLONIA',
                                            text: 'Colonia',
                                            flex: .05,                                            
                                            align:'left'
                                        },
                                        {
                                            dataIndex: 'CP',
                                            text: 'CP',
                                            flex: .03,                                            
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'ESTADO',
                                            text: 'Estado',
                                            flex: .04,                                            
                                            align:'center'
                                        },
                                        {
                                            dataIndex: 'MUNICIPIO',
                                            text: 'Municipio',
                                            flex: .04,                                            
                                            align:'center'
                                        }
                                    ], //Cierra columns del grid
                                    viewConfig: {
                                
                                    },
                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                    }),
                                    bbar: new Ext.PagingToolbar({
                                        pageSize: 10,
                                        store: storeDonantesSustitutos,
                                        displayInfo: true
                                    })
                                }
                            ] //Cierra items form principal
                        }                        
                    ] //Cierra items Ext.apply
                }); //Cierra Ext.apply
                donantes.verSustitutos.superclass.initComponent.apply(this, arguments);
                storeDonantesSustitutos.load();
            } //Cierra initComponent
       }); //Cierra Ext.define
       
       
        </script>
    </head>
    <body>
        <div id="contenedor"></div>                    
    </table>
</body>
</html>