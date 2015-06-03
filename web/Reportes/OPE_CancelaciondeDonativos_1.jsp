<%--
    Document   : universoDonantesAnualSHCP
    Created on : 26/11/2011, 19:59:12 pm
    Author     : JZAMORA
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%//Obtenemos los datos de la cita programanda

%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript"> 
 
            //  
 
            function render_moneyRPP(v, p, record){
                return '$ '+v
            }
            
            function render_statusRLC(v, p, record){
                if(v=="0"){
                    return "<img src='img/class/edit-doc.png'";
                }  else if(v=="1"){
                    return "<img src='img/status-1.png'";
                } else if(v=="2"){
                    return "<img src='img/class/new-doc.png'>";                    
                } else {
                    return "";
                }
            }  
              
              
            //   //combo tipos de Recolectores
            var listaFiltros = [
                ['0', 'Cancelación por proyecto.'],
                ['1', 'Cancelación por asignación.']];


            var storeCBCancelacionDonativo = Ext.create('Ext.data.SimpleStore',{
                autoLoad: true,
                fields: ['ID', 'NOMBRE'],
                data: listaFiltros
            });  
            
            
            Ext.define('catalog',{// create the Data Titulo
                id:'catalog',
                extend: 'Ext.data.Model',
                fields: ['id','id_catalog','nombre','status']
            });
            
            var statesCAMPANAS_FINANCIERAS = Ext.create('Ext.data.JsonStore', {// create the Store Titulo
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
            
            var statesASIGNACIONES = Ext.create('Ext.data.JsonStore', {// create the Store Titulo
                model: 'catalog',
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getCatalogByLlave', 
                    extraParams:{llave:'INGRESOS_ASIGNACIONES'},
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });
           
            Ext.define('OPE_CancelaciondeDonativos',{// create the Data Atenciones
                id:'OPE_CancelaciondeDonativos',
                extend: 'Ext.data.Model',
                fields:     [
//                    {name: 'FECHA_IMPRESION'},
                    {name: 'ID_DONANTE'},
                    {name: 'DONANTE'},
                    {name: 'ID_DONATIVO'},
                    {name: 'NOMBRE'},
                    {name: 'IMPORTE'},
                    {name: 'ID_RECIBO'},
                    {name: 'COMENTARIOS_CANCELACION'},
                   
                ]
            });

            var storeOPE_CancelaciondeDonativos = Ext.create('Ext.data.JsonStore', {// create the Store Atenciones
                model: 'OPE_CancelaciondeDonativos',
                id: 'storeOPE_CancelaciondeDonativos',
                name: 'storeOPE_CancelaciondeDonativos',
                //                waitMsg:'Loading...',
                pageSize: 200,
                //                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do', 
                    extraParams:{ method: 'getR_OPE_CancelaciondeDonativos'},
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty:'totalcount'
                    }
                }
//                ,
//                listeners:{
//                    beforeload:function(store,operation,option){ 
//                        store.proxy.extraParams = {fechaini:CancelaciondeDonativos.fechaini,
//                            fechafin:CancelaciondeDonativos.fechafin,
//                            UsuarioAT:CancelaciondeDonativos.UsuarioAT,
//                            TipoListado:CancelaciondeDonativos.TipoListado,
//                            chekbox:CancelaciondeDonativos.chekbox
//                        };
//                    }
//                }
            });   
                       
            
            var CancelaciondeDonativos = new Ext.form.field.Hidden({//Parametros para obtener informacion en el grid
                fechaini :'01/06/2012',
                fechafin : '06/09/2012',
                UsuarioAT : 'CGARZA',
                TipoListado:'0',
                chekbox:'1'
                //usuario : 'CWILSON'
            });
            
            
            
           
               
            Ext.define('Usuarios',{// create the Data cbUsuarios
                id:'Usuarios',
                extend: 'Ext.data.Model',
                fields:['NOMBRE', 'ID']
            });

            var storeUsuario = Ext.create('Ext.data.JsonStore', {// create the Store cbUsuarios
                model: 'Usuarios',
                pageSize: 50,
                proxy: {
                    type: 'ajax',
                    url: 'comboboxAC.do?method=getAllUsuarios', 
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            });         
            
            //Inicia
            Ext.define('Reportes.OPE_CancelaciondeDonativos_1', {
                extend: 'Ext.window.Window',
                id:'OPE_CancelaciondeDonativos_1',
                name: 'Reportes.OPE_CancelaciondeDonativos_1',
                alias:'widget.OPE_CancelaciondeDonativos_1',                
                title: 'Reporte de OPE Cancelacion de Donativos',
                width: 1200,                
                height: 600,
                border: false,
                buttonAlign: 'left',
                maximizable: true,
                layout: 'fit',    
                region:'center',
                //                modal:true,
                closeAction:'destroy',
                autoScroll:true,//modificacion
                initComponent: function() {
                    
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'grid',
                                store: storeOPE_CancelaciondeDonativos,
                                id:'gridOPE_CancelaciondeDonativos',
                                name: 'gridOPE_CancelaciondeDonativos',
                                columns: [
//                                    {
//                                        dataIndex: 'FECHA_IMPRESION',
//                                        flex: .5,
//                                        text :'FECHA_IMPRESION'
//                                    }
//                                    ,
                                    {
                                        dataIndex: 'ID_DONANTE',
                                        flex: .2,
                                        text :'ID_DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'DONANTE',
                                        flex: .8,
                                        text :'DONANTE'
                                    }
                                    ,
                                    {
                                        dataIndex: 'ID_DONATIVO',
                                        flex: .4,
                                        text :'ID_DONATIVO'
                                    },
                                    {
                                        dataIndex: 'NOMBRE',
                                        flex: .6,
                                        text: 'NOMBRE'
                                    },
                                    {
                                        dataIndex: 'IMPORTE',
                                        flex: .6,
                                        renderer:render_moneyRPP,
                                        text: 'IMPORTE'
                                    },
                                    {
                                        dataIndex: 'ID_RECIBO',
                                        flex: .6,
                                        text: 'ID_RECIBO'
                                    }
                                    ,
                                    {
                                        dataIndex: 'COMENTARIOS_CANCELACION',
                                        flex: .6,
                                        text: 'COMENTARIOS_CANCELACION'
                                    }
                                ]                        
                                ,
                               
                                tbar: {
                                    xtype: 'toolbar',
                                    items: [
                                        {
                                            xtype: 'datefield',
                                            name: 'fechaini',
                                            id: 'fechaini',
                                            labelWidth: 75,
                                            fieldLabel: 'Fecha Inicial'
                                            //                                            listeners: {
                                            //                                                select: function(field, value, option){
                                            //                                                    parametersuniversoDonantesAnualSHCP.fechaini= mostrarFecha(Ext.getCmp('fechaini').getValue());
                                            //                                                    storeOPE_CancelaciondeDonativos.load();
                                            //                                                }
                                            //                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'datefield',
                                            name: 'fechafin',
                                            id: 'fechafin',
                                            labelWidth: 70,
                                            fieldLabel: 'Fecha Final'
                                            //                                            listeners: {
                                            //                                                select: function(field, value, option){
                                            //                                                    parametersuniversoDonantesAnualSHCP.fechafin= mostrarFecha(Ext.getCmp('fechafin').getValue());
                                            //                                                    storeOPE_CancelaciondeDonativos.load();
                                            //                                                }
                                            //                                            }
                                        }
                                        ,
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'combo',
                                            name: 'UsuarioAT',
                                            id: 'UsuarioAT',
                                            fieldLabel: 'Usuario',
                                            labelWidth: 45,
                                            store: storeUsuario,
                                            anchor: '60%',
                                            editable: false,
                                            valueField: 'ID',
                                            allowBlank:false,
                                            displayField:'ID',
                                            triggerAction: 'all',
                                            tabIndex: 13
                                            //                                            listeners:{
                                            //                                                select:function(combo,record,opcion)
                                            //                                                {
                                            //                                                    parametersuniversoDonantesAnualSHCP.usuario= record[0].get("ID");
                                            //                                                    storeOPE_CancelaciondeDonativos.load();
                                            //                                                }
                                            //                                            }
                                        },
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'combo',
                                            name: 'Tipo_Listado',
                                            id: 'Tipo_Listado',
                                            fieldLabel: 'Listado',
                                            labelWidth: 45,
                                            store: storeCBCancelacionDonativo,
                                            anchor: '60%',
                                            editable: false,
                                            valueField: 'ID',
                                            allowBlank:false,
                                            displayField:'NOMBRE',
                                            triggerAction: 'all',
                                            defaultValue:'Mexico',
                                            tabIndex: 13
                                            //                                            select: function(field, value){
                                            //                                                alert("tipo de listado"+ value );
                                            //                                                if(value[0].data.id==1 || value[0].data.id==0){
                                            //                                                    alert("tipo de listado"+ value );
                                            //                                                    Ext.getCmp('cancelacionProyecto').setVisible(true);   
                                            //                                                }else{
                                            //                                                    Ext.getCmp('cancelacionAsignacion').setVisible(true);
                                            //                                                    alert("tipo de listadsdsdsdo"+ value );
                                            //                                                }
                                            //                                                
                                            //                                            }
                                        } 
                                        ,{xtype:'tbseparator'}
                                        ,{
                                            xtype: 'checkboxfield',
                                            labelWidth: 60,
                                            id: 'chkbxNombre',
                                            boxLabel: 'Nombre S/N'
                                        },
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Buscar',
                                            iconCls:'icon-find2',
                                            handler: function()
                                            {
                                                var chekbox;
                                                if(Ext.getCmp('chkbxNombre').checked==true){
                                                    chekbox=1
//                                                    alert("check box 1");
                                                }else {
                                                    chekbox=0 
//                                                    alert("check box 0");
                                                }
                                                var fechaini=Ext.getCmp('fechaini').getValue();
                                                var fechafin=Ext.getCmp('fechafin').getValue();
                                                var UsuarioAT=Ext.getCmp('UsuarioAT').getValue();
                                                var TipoListado=Ext.getCmp('Tipo_Listado').getValue();
                                               
                                                storeOPE_CancelaciondeDonativos.proxy.extraParams.fechaini=fechaini;
                                                storeOPE_CancelaciondeDonativos.proxy.extraParams.fechafin=fechafin;
                                                storeOPE_CancelaciondeDonativos.proxy.extraParams.UsuarioAT=UsuarioAT;
                                                storeOPE_CancelaciondeDonativos.proxy.extraParams.TipoListado=TipoListado;
                                                storeOPE_CancelaciondeDonativos.proxy.extraParams.chekbox=chekbox;
                                                                                                alert("1-- " +fechaini);
                                                                                                alert("2-- " +fechafin);
                                                storeOPE_CancelaciondeDonativos.load();
                                            }   
                                        }
                                        ,{xtype:'tbseparator'}
                                        ,Ext.create('Ext.Button', {
                                            text: ' Exportar ',
                                            iconCls:'icon-xlsx',
                                            handler: function() {
                                                window.open("ShowExcel?idOperationType=9&fechaini="+parametersuniversoDonantesAnualSHCP.fechaini+ "&fechafin="+parametersuniversoDonantesAnualSHCP.fechafin+"&usuario="+parametersuniversoDonantesAnualSHCP.usuario);
                                            }
                                        }),
                                        {xtype:'tbseparator'},
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                var win=Ext.getCmp('OPE_CancelaciondeDonativos_1');
                                                win.close();
                                            }   
                                        }
                                    ]
                                },//Fin de tbar continuacion de barra de paginacion //Paginacion
                                bbar: new Ext.PagingToolbar({
                                    pageSize: 200,
                                    store: storeOPE_CancelaciondeDonativos,
                                    displayInfo: true
                                })
                            }
                        ]
                    });            
                    Reportes.OPE_CancelaciondeDonativos_1.superclass.initComponent.apply(this, arguments);
                    storeOPE_CancelaciondeDonativos.load();//en blanco comentar esta linea
                }
            });
        </script>
    </head>
    <body>
    </body>
</html>