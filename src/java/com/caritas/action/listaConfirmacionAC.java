package com.caritas.action;

import com.caritas.bl.donativoBL;
import com.caritas.bl.listaConfirmacionBL;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

public class listaConfirmacionAC extends DispatchAction {
    private final static String SUCCESS = "success";
    private final static String FAILURE = "failure";

    public ActionForward getAllzonas(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
            listaConfirmacionBL ribl = new listaConfirmacionBL();
            salida = ribl.getAllzonas();
            System.out.println("<datasss.toString()>> " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllDonativos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        String idUsuario = "";        
        String fechaCobro  = "";
        int idZona  = 0;
        int numCaso = 0;
        int idCampFin = 0;
        String fechaAltaCF = "";
        String nombreDonante = "";
        int idFormaPago = 0;
        int idFormaPago2 = 0;
        int idCampFin2      = 0;
        int idClasificacion = 0;
        int personalmente   = 0;
        int especial        = 0;
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        
        try {                       
            if(request.getParameter("FECHA_COBRO") != null){ fechaCobro = request.getParameter("FECHA_COBRO"); if(fechaCobro.length() == 0) fechaCobro = null; }else{ fechaCobro = null; }            
            if(request.getParameter("FECHA_ALTA_CF") != null){ fechaAltaCF = request.getParameter("FECHA_ALTA_CF"); if(fechaAltaCF.length() == 0) fechaAltaCF = null; } else fechaAltaCF = null;
            if(request.getParameter("ID_ZONA") != null) idZona = Integer.parseInt(request.getParameter("ID_ZONA")); else idZona = 0;            
            if(request.getParameter("NUM_CASO") != null) numCaso = Integer.parseInt(request.getParameter("NUM_CASO")); else numCaso = 0;
            if(request.getParameter("ID_CAMP_FIN") != null) idCampFin = Integer.parseInt(request.getParameter("ID_CAMP_FIN")); else idCampFin = 0;            
            if(request.getParameter("NOMBRE_DONANTE") != null){ nombreDonante = request.getParameter("NOMBRE_DONANTE"); }else nombreDonante = null;
            if(request.getParameter("ID_FORMA_PAGO") != null) idFormaPago = Integer.parseInt(request.getParameter("ID_FORMA_PAGO")); else idFormaPago = 0;
                        
            if(request.getParameter("ID_FORMA_PAGO_2") == null) idFormaPago2 = 0; else idFormaPago2 = Integer.parseInt(request.getParameter("ID_FORMA_PAGO_2"));                       
            if(request.getParameter("ID_CAMP_FIN_2") == null) idCampFin2 = 0; else idCampFin2 = Integer.parseInt(request.getParameter("ID_CAMP_FIN_2"));
            if(request.getParameter("ID_CLASIFICACION") == null) idClasificacion = 0; else idClasificacion = Integer.parseInt(request.getParameter("ID_CLASIFICACION"));
            if(request.getParameter("PERSONALMENTE_2") == null) personalmente = 0; else personalmente = Integer.parseInt(request.getParameter("PERSONALMENTE_2"));
            if(request.getParameter("ESPECIAL_2") == null) especial = 0; else especial = Integer.parseInt(request.getParameter("ESPECIAL_2"));
                        
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");            
            idUsuario = request.getParameter("idUsuario");
            
            listaConfirmacionBL listaBl = new listaConfirmacionBL();
            salida = listaBl.getAllDonativos(strQuery, idUsuario, fechaCobro, idZona, numCaso, idCampFin, fechaAltaCF, nombreDonante, idFormaPago, start, limit, idFormaPago2, idCampFin2, idClasificacion, personalmente, especial);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getAllDonativos]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllCobrosConfirmados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idRecolector    = 0;
        String fechaVisita  = "";
        int idZona  = 0;
        int idCampFin = 0;
        String fechaAltaCF = "";
        String idRecibo = "";
        String nombreDonante = "";
        listaConfirmacionBL lista = new listaConfirmacionBL();
        int idFormaPagoE        = 0;
        int idCampFinE          = 0;
        int idClasifE           = 0;
        int personalE           = 0;
        int especialE           = 0;
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        
        try {
            if(request.getParameter("ID_RECOLECTOR") != null) idRecolector = Integer.parseInt(request.getParameter("ID_RECOLECTOR")); else idRecolector = 0;
            if(request.getParameter("FECHA_VISITA") != null){ fechaVisita = request.getParameter("FECHA_VISITA"); if(fechaVisita.length() == 0) fechaVisita = null; }else fechaVisita = null;
            if(request.getParameter("ID_ZONA") != null) idZona = Integer.parseInt(request.getParameter("ID_ZONA")); else idZona = 0;
            if(request.getParameter("ID_CAMP_FIN") != null) idCampFin = Integer.parseInt(request.getParameter("ID_CAMP_FIN")); else idCampFin = 0;
            if(request.getParameter("FECHA_ALTA_CF") != null){ fechaAltaCF = request.getParameter("FECHA_ALTA_CF"); if(fechaAltaCF.length() == 0) fechaAltaCF = null; }else fechaAltaCF = null;
            if(request.getParameter("NOMBRE_DONANTE") != null){ nombreDonante = request.getParameter("NOMBRE_DONANTE"); }else nombreDonante = null;
            if(request.getParameter("ID_RECIBO") != null){ idRecibo = request.getParameter("ID_RECIBO"); if(idRecibo.length() == 0) idRecibo = null; }else idRecibo = null;
            
            if(request.getParameter("ID_FORMA_PAGO_E") != null) idFormaPagoE = Integer.parseInt(request.getParameter("ID_FORMA_PAGO_E")); else idFormaPagoE = 0;
            if(request.getParameter("ID_CAMP_FIN_E") != null) idCampFinE = Integer.parseInt(request.getParameter("ID_CAMP_FIN_E")); else idCampFinE = 0;
            if(request.getParameter("ID_CLASIF_E") != null) idClasifE = Integer.parseInt(request.getParameter("ID_CLASIF_E")); else idClasifE = 0;
            if(request.getParameter("PERSONAL_E") != null) personalE = Integer.parseInt(request.getParameter("PERSONAL_E")); else personalE = 0;
            if(request.getParameter("ESPECIAL_E") != null) especialE = Integer.parseInt(request.getParameter("ESPECIAL_E")); else especialE = 0;
            
            
            salida = lista.getAllCobrosConfirmados(idRecolector, fechaVisita, idZona, idCampFin, fechaAltaCF, nombreDonante, idRecibo, start, limit, idFormaPagoE, idCampFinE, idClasifE, personalE, especialE);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getDonativosParaConfirmacionMasiva(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida       = "";       
        String fechaCobroIni   = "";       
        String fechaCobroFin   = "";
        int idCampFin       = 0;
        int idZona          = 0;
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        
        try {                       
            if(request.getParameter("FECHA_COBRO_INI") != null){ fechaCobroIni = request.getParameter("FECHA_COBRO_INI"); if(fechaCobroIni.length() == 0) fechaCobroIni = null; }else{ fechaCobroIni = null; }            
            if(request.getParameter("FECHA_COBRO_FIN") != null){ fechaCobroFin = request.getParameter("FECHA_COBRO_FIN"); if(fechaCobroFin.length() == 0) fechaCobroFin = null; }else{ fechaCobroFin = null; }            
            if(request.getParameter("ID_CAMP_FIN") != null) idCampFin = Integer.parseInt(request.getParameter("ID_CAMP_FIN")); else idCampFin = 0;            
            if(request.getParameter("ID_ZONA") != null) idZona = Integer.parseInt(request.getParameter("ID_ZONA")); else idZona = 0;            
            
                        
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");            
            
            
            listaConfirmacionBL listaBl = new listaConfirmacionBL();
            salida = listaBl.getDonativosParaConfirmacionMasiva(strQuery, fechaCobroIni, fechaCobroFin, idCampFin, start, limit, idZona);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getAllDonativos]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getDonativosPagosReprogramados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida       = "";
        String nombre       = "";
        int idZona          = 0;        
        listaConfirmacionBL listaBl = new listaConfirmacionBL();
        
        try {
            
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");            
            
            if(request.getParameter("NOMBRE") != null) nombre = request.getParameter("NOMBRE");
            if(request.getParameter("ID_ZONA") != null) idZona = Integer.parseInt(request.getParameter("ID_ZONA"));
            
            salida = listaBl.getDonativosPagosReprogramados(nombre, idZona, start, limit);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getDonativosPagosReprogramados]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getAllRecibosPorEntregar(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        listaConfirmacionBL lista = new listaConfirmacionBL();

        try {
            salida = lista.getAllRecibosPorEntregar();
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    private void mostrarPDF(byte[] reportPDF, HttpServletResponse response) throws IOException {
        //Incializamos el array         
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ServletOutputStream out = response.getOutputStream();
        bos.write(reportPDF);//        
        response.setContentType("application/pdf");        
        //para que el pdf se pueda ver en microsoft explorer
//        response.setHeader("Cache-Control", "cache");
        //para que aparezca el diálogo abrir/guardar
        response.setHeader("Cache-Control", "cache");
//        response.setHeader("Content-Disposition", "attachment; filename=archivo.pdf");        
//        response.setHeader("Pragma", "cache");        
        response.setContentLength(bos.size());
        out.write(bos.toByteArray());
        out.flush();
        bos.close();
        out.close();
        response.flushBuffer();
    }

    public ActionForward reportServices(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        try {
            int id_solicitud            = 0;            
            int tipo_reporte            = Integer.parseInt(request.getParameter("tipo_reporte"));
            String idUsuario            = request.getParameter("idUsuario");
            String destino              = "ERROR";
            String salida               = "";
            String nameReport           = "";
            String resultado            = "";
            String motivoReimpresion    = request.getParameter("motivoReimpresion");
            int reimpresion             = Integer.parseInt(request.getParameter("reimpresion"));
            int longitud                = 0;            
            int idBitacoras[]           = new int[0]; //Este es el arreglo final de bitacoras 
           
            //Meter todas las bitacoras en un arreglo
            if (request.getParameter("result") != null) {
                resultado = request.getParameter("result");                
                String[] idBitacorasArrayStr = resultado.split(",");
                idBitacoras = new int[idBitacorasArrayStr.length];
                for (int i = 0; i < idBitacorasArrayStr.length; i++) {
                    idBitacoras[i] = Integer.parseInt(idBitacorasArrayStr[i]);
                }
            }            
            
            try {                
                switch (tipo_reporte) {
                    case 1:
                        nameReport = "reciboNoDeducible_rs.jasper";
                        break;
                }
                listaConfirmacionBL hs = new listaConfirmacionBL();         
                salida = hs.generarInforme(idBitacoras, nameReport); //Generar el informe en PDF 
                if(salida == "success"){
                   for(int e = 0; e < idBitacoras.length; e++){
                       hs.statusImpresion(idBitacoras[e], idUsuario, reimpresion, motivoReimpresion);                       
                   } 
                }                
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("Mensaje", "Error interno. Por favor, inténtelo otra vez en unos minutos.");
            }
            return null;//mapping.findForward(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public ActionForward getCobrosConfirmadosFiltros(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        listaConfirmacionBL lista = new listaConfirmacionBL();
        try {
            int idRecolector    = Integer.parseInt(request.getParameter("ID_RECOLECTOR"));
            //int idZona          = Integer.parseInt(request.getParameter("ID_ZONA"));           
            //System.out.println("idZonaAC: "+idZona);
            salida = lista.getCobrosConfirmadosFiltros(idRecolector);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward asignarRecolectorEspecial(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        listaConfirmacionBL LCBL = new listaConfirmacionBL();
        try {
            int idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));
            salida = LCBL.asignarRecolectorEspecial(idBitacora);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward reportServicesOriginal(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        try {
            int id_solicitud = Integer.parseInt(request.getParameter("id_solicitud"));            
            int tipo_reporte = Integer.parseInt(request.getParameter("tipo_reporte"));
            String destino = "ERROR";
            String idUsuario = request.getParameter("idUsuario");
            
            try {
                String nameReport = "";
                switch (tipo_reporte) {
                    case 1:
                        nameReport = "reciboNoDeducibleOriginal_rs.jasper";
                        break;
                }
                listaConfirmacionBL hs = new listaConfirmacionBL();
                byte[] informePDF = hs.generarInformeOriginal(id_solicitud, nameReport);
//                hs.metodoImprimir(informePDF); //COMENTAR PARA QUE NO MANDE A IMPRIMIR                
                mostrarPDF(informePDF, response);//LINEA PARA MOSTRAR EL PDF                
//                hs.statusImpresion(idUsuario, id_solicitud);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("mensaje", "Error interno. Por favor, inténtelo otra vez en unos minutos.");
            }
            return null;//mapping.findForward(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public ActionForward confirmacionMasiva(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String idUsuario    = request.getParameter("ID_USUARIO");
        String result       = request.getParameter("RESULTADO");
        String salida       = "";
        listaConfirmacionBL confirm = new listaConfirmacionBL();
        
        System.out.println("idUsuario: "+idUsuario);
        System.out.println("result: "+result);
        
        try {            
            salida = confirm.confirmacionMasiva(idUsuario, result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward facturacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida               = "";
        String idCampFin            = "";
        String fechaCobro           = "";
        String fechaConfirmacion    = "";
        String idRecibo             = "";
        listaConfirmacionBL listaBl = new listaConfirmacionBL();
        
        fechaCobro         = request.getParameter("FECHA_COBRO");        
        fechaConfirmacion  = request.getParameter("FECHA_CONFIRM");        
        idCampFin          = request.getParameter("ID_CAMPANA_FINANCIERA");
        idRecibo          = request.getParameter("ID_RECIBO");
        System.out.println("idRecibo: "+idRecibo);
        
        try { 
            salida = listaBl.facturacion(idCampFin, fechaCobro, fechaConfirmacion, idRecibo);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[facturacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward asignarSustituto_ingresosFacturacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data         = new JSONObject();
        JSONObject fInfo        = new JSONObject(); 
        String jsonData         = request.getParameter("jsonData");
        JSONObject jsonObject   = JSONObject.fromObject(jsonData);
        listaConfirmacionBL confirmacionBL = new listaConfirmacionBL();
        int idBitacora          = Integer.parseInt(request.getParameter("idBitacora"));        
        
        try {         
            int salida = confirmacionBL.asignarSustituto_ingresosFacturacion(jsonObject, idBitacora);
            fInfo.element("salida", salida);
            data.element("success", "true");
            data.element("fileinfo", fInfo);            
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);            
        }
        request.setAttribute("resp", data.toString());       
        return mapping.findForward(SUCCESS);
    }

    public ActionForward reportServicesReimpresion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        try {                        
            int tipo_reporte        = Integer.parseInt(request.getParameter("tipo_reporte"));
            int idBitacoras[]       = new int[0]; //Este es el arreglo final de bitacoras 
            String idUsuario        = request.getParameter("idUsuario");
            listaConfirmacionBL hs  = new listaConfirmacionBL(); 
            String destino          = "ERROR";
            String salida           = "";
            String nameReport       = "";
            String resultado        = "";
            String motivo           = request.getParameter("motivo");
            int longitud            = 0;
            int id_solicitud        = 0;            
           
            //Sacar las bitacoras del String y crear un arreglo con ellas
            if (request.getParameter("result") != null) {
                resultado = request.getParameter("result");                
                String[] idBitacorasArrayStr = resultado.split(",");
                idBitacoras = new int[idBitacorasArrayStr.length];
                for (int i = 0; i < idBitacorasArrayStr.length; i++) {
                    idBitacoras[i] = Integer.parseInt(idBitacorasArrayStr[i]);
                }
            }            
            
            try {                
                switch (tipo_reporte) {
                    case 1:
                        nameReport = "reciboNoDeducible_rs.jasper";
                        break;
                }
                
                salida = "success";
//                salida = hs.recibosReimpresion(idUsuario, resultado, motivo);
                if(salida == "success"){
//                    hs.generarInforme(idBitacoras, nameReport); //Generar el informe en PDF                    
//                    for(int e = 0; e < idBitacoras.length; e++){
//                       hs.statusImpresion(idUsuario, idBitacoras[e]);                       
//                    }
                }else{
                    
                }                               
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("Mensaje", "Error interno. Por favor, inténtelo otra vez en unos minutos.");
                return mapping.findForward(FAILURE);
            }
            //return null;//mapping.findForward(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getComentariosConfirmacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = 0;
                
        try {                       
            idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));            
            listaConfirmacionBL listaBl = new listaConfirmacionBL();
            salida = listaBl.getComentariosConfirmacion(idBitacora);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getComentariosConfirmacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getComentariosCancelacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = 0;
                
        try {           
            idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));            
            listaConfirmacionBL listaBl = new listaConfirmacionBL();
            salida = listaBl.getComentariosCancelacion(idBitacora);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getComentariosCancelacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getComentariosReprogramacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = 0;
                
        try {           
            idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));            
            listaConfirmacionBL listaBl = new listaConfirmacionBL();
            salida = listaBl.getComentariosReprogramacion(idBitacora);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getComentariosReprogramacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getComentariosBitacoraReprogramacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = 0;
                
        try {           
            idBitacora = Integer.parseInt(request.getParameter("idBitacora"));
            
            listaConfirmacionBL listaBl = new listaConfirmacionBL();
            salida = listaBl.getComentariosBitacoraReprogramacion(idBitacora);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getComentariosReprogramacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward addCall(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();  
        listaConfirmacionBL listaConf = new listaConfirmacionBL(); 
        String idUsuario = "";
        
        try {                       
            String jsonData = request.getParameter("jsonData");
            idUsuario = request.getParameter("idUsuario");            
            JSONObject jsonObject = JSONObject.fromObject(jsonData);                                
            int salida = listaConf.addCall(jsonObject, Integer.parseInt(request.getParameter("idBitacora")), idUsuario);           
            fInfo.element("salida", salida);
            data.element("success", "true");
            data.element("fileinfo", fInfo);            
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);            
        }
        request.setAttribute("resp", data.toString());       
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getBitacoraLlamadas(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {        
        listaConfirmacionBL listaBl = new listaConfirmacionBL();
        String salida = "";
        int idBitacora = 0;
                
        try {           
            idBitacora = Integer.parseInt(request.getParameter("idBitacora"));            
            salida = listaBl.getBitacoraLlamadas(idBitacora);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error listaConfirmacionAC[getBitacoraLLamadas]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }
    
}
