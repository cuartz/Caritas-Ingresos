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
        /*********************** VARIABLES GLOBALES ******************************/
        var winIngresosFacturacion;
        var idBitacoraFacturacion;
        var idUsuarioTmp            = '<%=idusersession%>';
        var idUsuarioSplit          = idUsuarioTmp.split(":");
        var idUsuario               = idUsuarioSplit[0];
        
        /*********************** FUNCIONES JAVASCRIPT ******************************/
        function validaFacturacionIngresos(){
            if(Ext.getCmp("ID_SUSTITUTO_FACT").getValue() == null){ //Validar la fecha de visita
                Ext.MessageBox.alert('Error','¡Seleccione un sustituto a grabar!');
                return false
            }            
        }
        
        
        /*********************** MODELS ******************************/
        
        
        
        /*********************** STORES ******************************/
        
        
        
        
        /*********************** INICIA PANTALLA ******************************/
        Ext.define('confirmaciones.facturacion', {
            extend: 'Ext.window.Window',                   
            alias:'widget.facturacion',                
            title: 'Asignar Sustituto',
            constrain : true,
            width: 480,                
            height: 120,
            border: false,
            buttonAlign: 'left',
            maximizable: true,
            layout: 'fit',
            closeAction : 'destroy', 
            region:'center',
            initComponent: function() {
                /********* INICIALIZAR VARIABLES *********/
                winIngresosFacturacion  = this;
                idBitacoraFacturacion   = this.name;                
                
                var cbxSustitutoFact = Ext.create('Ext.data.JsonStore', {
                    model: 'Sustituto',
                    proxy: {
                        type: 'ajax',
                        url: 'comboboxAC.do?method=getSearchSustituto',
                        extraParams:{ID_BITACORA:idBitacoraFacturacion},
                        reader: {
                            type: 'json',
                            root: 'rows'
                        }
                    }
                });
                
                var tbarAsignarSustituto = new Ext.Toolbar({ // toolbar tres
                    items: [
                        Ext.create('Ext.Button',{
                            text:'Guardar',
                            iconCls:'icon-save',
                            handler:function(){                                                        
                                var json = winIngresosFacturacion.getDatas();
                                if(validaFacturacionIngresos() != false){
                                    Ext.Msg.confirm('Asignar Sustituto', '¿Los datos son correctos?', function(btn, text){ 
                                        if (btn == 'yes'){
                                            Ext.getCmp('frmAsignarSustituto').getForm().submit({                                                            
                                                url: 'listaConfirmacionAC.do?method=asignarSustituto_ingresosFacturacion&jsonData='+json+'&idBitacora='+idBitacoraFacturacion,                                                           
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {
                                                    Ext.getCmp('gridFacturacion').getStore().load();
                                                    winIngresosFacturacion.close();
                                                    Ext.MessageBox.alert('Guardado','¡Se grabo la información correctamente!');    
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                }
                                            }); 
                                        }
                                    }); 
                                }
                                
                                
                                
                            }
                        }),
                        '-',                                           
                        Ext.create('Ext.Button',{
                            text:'Salir',
                            iconCls:'icon-salir',
                            handler: function(){                                                            
                                winIngresosFacturacion.close();
                            }
                        })
                    ]
                }); //termina toolbar
                
                Ext.apply(this, {
                    items: [
                        {
                            xtype: 'form',
                            id: 'frmAsignarSustituto',
                            tbar: tbarAsignarSustituto,                            
                            items:[
                                {
                                    xtype: 'combo',
                                    fieldLabel: 'Seleccionar',
                                    id: 'ID_SUSTITUTO_FACT',
                                    size: 40,
                                    margin: 10,
                                    store:cbxSustitutoFact,
                                    displayField: 'RAZON_SOCIAL',
                                    valueField: 'ID_DONANTE_TMP'                                    
                                }
                            ] //Cierra items del form
                        }
                    ] //Cierra items Ext.apply
                }); //Cierra Ext.apply                
                confirmaciones.facturacion.superclass.initComponent.apply(this, arguments);
            }, //Cierra initComponent
            getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                var camposName=['ID_SUSTITUTO_FACT']

                var camposValue = {'ID_SUSTITUTO_FACT':0};                                        

                var pos=0;
                var value = '';                    

                for(pos=0;pos<camposName.length;pos++){                    
                    value = Ext.getCmp(camposName[pos]).getValue();
                    camposValue[camposName[pos]] = value;                                                                                                                          
                }                                 
                return Ext.encode(camposValue);
            } //Cierra getData();
        }); //Cierra Ext.define
        
        
        </script>
    </head>
    <body>
    </body>
</html>
