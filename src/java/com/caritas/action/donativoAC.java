package com.caritas.action;

import com.caritas.bl.donanteBL;
import com.caritas.bl.donativoBL;
import com.caritas.bl.bitacoraPagosBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class donativoAC extends DispatchAction {
     private final static String SUCCESS = "success"; 
     private final static String FAILURE = "failure";      
   
    public ActionForward getAllDonativos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");

        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");
            donativoBL donBl = new donativoBL();
            salida = donBl.getAllDonativos(strQuery, Integer.parseInt(request.getParameter("idDonante")), start, limit);  
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward saveDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        bitacoraPagosAC bita = new bitacoraPagosAC();
        int idDonativo = 0;

        try {
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            donativoBL.saveDonativo(jsonObject, request.getParameter("uid"), request.getParameter("idUsuario"));
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

    public ActionForward getNameDonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonante = Integer.parseInt(request.getParameter("ID_DONANTE"));
        donativoBL donativo = new donativoBL();

        try {
            salida = donativo.getNameDonante(idDonante);
            //System.out.println("salida: "+salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward deleteDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        donativoBL donBl = new donativoBL();
        try {
            int ID_DONATIVO = Integer.parseInt(request.getParameter("ID_DONATIVO"));
            salida = donBl.deleteDonativo(ID_DONATIVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward cancelarDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {        
        donativoBL donBl    = new donativoBL(); 
        String idUsuario    = "";
        JSONObject data     = new JSONObject();
        JSONObject fInfo    = new JSONObject();
        String jsonData     = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        int ID_DONATIVO     = Integer.parseInt(request.getParameter("idDonativo")); 
        idUsuario           = request.getParameter("idUsuario");
        int precancelacion  = Integer.parseInt(request.getParameter("precancelacion"));        
        
        try {                    
            donBl.cancelarDonativo(jsonObject, ID_DONATIVO, idUsuario, precancelacion);            
            int salida = 1;
            fInfo.element("salida", salida);            
            data.element("success", "true");
            data.element("fileinfo", fInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", data.toString());
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getDonativoInfoUpdate(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int ID_DONATIVO = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        donativoBL donativo = new donativoBL();
        
        try { 
            salida = donativo.getDonativoUpdateInfo(ID_DONATIVO);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward updateDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        bitacoraPagosAC bita = new bitacoraPagosAC();
        int idDonativo = 0;

        try {
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            donativoBL.updateDonativo(jsonObject, request.getParameter("idUsuario"), Integer.parseInt(request.getParameter("idDonativo")));
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
    
    public ActionForward terminarDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        donativoBL donBl = new donativoBL();
        try {
            int ID_DONATIVO = Integer.parseInt(request.getParameter("ID_DONATIVO"));
            salida = donBl.terminarDonativo(ID_DONATIVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward moverDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {        
        donativoBL donBl    = new donativoBL(); 
        String idUsuario    = "";
        JSONObject data     = new JSONObject();
        JSONObject fInfo    = new JSONObject();
        String jsonData     = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        int ID_DONATIVO     = Integer.parseInt(request.getParameter("idDonativo"));                       
        
        try {                    
            donBl.moverDonativo(jsonObject, ID_DONATIVO);            
            int salida = 1;
            fInfo.element("salida", salida);            
            data.element("success", "true");
            data.element("fileinfo", fInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", data.toString());
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getSolicitudesDonativosPrecancelados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        donativoBL donBl    = new donativoBL();
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");

        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");            
            salida = donBl.getSolicitudesDonativosPrecancelados(strQuery, start, limit);  
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward aprobarCancelacionDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        donativoBL donBl    = new donativoBL();
        
        try {
            int ID_DONATIVO     = Integer.parseInt(request.getParameter("ID_DONATIVO"));
            String idUsuario    = request.getParameter("idUsuario");
            salida              = donBl.aprobarCancelacionDonativo(ID_DONATIVO, idUsuario);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward denegarCancelacionDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        donativoBL donBl    = new donativoBL();
        
        try {
            int ID_DONATIVO = Integer.parseInt(request.getParameter("ID_DONATIVO"));            
            salida = donBl.denegarCancelacionDonativo(ID_DONATIVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }

    
}
