
package com.caritas.action;

import com.caritas.bl.donanteBL;
import com.caritas.properties.Dummy;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import com.caritas.properties.Dummy;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

public class donanteAC extends DispatchAction {
    private final static String SUCCESS = "success";
    private final static String FAILURE = "failure:";
    private final static String EXISTS = "exists:";

    public ActionForward getEstados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();

        int idPais = (request.getParameter("idpais") == null || request.getParameter("idpais").equals("")) ? 0 : Integer.parseInt(request.getParameter("idpais"));
        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");
            donanteBL rbl = new donanteBL();
            salida = rbl.getComboEstados(idPais, strQuery);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getEstadosDos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        
        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");
            donanteBL rbl = new donanteBL();
            salida = rbl.getComboEstadosDos(strQuery);           
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getMunicipios(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        int idEstado = (request.getParameter("idestado") == null || request.getParameter("idestado").equals("")) ? 0 : Integer.parseInt(request.getParameter("idestado"));

        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");
            donanteBL rbl = new donanteBL();
            salida = rbl.getComboMunicipios(idEstado, strQuery);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getPaises(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");
            donanteBL rbl = new donanteBL();
            salida = rbl.getComboPaises(strQuery);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward savedonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        int salida = 0;
        int ID_DONANTE = (request.getParameter("ID_DONANTE") == null || request.getParameter("ID_DONANTE").equals("null") || request.getParameter("ID_DONANTE").equals("")) ? 0 : Integer.parseInt(request.getParameter("ID_DONANTE"));
        String idUsuario = request.getParameter("idUsuario") == null ? "" : request.getParameter("idUsuario");        
        
        StringBuilder sc_response = new StringBuilder();

        try {
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            salida = donanteBL.savedonante(jsonObject, idUsuario, ID_DONANTE);            
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);
        }
        sc_response.append("{'success': true, 'data':{'salida':'");
        sc_response.append(salida);
        sc_response.append("'}}");
        response.getWriter().write(sc_response.toString());
        request.setAttribute("resp", sc_response.toString());       
        return mapping.findForward(SUCCESS);       
    }
    
    public ActionForward updateDonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        int salida = 0;
        int ID_DONANTE = (request.getParameter("ID_DONANTE") == null || request.getParameter("ID_DONANTE").equals("null") || request.getParameter("ID_DONANTE").equals("")) ? 0 : Integer.parseInt(request.getParameter("ID_DONANTE"));
        String idUsuario = request.getParameter("idUsuario") == null ? "" : request.getParameter("idUsuario");                
        StringBuilder sc_response = new StringBuilder();

