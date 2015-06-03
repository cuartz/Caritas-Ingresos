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
        /********************** VARIABLES GLOBALES **************************/
        var idDonativoBitacora;
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];                        
        var idBitacora      = 0;
        var idReciboTmpp;

        /********************** MODELS **************************/                       
        Ext.define('catalog',{
            id:'catalog',
            extend: 'Ext.data.Model',
            fields: ['id','id_catalog','nombre','status']
        });

        Ext.define('beneficiario',{// create the Data beneficiario
            id:'beneficiario',
            extend: 'Ext.data.Model',
            fields: ['id','name']
        });

        Ext.define('donativosConfirmacion',{   //Grid de Historial de Pagos
            id:'donativosConfirmacion',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'totalcount'},
                {name: 'ID_BITACORA'},
                {name: 'ID_DONATIVO'},
                {name: 'ID_DONANTE'},
                {name: 'NOMBRE'},
                {name: 'NUM_PAGO'},
                {name: 'ESTATUS_PAGO'},
                {name: 'ESTATUS_PAGO_DESC'},
                {name: 'FECHA_COBRO'},
                {name: 'FECHA_PAGO'},
                {name: 'FORMA_PAGO'},
                {name: 'IMPORTE'},
                {name: 'ID_TIPO_ENVIO'},
                {name: 'TIPO_ENVIO'},
                {name: 'TEL_CASA'},
                {name: 'TEL_CEL'},
                {name: 'TEL_OFICINA'},
                {name: 'DATOS_CLAVE'},
                {name: 'FECHA_ALTA_RECIBO'}
            ]
        });

        Ext.define('pagosConfirmados',{   //Grid de Pagos Confirmados
            id:'pagosConfirmados',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'ID_BITACORA'},
                {name: 'ID_DONATIVO'},
                {name: 'ID_RECIBO'},
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
                {name: 'FECHA_VISITA'},
                {name: 'STATUS_IMPRESO'},
                {name: 'FECHA_IMPRESION'},
                {name: 'ID_RECOLECTOR'},
                {name: 'ID_ZONA'},
                {name: 'USUARIO_CONFIRMACION'}
            ]
        });
        
        Ext.define('confirmacionMasivaMdl',{   //Grid de Pagos Confirmados
            id:'confirmacionMasivaMdl',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'ID_BITACORA'},
                {name: 'ID_DONATIVO'},
                {name: 'ID_DONANTE'},
                {name: 'NOMBRE'},
                {name: 'NUM_PAGO'},
                {name: 'ESTATUS_PAGO'},
                {name: 'ESTATUS_PAGO_DESC'},
                {name: 'FECHA_COBRO'},
                {name: 'FECHA_PAGO'},
                {name: 'FORMA_PAGO'},
                {name: 'IMPORTE'},
                {name: 'ID_TIPO_ENVIO'},
                {name: 'TIPO_ENVIO'},
                {name: 'TE_CASA'},
                {name: 'TEL_CEL'},
                {name: 'TEL_OFICINA'},
                {name: 'DATOS_CLAVE'},
                {name: 'ID_ZONA'},
                {name: 'DIRECCION'},
                {name: 'FECHA_ALTA_RECIBO'}
            ]
        });
        
        Ext.define('pagosReprogramadosMdl',{   //Grid de Pagos Confirmados
            id:'pagosReprogramadosMdl',
            extend: 'Ext.data.Model',
            fields:[
                {name: 'ID_BITACORA'},
                {name: 'ESTATUS_PAGO_TMP'},
                {name: 'ESTATUS'},
                {name: 'ID_RECIBO'},
                {name: 'NOMBRE'},
                {name: 'ID_NUM_PAGO'},
                {name: 'FECHA_COBRO'},
                {name: 'FECHA_VISITA'},
                {name: 'TEL_CASA'},
                {name: 'TEL_MOVIL'},
                {name: 'TEL_OFICINA'},
                {name: 'COMENTARIOS_REPROGRAMAR'},
                {name: 'FECHA_REPROGRAMACION'},
                {name: 'ID_DONATIVO'}
            ]
        });
        
        Ext.define('recolectores',{// create the Data TIPO DE DIRECCION
            id:'recolectores',
            extend: 'Ext.data.Model',
            fields: ['id','nombre','idZona','idTipoRecolector']
        });

        /********************** STORES **************************/
        var stateszonasPpD = Ext.create('Ext.data.JsonStore', {
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
        
        var statesclasificacionDonantePC = Ext.create('Ext.data.JsonStore', {// create the Store Clasificacion de Donante
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                    extraParams:{llave:'INGRESOS_CLASIFICACION_DONANTE'},
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
        
        var cbxFormaPago = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                extraParams:{llave:'DONATIVO_FORMA_PAGO'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        }); 
        
        var cbxCampFinancieraRpE = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        //Store para el combobox de campañas financieras en pestaña de Confirmacion por Campañas (confirmacion masiva)
        var cbxCampFinancieraConfMasiva = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByNombreConfMasiva', //method=getAllHelpServices
                extraParams:{llave:'CAMPANAS_FINANCIERAS'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var storezonasRpE = Ext.create('Ext.data.JsonStore', {
            model: 'catalog',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getCatalogByLlave', //method=getAllHelpServices
                extraParams:{llave:'INGRESOS_ZONAS'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var storesTipoRecolectorRpE = Ext.create('Ext.data.JsonStore', {
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

        var comboSearchBeneficiario = Ext.create('Ext.data.JsonStore', {// create the Store beneficiario
            model: 'beneficiario',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getSearchBeneficiarioIngresos',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
        
        var storeRecolectores = Ext.create('Ext.data.JsonStore', {
            model: 'recolectores',
            proxy: {
                type: 'ajax',
                url: 'comboboxAC.do?method=getAllRecolectores',                      
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });

        var beneficiarioSearchTPL = new Ext.XTemplate(
            '<tpl for="."><div  class="search-item">',
            '<h5 style="color: #0000cc;">{id}</h5>{name} {funcion}<br>',
            '</div>',
            '</tpl>'
        );  
         

        /********************** FUNCIONES **************************/
        function render_moneyConfirma(v, p, record){
            return '$ '+v
        }

        function render_statusConfirma(v, p, record){
            if(v==2775){ //No Confirmado
                return "<img src='img/sinConfirmar.png' width='15px'>";
            }  else if(v==2776){ //Confirmado
                return "<img src='img/status1.png'";
            } else if(v==2777){ //Pagado
                return "<img src='img/new-doc.png'>";                    
            } else if(v==2778){ //Cancelado
                return "<img src='img/status-1.png'>";                    
            } else if(v==2779){ //Reprogramado
                return "<img src='img/timecita1.png'>";                    
            } else if(v==2780){ //Cobrar sin confirmar
                return "<img src='img/idea.png'>";                    
            } else {
                return "";
            }
        }
            
        /********************** INICIA PANTALLA **************************/            
        Ext.define('confirmaciones.confirmacion', {
            extend: 'Ext.window.Window',                
            alias:'widget.confirmacion',                
            title: 'Listas de Confirmacion',
            width: 1100,                
            height: 650,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy',
            region:'center',
            modal: true,
            initComponent: function() {
                /********************** INICIAR VARIABLES **************************/ 
                var winConfirmacion = this;

                var storeHistorialPagos = Ext.create('Ext.data.JsonStore', { // Store del grid del Historial de Pagos                      
                    model: 'donativosConfirmacion',
                    pageSize: 100,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'listaConfirmacionAC.do?method=getAllDonativos&idUsuario='+idUsuario,                                     
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty: 'totalcount'//Paginacion                
                        }                       
                    }
                });
                
                var storeGridPagosConfirmados = Ext.create('Ext.data.JsonStore', { // Store del grid de pagos confirmados                  
                    model: 'pagosConfirmados',
                    pageSize: 200,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'listaConfirmacionAC.do?method=getAllCobrosConfirmados', 
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty:'totalcount'//Paginacion                
                        }
                    }
                });
                
                var storePagosReprogramados = Ext.create('Ext.data.JsonStore', { // Store del grid del Historial de Pagos                      
                    model: 'pagosReprogramadosMdl',
                    pageSize: 300,
                    autoLoad:false,
                    proxy: {
                        type: 'ajax',                       
                        url: 'listaConfirmacionAC.do?method=getDonativosPagosReprogramados',                                     
                        reader: {
                            type: 'json',
                            root: 'rows',
                            totalProperty: 'totalcount'//Paginacion                
                        }                       
                    }
                });

                var tbarPagosXDia = new Ext.Toolbar({ // toolbar Dos
                    items: [
                        Ext.create('Ext.Button',{
                        text:'Buscar',
                        iconCls:'icon-find',
                        handler:function(){                            
                            var FECHA_COBRO_TMP_1 = Ext.getCmp('FECHA_COBRO').getValue();
                            var ID_ZONA_TMP_1 = Ext.getCmp('ID_ZONA_PD').getValue();                            
                            var NUM_CASO_TMP_1 = Ext.getCmp('comboSearchBeneficiario').getValue();                            
                            var ID_CAMPANA_FINANCIERA_TMP_1 = Ext.getCmp('ID_CAMPANA_FINANCIERA_PD').getValue();
                            var FECHA_ALTA_CF_TMP_1 = Ext.getCmp('FECHA_ALTA_CF_PD').getValue();
                            var NOMBRE_DONANTE_TMP_1 = Ext.getCmp('NOMBRE_DONANTE_PD').getValue();                            
                            var ID_FORMA_PAGO_TMP_1 = Ext.getCmp('ID_FORMA_PAGO_PD').getValue();                            
                            var ID_FORMA_PAGO_TMP_2 = Ext.getCmp('ID_FORMA_PAGO_PD_E').getValue();
                            var ID_CAMPANA_FINANCIERA_TMP_2 = Ext.getCmp('ID_CAMPANA_FINANCIERA_PD_E').getValue();
                            var ID_CLASIFICACION_TMP_2 = Ext.getCmp('ID_CLASIFICACION_PD_E').getValue();
                            var PERSONALMENTE_TMP_2 = Ext.getCmp('PERSONALMENTE_PD_E').getValue();
                            var ESPECIAL_TMP_2 = Ext.getCmp('ESPECIAL_PD_E').getValue();
                            
                            if(FECHA_COBRO_TMP_1 == null) FECHA_COBRO_TMP_1 = null;                                                        
                            if(ID_ZONA_TMP_1 == null) ID_ZONA_TMP_1 = 0;
                            if(NUM_CASO_TMP_1 == null) NUM_CASO_TMP_1 = 0;
                            if(ID_CAMPANA_FINANCIERA_TMP_1 == null) ID_CAMPANA_FINANCIERA_TMP_1 = 0;
                            if(FECHA_ALTA_CF_TMP_1 == null) FECHA_ALTA_CF_TMP_1 = null;
                            if(NOMBRE_DONANTE_TMP_1 == '') NOMBRE_DONANTE_TMP_1 = null
                            if(ID_FORMA_PAGO_TMP_1 == null) ID_FORMA_PAGO_TMP_1 = 0;                            
                            if(ID_FORMA_PAGO_TMP_2 == null) ID_FORMA_PAGO_TMP_2 = 0
                            if(ID_CAMPANA_FINANCIERA_TMP_2 == null) ID_CAMPANA_FINANCIERA_TMP_2 = 0
                            if(ID_CLASIFICACION_TMP_2 == null) ID_CLASIFICACION_TMP_2 = 0                            
                            if(PERSONALMENTE_TMP_2 == false) PERSONALMENTE_TMP_2 = 0
                            if(PERSONALMENTE_TMP_2 == true) PERSONALMENTE_TMP_2 = 1
                            if(ESPECIAL_TMP_2 == false) ESPECIAL_TMP_2 = 0
                            if(ESPECIAL_TMP_2 == true) ESPECIAL_TMP_2 = 1                            
                            
                            storeHistorialPagos.proxy.extraParams = {
                                FECHA_COBRO:FECHA_COBRO_TMP_1,
                                ID_ZONA:ID_ZONA_TMP_1,
                                NUM_CASO:NUM_CASO_TMP_1,
                                ID_CAMP_FIN:ID_CAMPANA_FINANCIERA_TMP_1,
                                FECHA_ALTA_CF:FECHA_ALTA_CF_TMP_1,
                                NOMBRE_DONANTE:NOMBRE_DONANTE_TMP_1,
                                ID_FORMA_PAGO:ID_FORMA_PAGO_TMP_1,
                                ID_FORMA_PAGO_2:ID_FORMA_PAGO_TMP_2,
                                ID_CAMP_FIN_2:ID_CAMPANA_FINANCIERA_TMP_2,
                                ID_CLASIFICACION_2:ID_CLASIFICACION_TMP_2,
                                PERSONALMENTE_2:PERSONALMENTE_TMP_2,
                                ESPECIAL_2:ESPECIAL_TMP_2
                            };
                            storeHistorialPagos.load(); 
                        }
                    }),
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Limpiar Filtros',
                        iconCls:'icon-clear',
                        handler: function(){                                                                                                                   
                            Ext.getCmp('frmPagosPorDia').getForm().reset();
                            storeHistorialPagos.proxy.extraParams = {
                                FECHA_COBRO:null,
                                ID_ZONA:0,
                                ID_CAMP_FIN:0,
                                FECHA_ALTA_CF:null,
                                ID_FORMA_PAGO:0
                            };
                            storeHistorialPagos.load(); 
                        }
                    }),
                    '-',
                    {
                        xtype: 'button',
                        text: 'Comentarios',
                        iconCls: 'icon-edit-doc',
                        handler: function(){
                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];
                            if(selectedRow!=undefined){
                                var idBitacoraTmpp = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.comentariosRecibo',idBitacoraTmpp);                                                                  
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea consultar!');
                            }                            
                        }
                    },                    
                    '-',
                    {
                        xtype: 'button',
                        text: 'Información del donativo',
                        iconCls: 'icon-grid',
                        handler: function(){
                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];
                            if(selectedRow!=undefined){
                                idDonativoBitacora = selectedRow.data.ID_DONATIVO;                                                               
                                createNewObj2('donantes.bitacoraPagos',idDonativoBitacora);                                                                  
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea consultar!');
                            }
                        }
                    },
                    '-',
                    {
                        xtype: 'button',
                        text: 'Buscar Donantes',
                        iconCls:'icon-registro',
                        handler: function(){                                                                                                                       
                            createNewObj('donantes.donantes'); 
                        }
                    },
//                    '-',
//                    Ext.create('Ext.Button',{
//                        text:'Ver Datos Donante y Bitacora',
//                        iconCls: 'icon-registro',
//                        handler:function(){
//                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];
//                            if(selectedRow!=undefined){
//                                var idDonativoTmpp = selectedRow.data.ID_DONATIVO;
//                                createNewObj2('confirmaciones.verDatosDonante',idDonativoTmpp);
//                            }else{
//                                Ext.MessageBox.alert('Error','¡Seleccione un recibo!');
//                            }
//
//                        }
//                    }),
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Registrar Llamada',
                        iconCls: 'icon-add',
                        handler:function(){                                                            
                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                idBitacora = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.registrarLlamada',idBitacora);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione un donante!');
                            }
                        }
                    }),
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Bitacora Llamadas',
                        iconCls: 'icon-grid',
                        handler:function(){                                                            
                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                idBitacora = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.bitacoraLlamadas',idBitacora);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione un donante!');
                            }
                        }
                    }),
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Confirmar Pago',
                        iconCls: 'icon-money',
                        handler:function(){                                                            
                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                idBitacora = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.confirmacionPago',idBitacora);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
                            }
                        }
                    }),                                                    
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Enviar S/C',
                        iconCls: 'icon-money',
                        handler: function(){
                            var selectedRow = Ext.getCmp('gridDonativosConfirmacion').selModel.selected.items[0];
                            if(selectedRow!=undefined){
                                idBitacora = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.sinConfirmar',idBitacora);    
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione el pago que desea confirmar!');
                            }                                                                                                                   
                        }
                    }),
                    '-',
                    
                    Ext.create('Ext.Button',{
                        text:'Salir',
                        iconCls:'icon-salir',
                        handler: function(){
                            winConfirmacion.close();
                        }
                    })
                    ]
                }); //termina toolbar dos
                
                var tbarPagosConfirmados = new Ext.Toolbar({ // toolbar Dos
                    items: [
                        Ext.create('Ext.Button',{
                            text:'Buscar',
                            iconCls:'icon-find',
                            handler:function(){                                                        
                                var ID_RECOLECTOR_TMP_2 = Ext.getCmp('ID_RECOLECTOR_PC').getValue();
                                var FECHA_VISITA_TMP_2 = Ext.getCmp('FECHA_VISITA_PC').getValue();
                                var ID_ZONA_TMP_2 = Ext.getCmp('ID_ZONA_PC').getValue();
                                var ID_CAMPANA_FINANCIERA_TMP_2 = Ext.getCmp('ID_CAMPANA_FINANCIERA_PC').getValue();
                                var FECHA_ALTA_CF_TMP_2 = Ext.getCmp('FECHA_ALTA_PC').getValue();
                                var NOMBRE_DONANTE_TMP_2 = Ext.getCmp('NOMBRE_DONANTE_PC').getValue();
                                var ID_RECIBOO = Ext.getCmp('ID_RECIBO_PC').getValue();
                                
                                var ID_FORMA_PAGO_E_TMP = Ext.getCmp('ID_FORMA_PAGO_PC_E').getValue();
                                var ID_CAMP_FIN_E_TMP = Ext.getCmp('ID_CAMPANA_FINANCIERA_PC_E').getValue();
                                var ID_CLASIFICACION_E_TMP = Ext.getCmp('ID_CLASIFICACION_PC_E').getValue();
                                var PERSONALMENTE_E_TMP = Ext.getCmp('PERSONALMENTE_PC_E').getValue();
                                var ESPECIAL_E_TMP = Ext.getCmp('ESPECIAL_PC_E').getValue();
                                
                                if(FECHA_VISITA_TMP_2 == null) FECHA_VISITA_TMP_2 = null;
                                if(ID_RECOLECTOR_TMP_2 == null) ID_RECOLECTOR_TMP_2 = 0;
                                if(ID_ZONA_TMP_2 == null) ID_ZONA_TMP_2 = 0;
                                if(ID_CAMPANA_FINANCIERA_TMP_2 == null) ID_CAMPANA_FINANCIERA_TMP_2 = 0;
                                if(FECHA_ALTA_CF_TMP_2 == null) FECHA_ALTA_CF_TMP_2 = null;
                                if(NOMBRE_DONANTE_TMP_2 == null) NOMBRE_DONANTE_TMP_2 = null;
                                if(ID_RECIBOO == null) ID_RECIBOO == null;
                                
                                if(ID_FORMA_PAGO_E_TMP == null) ID_FORMA_PAGO_E_TMP = 0;
                                if(ID_CAMP_FIN_E_TMP == null) ID_CAMP_FIN_E_TMP = 0;
                                if(ID_CLASIFICACION_E_TMP == null) ID_CLASIFICACION_E_TMP = 0;
                                if(PERSONALMENTE_E_TMP == false) PERSONALMENTE_E_TMP = 0; else PERSONALMENTE_E_TMP = 1;
                                if(ESPECIAL_E_TMP == false) ESPECIAL_E_TMP = 0; else ESPECIAL_E_TMP = 1;
                                
                                storeGridPagosConfirmados.proxy.extraParams = {
                                    ID_RECOLECTOR:ID_RECOLECTOR_TMP_2,
                                    FECHA_VISITA:FECHA_VISITA_TMP_2,
                                    ID_ZONA:ID_ZONA_TMP_2,
                                    ID_CAMP_FIN:ID_CAMPANA_FINANCIERA_TMP_2,
                                    FECHA_ALTA_CF:FECHA_ALTA_CF_TMP_2,
                                    NOMBRE_DONANTE:NOMBRE_DONANTE_TMP_2,
                                    ID_RECIBO:ID_RECIBOO,
                                    
                                    ID_FORMA_PAGO_E:ID_FORMA_PAGO_E_TMP,
                                    ID_CAMP_FIN_E:ID_CAMP_FIN_E_TMP,
                                    ID_CLASIF_E:ID_CLASIFICACION_E_TMP,
                                    PERSONAL_E:PERSONALMENTE_E_TMP,
                                    ESPECIAL_E:ESPECIAL_E_TMP
                                };
                                storeGridPagosConfirmados.load(); 
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Limpiar Filtros',
                            iconCls:'icon-clear',
                            handler: function(){                                                                                                                   
                                Ext.getCmp('frmConfirmaciones').getForm().reset();//                               
                                storeGridPagosConfirmados.proxy.extraParams = {
                                    ID_RECOLECTOR:0,
                                    FECHA_VISITA:null,
                                    ID_ZONA:0,
                                    ID_CAMP_FIN:0,
                                    FECHA_ALTA_CF:null
                                };
                                storeGridPagosConfirmados.load();
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text: 'Imprimir Pago Confirmado',                            
                            tooltip: '',                           
                            iconCls:'icon-print',
                            id:'printBiNGRESOS',                           
                            handler: function() {
                                if(idUsuario == 'RNUNEZ' || idUsuario == 'OGARCIA'){
                                    var selectedRow         = Ext.getCmp('gridPagosConfirmados').selModel.selected.items[0];
                                    var sizeSelected        = Ext.getCmp('gridPagosConfirmados').selModel.selected.items.length;
                                    var idBitacoraTmp       = 0;
                                    var result              = "";
                                    var contadorImpresos    = 0;
                                    var contadorPagados     = 0;
                                    if(selectedRow != undefined){
                                        //Obtener las bitacoras seleccionadas y crear el string
                                        for(z = 0; z < sizeSelected; z = z+1){
                                            selectedRow = Ext.getCmp('gridPagosConfirmados').selModel.selected.items[z];
                                            idBitacoraTmp = selectedRow.data.ID_BITACORA;
                                            result += idBitacoraTmp + ",";
                                            if(selectedRow.data.STATUS_IMPRESO != 'NO'){ //Si ya esta impreso
                                                contadorImpresos = contadorImpresos + 1
                                            }
                                            if(selectedRow.data.ID_ESTATUS_PAGO_TMP == 2777 || selectedRow.data.ID_ESTATUS_PAGO_TMP == 2778){ //Pagado, Cancelado
                                                contadorPagados = contadorPagados + 1
                                            }
                                        }

                                        if(contadorPagados > 0){                                                
                                            Ext.MessageBox.alert('Error','¡Existen recibos que ya han sido PAGADOS y/o CANCELADOS, favor de verificar!');                                                
                                        }else if(contadorImpresos > 0){ //REIMPRESION
                                            if(idUsuario == 'RNUNEZ' || idUsuario == 'OGARCIA'){
                                                Ext.Ajax.request({
                                                    url : 'listaConfirmacionAC.do?method=reportServices',
                                                    params : { 
                                                        result:result,
                                                        tipo_reporte:1,
                                                        idUsuario:idUsuario,
                                                        reimpresion:1,
                                                        motivoReimpresion:''
                                                    },
                                                    method: 'GET',
                                                    success: function ( result, request ) {
                                                        Ext.MessageBox.alert('Impresión','¡Se enviaron '+sizeSelected+' recibos a REIMPRESIÓN!');
                                                        storeGridPagosConfirmados.load();
                                                    },
                                                    failure: function ( result, request) {
//                                                        Ext.MessageBox.alert('Error','¡Error en la REIMPRESIÓN de los recibos!');
                                                        storeGridPagosConfirmados.load();
                                                    }
                                                });                                            
                                            }else{
                                                Ext.MessageBox.alert('Error','¡Existen recibos que ya han sido IMPRESOS, favor de verificar!');
                                            }
                                        }else{ //IMPRESION
                                            Ext.Ajax.request({
                                                url : 'listaConfirmacionAC.do?method=reportServices',
                                                params : { 
                                                    result:result,
                                                    tipo_reporte:1,
                                                    idUsuario:idUsuario,
                                                    reimpresion:0,
                                                    motivoReimpresion:''
                                                },
                                                method: 'GET',
                                                success: function ( result, request ) {
                                                    Ext.MessageBox.alert('Impresión','¡Se enviaron '+sizeSelected+' recibos a IMPRESIÓN!');
                                                    storeGridPagosConfirmados.load();
                                                },
                                                failure: function ( result, request) {
//                                                    Ext.MessageBox.alert('Error','¡Error en la IMPRESIÓN de los recibos!');
                                                    storeGridPagosConfirmados.load();
                                                }
                                            });                                        
                                        }
                                        result = "";
                                        contadorImpresos = 0;
                                        contadorPagados = 0;
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Favor de seleccionar un registro!');
                                    }
                                }else{
                                    Ext.MessageBox.alert('Error','¡Usted no tiene permisos para ejecutar esta acción!');
                                }
                            }
                        }),                        
                        '-',
                        Ext.create('Ext.Button',{
                            text: 'Vista Previa Recibo',                            
                            tooltip: '',                           
                            iconCls:'icon-print',                            
                            handler: function() {
                                var selectedRow = Ext.getCmp('gridPagosConfirmados')!=null?Ext.getCmp('gridPagosConfirmados').selModel.selected.items[0]:undefined; 
                                if(selectedRow!=undefined){
                                    if(idUsuario == 'MMENDOZA' || idUsuario == 'AALVARADO' || idUsuario == 'RNUNEZ'){
                                        window.open('listaConfirmacionAC.do?method=reportServicesOriginal&id_solicitud='+selectedRow.data.ID_BITACORA+'&tipo_reporte=1&idUsuario='+idUsuario);                                    
                                        storeGridPagosConfirmados.load();
                                    }else{
                                        Ext.MessageBox.alert('Error','¡Usted no tiene permisos para esta acción!');
                                    }                                                                        
                                }
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Reporte Recolector',
                            iconCls:'icon-xlsx',
                            handler:function(){
                                var ID_RECOLECTOR_TMP_2 = Ext.getCmp('ID_RECOLECTOR_PC').getValue();
                                var FECHA_VISITA_TMP_2 = Ext.getCmp('FECHA_VISITA_PC').getValue();
                                var ID_ZONA_TMP_2 = Ext.getCmp('ID_ZONA_PC').getValue();
                                var ID_CAMPANA_FINANCIERA_TMP_2 = Ext.getCmp('ID_CAMPANA_FINANCIERA_PC').getValue();
                                var FECHA_ALTA_CF_TMP_2 = Ext.getCmp('FECHA_ALTA_PC').getValue();
                                var NOMBRE_DONANTE_TMP_2 = Ext.getCmp('NOMBRE_DONANTE_PC').getValue();
                                
                                if(FECHA_VISITA_TMP_2 == null) FECHA_VISITA_TMP_2 = null;
                                if(ID_RECOLECTOR_TMP_2 == null) ID_RECOLECTOR_TMP_2 = 0;
                                if(ID_ZONA_TMP_2 == null) ID_ZONA_TMP_2 = 0;
                                if(ID_CAMPANA_FINANCIERA_TMP_2 == null) ID_CAMPANA_FINANCIERA_TMP_2 = 0;
                                if(FECHA_ALTA_CF_TMP_2 == null) FECHA_ALTA_CF_TMP_2 = null;
                                if(NOMBRE_DONANTE_TMP_2 == null) NOMBRE_DONANTE_TMP_2 = null;
                                window.open("ShowExcel?idOperationType=2&idRecolector="+ID_RECOLECTOR_TMP_2+"&idZona="+ID_ZONA_TMP_2+"&fechaVisita="+FECHA_VISITA_TMP_2+"&idCampFin="+ID_CAMPANA_FINANCIERA_TMP_2+"&fechaCaptura="+FECHA_ALTA_CF_TMP_2+"&nombre="+NOMBRE_DONANTE_TMP_2);
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Reporte Extra',
                            iconCls:'icon-xlsx',
                            handler:function(){
                                var ID_RECOLECTOR_TMP_2 = Ext.getCmp('ID_RECOLECTOR_PC').getValue();
                                var FECHA_VISITA_TMP_2 = Ext.getCmp('FECHA_VISITA_PC').getValue();
                                var ID_ZONA_TMP_2 = Ext.getCmp('ID_ZONA_PC').getValue();
                                var ID_CAMPANA_FINANCIERA_TMP_2 = Ext.getCmp('ID_CAMPANA_FINANCIERA_PC').getValue();
                                var FECHA_ALTA_CF_TMP_2 = Ext.getCmp('FECHA_ALTA_PC').getValue();
                                var NOMBRE_DONANTE_TMP_2 = Ext.getCmp('NOMBRE_DONANTE_PC').getValue();
                                
                                if(FECHA_VISITA_TMP_2 == null) FECHA_VISITA_TMP_2 = null;
                                if(ID_RECOLECTOR_TMP_2 == null) ID_RECOLECTOR_TMP_2 = 0;
                                if(ID_ZONA_TMP_2 == null) ID_ZONA_TMP_2 = 0;
                                if(ID_CAMPANA_FINANCIERA_TMP_2 == null) ID_CAMPANA_FINANCIERA_TMP_2 = 0;
                                if(FECHA_ALTA_CF_TMP_2 == null) FECHA_ALTA_CF_TMP_2 = null;
                                if(NOMBRE_DONANTE_TMP_2 == null) NOMBRE_DONANTE_TMP_2 = null;
                                window.open("ShowExcel?idOperationType=21&idRecolector="+ID_RECOLECTOR_TMP_2+"&idZona="+ID_ZONA_TMP_2+"&fechaVisita="+FECHA_VISITA_TMP_2+"&idCampFin="+ID_CAMPANA_FINANCIERA_TMP_2+"&fechaCaptura="+FECHA_ALTA_CF_TMP_2+"&nombre="+NOMBRE_DONANTE_TMP_2);
                            }
                        }),
                        '-',
                        {
                            xtype: 'button',
                            text: 'Ver Comentarios',
                            iconCls: 'icon-edit-doc',
                            handler: function(){
                                var selectedRow = Ext.getCmp('gridPagosConfirmados').selModel.selected.items[0];
                                if(selectedRow!=undefined){
                                    var idBitacoraTmpp = selectedRow.data.ID_BITACORA;
                                    createNewObj2('confirmaciones.comentariosRecibo',idBitacoraTmpp);                                                                  
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea consultar!');
                                }                            
                            }
                        },
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                                            
                                winConfirmacion.close();
                            }
                        })
                    ]
                }); //termina toolbar dos
                
                var tbarPagosReprogramados = new Ext.Toolbar({ // toolbar tres
                    items: [
                        Ext.create('Ext.Button',{
                            text:'Buscar',
                            iconCls:'icon-find',
                            handler:function(){                               
                                var NOMBRE_PR = Ext.getCmp('NOMBRE_DONANTE_PR').getValue();
                                var ID_ZONA_PR = Ext.getCmp('ID_ZONA_PR').getValue();                                                               
                                if(ID_ZONA_PR == null) ID_ZONA_PR = 0;
                                storePagosReprogramados.proxy.extraParams = {                                   
                                    NOMBRE:NOMBRE_PR,
                                    ID_ZONA:ID_ZONA_PR
                                };
                                storePagosReprogramados.load(); 
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Limpiar Filtros',
                            iconCls:'icon-clear',
                            handler: function(){                                                                                                                   
                                Ext.getCmp('frmReprogramados').getForm().reset();                               
                                storePagosReprogramados.proxy.extraParams = {                                    
                                    FECHA_COBRO:null,
                                    FECHA_VISITA:null,
                                    NOMBRE:null,
                                    ID_ZONA:0
                                };
                                storePagosReprogramados.load();
                            }
                        }),
                        '-',
                        {
                            xtype: 'button',
                            text: 'Ver Comentarios',
                            iconCls: 'icon-edit-doc',
                            handler: function(){
                                var selectedRow = Ext.getCmp('gridPagosReprogramados').selModel.selected.items[0];
                                if(selectedRow!=undefined){
                                    var idBitacoraTmpp = selectedRow.data.ID_BITACORA;
                                    createNewObj2('confirmaciones.comentariosRecibo',idBitacoraTmpp);                                                                  
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el recibo que desea consultar!');
                                }                            
                            }
                        },
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Reprogramar Pago',
                            iconCls:'icon-money',
                            handler:function(){     
                                var selectedRow = Ext.getCmp('gridPagosReprogramados').selModel.selected.items[0];
                                if(selectedRow!=undefined){
                                    idBitacora = selectedRow.data.ID_BITACORA;                                                              
                                    if(selectedRow.data.ESTATUS_PAGO_TMP == 2779){
                                        createNewObj2('confirmaciones.reprogramarPago',idBitacora);
                                    }else{
                                        Ext.MessageBox.alert('Error','¡El pago seleccionado no ha sido enviado por primera vez!');
                                    }                                                               
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione el pago que desea reprogramar!');
                                }

                            }
                        }),
                        '-',
                        '-',
                    Ext.create('Ext.Button',{
                        text:'Registrar Llamada',
                        iconCls: 'icon-add',
                        handler:function(){                                                            
                            var selectedRow = Ext.getCmp('gridPagosReprogramados').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                idBitacora = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.registrarLlamada',idBitacora);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione un donante!');
                            }
                        }
                    }),
                    '-',
                    Ext.create('Ext.Button',{
                        text:'Bitacora Llamadas',
                        iconCls: 'icon-grid',
                        handler:function(){                                                            
                            var selectedRow = Ext.getCmp('gridPagosReprogramados').selModel.selected.items[0];                            
                            if(selectedRow!=undefined){                                
                                idBitacora = selectedRow.data.ID_BITACORA;
                                createNewObj2('confirmaciones.bitacoraLlamadas',idBitacora);
                            }else{
                                Ext.MessageBox.alert('Error','¡Seleccione un donante!');
                            }
                        }
                    }),
                    '-',
                        Ext.create('Ext.Button',{
                            text:'Ver Historial de Envio',
                            iconCls: 'icon-grid',
                            handler:function(){
                                var selectedRow = Ext.getCmp('gridPagosReprogramados').selModel.selected.items[0];
                                if(selectedRow!=undefined){
                                    idReciboTmpp = selectedRow.data.ID_RECIBO;                                                              
                                    createNewObj2('confirmaciones.historialEnvioReprogramados',idReciboTmpp);
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione un recibo!');
                                }
                                
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Datos Donante y Bitacora',
                            iconCls: 'icon-registro',
                            handler:function(){
                                var selectedRow = Ext.getCmp('gridPagosReprogramados').selModel.selected.items[0];
                                if(selectedRow!=undefined){
                                    var idDonativoTmppp = selectedRow.data.ID_DONATIVO;
                                    createNewObj2('confirmaciones.verDatosDonante',idDonativoTmppp);
                                }else{
                                    Ext.MessageBox.alert('Error','¡Seleccione un recibo!');
                                }
                                
                            }
                        }),
                        '-',
                        Ext.create('Ext.Button',{
                            text:'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                                            
                                winConfirmacion.close();
                            }
                        })
                    ]
                }); //termina toolbar pagos reprogramados

                Ext.apply(this, {
                    items: [
                        {
                            xtype: 'tabpanel',
                            height: 890,
                            width: 837,
                            activeTab: 0,
                            border:false,
                            items: [
                                /************************ PESTAÑA PAGOS POR DIA ********************************/
                                {
                                    xtype: 'panel',
                                    width: 1100,
                                    height: 650,
                                    border:false,
                                    title: 'Pagos por dia',
                                    tbar: tbarPagosXDia,
                                    items: [
                                        {
                                            xtype: 'form',
                                            id: 'frmPagosPorDia',
                                            height: 650,                                                
                                            border:false,
                                            items: [
                                                {
                                                    xtype: 'container',
                                                    layout: {
                                                        type: 'hbox'
                                                    },
                                                    items:[
                                                        { //Container Izq
                                                            xtype: 'container',
                                                            flex: 0.5,                                                
                                                            margin: 1,
                                                            items:[
                                                                {
                                                                    xtype: 'fieldset',
                                                                    height: 220,
                                                                    title: 'Busqueda',
                                                                    items: [
                                                                        {                                                                    
                                                                            xtype: 'datefield',
                                                                            width: 325,                                                                    
                                                                            fieldLabel: 'Fecha Cobro',
                                                                            id: 'FECHA_COBRO', 
                                                                            labelWidth: 130
                                                                        },
                                                                        {
                                                                            xtype: 'datefield',
                                                                            width: 325,
                                                                            labelWidth: 130,
                                                                            fieldLabel: 'Fecha Captura',
                                                                            id: 'FECHA_ALTA_CF_PD'                                                            
                                                                        },
                                                                        {
                                                                            xtype: 'textfield',
                                                                            fieldLabel:'Nombre',
                                                                            id:'NOMBRE_DONANTE_PD',                                                                    
                                                                            labelWidth: 130,
                                                                            width: 500,
                                                                            size: 250
                                                                        },
                                                                        {
                                                                            xtype: 'combobox',
                                                                            store: comboSearchBeneficiario,
                                                                            emptyText:'Busca y selecciona un Beneficiario',
                                                                            blankText:'Buscar o agregar beneficiario',                                                                            
                                                                            id:'comboSearchBeneficiario',
                                                                            name:'comboSearchBeneficiario',
                                                                            minChars:2,
                                                                            displayField:'name',
                                                                            valueField:'id',
                                                                            typeAhead: false,
                                                                            loadingText: 'Buscando...',
                                                                            fieldLabel: 'Buscar Caso',
                                                                            width: 500,
                                                                            labelWidth: 130,
                                                                            pageSize:10,
                                                                            hideTrigger:false,
                                                                            queryParam : 'keyword',
                                                                            triggerCls:'x-form-search-trigger',
                                                                            tpl:  beneficiarioSearchTPL,
                                                                            itemSelector: 'div.search-item'
                                                                        },
                                                                        {
                                                                            xtype: 'combobox',
                                                                            fieldLabel: 'Zona',
                                                                            id:'ID_ZONA_PD',
                                                                            store: stateszonasPC,
                                                                            width: 500,
                                                                            labelWidth: 130,
                                                                            valueField: 'id',
                                                                            displayField: 'nombre',                                                                        
                                                                            emptyText: 'Seleccione la Zona...'                                                                          
                                                                        
                                                                        },                                                                        
                                                                        {
                                                                            xtype: 'combobox',
                                                                            fieldLabel: 'Campaña Financiera',
                                                                            store: cbxCampFinancieraRpE,
                                                                            id: 'ID_CAMPANA_FINANCIERA_PD',
                                                                            emptyText: 'Seleccione la campaña',
                                                                            size: 30,
                                                                            labelWidth: 130,
                                                                            width: 500,
                                                                            displayField: 'nombre',
                                                                            valueField: 'id' 
                                                                        
                                                                        },//                                                                       
                                                                        {
                                                                            xtype: 'combobox',
                                                                            fieldLabel: 'Forma de Pago',
                                                                            store: cbxFormaPago,
                                                                            emptyText: 'Seleccione la forma de pago',
                                                                            size: 30,
                                                                            width: 500,
                                                                            displayField: 'nombre',
                                                                            labelWidth: 130,
                                                                            valueField: 'id',
                                                                            id: 'ID_FORMA_PAGO_PD'
                                                                        }                                                                      
                                                                    ] // Cierra items fieldset
                                                                }
                                                            ] //Cierra items container izq
                                                        },
                                                        { //Container Der
                                                            xtype: 'container',
                                                            flex: 0.5,
                                                            margin: 1,
                                                            items:[
                                                                {
                                                                    xtype: 'fieldset',
                                                                    height: 220,
                                                                    title: 'Excluir',
                                                                    items:[
                                                                        {
                                                                            xtype: 'panel',
                                                                            border:false,
                                                                            items:[
                                                                                Ext.create('Ext.form.ComboBox', {
                                                                                    fieldLabel: 'Forma de Pago',
                                                                                    store: cbxFormaPago,
                                                                                    emptyText: 'Seleccione la forma de pago',
                                                                                    size: 30,
                                                                                    displayField: 'nombre',
                                                                                    labelWidth: 130,
                                                                                    valueField: 'id',
                                                                                    id: 'ID_FORMA_PAGO_PD_E'                                                                       
                                                                                }),
                                                                                Ext.create('Ext.form.ComboBox', {
                                                                                    fieldLabel: 'Campaña Financiera',
                                                                                    store: cbxCampFinancieraRpE,
                                                                                    id: 'ID_CAMPANA_FINANCIERA_PD_E',
                                                                                    emptyText: 'Seleccione la campaña',
                                                                                    size: 30,
                                                                                    labelWidth: 130,
                                                                                    width: 400,
                                                                                    displayField: 'nombre',
                                                                                    valueField: 'id' 
                                                                                }),
                                                                                Ext.create('Ext.form.ComboBox', {
                                                                                    fieldLabel: 'Clasificación',
                                                                                    name:'ID_CLASIFICACION',
                                                                                    id:'ID_CLASIFICACION_PD_E',
                                                                                    emptyText:'Seleccione la clasificación...',                                                                                    
                                                                                    editable:false,
                                                                                    anchor: '900%',
                                                                                    labelWidth: 130,
                                                                                    size: 30,
                                                                                    store: statesclasificacionDonantePC,
                                                                                    queryMode: 'local',
                                                                                    displayField: 'nombre',
                                                                                    valueField: 'id'
                                                                                }),
                                                                                {
                                                                                    xtype: 'checkbox',
                                                                                    fieldLabel: 'Personalmente',
                                                                                    id: 'PERSONALMENTE_PD_E',
                                                                                    labelWidth: 130
                                                                                },
                                                                                {
                                                                                    xtype: 'checkbox',
                                                                                    fieldLabel: 'Especial',
                                                                                    id: 'ESPECIAL_PD_E',
                                                                                    labelWidth: 130
                                                                                }
                                                                            ] //Cierra items panel
                                                                        }                                                                        
                                                                    ] //Cierra items fieldset
                                                                }
                                                            ] //Cierra items container derecho
                                                        }
                                                    ] //Cierra items container principal//                                                    
                                                },
                                                {
                                                    xtype: 'grid',
                                                    title: 'Historial Pagos',
                                                    height: 330,
                                                    width: 1092,
                                                    id: 'gridDonativosConfirmacion',
                                                    store: storeHistorialPagos,
                                                    columns: [
                                                        {
                                                            dataIndex: 'ESTATUS_PAGO_DESC',
                                                            text: 'Estatus',
                                                            flex: .05,
                                                            align:'center'                                                                
                                                        },                                                                                                                      
                                                        {
                                                            dataIndex: 'NOMBRE',
                                                            text: 'Donante',
                                                            flex: .1
                                                        },                                                            
                                                        {
                                                            dataIndex: 'NUM_PAGO',
                                                            text: 'No. Pago',
                                                            flex: .03,
                                                            align:'center'                                                    
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_ALTA_RECIBO',
                                                            text: 'Fecha Alta',
                                                            flex: .04 
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_COBRO',
                                                            text: 'Fecha de Cobro',
                                                            flex: .04                                                    
                                                        },                                                            
                                                        {
                                                            dataIndex: 'IMPORTE',
                                                            text: 'Importe',
                                                            flex: .03,
                                                            renderer: render_moneyConfirma
                                                        },
                                                        {
                                                            dataIndex: 'TEL_CASA',
                                                            text: 'Tel. Casa',
                                                            flex: .03,
                                                            align:'center'                                                    
                                                        },
                                                        {
                                                            dataIndex: 'TEL_CEL',
                                                            text: 'Tel. Cel',
                                                            flex: .04,
                                                            align:'center'                                                    
                                                        },
                                                        {
                                                            dataIndex: 'TEL_OFICINA',
                                                            text: 'Tel. Oficina',
                                                            flex: .04,
                                                            align:'center'                                                    
                                                        }
//                                                        {
//                                                            dataIndex: 'DATOS_CLAVE',
//                                                            text: 'Comentarios',
//                                                            flex: .1,
//                                                            align:'left'                                                    
//                                                        }                                                        
                                                    ],
                                                    viewConfig: {

                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                    }),
//                                                    bbar: pagerConfirmacion                                                   
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 100,
                                                        store: storeHistorialPagos,
                                                        displayInfo: true,
                                                        displayMsg: '{0} - {1} of {2} Registros',  
                                                        emptyMsg: 'No hay registros por mostrar'
                                                    })
                                                }
                                            ]
                                        }
                                    ]
                                }, //Termina tab Pagos por dia                                
                                /************************ PESTAÑA PAGOS CONFIRMADOS ********************************/
                                {
                                    xtype: 'panel',
                                    width: 1100,
                                    height: 680,
                                    border:false,
                                    title: 'Pagos Confirmados',
                                    tbar: tbarPagosConfirmados,                                    
                                    items: [
                                        {
                                            xtype: 'form',
                                            id: 'frmConfirmaciones',
                                            height: 680,
                                            border:false,                                               
                                            items: [
                                                {
                                                    xtype: 'container',
                                                    layout: {
                                                        type: 'hbox'
                                                    },
                                                    items:[
                                                        { //Container izq
                                                            xtype: 'container',
                                                            flex: 0.5,                                                
                                                            margin: 1,
                                                            items:[
                                                                {
                                                                    xtype: 'fieldset',
                                                                    height: 220,
                                                                    title: 'Busqueda',
                                                                    items:[
                                                                        Ext.create('Ext.form.ComboBox',{
                                                                            fieldLabel: 'Zona',
                                                                            id:'ID_ZONA_PC',
                                                                            store: stateszonasPC,                                                                                                                                                                                                                          
                                                                            labelWidth: 130,
                                                                            width: 500,                                                                        
                                                                            valueField: 'id',
                                                                            displayField: 'nombre',                                                                        
                                                                            emptyText: 'Seleccione el tipo de Zona...',
                                                                            selectOnFocus: true
                                                                        }),
                                                                        Ext.create('Ext.form.ComboBox', {
                                                                            fieldLabel: 'Recolector',
                                                                            name:'ID_RECOLECTOR',
                                                                            id:'ID_RECOLECTOR_PC',
                                                                            emptyText:'Seleccione el Recolector',                                                            
                                                                            editable:false,
                                                                            width: 500,
                                                                            labelWidth: 130,
                                                                            size: 30,
                                                                            store: storeRecolectores,
                                                                            queryMode: 'local',
                                                                            displayField: 'nombre',
                                                                            valueField: 'id'
                                                                        }),
                                                                        Ext.create('Ext.form.ComboBox', {
                                                                            fieldLabel: 'Campaña Financiera',
                                                                            store: cbxCampFinancieraRpE,
                                                                            id: 'ID_CAMPANA_FINANCIERA_PC',
                                                                            emptyText: 'Seleccione la campaña',
                                                                            size: 30,
                                                                            labelWidth: 130,
                                                                            width: 500,
                                                                            displayField: 'nombre',
                                                                            valueField: 'id' 
                                                                        }),
                                                                        {
                                                                            xtype: 'textfield',
                                                                            fieldLabel:'Nombre',
                                                                            id:'NOMBRE_DONANTE_PC',                                                                    
                                                                            labelWidth: 130,
                                                                            width: 500,
                                                                            size: 250                                   
                                                                        },
                                                                        {
                                                                            xtype: 'datefield',
                                                                            width: 325,
                                                                            labelWidth: 130,
                                                                            fieldLabel: 'Fecha Visita',
                                                                            id: 'FECHA_VISITA_PC'                                                            
                                                                        },
                                                                        {
                                                                            xtype: 'datefield',
                                                                            width: 325,
                                                                            labelWidth: 130,
                                                                            fieldLabel: 'Fecha Captura',
                                                                            id: 'FECHA_ALTA_PC'                                                            
                                                                        },
                                                                        {
                                                                            xtype: 'numberfield',
                                                                            id: 'ID_RECIBO_PC', //SE PUSO EL MISMO NOMBRE DEL CAMPO PARA NO CAMBIAR TODAS LAS VARIABLES
                                                                            fieldLabel: 'Recibo',
                                                                            hideTrigger: true,
                                                                            labelWidth: 130,
                                                                            size: 10
                                                                        }
                                                                    ] //Cierra items fieldset busqueda
                                                                }
                                                            ] //Cierra items container izq
                                                        },
                                                        { //Container derecho
                                                            xtype: 'container',
                                                            flex: 0.5,
                                                            margin: 1,
                                                            items:[
                                                                {
                                                                    xtype: 'fieldset',
                                                                    height: 220,
                                                                    title: 'Excluir',
                                                                    items:[
                                                                        Ext.create('Ext.form.ComboBox', {
                                                                            fieldLabel: 'Forma de Pago',
                                                                            store: cbxFormaPago,
                                                                            emptyText: 'Seleccione la forma de pago',
                                                                            size: 30,
                                                                            width: 400,
                                                                            displayField: 'nombre',
                                                                            labelWidth: 130,
                                                                            valueField: 'id',
                                                                            id: 'ID_FORMA_PAGO_PC_E'                                                                       
                                                                        }),
                                                                        Ext.create('Ext.form.ComboBox', {
                                                                            fieldLabel: 'Campaña Financiera',
                                                                            store: cbxCampFinancieraRpE,
                                                                            id: 'ID_CAMPANA_FINANCIERA_PC_E',
                                                                            emptyText: 'Seleccione la campaña',
                                                                            size: 30,
                                                                            labelWidth: 130,
                                                                            width: 400,
                                                                            displayField: 'nombre',
                                                                            valueField: 'id' 
                                                                        }),
                                                                        Ext.create('Ext.form.ComboBox', {
                                                                            fieldLabel: 'Clasificación',
                                                                            name:'ID_CLASIFICACION',
                                                                            id:'ID_CLASIFICACION_PC_E',
                                                                            emptyText:'Seleccione la clasificación...',                                                                                    
                                                                            editable:false,                                                                            
                                                                            labelWidth: 130,
                                                                            width: 400,
                                                                            size: 30,
                                                                            store: statesclasificacionDonantePC,
                                                                            queryMode: 'local',
                                                                            displayField: 'nombre',
                                                                            valueField: 'id'
                                                                        }),
                                                                        {
                                                                            xtype: 'checkbox',
                                                                            fieldLabel: 'Personalmente',
                                                                            id: 'PERSONALMENTE_PC_E',
                                                                            labelWidth: 130
                                                                        },
                                                                        {
                                                                            xtype: 'checkbox',
                                                                            fieldLabel: 'Especial',
                                                                            id: 'ESPECIAL_PC_E',
                                                                            labelWidth: 130
                                                                        }
                                                                    ] //Cierra items excluir busqueda
                                                                }
                                                            ] //Cierra items container der
                                                        }
                                                    ] //Cierra items container principal
                                                },
                                                {
                                                    xtype: 'gridpanel',
                                                    id:'gridPagosConfirmados',
                                                    title: 'Pagos Confirmados',
                                                    height: 330,
                                                    width: 1092,
                                                    store: storeGridPagosConfirmados,
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
                                                            flex: .02,
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
                                                            flex: .01,
                                                            align:'center'

                                                        },
                                                        {
                                                            dataIndex: 'IMPORTE',
                                                            text: 'Importe',
                                                            flex: .03,
                                                            renderer: render_moneyConfirma,
                                                            align:'center'
                                                        },                                                                                                                    
                                                        {
                                                            dataIndex: 'FORMA_PAGO',
                                                            text: 'Forma de Pago',
                                                            flex: .04
                                                        },
                                                        {
                                                            dataIndex: 'ID_RECOLECTOR',
                                                            text: 'Recolector',
                                                            flex: .04
                                                        },
                                                        {
                                                            dataIndex: 'ID_ZONA',
                                                            text: 'Zona',
                                                            flex: .01,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'USUARIO_CONFIRMACION',
                                                            text: 'Usuario',
                                                            flex: .04
                                                        },
                                                        {
                                                            dataIndex: 'STATUS_IMPRESO',
                                                            text: 'Impreso',
                                                            flex: .02,
                                                            align:'center'
                                                        }
                                                    ],
                                                    viewConfig: {

                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                    }),
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 200,
                                                        store: storeGridPagosConfirmados,
                                                        displayInfo: true
                                                    })
                                                }
                                            ]
                                        }
                                    ]
                                },                                
                                /************************ PESTAÑA PAGOS REPROGRAMADOS ********************************/
                                {
                                    xtype: 'panel',
                                    width: 1100,
                                    height: 400,
                                    border:false,
                                    title: 'Pagos Reprogramados',
                                    tbar: tbarPagosReprogramados,
                                    items: [
                                        {
                                            xtype: 'form',
                                            id: 'frmReprogramados',                                                                                        
                                            border:false,
                                            items: [
                                                {
                                                    xtype: 'fieldset',
                                                    height: 90,
                                                    title: 'Busqueda',
                                                    items:[                                                        
                                                        {
                                                            xtype: 'textfield',
                                                            fieldLabel:'Nombre',
                                                            id:'NOMBRE_DONANTE_PR',                                                                    
                                                            labelWidth: 130,
                                                            width: 500,
                                                            size: 250
                                                        },                                                    
                                                        {
                                                            xtype: 'combobox',
                                                            fieldLabel: 'Zona',
                                                            id:'ID_ZONA_PR',
                                                            store: stateszonasPC,
                                                            width: 500,
                                                            labelWidth: 130,
                                                            valueField: 'id',
                                                            displayField: 'nombre',                                                                        
                                                            emptyText: 'Seleccione la Zona...'                                                                          

                                                        }                                                    
                                                    ]
                                                },
                                                {
                                                    xtype: 'grid',
                                                    title: 'Pagos Reprogramados',
                                                    height: 460,
                                                    width: 1092,
                                                    id: 'gridPagosReprogramados',
                                                    store: storePagosReprogramados,
                                                    columns: [
                                                        {
                                                            dataIndex: 'ESTATUS',
                                                            text: 'Estatus',
                                                            flex: .05,
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
                                                            flex: .1,
                                                            align:'left'
                                                        },
                                                        {
                                                            dataIndex: 'ID_NUM_PAGO',
                                                            text: 'Pago',
                                                            flex: .02,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_COBRO',
                                                            text: 'Fecha Cobro',
                                                            flex: .04,
                                                            align:'center'
                                                        },                                                            
                                                        {
                                                            dataIndex: 'FECHA_VISITA',
                                                            text: 'Fecha Visita',
                                                            flex: .04,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'FECHA_REPROGRAMACION',
                                                            text: 'Reprogramación',
                                                            flex: .04,
                                                            align:'center'
                                                        },
                                                        {
                                                            dataIndex: 'TEL_CASA',
                                                            text: 'Tel. Casa',
                                                            flex: .03,
                                                            align:'center'                                                    
                                                        },
                                                        {
                                                            dataIndex: 'TEL_MOVIL',
                                                            text: 'Tel. Cel',
                                                            flex: .04,
                                                            align:'center'                                                    
                                                        },                                                        
                                                        {
                                                            dataIndex: 'COMENTARIOS_REPROGRAMAR',
                                                            text: 'Comentarios',
                                                            flex: .1,
                                                            align:'left'                                                    
                                                        }                                                        
                                                    ],
                                                    viewConfig: {

                                                    },
                                                    selModel: Ext.create('Ext.selection.CheckboxModel', {

                                                    }),
//                                                    bbar: pagerConfirmacion                                                   
                                                    bbar: new Ext.PagingToolbar({
                                                        pageSize: 300,
                                                        store: storePagosReprogramados,
                                                        displayInfo: true,
                                                        displayMsg: '{0} - {1} of {2} Registros',  
                                                        emptyMsg: 'No hay registros por mostrar'
                                                    })
                                                }
                                            ] //Cierra items form
                                        }
                                    ]
                                } //Termina ventana de pagos reprogramados
                            ]                           
                        }]
                }); //Cierra ext.apply
                storeHistorialPagos.load();
                storeGridPagosConfirmados.load();                
                storePagosReprogramados.load();
                cbxCampFinancieraRpE.load();
                storeRecolectores.load();
                statesclasificacionDonantePC.load();
                confirmaciones.confirmacion.superclass.initComponent.apply(this, arguments); 
            } //Cierra init component
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>
