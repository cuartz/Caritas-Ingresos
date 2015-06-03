<%--
    Document   : Archivar Documentos
    Created on : 25/11/2011, 14:14:12 pm
    Author     : Ozamora
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" %>
<%@page import="org.apache.struts.Globals" %>
<%@page import="java.util.Locale" %>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%//Obtenemos los datos de la cita programanda
           /*
     * HttpSession sesion = request.getSession(); Person infoUser = (Person)
     * sesion.getAttribute("infoSesion"); if (infoUser == null) { infoUser = new
     * Person(); }
     */
%>
<html>
    <head>
        <!-- LIBRERIAS PARA ExtJS-->
        <!--        <link rel="stylesheet" type="text/css" href="css/estilo.css" />-->
        <script type="text/javascript">
   
            //// Inicia File Upload

            function render_ext(v, p, record){
                var ext = "else";
                if(record.get('nombre_archivo').split(".")[1]=="jpg"||record.get('nombre_archivo').split(".")[1]=="png"||record.get('nombre_archivo').split(".")[1]=="gif"){
                    ext = "jpg";
                } else if(record.get('nombre_archivo').split(".")[1]=="pdf"){
                    ext = "pdf";
                } else if(record.get('nombre_archivo').split(".")[1]=="xls"||record.get('nombre_archivo').split(".")[1]=="xlsx"){
                    ext = "xlsx";
                } else if(record.get('nombre_archivo').split(".")[1]=="doc"||record.get('nombre_archivo').split(".")[1]=="docx"){
                    ext = "docx";
                } else if(record.get('nombre_archivo').split(".")[1]=="ppt"||record.get('nombre_archivo').split(".")[1]=="pptx"){
                    ext = "pptx";
                } 
                    
                
                if(record.get('status')!='0'){
                    return "<img src='img/class/"+ext+".png'>";
                }
            }   
            var fp = Ext.create('Ext.form.Panel', {
                id: 'fp',
                width: 500,
                frame: true,
                bodyPadding: '10 10 0',

                defaults: {
                    anchor: '100%',
                    allowBlank: false,
                    msgTarget: 'side',
                    labelWidth: 50,
                    border: false
                },

                items: [
                    {
                        xtype: 'filefield',
                        id: 'form-file',
                        blankText: 'Favor de Seleccionar el archivo a Adjuntar',
                        fieldLabel: 'Cargar',
                        name: 'photo-path',
                        buttonText: '',
                        buttonConfig: {
                            iconCls: 'upload-icon'
                        }
                    }],

                buttons: [{
                        text: 'Guardar',
                        id:'Reg_save',
                        handler: function(){
                            alert('guardar file');
                            saveFile();
                        }
                    },{
                        text: 'Restablecer',
                        handler: function() {
                            this.up('form').getForm().reset();
                            clearFileUpload('form-file');
                            Ext.getCmp('form-file').clearInvalid();
                        }
                    },{
                        text: 'Cerrar',
                        handler: function() {
                            fotoUploadNew.hide();
                        }
                    }]
            });

            function saveFile(typeOperation, language){

                if(fp.getForm().isValid()){
                    var idBeneficiario
                        
                    //                    var selectedRow=Ext.getCmp('gridcitaexes')!=null?Ext.getCmp('gridcitaexes').selModel.selected.items[0]:undefined; 
//                    if(selectedRow!=undefined){
//                        idBeneficiario = selectedRow.data.id_beneficiario;
//                        if(idBeneficiario != null && idBeneficiario !='' )
//                        {

                            fp.getForm().submit({
                                url: 'addFileAC.do?method=saveFile&tipoArchivo=2',
//                                url: 'addFileAC.do?method=saveFile&idArchivo='+idBeneficiario+'&tipoArchivo=2',
                                timeout: 60000,
                                method: 'POST',
                                scope: this,
                                success: function(form, action ){
                                    var datas = "";
                                    try {
                                        var datas = Ext.JSON.decode(action.response.responseText);
                                        Ext.Msg.alert('Alerta','Archivo actualizado exitosamente: ' + datas.data.mensaje);
                                        tmpFoto = datas.data.mensaje;
                                        storeExpediente.load();
                                    }
                                    catch (err) {
                                        Ext.MessageBox.alert('ERROR', 'No se pudo decodificar: ' + action.response.responseText);
                                    }
                                    fp.getForm().reset();
                                    clearFileUpload('form-file');
                                    Ext.getCmp('form-file').clearInvalid();
                                    fotoUploadNew.hide();
                                },
                                failure: function(form, action) {
                                    Ext.Msg.alert('Error','error');
                                }
                            });
//                        }                        
//                    }
                    
                
                    
                }
                else {
                    Ext.Msg.alert('Alerta','Error de carga del archivo');
                }
            }

            function clearFileUpload(id){
                fileField = document.getElementById(id);// get the file upload element
                parentNod = fileField.parentNode;// get the file upload parent element
                tmpForm = document.createElement("form");// create new element
                parentNod.replaceChild(tmpForm,fileField);
                tmpForm.appendChild(fileField);
                tmpForm.reset();
                parentNod.replaceChild(fileField,tmpForm);
            }

            var fotoUploadNew = Ext.create("Ext.Window", {
                id: 'fotoUploadNew',
                title : 'Cargar - Archivo',
                autoWidth : true,
                autoHeight:true,
                closable : false,
                modal : true,
                items:[
                    {
                        xtype: 'form',
                        layout: 'anchor',
                        id:'panelUpload',
                        waitMsgTarget: true,
                        autoScroll:true,
                        border: false,
                        items: [ fp ]
                    }
                ]
            });// Termina File Upload   
            
            Ext.define('detExpediente',{// create the Data Expediente
                id:'detExpediente',
                extend: 'Ext.data.Model',
                fields:     [
                    {name: 'nombre_archivo'},
                    {name: 'ruta_archivo'}
                ]
            });

            var storeExpediente = Ext.create('Ext.data.JsonStore', {// create the Store Expediente
                model: 'detExpediente',
                pageSize: 1000,
                autoLoad:false,
                proxy: {
                    type: 'ajax',
                    url: 'reportesAC.do?method=getExpediente', 
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
                ,
                listeners:{
                    beforeload:function(store,operation,option){
//                        var selectedRow=Ext.getCmp('gridcitaexes')!=null?Ext.getCmp('gridcitaexes').selModel.selected.items[0]:undefined; 
//                        if(selectedRow!=undefined){
//                            store.proxy.extraParams = {id_beneficiario:selectedRow.data.id_beneficiario};
//                        }                            
                    }
                }
            });   
    
            Ext.define('Reportes.addDocument', {
                extend: 'Ext.window.Window',
                id:'addDocument',
                alias:'widget.addDocument',                
                title: 'Expediente',
                width: 350,                
                height: 450,
                border: false,
                buttonAlign: 'left',
                layout: 'fit',
                modal:true,
                region:'center',
                initComponent: function() {
                    Ext.apply(this, {
                        items: [
                            {
                                xtype: 'grid',
                                store: storeExpediente,
                                id:'gridExpediente',
                                name: 'gridExpediente',
                                columns: [
                                    {
                                        dataIndex: 'nombre_archivo',
                                        renderer:render_ext,
                                        width:30
                                    },
                                    {
                                        dataIndex: 'nombre_archivo',
                                        text:'Archivos',
                                        flex:1
                                    },
                                    {
                                        dataIndex: 'ruta_archivo',
                                        hidden:true
                                    }
                                ]                        
                                ,tbar: {
                                    items: [ 
                                        {
                                            xtype: 'button',
                                            text: 'Cargar',
                                            iconCls: 'icon-clip',
                                            formBind: true, //only enabled once the form is valid
                                            disabled: false,
                                            handler: function()                                    
                                            {
                                                alert('carga');
                                                fotoUploadNew.show();
                                            }                                                                       
                                        },
                                        {xtype:'tbseparator'},
                                        Ext.create('Ext.Button', {
                                            text: 'Actualizar',
                                            tooltip: 'Actualiza los registros',
                                            iconCls:'icon-reload',
                                            hidden:false,
                                            handler: function() {
                                                storeExpediente.load();
                                            }
                                        })
                                        ,
                                        {xtype:'tbseparator'}
                                        ,
                                        {
                                            xtype: 'button',
                                            text: 'Salir',
                                            iconCls:'icon-salir',
                                            handler: function()
                                            {
                                                Ext.getCmp('addDocument').destroy();
                                            }   
                                        }
                                    ]
                                }
                            }
                        ]
                    });           
                    Reportes.addDocument.superclass.initComponent.apply(this, arguments); 
                    storeExpediente.load();
                    
                    Ext.getCmp('gridExpediente').on("celldblclick", function(gridprofile, rowIndex, columnIndex, e){
                        var selectedRow=gridprofile.selModel.selected.items[0];
//                        var selectedRow2=Ext.getCmp('gridcitaexes')!=null?Ext.getCmp('gridcitaexes').selModel.selected.items[0]:undefined; 
                        if(selectedRow!=null&&selectedRow2!=null){
                            window.open("downFile.jsp?&file_name="+selectedRow.data.ruta_archivo)
//                            window.open("downFile.jsp?id_beneficiario="+selectedRow2.data.id_beneficiario+"&file_name="+selectedRow.data.ruta_archivo)
                        }
                    });
                }
            });
   

        </script>
    </head>
    <body>
    </body>
</html>
