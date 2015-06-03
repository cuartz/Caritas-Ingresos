/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function loadPage(url, destino){
    Ext.onReady(function() {
    Ext.get(destino).load({
        url: url,
        callback: function (destino, exito, respuesta) {
            if (!exito) {
                if (respuesta.status == 404) {
                    Ext.MessageBox.alert('Advertencia', 'No se ha podido encontrar la pagina solicitada en el servidor.<br />Pongase en contacto con el servicio técnico para resolver el problema.');
                } else {
                    Ext.MessageBox.alert('Advertencia', 'No se ha podido establecer la conexion con el servidor.<br />Aguarde un momento e intente nuevamente.');
                }
            }
        },
        scripts: true
    }
    );
        return;
    });
}

function successmsg(title,message){
    Ext.MessageBox.show
    ({
       title: title,
       width: 300,
       msg: message,
       buttons: Ext.MessageBox.OK,
       icon: Ext.MessageBox.INFO
    });
}

function delvalue(grid,table){
    var selectedRow=grid.selModel.getSelected();
    if(selectedRow!=null){
        Ext.Ajax.request(
        {
            waitMsg: '',
            url: 'catalog.do',
            params:
            {
                method: "delvalue",
                id  : selectedRow.data.id,
                catalog: table
            },
            callback: function (options, success, response)
            {
                if (success)
                {
                    if(response.responseText.indexOf("OK")<0)
                    {
                        Ext.example.msg('warn', 'Cambio fallido!');
                    } else {
                        Ext.example.msg('info', 'Cambio satisfactorio');
                    }
                    grid.getStore().reload();
                }
                else
                {

                }
            },
            failure:function(response,options)
            {

            },
            success:function(response,options)
            {

            }
        });
    }
}

function addWindow(table,grid){
    var form = new Ext.form.FormPanel
    ({
        baseCls: 'x-plain',
        labelWidth: 120,
        defaultType: 'textfield',
        items: [
         {
            fieldLabel: 'Valor',
            name: 'fvalue',
            id:'fvalue',
            anchor:'100%',
            allowBlank:false,
            maxLengthText:100
        }]
    });

    var win = new Ext.Window({
            title: 'Agregar nuevo valor',
            width: 380,
            height:110,
            resizable: false,
            modal:true,
            layout: 'fit',
            plain:true,
            closable: true,
            bodyStyle:'padding:5px;',
            buttonAlign:'center',
            items: form,
            buttons: [{
                text: 'Guardar',
                handler: function()
                {
                    var field_val=Ext.get("fvalue").getValue();
                    if(field_val.length>0)
                    {
                        var box = Ext.MessageBox.wait('', 'Processing...');
                        Ext.Ajax.request(
                        {
                            url: 'catalog.do',
                            params:
                            {
                                method: "addvalue",
                                catalog: table,
                                field: 'description',
                                value : field_val
                            },
                            callback: function (options, success, response)
                            {
                                if (success)
                                {
                                    win.close();
                                    if(response.responseText.indexOf("OK")>0)
                                    {
                                         successmsg("Información","Registro guardado");
                                    } else if(response.responseText.indexOf("duplicate")>0) {
                                        warnmsg("Alerta","Valor duplicado");
                                    }

                                }
                                else
                                {
                                    warnmsg("Warning","System Error");
                                }
                                },
                            failure:function(response,options)
                            {
                                warnmsg("Warning","System Error");
                            },
                            success:function(response,options)
                            {
                                 grid.getStore().reload();
                                 //Ext.getCmp('store'+table).reload();//storeSectorAsistencial.reload();
                            }
                         });
                    }
                }
            },{
                text: 'Cancelar',
                handler: function()  {win.close();}
            }]
        });
    win.show();
}

function changevalue(id,table,field,value){
    Ext.Ajax.request(
    {
        waitMsg: '',
        url: 'catalog.do',
        params:
        {
            method: "changevalue",
            id  : id,
            catalog: table,
            field: field,
            value : value
        },
        callback: function (options, success, response)
        {
            if (success)
            {
                if(response.responseText.indexOf("OK")<0)
                {
                    Ext.example.msg('warn', 'Cambio fallido!');
                } else {
                    Ext.example.msg('info', 'Cambio satisfactorio');
                }
                Ext.getCmp('grid'+table).getStore().reload();
                //storeSectorAsistencial.reload();
            }
            else
            {

            }
        },
        failure:function(response,options)
        {

        },
        success:function(response,options)
        {

        }
    });
}

function warnmsg(title,message){
    Ext.MessageBox.show
    ({
       title: title,
       msg: message,
       buttons: Ext.MessageBox.OK,
       icon: Ext.MessageBox.ERROR
    });
}