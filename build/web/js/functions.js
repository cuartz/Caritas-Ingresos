/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function LoadModule(source,title,div){
    
    if(Ext.getCmp('windowStage')==null){
        win = Ext.create('widget.window', {
            title: title,//'Administracion - Catalogos',
            id:'windowStage',
            closable: true,
            closeAction: 'destroy',
            maximizable: false,
            width: 950,
            height: 450,
            layout: 'border',
            bodyStyle: 'padding: 5px;',
            resizable:false,
            items: [
            {
                region: 'center',
                xtype: 'panel',
                id:div,
                layout: {
                    type: 'fit',
                    padding: '5'
                }
            }

            ]
        });
        win.show();
    } else {
        Ext.getCmp('windowStage').show();
    }
        
    Ext.get(div).load({
        url: source,
        callback: function (div, exito, respuesta) {
            if (!exito) {
                if (respuesta.status == 404) {
                    Ext.MessageBox.alert('Advertencia', 'No se ha podido encontrar la pagina solicitada en el servidor.<br />Pongase en contacto con el servicio técnico para resolver el problema.');
                } else {
                    Ext.MessageBox.alert('Advertencia', 'No se ha podido establecer la conexion con el servidor.<br />Aguarde un momento e intente nuevamente.');
                }
            }
        },
        scripts: true
    });
}  

//fUNCION PARA MOSTRAR LA FECHA 
function mostrarFecha(valueFecha ){

var anoActual = valueFecha.getFullYear( );
var mesActual = valueFecha.getMonth( )+1;
mesActual = (mesActual < 9)?"0" + mesActual : mesActual;
var diaActual = valueFecha.getDate( );
diaActual = (diaActual < 9)?"0" + diaActual : diaActual;

//Estructura de la fecha
var fecha = diaActual + "/" + mesActual + "/"+ anoActual ;
return fecha;



}