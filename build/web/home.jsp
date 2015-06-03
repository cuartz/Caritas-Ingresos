<%@page import="com.caritas.utils.Base64Coder"%>
<%@page import="com.caritas.bl.loginBL"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", -1);
    HttpSession sesion = request.getSession();
    try {
        String idusersession = "";
        String msgError = "";
        if (request.getAttribute("idusersession") != null && request.getAttribute("idusersession").toString().equals("-1")) {
            sesion.setAttribute("idusersession", null);
            request.setAttribute("idusersession", null);
            idusersession = "";
        }

        if (sesion.getAttribute("idusersession") == null) {
            sesion.setAttribute("idusersession", request.getAttribute("idusersession"));
        }



        if (sesion.getAttribute("idusersession") != null) {
            if (sesion.getAttribute("idusersession").toString().equals("")) {
                sesion.setAttribute("idusersession", null);
                msgError = "Usuario o contraseña invalida.";
            } else if (!Base64Coder.decodeString(sesion.getAttribute("idusersession").toString().split(":")[1]).equals(sesion.getAttribute("idusersession").toString().split(":")[0])) {
                sesion.setAttribute("idusersession", null);
            }
        }

        idusersession = sesion.getAttribute("idusersession") == null ? "" : sesion.getAttribute("idusersession").toString();

        System.out.println("LOGINUSER:" + sesion.getAttribute("idusersession"));

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="es-ES">
    <head>

        <link rel='stylesheet' href='js/ext-4/resources/css/ext-all.css' type='text/css' media='all'/>        
        <script type="text/javascript" src="js/ext-4/ext-all.js"></script>
        <script type="text/javascript" src="js/ext-4/ext-lang-es.js"></script>
        <!--        <script type="text/javascript" src="js/RowExpander.js"></script>-->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"  />
        <title></title>

        <jsp:include page="catalogs/proveedor.jsp"/>       
        <jsp:include page="globals.jsp"/>
        <jsp:include page="administracion/login.jsp"/>
        <jsp:include page="administracion/permisosEspeciales.jsp"/>

        <jsp:include page="donantes/donantes.jsp"/>
        <jsp:include page="donantes/direccionDonante.jsp"/>
        <jsp:include page="donantes/misDonantes.jsp"/>
        <jsp:include page="donantes/donativos.jsp"/>
        <jsp:include page="donantes/datosTarjeta.jsp"/>
        <jsp:include page="donantes/datosCheque.jsp"/>
        <jsp:include page="donantes/datosDeposito.jsp"/>
        <jsp:include page="donantes/bitacoraPagos.jsp"/>
        <jsp:include page="donantes/bitacoraComentarios.jsp"/>
        <jsp:include page="donantes/formaPago.jsp"/>
        <jsp:include page="donantes/datosTransferencia.jsp"/>
        <jsp:include page="donantes/datosTarjetaDebito.jsp"/>
        <jsp:include page="donantes/actualizarDatosPago.jsp"/>
        <jsp:include page="donantes/agregarDatosPago.jsp"/>
        <jsp:include page="donantes/addSustituto.jsp"/>
        <jsp:include page="donantes/verSustitutos.jsp"/>
        <jsp:include page="donantes/recolectores.jsp"/>
        <jsp:include page="donantes/modificarRecibo.jsp"/>
        <jsp:include page="donantes/pagoPersonal.jsp"/>
        <jsp:include page="donantes/cancelarDonativo.jsp"/>
        <jsp:include page="donantes/moverDonativo.jsp"/>
        
        <jsp:include page="cartas/nuevaCarta.jsp"/>
        <jsp:include page="cartas/formatos.jsp"/>
        <jsp:include page="cartas/editarCarta.jsp"/>
        <jsp:include page="cartas/listaCandidatos.jsp"/>

        <jsp:include page="tesoreria/tesoreria.jsp"/>
        <jsp:include page="tesoreria/confirmacionCobro.jsp"/>
        <jsp:include page="tesoreria/tesoreriaConfirmacionCobro.jsp"/>
        <jsp:include page="tesoreria/confirmacionRecibos.jsp"/>   
        <jsp:include page="tesoreria/ingresos.jsp"/>  
        <jsp:include page="tesoreria/modificarReciboPagado.jsp"/>  

        <jsp:include page="confirmaciones/confirmacion.jsp"/>
        <jsp:include page="confirmaciones/confirmacionPago.jsp"/>
        <jsp:include page="confirmaciones/reprogramarPago.jsp"/>
        <jsp:include page="confirmaciones/cancelarPago.jsp"/>
        <jsp:include page="confirmaciones/sinConfirmar.jsp"/>
        <jsp:include page="confirmaciones/confirmacionCobroEfect.jsp"/>
        <jsp:include page="confirmaciones/confirmacionCobroEsp.jsp"/>
        <jsp:include page="confirmaciones/facturacion.jsp"/>
        <jsp:include page="confirmaciones/historialEnvioReprogramados.jsp"/>
        <jsp:include page="confirmaciones/verDatosDonante.jsp"/>
        <jsp:include page="confirmaciones/comentariosRecibo.jsp"/>
        <jsp:include page="confirmaciones/registrarLlamada.jsp"/>
        <jsp:include page="confirmaciones/bitacoraLlamadas.jsp"/>

        <jsp:include page="Reportes/menuReportes.jsp"/>        
        <jsp:include page="Reportes/menuReportes_MonitoreoySupervision_2.jsp"/>        
        <jsp:include page="Reportes/menuReportes_donantesobienechores_3.jsp"/>
        <jsp:include page="Reportes/Rep_MYS_RECIBOS_IMPRESOSMES_1.jsp"/>        
        <jsp:include page="Reportes/Rep_MYS_RECIBOS_COBRADOS_2.jsp"/>        
        <jsp:include page="Reportes/Rep_MYS_RECIBOS_POR_COBRAR_3.jsp"/>        
        <jsp:include page="Reportes/Rep_MYS_RECIBOS_POR_CONFIRMADO_4.jsp"/>        
        <jsp:include page="Reportes/Rep_MYS_RECIBOS_POR_EMPRESA_5.jsp"/>        
        <jsp:include page="Reportes/Rep_MYS_RECIBOS_POR_TIPODONANTE_6.jsp"/>          
        <jsp:include page="Reportes/Rep_DB_ListadoDonantes_Activos.jsp"/>  
        <jsp:include page="Reportes/Rep_DB_ListadoDonantes_Inactivos_2.jsp"/>
        <jsp:include page="Reportes/SHCPaportacionesAnuales_1.jsp"/>
        <jsp:include page="Reportes/SHCPuniversodeDonantes_2.jsp"/>
        <jsp:include page="Reportes/SHCPdeduciblesEmitidosAnoAnterior_3.jsp"/>
        <jsp:include page="Reportes/SHCPuniversoDonantesAnualesAlfa_4.jsp"/>     
        <jsp:include page="Reportes/SHCPinstitucionesDE_5.jsp"/>          
        <jsp:include page="Reportes/OPE_CancelaciondeDonativos_1.jsp"/>  
        <jsp:include page="Reportes/OPE_monitoreoySupervision_2.jsp"/>  
        <jsp:include page="Reportes/OPE_recibosDeducibles_3.jsp"/>  
        <jsp:include page="Reportes/OPE_donantesoBienechores_4.jsp"/>  
        <jsp:include page="Reportes/OPE_reProspectar_5.jsp"/>  
        <jsp:include page="Reportes/OPE_agradecimiento_6.jsp"/>        
        <jsp:include page="Reportes/TES_listadoCobranza_1.jsp"/>  
        <jsp:include page="Reportes/TES_concentradocobranza_2.jsp"/>  
        <jsp:include page="Reportes/TES_rastreoRecibosDeducibles_3.jsp"/>  
        <jsp:include page="Reportes/TES_seguimiento_4.jsp"/>
        <jsp:include page="Reportes/R_totalRegistrosDonantes.jsp"/>
        <jsp:include page="Reportes/R_totalRegistrosDonativos.jsp"/>
        <jsp:include page="Reportes/R_totalRegistrosBitacora.jsp"/>
        <jsp:include page="Reportes/addDocument.jsp"/>  
        <jsp:include page="Reportes/Rep_Ortografia.jsp"/>        
        <jsp:include page="Reportes/ayudaPrensa.jsp"/>
        <jsp:include page="Reportes/solicitudesRecibosPrecancelados.jsp"/>
        <jsp:include page="Reportes/ingresoMensual.jsp"/>

        <jsp:include page="Graficas/G_TotalRegistosDonante.jsp"/>     



        <!--favicon -->
        <link rel="shortcut icon" href="/favicon.ico" />
        <!-- Estilos -->
        <link rel="stylesheet" type="text/css" href="css/reset.min.css" />
        <link rel="stylesheet" type="text/css" href="css/menu.min.css" />
        <link rel="stylesheet" type="text/css" href="css/fancybox.css" />
        <link rel="stylesheet" type="text/css" href="css/tooltip.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style-default.css" />
        <!--        <link rel="stylesheet" type="text/css" href="css/example.css">-->
        <link rel="stylesheet" type="text/css" href="css/nested-loading.css">

            <SCRIPT LANGUAGE="JavaScript">
                var txt=":: Caritas Monterrey Ingresos ::                      ";
                var espera=100;
                var refresco=null;

                function rotulo_title() {
                    document.title=txt;
                    txt=txt.substring(1,txt.length)+txt.charAt(0);
                    refresco=setTimeout("rotulo_title()",espera);
                }

                rotulo_title();
            </SCRIPT>


            <link rel='stylesheet' id='contact-form-7-css'  href='css/styles.css' type='text/css' media='all' />

            <script type='text/javascript' src='js/l10n.js'></script>
            <script type='text/javascript' src='js/functions.js'></script>
            <script type='text/javascript' src='js/dtree.js'></script>

            <script type='text/javascript' src='js/jquery-1.4.min.js'></script>
            <script type='text/javascript' language='Javascript'>
                function s_toggleDisplay(his, me, show, hide) {
                    if (his.style.display != 'none') {
                        his.style.display = 'none';
                        me.innerHTML = show;
                    } else {
                        his.style.display = 'block';
                        me.innerHTML = hide;
                    }
                }
            </script>

            <script type="text/javascript">
                <!--
                //
                function ReadForm (obj1, tst)
                {
                    // Read the user form
                    var i,j,pos;
                    val_total="";val_combo="";

                    for (i=0; i<obj1.length; i++)
                    {
                        // run entire form
                        obj = obj1.elements[i];           // a form element

                        if (obj.type == "select-one")
                        {   // just selects
                            if (obj.name == "quantity" ||
                                obj.name == "amount") continue;
                            pos = obj.selectedIndex;        // which option selected
                            val = obj.options[pos].value;   // selected value
                            val_combo = val_combo + "(" + val + ")";
                        }
                    }
                    // Now summarize everything we have processed above
                    val_total = obj1.product_tmp.value + val_combo;
                    obj1.product.value = val_total;
                }
                //-->
            </script>


            <!--[if IE]>
            <script src="js/html5.js"></script>
            <![endif]-->

            <script type="text/javascript" src="js/jquery-ui-1.7.2.min.js"></script>
            <script type="text/javascript" src="js/jquery.easing.1.3.min.js"></script>
            <script type="text/javascript" src="js/hoverIntent.min.js"></script>
            <script type="text/javascript" src="js/jquery.bgiframe.min.js"></script>
            <!-- Drop down menus -->
            <script type="text/javascript" src="js/superfish.min.js"></script>
            <script type="text/javascript" src="js/supersubs.min.js"></script>

            <!-- Ribbon Scroll Effect --><script type="text/javascript" src="js/ribbonScroll.js"></script>	<!-- Input labels -->
            <script type="text/javascript" src="js/jquery.overlabel.min.js"></script>

            <!-- Anchor tag scrolling effects --><script type="text/javascript" src="js/scrollTo.min.js"></script>		<script type="text/javascript">
                jQuery(document).ready(function() {
                    // initialize anchor tag scrolling effect (scrollTo)
                    $j.localScroll();
                });
            </script>
            <!-- Inline popups/modal windows -->
            <script type="text/javascript" src="js/jquery.fancybox-1.3.1.pack.js"></script>

            <!-- Slide show --><!-- Cycle Slide Show --><script type="text/javascript" src="js/jquery.cycle.all.min.js"></script>		<script type="text/javascript">
                // initialize slideshow (Cycle)
                jQuery(document).ready(function() {
                    if ($j('#Slides').length > 0) {
                        $j('#Slides').cycle({
                            fx: 'fadeZoom,scrollHorz,scrollHorz,scrollHorz,scrollHorz,scrollHorz,scrollHorz',						speed: 750,
                            timeout:  8000,
                            randomizeEffects: false,
                            easing: 'easeOutCubic',
                            next:   '.slideNext',
                            prev:   '.slidePrev',
                            pager:  '#slidePager',
                            cleartypeNoBg: true,
                            before: function() {
                                // reset the overlay for the next slide
                                $j('#SlideRepeat').css('cursor','default').unbind('click'); },
                            after: function() {
                                // get the link and apply it to the overlay
                                var theLink = $j(this).children('a');
                                var linkURL = (theLink) ? theLink.attr('href') : false;
                                if (linkURL) {
                                    $j('#SlideRepeat').css('cursor','pointer').click( function() {
                                        document.location.href = linkURL;
                                    });
                                }
                            }
                        });
                    }
                });
            </script>

            <!-- IE only includes (PNG Fix and other things for sucky browsers -->

            <!--[if lt IE 7]>
                    <link rel="stylesheet" type="text/css" href="css/ie-only.css">
                    <script type="text/javascript" src="js/pngFix.min.js"></script>
                    <script type="text/javascript">
                            jQuery(document).ready(function(){
                                    $j(document.body).supersleight();
                            });
                    </script>
            <![endif]-->
            <!--[if IE]><link rel="stylesheet" type="text/css" href="css/ie-only-all-versions.css"><![endif]-->

            <!-- Font replacement (cufon) -->
            <script src="js/cufon-yui.js" type="text/javascript"></script>
            <script src="js/LiberationSans.font.js" type="text/javascript"></script>
            <!-- Font Replacement Styles -->
            <script type="text/javascript">
                // general font replacement styles
            
                Cufon.replace('h1, h2, h3, h4, h5, h6, .fancy_title div');
                Cufon.replace('.headline', {textShadow: '1px 1px rgba(255, 255, 255, 1)'})('.ribbon span', {hover: true, textShadow: '-1px -1px rgba(0, 0, 0, 0.4)'});			// enables cufon in popups and other modal functions
                function modalStart() {
                    // updated styles
                    jQuery('#fancybox-outer').addClass('rounded');
                    roundCorners();
                    // reload cufon
                    Cufon.replace('#fancybox-title-main');
                }
            </script>

            <!-- Functions to initialize after page load -->

            <script type="text/javascript" src="js/onLoad.js"></script>


    </head>
    <body>


        <!-- Site Container -->

        <div id="Wrapper">
            <div id="PageWrapper">
                <div class="pageTop"></div>
                <div id="Header">
                    <div style="position:absolute">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/logo.png"></div>
                    <!-- Main Menu -->
                    <div id="MenuWrapper">
                        <div id="MainMenu">
                            <div id="MmLeft"></div>
                            <div id="MmBody">
                                <!-- Main Menu Links -->
                                <ul class="sf-menu">
                                </ul><!--donde se valida y crea los menus Dinamicamente-->
                                <%=loginBL.getMenuUser(idusersession)%>
                                <ul class="sf-menu">
                                </ul>

                            </div>
                            <div id="MmRight"></div>
                        </div>
                    </div>


                    <div id="HeaderRight">
                        <!-- Search -->

                        <div id="Login">

                            <form action="login.do" id="loginForm" method="post" <%=loginBL.hideLogin(idusersession)%>>
                                Usuario: <input type="text" name="loginusr" id="loginusr" value="" /> 
                                Contraseña: <input type="password" name="loginpass" id="loginpass" value="" />
                                <input type="image" id="LoginSubmit" class="noStyle" src='img/entrar.png' width="30"/>
                            </form>
                            <%=loginBL.infoLogin(idusersession)%><label style="color:red"><%=msgError%></label>
                        </div>
                    </div>
                    <!-- Logo -->
                    <div id="Logo">
                        <a href="#"></a>			</div>

                    <!-- End of Content -->
                    <div class="clear"></div>

                </div>



                <!-- Slide show: jQuery Cycle (default) -->

                <div id="Slideshow">
                    <div id="SlideTop"></div>
                    <div id="SlideRepeat"></div>
                    <div id="SlideBottom"></div>
                    <div id="Slides">
<!--                        <div class="">
                            <a href="#"><img src="img/banner/caritas_01.jpg" alt="Slide" /></a>     </div>-->
                        <div class="">
                            <a href="#"><img src="img/banner/caritas_02.jpg" alt="Slide" /></a>     </div>
<!--                        <div class="">
                            <a href="#"><img src="img/banner/caritas_03.jpg" alt="Slide" /></a>     </div>-->
<!--                        <div class="">
                            <a href="#"><img src="img/banner/caritas_04.jpg" alt="Slide" /></a>     </div>-->
<!--                        <div class="">
                            <a href="#"><img src="img/banner/caritas_05.jpg" alt="Slide" /></a>     </div>-->
<!--                        <div class="">
                            <a href="#"><img src="img/banner/caritas_06.jpg" alt="Slide" /></a>     </div>
                        <div class="">
                            <a href="#"><img src="img/banner/caritas_07.jpg" alt="Slide" /></a>     </div>
                        <div class="">
                            <a href="#"><img src="img/banner/caritas_08.jpg" alt="Slide" /></a>     </div>-->
                        
                        <!--                        <div class="">
                                                    <a href="#"><img src="img/banner/caritas_09.jpg" alt="Slide" /></a>     </div>
                                                <div class="">
                                                    <a href="#"><img src="img/banner/caritas_10.jpg" alt="Slide" /></a>     </div>
                                                <div class="">
                                                    <a href="#"><img src="img/banner/caritas_11.jpg" alt="Slide" /></a>     </div>
                                                <div class="">
                                                    <a href="#"><img src="img/banner/caritas_12.jpg" alt="Slide" /></a>     </div>
                                                <div class="">
                                                    <a href="#"><img src="img/banner/caritas_13.jpg" alt="Slide" /></a>     </div>
                                                <div class="">
                                                    <a href="#"><img src="img/banner/caritas_14.jpg" alt="Slide" /></a>     </div>
                                                    <div class="">
                                                    <a href="#"><img src="img/banner/caritas_15.jpg" alt="Slide" /></a>     </div>-->
                        <!--                            <div class="">-->
                        <!--                            <a href="#"><img src="img/banner/caritas_16.jpg" alt="Slide" /></a>     </div>-->-->-->
                    </div>
                    <a href="#" class="slidePrev"></a>
                    <a href="#" class="slideNext"></a>
                    <div id="slidePager"></div>
                </div>


                <div class="pageMain">


                    <!-- Showcase Content -->
                    <div id="Showcase">
                        <div class="two-thirds showcase-area-left">
                            <div id="text-6" class="widget widget_text">			<div class="textwidget"><div id="simpleimage-2" class="widget widget_simpleimage">
                                        <div class="simpleimage">

                                            </p></div>
                                    </div>
                                </div>
                            </div>				</div>


                        <!-- End of Content -->

                    </div>

                    <!-- Page Content -->
                    <div class="contentArea">

                        <div class="clear"></div>

                    </div>
                </div> <!-- end <div class="pageMain"> -->

                <!-- Footer -->

                <div id="Footer">
                    <div id="FooterTop"></div>
                    <div id="FooterContent">

                        <div class="contentArea">
                            <div class="one-third">Links Relacionados<br><a href="http://www.sorteocaritas.com.mx/" target="_blank">Sorteo Caritas</a>
                                    <br><a href="http://www.caritas.mx/" target="_blank">Donativos</a>
                                        </div>

                                        <div class="one-third"> Preguntas Frecuentes  
                                            <br><a href="chat/JavaChat_cliente.jar">Chat</a>
                                                <!--                                                <br><a href="">Noticias</a>-->
                                        </div>

                                        <div class="one-third last"> Documentos
                                            <br><a href="Manuales/Manual_de_Usuario_Ingresos.pdf">Manual de Usuario</a>                                               
                                        </div>


                                        <!-- End of Content -->
                                        <div class="clear"></div>
                                        </div>

                                        </div>
                                        <div id="FooterBottom"></div>

                                        </div>
                                        </div>
                                        </div>

                                        </body>
                                        </html>
                                        <%
                                            } catch (Exception ex) {
                                                ex.printStackTrace();
                                            }%>
