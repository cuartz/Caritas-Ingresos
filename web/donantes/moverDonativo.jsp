<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript">
        /********************* VARIABLES GLOBALES ***********************/
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        var winMoverDonativo;
        var idDonativo_mover;       
               
        /********************** FUNCIONES JAVASCRIPT ****************************/
        function vMoverDonativo(){
            if(Ext.getCmp("ID_DONANTE_NUEVO").getValue() == "" || Ext.getCmp("ID_DONANTE_NUEVO").getValue() == null){
                Ext.MessageBox.alert('Error','!Ingresa el numero de donante al que vas a trasladar el donativo!');                   
                return false
            }
        }        
                
        /********************** INICIA PANTALLA ****************************/
        Ext.define('donantes.moverDonativo', {
                extend: 'Ext.window.Window',                    
                alias:'widget.moverDonativo',                   
                title: 'Mover Donativo',                
                model: true,
                width: 300,                
                height: 100,
                border: false,
                buttonAlign: 'left',
                closeAction:'close',
                autoDestroy:true,
                maximizable: true,
                layout: 'fit',                    
                region:'center',
                constrain:true,
                modal: true,
                initComponent: function() {
                idDonativo_mover = this.name;
                winMoverDonativo = this;                
                    
                var tbarCancelarD = new Ext.Toolbar({ 
                    items: [
                        new Ext.Button({
                            text: 'Guardar',
                            iconCls: 'icon-save',
                            handler: function(){
                                if(idUsuario == 'MMENDOZA' || idUsuario == 'RNUNEZ'){
                                    var json = winMoverDonativo.getDatas();                             
                                    if(vMoverDonativo() != false ){
                                        Ext.Msg.confirm('Mover Donativo', 'Esta acción eliminará el donativo y todos sus recibos y lo agregará en el nuevo donante. ¿Es correcto?', function(btn, text){
                                            if (btn == 'yes'){                                            
                                                Ext.getCmp('mainFormMover').getForm().submit({
                                                    url: 'donativoAC.do?method=moverDonativo&jsonData='+json+'&idDonativo='+idDonativo_mover,
                                                    waitMsg: 'Guardando...',
                                                    success: function(form, action) {
                                                        Ext.MessageBox.alert('Listo','El donativo ha sido trasladado correctamente');
                                                        Ext.getCmp('gridDonativos').getStore().load();
                                                        winMoverDonativo.destroy();                                                    
                                                    },
                                                    failure: function(form, action) {
                                                        Ext.MessageBox.alert('Error','¡Ocurrio un error al trasladar el donativo!');                                                    
                                                    }
                                                });                                               
                                            }
                                        }); 
                                    }
                                }else{
                                    Ext.MessageBox.alert('Error','¡Usted no tiene permisos para esta acción!');
                                }                        
                            }                                    
                        }),
                        '-',                                
                        new Ext.Button({
                            text: 'Salir',
                            iconCls: 'icon-salir',
                            handler: function(){                                   
                                winMoverDonativo.destroy();                            
                            }   
                        })
                    ]
                }); //termina toolbar uno
                    
                    Ext.apply(this, {
                        items:[
                            {
                                xtype: 'form',
                                id: 'mainFormMover',
                                tbar: tbarCancelarD,                               
                                items:[
                                    {
                                        xtype: 'numberfield',                                        
                                        fieldLabel: 'No. Donante',
                                        id: 'ID_DONANTE_NUEVO',
                                        hideTrigger: true,
                                        size: 20
                                    }
                                ] //Cierra items form principal
                            }
                        ] //Cierra items Ext.apply
                    }); //Cierra Ext.apply
                    donantes.moverDonativo.superclass.initComponent.apply(this, arguments); 
                }, //Cierra initComponent
                getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                    var camposName=['ID_DONANTE_NUEVO']

                    var camposValue = {'ID_DONANTE_NUEVO':0};                           

                    var pos=0;
                    var value = '';             
//                       
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
