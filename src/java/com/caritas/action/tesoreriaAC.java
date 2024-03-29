package com.caritas.action;

import com.caritas.bl.confirmacionPagoBL;
import com.caritas.bl.donativoBL;
import com.caritas.bl.tesoreriaBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class tesoreriaAC extends DispatchAction { 
    private final static String SUCCESS = "success";
    private final static String FAILURE = "failure";

    public ActionForward getAllCobrosEfectivo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idRecolector    = 0;
        String fechaVisita  = "";
        int idZona  = 0;
        String recibo       = "";
        String nombre       = "";
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");

        try {
            if(request.getParameter("ID_RECOLECTOR") != null)
                idRecolector = Integer.parseInt(request.getParameter("ID_RECOLECTOR"));
            else
                idRecolector = 0;
            if(request.getParameter("FECHA_VISITA") != null){                
                fechaVisita = request.getParameter("FECHA_VISITA");               
                if(fechaVisita.length() == 0)
                    fechaVisita = null;                
            }else
                fechaVisita = null;
            if(request.getParameter("ID_ZONA") != null)
                idZona = Integer.parseInt(request.getParameter("ID_ZONA"));
            else
                idZona = 0;
            recibo  = request.getParameter("ID_RECIBO");
            if(recibo == "") recibo = null;
            nombre  = request.getParameter("NOMBRE_DONANTE");
            if(nombre == "") nombre = null;
            tesoreriaBL tesoreriaa = new tesoreriaBL();
            salida = tesoreriaa.getAllCobrosEfectivo(idRecolector, fechaVisita, idZona, start, limit, recibo, nombre);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllCobrosEfectivoPagadosTmp(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";

        try {
            tesoreriaBL tesoreriaa = new tesoreriaBL();
            salida = tesoreriaa.getAllCobrosEfectivoPagadosTmp();
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward confirmacionCobro(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        tesoreriaBL tesoreriaa = new tesoreriaBL();
        String idUsuario = "";
        int option      = Integer.parseInt(request.getParameter("opttion"));

        try {            
            idUsuario = request.getParameter("idUsuario");            
            tesoreriaa.confirmacionCobro(jsonObject, Integer.parseInt(request.getParameter("idBitacora")), idUsuario, option);
            int salida = 1;
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
    
    public ActionForward reprogramacionLoadInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));
        
        try {
            tesoreriaBL tesoreriaa = new tesoreriaBL();
            salida = tesoreriaa.reprogramacionLoadInfo(idBitacora);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward tesoreriaConfirmacionCobro(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        tesoreriaBL tesoreriaa = new tesoreriaBL();
        String idUsuario    = "";

        try {
            idUsuario = request.getParameter("idUsuario");
            tesoreriaa.tesoreriaConfirmacionCobro(jsonObject, Integer.parseInt(request.getParameter("idBitacora")), idUsuario);
            int salida = 1;
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

    public ActionForward generarArchivoFactura(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        tesoreriaBL tesoreriaa = new tesoreriaBL();
        try {
            int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));
            salida = tesoreriaa.generarArchivoFactura(ID_BITACORA);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
       
    public ActionForward reciboModificarFechaPago(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        tesoreriaBL tesoreriaa = new tesoreriaBL();

        try {            
            tesoreriaa.reciboModificarFechaPago(jsonObject, Integer.parseInt(request.getParameter("idBitacora")));
            int salida = 1;
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
    
    public ActionForward getReporteDiarioEspecie(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        String fechaPago  = request.getParameter("FECHA_PAGO");
        
        if(fechaPago == "") fechaPago = null;       
        
        try {
            tesoreriaBL tesoreriaa = new tesoreriaBL();
            salida = tesoreriaa.getReporteDiarioEspecie(fechaPago);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getReporteDiarioTres(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        String fechaIni  = request.getParameter("FECHA_INI");
        String fechaFin  = request.getParameter("FECHA_FIN");
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        
        
        
        if(fechaIni == "") fechaIni = null;       
        if(fechaFin == "") fechaFin = null;
        
        try {
            tesoreriaBL tesoreriaa = new tesoreriaBL();
            salida = tesoreriaa.getReporteDiarioTres(fechaIni, fechaFin, start, limit);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward generarArchivoAdminPack(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        tesoreriaBL tesoreriaa = new tesoreriaBL();
        String bitacoras = "";
        
        try {
//            int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));
            bitacoras = request.getParameter("bitacoras");
            salida = tesoreriaa.generarArchivoAdminPack(bitacoras);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getFormaDePagoByBitacora(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));        
        tesoreriaBL tesoreriaa = new tesoreriaBL();

        try {            
            salida = tesoreriaa.getFormaDePagoByBitacora(idBitacora);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
}
