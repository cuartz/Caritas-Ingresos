<%-- 
    Document   : administration
    Created on : 14/03/2011, 04:55:39 PM
    Author     : RCastilloc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%--<jsp:include page="catalogs/gridSectorAsistencial.jsp"/>
<jsp:include page="catalogs/gridEscolaridad.jsp"/>
<jsp:include page="catalogs/gridEstado.jsp"/>
<jsp:include page="catalogs/gridEtnia.jsp"/>
<jsp:include page="catalogs/gridIndicador.jsp"/>
<jsp:include page="catalogs/gridEstadoCivil.jsp"/>
<jsp:include page="catalogs/gridCiudad.jsp"/>
<jsp:include page="catalogs/gridSucursal.jsp"/>
<jsp:include page="catalogs/gridPais.jsp"/>
<jsp:include page="catalogs/gridServiciosMedicos.jsp"/>
<jsp:include page="catalogs/gridEnfermedades.jsp"/>--%>
<script>
    function LoadAdministration(){
    	mytree = new dTree('mytree');

//	mytree.add(146, -1, 'Designers', 'team_index.asp?groupe_id=146', 'Designers', '', '');
	mytree.add(1, -1, '', '#', '', '', '');
	mytree.add(2, 1, '<div class="service">Caritas Parroquiales</div>', '#', '', '', '');
	mytree.add(3, 2, '<div class="service">Salud</div>', '#', '', '', '');
	mytree.add(4, 3, '<div class="service">Atención Médica</div>', '#', '', '', '');
	mytree.add(5, 3, '<div class="service">Medicamento</div>', '#', '', '', '');
	mytree.add(6, 3, '<div class="service">Aparatos y Protesis</div>', '#', '', '', '');
	mytree.add(7, 2, '<div class="service">Servicios Funerarios</div>', '#', '', '', '');
	mytree.add(8, 2, '<div class="service">Vivienda</div>', '#', '', '', '');
	mytree.add(9, 2, '<div class="service" onclick="return false;">Promoción Humana</div>', '#', '', '', '');
        mytree.add(10, 8, '<div class="service">Mobiliario</div>', '#', '', '', '');
        mytree.add(11, 8, '<div class="service">Pago Renta y/o Servicios Publicos</div>', '#', '', '', '');
        mytree.add(12, 8, '<div class="service">Reconstrucción vivienda</div>', '#', '', '', '');
        mytree.add(13, 9, '<div class="service">Apoyo Escolar</div>', '#', '', '', '');
        mytree.add(14, 9, '<div class="service">Negocio Familiar</div>', '#', '', '', '');
        mytree.add(15, 9, '<div class="service">Trámite de papeleria</div>', '#', '', '', '');
        mytree.add(16, 9, '<div class="service">Curso y talleres</div>', '#', '', '', '');
        //mytree.openAll();
    
    
    Ext.BLANK_IMAGE_URL = 'img/s.gif';
    //document.getElementById('menu_init').src="img/menu_administracion.jpg";

    Ext.onReady(function() {


        var treeOrganizationalStructure = new Ext.tree.TreePanel({
            border: false,
            autoScroll:true,
            rootVisible:false,
            width:1050,
            title:'',
            frame: true,
            useArrows:true,
            root:{
                text:'root',
                children:[
                    {
                        text:'Caritas Monterrey',
                        iconCls:'ceo-icon',//the icon CSS class
                        width:400,
                        //leaf:true,
                        children:[
                            {
                                text:'Salud',
                                iconCls:'ceo-icon',//the icon CSS class
                                width:400,
                                buttonAlign:'left',
                                leaf:false
                            },
                            {
                                text:'Servicios Funerarios',
                                iconCls:'ceo-icon',//the icon CSS class
                                leaf:true
                            },
                            {
                                text:'Vivienda',
                                iconCls:'ceo-icon',//the icon CSS class
                                leaf:true
                            },
                            {
                                text:'Promocion Humana',
                                iconCls:'ceo-icon',//the icon CSS class
                                leaf:true
                            }
                        ]
                    }
                ]
            }
        });

        var organizationalStructure = new Ext.Panel({
            layout: 'fit',
            title:'Areas de Servicio',
            width: 800,
            height: 350,
            items: [
                {
                    xtype:'box',
                    html:'<div id="org"><table border="0" width="730" align="center">'+mytree+'</table></div>'
                }
            ]
        });

        var catalogsSystem = new Ext.Panel({
            layout: 'border',
            title:'Catálogos',
            width: 300,
            height: 560,
            autoScroll: false,
            items: [
                {
                   region: 'center',
                    xtype: 'panel',
                    layout:'column',
                    autoScroll: true,
                    items: [
//                    {
//                        columnWidth: .25,
//                        items:[gridServiciosMedicos]
//                    },{
//                        columnWidth: .25,
//                        items:[gridEnfermedades]
//                    },
//                    {
//                        columnWidth: .25,
//                        items:[gridSectorAsistencial]
//                    },{
//                        columnWidth: .25,
//                        items:[gridEscolaridad]
//                    },{
//                        columnWidth: .25,
//                        items:[gridEstado]
//                    },{
//                        columnWidth: .25,
//                        items:[gridEtnia]
//                    },{
//                        columnWidth: .25,
//                        items:[gridIndicador]
//                    },{
//                        columnWidth: .25,
//                        items:[gridEstadoCivil]
//                    },{
//                        columnWidth: .25,
//                        items:[gridCiudad]
//                    },{
//                        columnWidth: .25,
//                        items:[gridSucursal]
//                    },{
//                        columnWidth: .25,
//                        items:[gridPais]
//                    }
                    ]
                }
            ]
        });


        var stageTabPanel = new Ext.Panel({
        layout: 'form',
        id:'stageTabPanel',
        width: 1050,
        height: 560,
        renderTo: 'stage',
        border: false,
        autoScroll: false,
        items: [{
            xtype: 'tabpanel', // En vez de instanciar directamente el objeto, utilizamos la notación del xtype
            height: 560,
            //autoScroll:true,
            defaults:{ autoScroll:false },
            bodyStyle: 'padding:5px',
            activeTab: 0,
            enableTabScroll:true,
            plain: true,
            items: [
                catalogsSystem,
                organizationalStructure
            ]
        }
        ]
    });
});
    }
</script>