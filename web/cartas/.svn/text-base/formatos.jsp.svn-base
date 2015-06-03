<%-- 
    Document   : formatos
    Created on : 11/04/2012, 03:34:58 PM
    Author     : rnunez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            Ext.onReady(function() {
                // combobos de camp. fin 
            
                Ext.define('catalog',{
                    id:'catalog',
                    extend: 'Ext.data.Model',
                    fields: ['id','id_catalog','nombre','status']
                });
                
                
                var cbxCampFinanciera = Ext.create('Ext.data.JsonStore', {
                    model: 'catalog',
                    proxy: {
                        type: 'ajax',
                        url: 'comboboxAC.do?method=getCatalogByLlave',
                        extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                        reader: {
                            type: 'json',
                            root: 'rows'
                        }
                    }
                });
                
                 /********************* STORES PARA COMBOBOX *************************/
            var cbxCartas = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', 
                    extraParams:{llave:'INGRESOS_CARTAS'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  
            
                var cbxCampFinancieraListaCandidatos = Ext.create('Ext.data.JsonStore', {
                    model: 'catalog',
                    proxy: {
                        type: 'ajax',
                        url: 'comboboxAC.do?method=getCatalogByLlave',
                        extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                        reader: {
                            type: 'json',
                            root: 'rows'
                        }
                    }
                });
                var cbxCampFinancieraListaCandidatosF = Ext.create('Ext.data.JsonStore', {
                    model: 'catalog',
                    proxy: {
                        type: 'ajax',
                        url: 'comboboxAC.do?method=getCatalogByLlave',
                        extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                        reader: {
                            type: 'json',
                            root: 'rows'
                        }
                    }
                });
                
                 /********************* STORES PARA COMBOBOX *************************/
            var cbxCartasListaCandidatos = Ext.create('Ext.data.JsonStore', {
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', 
                    extraParams:{llave:'INGRESOS_CARTAS'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });  
            
            
            //LISTA CARTAS INICIA
             Ext.define('gridDonanteCarta',{// create the Data 
                id:'gridDonanteCarta',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_DONANTE'},
                    {name: 'DONANTE'},
                    {name: 'CALLE'},
                    {name: 'COLONIA'},
                    {name: 'MUNICIPIO'},
                    {name: 'TEL_CASA'}
                  
                ]
            });
            
            
            var storegridDonanteCarta = Ext.create('Ext.data.JsonStore', {// create the Store 
                model: 'gridDonanteCarta',
                pageSize: 50,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'cartasAC.do?method=getAllGrid_DonantesCartas', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                
                    }
                }
            });   
            
             Ext.define('gridListaCartas',{// create the Data 
                id:'gridListaCartas',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_DONANTE'},
                    {name: 'ID_ESTATUS_CARTA'},
                    {name: 'DONANTE'},
                    {name: 'CALLE'},
                    {name: 'COLONIA'},
                    {name: 'MUNICIPIO'},
                    {name: 'TEL_CASA'}
                  
                ]
            });
            
            
            var storegridListaCartas = Ext.create('Ext.data.JsonStore', {// create the Store 
                model: 'gridListaCartas',
                pageSize: 50,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'cartasAC.do?method=getAllGrid_listaCartas', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                
                    }
                }
            });   
            
            //LISTA CARTAS FIN
            
            //LISTA CANDIDATOS INICIA
            
            Ext.define('gridDonanteCandidato',{// create the Data 
                id:'gridDonanteCandidato',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'ID_DONANTE'},
                    {name: 'DONANTE'},
                    {name: 'CALLE'},
                    {name: 'COLONIA'},
                    {name: 'MUNICIPIO'},
                    {name: 'TEL_CASA'}
                  
                ]
            });
            
            
            var storegridDonanteCandidato = Ext.create('Ext.data.JsonStore', {// create the Store 
                model: 'gridDonanteCandidato',
                pageSize: 50,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'cartasAC.do?method=getAllGrid_DonantesCandidato', 
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                
                    }
                }
            });   
            
            //LISTA CANDIDATOS FIN
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                var campFin = [
                    ['1', 'Campaña A'],
                    ['2', 'Campaña B'],
                    ['3', 'Campaña C'],
                    ['4', 'Campaña D'],
                    ['5', 'Campaña E']]; 
                // combobos de tipo de cartas tab 
                var tipoCarta = [
                    ['1', 'Petición'],
                    ['2', 'Agradecimiento']]; 
                //Grid panel de formatos de cartas
                var storeFormatos = Ext.create('Ext.data.JsonStore', ({
                    fields:[{name: 'idCarta'},                    
                        {name: 'tipoCarta'},
                        {name: 'nombre'}],
                    data: [
                        {idCarta:'1', tipoCarta:'Agradecimiento', nombre:'Agradecimiento'},
                        {idCarta:'2', tipoCarta:'Petición', nombre:'Petición'}                                     
                    ]
                }));    
                //Grid panel de candidatos tab lista de cartas
                var candidatosCartas = Ext.create('Ext.data.JsonStore', ({
                    fields:[{name: 'idDonante'},
                        {name: 'titulo'},
                        {name: 'donante'},
                        {name: 'calle'},
                        {name: 'colonia'},
                        {name: 'municipio'},
                        {name: 'telCasa'},
                        {name: 'telOficina'}],
                    data: [
                        {idDonante:'1', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375'},
                        {idDonante:'2', titulo:'Sra.', donante:'Omar Zamora', calle:'Las Flores', colonia:'Buenos Aires', municipio:'San Nicolas', telCasa:'83884434', telOficina:'17934596'},
                        {idDonante:'3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375'},
                        {idDonante:'4', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375'}
                    ]
                }));    
                //Grid panel de lista de cartas tab lista de cartas
                var listaCartas = Ext.create('Ext.data.JsonStore', ({
                    fields:[{name: 'idDonante'},
                        {name: 'status'},
                        {name: 'titulo'},
                        {name: 'donante'},
                        {name: 'calle'},
                        {name: 'colonia'},
                        {name: 'municipio'},
                        {name: 'telCasa'},
                        {name: 'telOficina'},
                        {name: 'comentarios'}],
                    data: [
                        {idDonante:'1', status: '1', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Se le marco y no se encontro'},
                        {idDonante:'2', status: '2', titulo:'Sra.', donante:'Omar Zamora', calle:'Las Flores', colonia:'Buenos Aires', municipio:'San Nicolas', telCasa:'83884434', telOficina:'17934596', comentarios:'Marcarle despues de las 3 pm'},
                        {idDonante:'3', status: '3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Anda de viaje'},
                        {idDonante:'4', status: '3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Ya donó'}
                    ]
                })); 
                //Grid panel de lista de candidatos en tab lista de cadndidatos
                var listaCandidatos = Ext.create('Ext.data.JsonStore', ({
                    fields:[{name: 'idCandidato '},
                        {name: '´nombre'},
                        {name: 'titulo'},
                        {name: 'donante'},
                        {name: 'calle'},
                        {name: 'colonia'},
                        {name: 'municipio'},
                        {name: 'telCasa'},
                        {name: 'telOficina'},
                        {name: 'comentarios'}],
                    data: [
                        {idDonante:'1', status: '1', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Se le marco y no se encontro'},
                        {idDonante:'2', status: '2', titulo:'Sra.', donante:'Omar Zamora', calle:'Las Flores', colonia:'Buenos Aires', municipio:'San Nicolas', telCasa:'83884434', telOficina:'17934596', comentarios:'Marcarle despues de las 3 pm'},
                        {idDonante:'3', status: '3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Anda de viaje'},
                        {idDonante:'4', status: '3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Ya donó'}
                    ]
                })); 
                //Grid panel de lista de candidatos en tab lista de cadndidatos
                var confirmaciones = Ext.create('Ext.data.JsonStore', ({
                    fields:[{name: 'idDonante '},
                        {name: '´nombre'},
                        {name: 'titulo'},
                        {name: 'donante'},
                        {name: 'calle'},
                        {name: 'colonia'},
                        {name: 'municipio'},
                        {name: 'telCasa'},
                        {name: 'telOficina'},
                        {name: 'comentarios'}],
                    data: [
                        {idDonante:'1', status: '1', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Se le marco y no se encontro'},
                        {idDonante:'2', status: '2', titulo:'Sra.', donante:'Omar Zamora', calle:'Las Flores', colonia:'Buenos Aires', municipio:'San Nicolas', telCasa:'83884434', telOficina:'17934596', comentarios:'Marcarle despues de las 3 pm'},
                        {idDonante:'3', status: '3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Anda de viaje'},
                        {idDonante:'4', status: '3', titulo:'Sr.', donante:'Ricardo Nuñez', calle:'Sierra Altamira', colonia:'Sierra Vista', municipio:'Monterrey', telCasa:'17673356', telOficina:'83228375', comentarios:'Ya donó'}
                    ]
                })); 
                //funcion de los estatus de colores
                function render_statusCartas(v, p, record){
                    if(v=="1"){
                        return "<img src='img/amarillo.png' width='20px'";
                    }  else if(v=="2"){
                        return "<img src='img/azul.png' width='20px'";
                    } else if(v=="3"){
                        return "<img width='20px' src='img/verde.png'>";                    
                    } else {
                        return "";
                    }
                }  
                //Creation Screen            
                Ext.define('cartas.formatos', {
                    extend: 'Ext.window.Window',                
                    alias:'widget.formatos',                
                    title: 'Cartas',
                    width: 878,                
                    height: 560,
                    border: false,
                    buttonAlign: 'left',
                    maximizable: true,
                    layout: 'fit',
                    closeAction : 'close',
                    region:'center',
                    initComponent: function() {
                        var winFormatos = this;
                        //Toolbar formatos de cartas
                        var tbFormatos = new Ext.Toolbar({
                            items:[
                                new Ext.form.Label({
                                    text: 'Cargar Nueva Plantilla' 
                                }),
                                new Ext.form.field.File({                                
                                    iconCls: 'icon-new-doc'
                                }),
                                new Ext.Button({
                                    text:'Agregar Plantilla',
                                    iconCls: 'upload-icon',
                                    handler: function() {
                                        createNewObj('Reportes.addDocument');                               
                                    }  
                                }),
                                '-',                      
                                new Ext.Button({
                                    text:'Ver Plantilla',
                                    iconCls: 'icon-edit-doc',
                                    handler: function() {
                                        createNewObj('cartas.editarCarta');                               
                                    } 
                                }),
                                '-',                            
                                new Ext.Button({
                                    text: 'Salir',
                                    iconCls:'icon-salir',
                                    handler: function(){
                                        winFormatos.close();                            
                                    }
                                })  
                            ] //Cierra items toolbar
                        }); //termina toolbarFormatos
                        var tbCartas = new Ext.Toolbar({
                            items:[                           
                                new Ext.Button({
                                    text:'Filtrar Candidatos',
                                    iconCls: 'icon-filter',
                                    handler: function() {
                                        createNewObj('cartas.nuevaCarta');                               
                                    }  
                                }),
                                '-',                      
                                new Ext.Button({
                                    text:'Generar Cartas',
                                    iconCls: 'icon-add',
                                    handler: function() {
                                        createNewObj('cartas.editarCarta');                               
                                    } 
                                }),
                                '-',
                                new Ext.Button({
                                    text:'Ver Datos Donante',
                                    iconCls: 'icon-add',
                                    handler: function() {
                                        createNewObj('cartas.editarCarta');                               
                                    } 
                                }),
                                {xtype:'tbseparator'},
                                        Ext.create('Ext.Button', {
                                            text: 'Expediente',
                                            iconCls:'icon-expediente',
                                            handler: function() {
                                                var obj=createNewObj('Reportes.addDocument')
                                            }
                                        }),
                                '-',                            
                                new Ext.Button({
                                    text: 'Salir',
                                    iconCls:'icon-salir',
                                    handler: function(){
                                        winFormatos.close();                            
                                    }
                                })  
                            ] //Cierra items toolbar
                        }); //termina toolbar lista de Cartas
                        //Toolbar lista de candidatos
                        var tbCandidatos = new Ext.Toolbar({
                            items:[
                                new Ext.Button({
                                    text:'Buscar',
                                    iconCls: 'icon-find',
                                    handler: function() {
                                        createNewObj('cartas.nuevaCarta');                               
                                    }  
                                }),
                                '-',
                                new Ext.form.Label({
                                    text: 'Agregar Candidatos' 
                                }),
                                new Ext.form.field.File({                  
                                }),
                                new Ext.Button({
                                    text:'Eliminar Candidatos',
                                    iconCls: 'icon-delete',
                                    handler: function() {
                                        createNewObj('cartas.nuevaCarta');                               
                                    }  
                                }),
                                '-',                      
                                new Ext.Button({
                                    text:'Ver Datos Completos',
                                    iconCls: 'icon-edit-doc',
                                    handler: function() {
                                        createNewObj('cartas.editarCarta');                               
                                    } 
                                }),
                                '-',                            
                                new Ext.Button({
                                    text: 'Salir',
                                    iconCls:'icon-salir',
                                    handler: function(){
                                        winFormatos.close();                            
                                    }
                                })  
                            ] //Cierra items toolbar
                        }); //termina toolbarCandidatos
                        var tbConfirmaciones = new Ext.Toolbar({
                            items:[                            
                                new Ext.Button({
                                    text: 'Buscar',
                                    iconCls: 'icon-find'
                                }),
                                new Ext.form.TextField({                          
                                }),
                                '-',                      
                                new Ext.Button({
                                    text:'Ver Datos Completos',
                                    iconCls: 'icon-edit-doc',
                                    handler: function() {
                                        createNewObj('cartas.editarCarta');                               
                                    } 
                                }),
                                '-',
                                new Ext.Button({
                                    text:'Confirmar Respuesta',
                                    iconCls: 'icon-editar',
                                    handler: function() {
                                        createNewObj('cartas.editarCarta');                               
                                    } 
                                }),
                                '-',
                                new Ext.Button({
                                    text: 'Salir',
                                    iconCls:'icon-salir',
                                    handler: function(){
                                        winFormatos.close();                            
                                    }
                                })  
                            ] //Cierra items toolbar
                        }); //termina toolbar Confirmaciones
                        Ext.apply(this, {
                            items:[
                                {  //TabPanel
                                    xtype: 'tabpanel',
                                    height: 890,
                                    width: 837,
                                    activeTab: 0,
                                    border:false,
                                    items:[
//                                        {
//                                            xtype: 'panel',
//                                            width: 865,
//                                            height: 870,
//                                            border:false,
//                                            title: 'Formatos de Cartas',
//                                            tbar: tbFormatos,
//                                            items:[
//                                                {
//                                                    xtype: 'grid',
//                                                    store: storeFormatos,
//                                                    height: 470,
//                                                    columns:[
//                                                        {
//                                                            dataIndex: 'idCarta',
//                                                            text: 'ID',
//                                                            flex: .01,
//                                                            align:'center'
//                                                        },
//                                                        {
//                                                            dataIndex: 'tipoCarta',
//                                                            text: 'Tipo de Carta',
//                                                            flex: .04,
//                                                            align:'left'
//                                                        },
//                                                        {
//                                                            dataIndex: 'nombre',
//                                                            text: 'Nombre',
//                                                            flex: .08,
//                                                            align:'left'
//                                                        }
//                                                    ], //Cierra columns
//                                                    viewConfig: {                       
//                                                    },
//                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {
//                                                    }),
//                                                    bbar: new Ext.PagingToolbar({
//                                                        pageSize: 1,
//                                                        store: storeFormatos,
//                                                        displayInfo: true
//                                                    }) //Cierra grid
//                                                } //Cierra items de grid panel de formatos
//                                            ] //Cierra items tab formato de cartas
//                                        }, //Cierra tab formato de cartas                                    
                                        {
                                            xtype: 'panel',
                                            width: 865,
                                            height: 870,
                                            border:false,
                                            title: 'Lista de Cartas',
                                            tbar: tbCartas,
                                            items:[
                                                {   // Container
                                                    xtype: 'container',
                                                    layout: {
                                                        type: 'hbox'
                                                    }, 
                                                    height: 200,
                                                    anchor: '100%',
                                                    items:[                                                    
                                                        {   //Fieldset izq
                                                            xtype: 'fieldset',
                                                            height: 200,
                                                            title: 'Filtros de Candidatos',
                                                            flex: 0.4,
                                                            items:[
                                                                Ext.create('Ext.form.ComboBox', {
                                                                    fieldLabel: 'Tipo de Carta',
                                                                    store: cbxCartas,
                                                                    id: 'TIPO_CARTA',
                                                                    emptyText: 'Seleccione el tipo de Carta',
                                                                    size: 30,
                                                                    displayField: 'nombre',
                                                                    valueField: 'id'
                                                                }),
                                                                {
                                                                    xtype: 'datefield',
                                                                    fieldLabel: 'Fecha Inicial'                                                                                                                                                                                               
                                                                },
                                                                {
                                                                    xtype: 'datefield',
                                                                    fieldLabel: 'Fecha Final'  
                                                                },
                                                                Ext.create('Ext.form.ComboBox', {
                                                                    fieldLabel: 'Campaña Fin.',
                                                                    store: cbxCampFinanciera,
                                                                    id: 'CAMPANA_FINANCIERA',
                                                                    emptyText: 'Seleccione la Campaña',
                                                                    size: 30,
                                                                    displayField: 'nombre',
                                                                    valueField: 'id'
                                                                })
                                                            
                                                            ]
                                                        },
                                                        { // Grid Panel
                                                            xtype: 'gridpanel',
                                                            height: 200,
                                                            store: storegridDonanteCarta,                                                        
                                                            flex: 0.6,
                                                            columns:[
                                                                {
                                                                    dataIndex: 'ID_DONANTE',
                                                                    text: 'ID',
                                                                    flex: .03,
                                                                    align:'center'
                                                                },
                                                                {
                                                                    dataIndex: 'DONANTE',
                                                                    text: 'DONANTE',
                                                                    flex: .05
                                                                },
                                                                {
                                                                    dataIndex: 'CALLE',
                                                                    text: 'CALLE',
                                                                    flex: .1
                                                                },
                                                                {
                                                                    dataIndex: 'COLONIA',
                                                                    text: 'COLONIA',
                                                                    flex: .1
                                                                },
                                                                {
                                                                    dataIndex: 'MUNICIPIO',
                                                                    text: 'MUNICIPIO',
                                                                    flex: .1
                                                                },
                                                                {
                                                                    dataIndex: 'TEL_CASA',
                                                                    text: 'TEL_CASA',
                                                                    flex: .1
                                                                }
                                                            ], //Cierra columns                                                        
                                                            viewConfig: {
                                                            },
                                                            selModel: Ext.create('Ext.selection.CheckboxModel', {
                                                            }),
                                                            bbar: new Ext.PagingToolbar({
                                                                pageSize: 1000,
                                                                store: storegridDonanteCarta,
                                                                displayInfo: true
                                                            })
                                                        } //Cierra gridpanel
                                                    ] //Cierra items de container
                                                }, //Cierra container
                                                {
                                                    xtype: 'gridpanel',
                                                    store: storegridListaCartas, 
                                                    title: 'Lista de Cartas',
                                                    height: 270,
                                                    flex: 0.6,
                                                    columns:[
                                                        {
                                                            dataIndex: 'ID_DONANTE',
                                                            text: 'ID',
                                                            flex: .03,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'ID_ESTATUS_CARTA',
                                                            text: 'Estatus',
                                                            align:'center',
                                                            flex: .05,                                                        
                                                            renderer: render_statusCartas
                                                        },
                                                        {
                                                            dataIndex: 'DONANTE',
                                                            text: 'DONANTE',
                                                            flex: .04
                                                        },
                                                        {
                                                            dataIndex: 'CALLE',
                                                            text: 'CALLE',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'COLONIA',
                                                            text: 'COLONIA',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'MUNICIPIO',
                                                            text: 'MUNICIPIO',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'TEL_CASA',
                                                            text: 'TEL_CASA',
                                                            flex: .1
                                                        }
                                                    ], //Cierra columns                                                        
                                                    viewConfig: {
                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {
                                                    }),
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 1000,
                                                        store: listaCartas,
                                                        displayInfo: true
                                                    })
                                                }
                                            ] //Cierra items tab lista de cartas
                                        }, //Cierra tab lista de cartas   
                                        {
                                            xtype: 'panel',
                                            width: 865,
                                            height: 670,
                                            border:false,
                                            title: 'Lista de Candidatos',
                                            tbar: tbCandidatos,
                                            items:[
                                                {   // Container
                                                    xtype: 'container',
                                                    layout: {
                                                        type: 'hbox'
                                                    }, 
                                                    height: 200,
                                                    anchor: '100%',
                                                    items:[                                                    
                                                        {   //Fieldset izq
                                                            xtype: 'fieldset',
                                                            height: 200,
                                                            title: 'Filtros de Candidatos',
                                                            flex: 0.4,
                                                            items:[
                                                                Ext.create('Ext.form.ComboBox', {
                                                                    fieldLabel: 'Tipo de Carta',
                                                                    store: cbxCartasListaCandidatos,
                                                                    id: 'TIPO_CARTA_LC',
                                                                    emptyText: 'Seleccione el tipo de Carta',
                                                                    size: 30,
                                                                    displayField: 'nombre',
                                                                    valueField: 'id'
                                                                }),
                                                                {
                                                                    xtype: 'datefield',
                                                                    fieldLabel: 'Fecha Inicial'                                                                                                                                                                                               
                                                                },
                                                                {
                                                                    xtype: 'datefield',
                                                                    fieldLabel: 'Fecha Final'  
                                                                },
                                                                Ext.create('Ext.form.ComboBox', {
                                                                    fieldLabel: 'Campaña Fin.',
                                                                    store: cbxCampFinancieraListaCandidatos,
                                                                    id: 'CAMPANA_FINANCIERA_LC',
                                                                    emptyText: 'Seleccione la Campaña',
                                                                    size: 30,
                                                                    displayField: 'nombre',
                                                                    valueField: 'id'
                                                                })
                                                            ]
                                                        },
                                                        { // Grid Panel
                                                            xtype: 'gridpanel',
                                                            height: 200,
                                                            store: storegridDonanteCandidato,                                                        
                                                            flex: 0.6,
                                                            columns:[
                                                                {
                                                                    dataIndex: 'ID_DONANTE',
                                                                    text: 'ID',
                                                                    flex: .03,
                                                                    align:'center'
                                                                },
                                                                {
                                                                    dataIndex: 'DONANTE',
                                                                    text: 'DONANTE',
                                                                    flex: .05
                                                                },
                                                                {
                                                                    dataIndex: 'CALLE',
                                                                    text: 'CALLE',
                                                                    flex: .1
                                                                },
                                                                {
                                                                    dataIndex: 'COLONIA',
                                                                    text: 'COLONIA',
                                                                    flex: .1
                                                                },
                                                                {
                                                                    dataIndex: 'MUNICIPIO',
                                                                    text: 'MUNICIPIO',
                                                                    flex: .1
                                                                },
                                                                {
                                                                    dataIndex: 'TEL_CASA',
                                                                    text: 'TEL_CASA',
                                                                    flex: .1
                                                                }
                                                            ], //Cierra columns                                                        
                                                            viewConfig: {
                                                            },
                                                            selModel: Ext.create('Ext.selection.CheckboxModel', {
                                                            }),
                                                            bbar: new Ext.PagingToolbar({
                                                                pageSize: 1000,
                                                                store: storegridDonanteCandidato,
                                                                displayInfo: true
                                                            })
                                                        } //Cierra gridpanel
                                                    ] //Cierra items de container
                                                }, //Cierra container
                                                {
                                                    xtype: 'container',                                    
                                                    anchor: '100%',
                                                    items:[
                                                        {
                                                            xtype: 'fieldset',
                                                            margin: 5,
                                                            title: 'Filtros Candidatos',
                                                            items:[
                                                                {
                                                                    xtype: 'datefield',
                                                                    fieldLabel: 'Fecha Inicial'                                                                                                                                                                                               
                                                                },
                                                                {
                                                                    xtype: 'datefield',
                                                                    fieldLabel: 'Fecha Final'  
                                                                },
                                                                Ext.create('Ext.form.ComboBox', {
                                                                    fieldLabel: 'Campaña Fin.',
                                                                    store: cbxCampFinancieraListaCandidatosF,
                                                                    id: 'CAMPANA_FINANCIERA_LC_F',
                                                                    emptyText: 'Seleccione la Campaña',
                                                                    size: 30,
                                                                    displayField: 'nombre',
                                                                    valueField: 'id'
                                                                })//Cierra grupos items fieldset
                                                            ] //Cierra items fieldset
                                                        } //Cierra grupos container
                                                    ] //CIerra items container
                                                }, //Cierra grupo items tab lista candidatos
                                                {
                                                    xtype: 'grid',
                                                    store: listaCandidatos,
                                                    title: 'Candidatos',
                                                    columns:[
                                                        {
                                                            dataIndex: 'idDonante',
                                                            text: 'ID',
                                                            flex: .03,
                                                            align:'center'
                                                        }
                                                    ] //Cierra columns grid
                                                } //Cierra grupo 2 items tab lista candidatos
                                            ] //Cierra items tab lista de candidatos
                                        }, //Cierra tab lista de candidatos   
                                        {
                                            xtype: 'panel',
                                            width: 865,
                                            height: 870,
                                            border:false,
                                            title: 'Confirmaciones',
                                            tbar: tbConfirmaciones,
                                            items:[
                                                {
                                                    xtype: 'gridpanel',
                                                    store: confirmaciones,  
                                                    height: 470,
                                                    flex: 0.6,
                                                    columns:[
                                                        {
                                                            dataIndex: 'idDonante',
                                                            text: 'ID',
                                                            flex: .03,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'status',
                                                            text: 'Estatus',
                                                            align:'center',
                                                            flex: .05,                                                        
                                                            renderer: render_statusCartas
                                                        },
                                                        {
                                                            dataIndex: 'titulo',
                                                            text: 'Titulo',
                                                            flex: .04
                                                        },
                                                        {
                                                            dataIndex: 'donante',
                                                            text: 'Donante',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'calle',
                                                            text: 'Calle',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'colonia',
                                                            text: 'Colonia',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'municipio',
                                                            text: 'Municipio',
                                                            flex: .1
                                                        },
                                                        {
                                                            dataIndex: 'telCasa',
                                                            text: 'Tel. Casa',
                                                            flex: .07
                                                        },
                                                        {
                                                            dataIndex: 'comentarios',
                                                            text: 'Comentarios',
                                                            flex: .1
                                                        }
                                                    ], //Cierra columns gridpanel
                                                    viewConfig: {
                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {
                                                    }),
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 1000,
                                                        store: confirmaciones,
                                                        displayInfo: true
                                                    })
                                                }
                                            ] //Cierra items panel
                                        } //Cierra tab confirmaciones 
                                    ] //Cierra items tabpanel
                                } //Cierra tabpanel
                            ] // Cierra items apply
                        }) //Cierra Ext.Apply
                        cartas.formatos.superclass.initComponent.apply(this, arguments); 
                        storegridDonanteCarta.load();
                        storegridListaCartas.load();
                        storegridDonanteCandidato.load();
                    } //Cierra init Component
                });
            });
        </script>
    </head>
    <body>
        <div id="contenedor"></div>
    </body>
</html>