        try {
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            salida = donanteBL.updateDonante(jsonObject, idUsuario, ID_DONANTE);            
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);
        }
        sc_response.append("{'success': true, 'data':{'salida':'");
        sc_response.append(salida);
        sc_response.append("'}}");
        response.getWriter().write(sc_response.toString());
        request.setAttribute("resp", sc_response.toString());       
        return mapping.findForward(SUCCESS);       
    }
    
    public ActionForward saveDonanteSustituto(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {        
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        int salida = 1;        
        
        try {         
            donanteBL.saveDonanteSustituto(jsonObject,request.getParameter("idUsuario"));            
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
    
    public ActionForward getDonantesSustitutos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        String salida = "";
        
        try {
            salida = donanteBL.getDonantesSustitutos(Integer.parseInt(request.getParameter("idDonante")));            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);            
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAlldireccionDonantes(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";

        int ID_DONA = Integer.parseInt((request.getParameter("ID_DONANTE") == null || request.getParameter("ID_DONANTE").equals("")) ? "0" : request.getParameter("ID_DONANTE"));        
        org.json.JSONArray jsonList = new org.json.JSONArray();
        try {
            donanteBL scbl = new donanteBL();
            salida = scbl.getAlldireccionDonantes(ID_DONA);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward savedirecciondonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();

        String personS = request.getParameter("ID_DONANTE");
        int person = (personS == null || personS.equals("null") || personS.equals("")) ? 0 : Integer.parseInt(personS);
        String idUsuario = request.getParameter("idUsuario") == null ? "" : request.getParameter("idUsuario");
        try {
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            int salida = donanteBL.savedirecciondonante(jsonObject, idUsuario, person);
            fInfo.element("salida", salida);
            data.element("success", "true");
            data.element("fileinfo", fInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", data.toString());        
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward actualizardirecciondonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();        
        String idUsuario    = request.getParameter("idUsuario");
        int idDonante       = Integer.parseInt(request.getParameter("ID_DONANTE"));
        int idDireccion     = Integer.parseInt(request.getParameter("ID_DIRECCION")); 
        
        try {
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            int salida = donanteBL.actualizardirecciondonante(jsonObject, idUsuario, idDonante, idDireccion);
            fInfo.element("salida", salida);
            data.element("success", "true");
            data.element("fileinfo", fInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", data.toString());        
        return mapping.findForward(SUCCESS);
    }

    public ActionForward deleteDireccion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String id_user = "";
        HttpSession sesion = request.getSession();
        if (sesion.getAttribute("idusersession") != null) {
            id_user = sesion.getAttribute("idusersession").toString().split(":")[0];
        }
        String salida = "";
        try {
            String ID_DIRECCION = request.getParameter("ID_DIRECCION");
            salida = donanteBL.deleteDireccion(ID_DIRECCION, id_user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getSearchDonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String keyword = (String) request.getParameter("keyword");
            salida = donanteBL.getDonanteByKeyword(keyword);
        } catch (Exception e) {
        }
        request.setAttribute("resp", salida.toString());
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getdonante(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int ID_DONANTE = Integer.parseInt(request.getParameter("ID_DONANTE"));

        JSONArray jsonList = new JSONArray();
        try {
            donanteBL rbl = new donanteBL();
            salida = rbl.getdonante(ID_DONANTE);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getDonanteAB(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        org.json.JSONArray jsonList = new org.json.JSONArray();
        try {
            
            String strQuery = request.getParameter("query")==null?"":request.getParameter("query");
            donanteBL Usua = new donanteBL();            
            salida = Usua.getDonanteAB(strQuery);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    } 
    
    public ActionForward getDonantePA(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        org.json.JSONArray jsonList = new org.json.JSONArray();
        try {
            
            int ID_DONANTE = (request.getParameter("ID_DONANTE")==null||request.getParameter("ID_DONANTE").equals(""))?0:Integer.parseInt(request.getParameter("ID_DONANTE"));            
            String strQuery = request.getParameter("query")==null?"":request.getParameter("query");
            donanteBL Usua = new donanteBL();            
            salida = Usua.getDonantePA(strQuery);           
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
      
    public ActionForward getDireccionUptInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int ID_DIRECCION = Integer.parseInt(request.getParameter("ID_DIRECCION"));        
        donanteBL Dirupt = new donanteBL();
        
        try { 
            salida = Dirupt.getDireccionUptInfo(ID_DIRECCION);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
       
    public ActionForward getAllRecolectores(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {       
        String salida = "";
        
        try {             
            salida = donanteBL.getAllRecolectores();            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);            
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward saveRecolector(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();        
        
        try {           
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);            
            donanteBL.saveRecolector(jsonObject);
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
    
    public ActionForward getRecibosEspeciales(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        String fechaVisita    = "";
        donanteBL lista = new donanteBL();
        try {            
            fechaVisita  = request.getParameter("fechaVisita");
            salida = lista.getRecibosEspeciales(fechaVisita);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward asignarReciboEspecial(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();        
        
        try {           
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);            
            donanteBL.saveRecolector(jsonObject);
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
    
    public ActionForward getRecolectoresEspeciales(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {       
        String salida = "";
        
        try {             
            salida = donanteBL.getRecolectoresEspeciales();            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            e.printStackTrace();
            return mapping.findForward(FAILURE);            
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward asignarReciboARecolectorEspecial(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));
        
        try {           
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            donanteBL.asignarReciboARecolectorEspecial(jsonObject, ID_BITACORA);
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
    
    public ActionForward actualizarDatosSustituto(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();               
        int idDonante       = Integer.parseInt(request.getParameter("ID_DONANTE"));
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        
        try {            
            int salida = donanteBL.actualizarDatosSustituto(jsonObject, idDonante);
            fInfo.element("salida", salida);
            data.element("success", "true");
            data.element("fileinfo", fInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", data.toString());        
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getSustitutoInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonante = Integer.parseInt(request.getParameter("ID_DONANTE"));
        donanteBL bitacoraa = new donanteBL();

        try {
            salida = bitacoraa.getDonanteSustitutoInfo(idDonante);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward deleteRecolector(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        int ID_RECOLECTOR = Integer.parseInt(request.getParameter("ID_RECOLECTOR"));
        String salida = "";
        try {            
            salida = donanteBL.deleteRecolector(ID_RECOLECTOR);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward deleteSustituto(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        int ID_SUSTITUTO = Integer.parseInt(request.getParameter("ID_SUSTITUTO"));
        String salida = "";
        try {            
            salida = donanteBL.deleteSustituto(ID_SUSTITUTO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getInfoRecolector(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idRecolector = Integer.parseInt(request.getParameter("ID_RECOLECTOR"));
        donanteBL bitacoraa = new donanteBL();

        try {
            salida = bitacoraa.getInfoRecolector(idRecolector);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

}