/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.bitacoraPagosBL;
import com.caritas.bl.confirmacionPagoBL;
import com.caritas.bl.reprogramarPagoBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

/**
 *
 * @author rnunez
 */
public class reprogramarPagoAC extends DispatchAction {
     private final static String SUCCESS = "success"; 
     private final static String FAILURE = "failure:"; 
    
    public ActionForward getFechas(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));       
        reprogramarPagoBL reprogramarBL = new reprogramarPagoBL();
        
        try {                                
            salida = reprogramarBL.getFechas(idBitacora);         
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward updateFechaPago(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();  
        reprogramarPagoBL repBL = new reprogramarPagoBL();
        String idUsuario    = "";
        
        try {
            idUsuario   = request.getParameter("idUsuario");
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);        
            repBL.updateFechaPago(jsonObject, Integer.parseInt(request.getParameter("idBitacora")), idUsuario);
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
    
    public ActionForward getHistorialReprogramacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = ""; 
        String idRecibo = "";
        reprogramarPagoBL reprogramarBL = new reprogramarPagoBL();
        
        try {
            idRecibo = request.getParameter("idRecibo");            
            salida = reprogramarBL.getHistorialReprogramacion(idRecibo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error reprogramarPagoAC[getHistorialReprogramacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getDonanteInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = ""; 
        String idRecibo = "";
        reprogramarPagoBL reprogramarBL = new reprogramarPagoBL();
        
        try {
            idRecibo = request.getParameter("ID_RECIBO");            
            salida = reprogramarBL.getDonanteInfo(idRecibo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            System.out.println("Error reprogramarPagoAC[getHistorialReprogramacion]: "+e.getMessage());
            return mapping.findForward(FAILURE);
        }
        return mapping.findForward(SUCCESS);
    }

}