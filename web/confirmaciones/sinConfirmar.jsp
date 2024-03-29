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
    /****************** VARIABLES GLOBALES **************************/
    var idBitacoraSinConfirmar  = 0;
    var nota                    = 'La dirección a la que se recogerá este recibo será a la de entrega y cobro.';    
    var idUsuarioTmp            = '<%=idusersession%>';
    var idUsuarioSplit          = idUsuarioTmp.split(":");
    var idUsuario               = idUsuarioSplit[0];
    var winSinConfirmar;

    /******************** FUNCIONES ************************/
    function loadComentariosInfo(ID_BITACORA){
        storeSinConfirmarInfo.proxy.extraParams.ID_BITACORA = ID_BITACORA;
        storeSinConfirmarInfo.load({ callback: function(records,o,s){
            if(records.length > 0){
                Ext.getCmp('COMENTARIOS').setValue(records[0].data.COMENTARIOS);                        
            }                            
        }}); //Cierra storeDonativoInfo                         
    }

    /******************** MODELS *************************/
    Ext.define('sinConfirmarInf',{
        id:'sinConfirmarInf',
        extend: 'Ext.data.Model',
        fields: [
            'COMENTARIOS'                
        ]
    });

    /******************** STORES *************************/
    var storeSinConfirmarInfo = Ext.create('Ext.data.JsonStore', {
        model: 'sinConfirmarInf',
        pageSize: 50,
        id:'storeSinConfirmarInfo',
        name:'storeSinConfirmarInfo',
        proxy: {
            type: 'ajax',
            url: 'sinConfirmarAC.do',
            extraParams: {method: 'getComentariosInfo'},
            reader: {
                type: 'json',
                root: 'rows'
            }
        }
    });        
        
    //Creation Screen            
    Ext.define('confirmaciones.sinConfirmar', {
        extend: 'Ext.window.Window',                
        alias:'widget.sinConfirmar',               
        title: 'Cobrar sin confirmar el pago',               
        width: 400,                
        height: 250,
        border: false,
        buttonAlign: 'left',
        maximizable: true,
        layout: 'fit',
        closeAction : 'destroy',
        region:'center',
        initComponent: function() {
        /***************** INICIALIZAR ****************/
        winSinConfirmar = this;
        idBitacoraSinConfirmar = this.name;
        loadComentariosInfo(idBitacora);

        /******************* TOOLBAR ************************/
        var tBarSinConfirmar = new Ext.Toolbar({ // toolbar Dos
            items: [
                new Ext.Button({
                    text: 'Guardar',
                    iconCls: 'icon-save',
                    handler: function(){
                        var json = winSinConfirmar.getDatas();
                        //alert('Guardar: '+json)
                        Ext.Msg.confirm('Confirmar Pago', '¿Los datos son correctos?', function(btn, text){ 
                            if (btn == 'yes'){
                                Ext.getCmp('frmSinConfirmar').getForm().submit({                                                            
                                url: 'sinConfirmarAC.do?method=saveSinConfirmar&jsonData='+json+'&idBitacora='+idBitacoraSinConfirmar+'&idUsuario='+idUsuario,
                                waitMsg: 'Guardando...',
                                success: function(form, action) {
                                    Ext.getCmp('gridDonativosConfirmacion').getStore().load();
                                    winSinConfirmar.close();
                                    Ext.MessageBox.alert('Guardado','¡Se grabo la información correctamente!');
                                },
                                failure: function(form, action) {
                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
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
                        winSinConfirmar.close();
                    }
                })
                ]
            }); //termina toolbar   

        Ext.apply(this, {
            items:[
                {
                    xtype: 'form',
                    id: 'frmSinConfirmar',                            
                    tbar: tBarSinConfirmar,
                    items:[
                        {                            
                            xtype: 'datefield',
                            format: 'd/m/y',
                            fieldLabel: 'Fecha Visita',
                            labelWidth: 110,
                            id: 'FECHA_VISITA_SIN_CONFIRMAR',
                            size: 30
                        },                        
                        {
                            xtype: 'textareafield',                            
                            height: 100,
                            width: 350,
                            labelWidth: 110,
                            id: 'COMENTARIOS',
                            fieldLabel: 'Comentarios'                                    
                        },
                        {
                            xtype: 'displayfield',
                            width: 400,                            
                            value: nota,
                            labelWidth: 110                            
                        }
                    ] //Cierra items form
                }                       
            ] //Cierra items ext.apply
        }); //Cierra Ext.apply
        confirmaciones.sinConfirmar.superclass.initComponent.apply(this, arguments); 
        }, //Cierra init component
        getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
            var camposName=['COMENTARIOS',
                'FECHA_VISITA_SIN_CONFIRMAR']
            var camposValue = {'COMENTARIOS':'',
                'FECHA_VISITA_SIN_CONFIRMAR':''};                                       
            var pos=0;
            var value = '';                    

            for(pos=0;pos<camposName.length;pos++){
                value = Ext.getCmp(camposName[pos]).getValue();
                camposValue[camposName[pos]] = value;                                                               
            }                                 
            return Ext.encode(camposValue);
        } //Cierra getData();
    }); //Cierra Ext
    </script>       
    </head>
    <body>        
    </body>
</html>
