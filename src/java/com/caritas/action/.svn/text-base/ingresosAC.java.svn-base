package com.caritas.action;

import com.caritas.bl.ingresosBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class ingresosAC extends DispatchAction {
   private final static String SUCCESS = "success"; 
   private final static String FAILURE = "failure:"; 
    
    public ActionForward getAllCobrosEfectivoPagados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
    String salida = "";
    int idRecolector    = 0;
    String fechaVisita  = "";
    int idZona  = 0;
    String fechaCobro = "";
    String nombre = "";
    String numRecibo = "";
    
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
        
         if(request.getParameter("FECHA_COBRO") != null){                
            fechaCobro = request.getParameter("FECHA_COBRO");               
            if(fechaCobro.length() == 0)
                fechaCobro = null;                
        }else
            fechaCobro = null;
        
        if(request.getParameter("NOMBRE_DONANTE") != null){                
                nombre = request.getParameter("NOMBRE_DONANTE");                               
            }else
                nombre = null;
        
        if(request.getParameter("NUM_RECIBO") != null){                
                numRecibo = request.getParameter("NUM_RECIBO");                               
            }else
                numRecibo = null; 
        
        ingresosBL ingresoss = new ingresosBL();           
        salida = ingresoss.getAllCobrosEfectivoPagados(idRecolector, fechaVisita, idZona, start, limit, fechaCobro, nombre, numRecibo);             
        request.setAttribute("resp", salida);
    } catch (Exception e) {
        e.printStackTrace();
        return mapping.findForward(FAILURE);
    }
    return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllCobrosEspeciePagados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";   
        int idRecolector    = 0;
        String fechaVisita  = "";
        int idZona  = 0;
        String fechaCobro = "";
        String nombre = "";
        String numRecibo = "";
        
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
        
        if(request.getParameter("FECHA_COBRO") != null){                
            fechaCobro = request.getParameter("FECHA_COBRO");               
            if(fechaCobro.length() == 0)
                fechaCobro = null;                
        }else
            fechaCobro = null;
        
        if(request.getParameter("NOMBRE_DONANTE") != null){                
                nombre = request.getParameter("NOMBRE_DONANTE");                               
            }else
                nombre = null;
        
        if(request.getParameter("NUM_RECIBO") != null){                
                numRecibo = request.getParameter("NUM_RECIBO");                               
            }else
                numRecibo = null;       
        
        ingresosBL ingresoss = new ingresosBL();            
        salida = ingresoss.getAllCobrosEspeciePagados(idRecolector, fechaVisita, idZona, fechaCobro, nombre, numRecibo, start, limit);            
        request.setAttribute("resp", salida);
    } catch (Exception e) {
        e.printStackTrace();
        return mapping.findForward(FAILURE);
    }
    return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllRecibosEntregados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
    String salida = "";   

    try {  
        ingresosBL ingresoss = new ingresosBL();            
        salida = ingresoss.getAllRecibosEntregados();            
        request.setAttribute("resp", salida);
    } catch (Exception e) {
        e.printStackTrace();
        return mapping.findForward(FAILURE);
    }
    return mapping.findForward(SUCCESS);
    }

    public ActionForward confirmacionCobro(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();         
        String jsonData = request.getParameter("jsonData");
        JSONObject jsonObject = JSONObject.fromObject(jsonData);        
        ingresosBL ingresoss = new ingresosBL(); 
        
        try {                    
            ingresoss.confirmacionCobro(jsonObject, Integer.parseInt(request.getParameter("idBitacora")));           
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
}
