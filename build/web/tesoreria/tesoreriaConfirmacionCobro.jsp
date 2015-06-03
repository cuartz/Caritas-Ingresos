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
        var idUsuarioTmp    = '<%=idusersession%>';
        var idUsuarioSplit  = idUsuarioTmp.split(":");
        var idUsuario       = idUsuarioSplit[0];
        /************************ VARIABLES GLOBALES ********************************/        
        var winConfirmCobro;
        var tbarConfirm;
        var idBitacoraTmp;
        var fechaaa = new Date();       
        
        Ext.define('formaPagoMdl',{
            id:'formaPagoMdl',
            extend: 'Ext.data.Model',
            fields: [                       
                'ID_FORMA_PAGO'
            ]
        });
        
        /************************ FUNCIONES ********************************/
        function cleanRegConfirmCobro(){
            Ext.getCmp('frmConfirmCobro').getForm().reset();
            Ext.getCmp('CHKBOX_NO').enable(); 
            Ext.getCmp('CHKBOX_YES').enable();
            Ext.getCmp('MOTIVO_NO_COBRADO').enable();                
        }
        
        function daysInMonth(humanMonth, year) {
            return new Date(year || new Date().getFullYear(), humanMonth, 0).getDate();
        }
        
        function mostrarFecha(days, fecha){
            
            var milisegundos=parseInt(35*24*60*60*1000);           
//            var fecha=new Date();
            var day=fecha.getDate();            
            // el mes es devuelto entre 0 y 11
            var month=fecha.getMonth()+1;           
            var year=fecha.getFullYear();           

            alert("Fecha actual: "+day+"/"+month+"/"+year);

            //Obtenemos los milisegundos desde media noche del 1/1/1970
            var tiempo=fecha.getTime();
            //Calculamos los milisegundos sobre la fecha que hay que sumar o restar...
            milisegundos=parseInt(days*24*60*60*1000);
            //Modificamos la fecha actual
            var total=fecha.setTime(tiempo+milisegundos);
            day=fecha.getDate();
            month=fecha.getMonth()+1;
            year=fecha.getFullYear();

            alert("Fecha modificada: "+day+"/"+month+"/"+year);
        }
        
        function dia_semana(fecha){   
            fecha=fecha.split('/');  
            if(fecha.length!=3){  
                    return null;  
            }  
            //Vector para calcular día de la semana de un año regular.  
            var regular =[0,3,3,6,1,4,6,2,5,0,3,5];   
            //Vector para calcular día de la semana de un año bisiesto.  
            var bisiesto=[0,3,4,0,2,5,0,3,6,1,4,6];   
            //Vector para hacer la traducción de resultado en día de la semana.  
            var semana=['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
            var semana1=[1, 2, 3, 4, 5, 6, 7];
            //Día especificado en la fecha recibida por parametro.  
            var dia=fecha[0];  
            //Módulo acumulado del mes especificado en la fecha recibida por parametro.  
            var mes=fecha[1]-1;  
            //Año especificado por la fecha recibida por parametros.  
            var anno=fecha[2];  
            //Comparación para saber si el año recibido es bisiesto.  
            if((anno % 4 == 0) && !(anno % 100 == 0 && anno % 400 != 0))  
                mes=bisiesto[mes];  
            else  
                mes=regular[mes];  
            //Se retorna el resultado del calculo del día de la semana.  
            return semana1[Math.ceil(Math.ceil(Math.ceil((anno-1)%7)+Math.ceil((Math.floor((anno-1)/4)-Math.floor((3*(Math.floor((anno-1)/100)+1))/4))%7)+mes+dia%7)%7)];  
        }
        
        function fecha(){
            var dia = 0;
            var mes = 0;
            var ano = 0;            
            var date = new Date();            
            var dia = date.getDate();
            var mes = date.getMonth() + 1;
            var ano = date.getFullYear();
            var milisegundos;            
            var tiempo;
            var diasMasMenos;            
            
            if(dia_semana(dia+"/"+mes+"/"+ano) > 2 && dia_semana(dia+"/"+mes+"/"+ano) <= 7){ //Si es entre semana                
                //alert("entre semana");
                diasMasMenos = -1;
                milisegundos=parseInt(35*24*60*60*1000);                
                tiempo=date.getTime();
                milisegundos=parseInt(diasMasMenos*24*60*60*1000);                
                var total=date.setTime(tiempo+milisegundos);
                dia=date.getDate();
                mes=date.getMonth()+1;
                ano=date.getFullYear();
            }else if(dia_semana(dia+"/"+mes+"/"+ano) == 2){ //Si es Lunes                
                //alert("lunes");                
                diasMasMenos = -2;
                milisegundos=parseInt(35*24*60*60*1000);                
                tiempo=date.getTime();
                milisegundos=parseInt(diasMasMenos*24*60*60*1000);               
                var total=date.setTime(tiempo+milisegundos);
                dia=date.getDate();
                mes=date.getMonth()+1;
                ano=date.getFullYear();
            }            
            fechaaa = date;
        }
        
        function validaAdmon(){            
            if(Ext.getCmp("ID_FORMA_PAGO_ADMON").getValue() == null){ //Validar la forma de pago
                Ext.MessageBox.alert('Error','!Selecciona la forma de pago del recibo!');                   
                return false
            }
        }
        
        function loadFormaPago(ID_BITACORA){            
            if(ID_BITACORA != ""){                
                storeFormaPago.proxy.extraParams.ID_BITACORA = ID_BITACORA;                 
                storeFormaPago.load({callback: function(records,o,s){                            
                    if(records.length>0){                        
                        var idFormaPago = records[0].data.ID_FORMA_PAGO;
                        cbxFormaPago.load({callback: function(records,o,s){
                            Ext.getCmp('ID_FORMA_PAGO_ADMON').setValue(parseInt(idFormaPago,10));
                        }});
                    }
                }});
                
            }
        }
        
        /************************ STORES******************************/        
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
        
        var storeFormaPago = Ext.create('Ext.data.JsonStore', {
            model: 'formaPagoMdl',
            pageSize: 50,
            id:'storeFormaPago',
            name:'storeFormaPago',
            proxy: {
                type: 'ajax',
                url: 'tesoreriaAC.do',
                extraParams: {method: 'getFormaDePagoByBitacora'},
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        });
                     
        /************************ INICIA PANTALLA ********************************/         
        Ext.define('tesoreria.tesoreriaConfirmacionCobro', {
            extend: 'Ext.window.Window',           
            alias:'widget.tesoreriaConfirmacionCobro',                
            title: 'Confirmacion Cobro',
            width: 450,                
            height: 160,
            border: false,
            buttonAlign: 'left',
            layout: 'fit',
            maximizable: true,
            closeAction : 'destroy',
            region:'center',
            modal: true,
            initComponent: function() {
                /************************ INICIALIZAR ********************************/ 
                winConfirmCobro = this;
                idBitacoraTmp = this.name; 
                fecha();
                loadFormaPago(idBitacoraTmp);
                //alert("idBitacora: "+idBitacoraTmp);
                /************************ TOOLBAR ********************************/ 
                tbarConfirm = new Ext.Toolbar({
                    items:[                      
                        {
                            xtype: 'button',
                            text: 'Guardar',
                            iconCls:'icon-save',
                            handler: function(){
                                var json = winConfirmCobro.getDatas();
//                                alert("guardar: "+json);
                                if(validaAdmon() != false ){
                                    Ext.Msg.confirm('Confirmar Pago', '¿Los datos son correctos?', function(btn, text){
                                        if (btn == 'yes'){
                                            Ext.getCmp('frmConfirmCobro').getForm().submit({
                                                url: 'tesoreriaAC.do?method=tesoreriaConfirmacionCobro&jsonData='+json+'&idBitacora='+idBitacoraTmp+'&idUsuario='+idUsuario,
                                                waitMsg: 'Guardando...',
                                                success: function(form, action) {
                                                    Ext.getCmp('gridCobrosEfectivo').getStore().load();
                                                    winConfirmCobro.close();
                                                    var info = Ext.MessageBox.alert('Guardado','Se grabo la información correctamente');
                                                },
                                                failure: function(form, action) {
                                                    Ext.MessageBox.alert('Error','¡Ocurrio un error al grabar la información!');
                                                }
                                            });                             
                                        }
                                    })
                                }                                 
                            }
                        },                        
                        '-',
                        {
                            xtype: 'button',
                            text: 'Salir',
                            iconCls:'icon-salir',
                            handler: function()
                            {                                                
                                winConfirmCobro.close();
                            }  
                        }                        
                    ]
                }); //Termina Toolbar
                
                Ext.apply(this, {
                    items: [
                        {
                            xtype: 'form',
                            id: 'frmConfirmCobro',
                            border: false,                            
                            tbar: tbarConfirm,
                            layout: {
                                type: 'anchor'
                            },
                            items: [
                                {                                   
                                    xtype: 'checkboxgroup',
                                    width: 427,
                                    fieldLabel: 'Cobrado',
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            id: 'CHKBOX_YES',
                                            boxLabel: 'Si',
                                                handler: function(){   
                                                        if(this.checked){ 
                                                        Ext.getCmp('CHKBOX_NO').disable();
                                                        Ext.getCmp('COMENTARIOS').disable();                                                            
                                                    }else{
                                                        Ext.getCmp('CHKBOX_NO').enable();
                                                        Ext.getCmp('COMENTARIOS').enable();
                                                    }
                                                }
                                        }//                                                                                    
                                    ] //Cierra items panel 1
                                },
                                {
                                    xtype: 'datefield', 
                                    id:'FECHA_PAGO_ADMON',                                    
                                    fieldLabel: 'Fecha Pago',
                                    format: 'd/m/Y',
                                    value: fechaaa
                                },
                                Ext.create('Ext.form.ComboBox', {
                                    fieldLabel: 'Forma de Pago',
                                    store: cbxFormaPago,
                                    emptyText: 'Seleccione la forma de pago',
                                    size: 30,
                                    displayField: 'nombre',
                                    valueField: 'id',
                                    id: 'ID_FORMA_PAGO_ADMON'
                                })
                            ] //Cierra items form                        
                        }
                    ] //Cierra items ext.apply
                }); //Cierra Ext.apply
                cbxFormaPago.load();
                tesoreria.confirmacionCobro.superclass.initComponent.apply(this, arguments); 
            }, //Cierra initComponent
            getDatas: function (){//Obtiene cada uno de los valores de los campos necesarios para crear un servicio y no deja guardar si falta alguno
                        var camposName=['CHKBOX_YES',                                        
                                        'FECHA_PAGO_ADMON',
                                        'ID_FORMA_PAGO_ADMON']

                        var camposValue = {'CHKBOX_YES':0,                                            
                                            'FECHA_PAGO_ADMON':'',
                                            'ID_FORMA_PAGO_ADMON':0};
                            
                        var pos=0;
                        var value = '';             
//                       
                        for(pos=0;pos<camposName.length;pos++){
                            if(pos == 0){
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == true)
                                    camposValue[camposName[pos]] = 1;
                                if(value == false)
                                    camposValue[camposName[pos]] = 0;
                            }else{
                                value = Ext.getCmp(camposName[pos]).getValue();
                                if(value == '')
                                    camposValue[camposName[pos]] = null;
                                else
                                    camposValue[camposName[pos]] = value;
                            }                                                                                                              
                        }                                 
                        return Ext.encode(camposValue);
                    }
        }); //Cierra Ext.define
        </script>
    </head>
    <body>
    </body>
</html>
