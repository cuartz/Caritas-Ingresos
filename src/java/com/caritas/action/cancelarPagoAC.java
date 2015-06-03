/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.cancelarPagoBL;
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
public class cancelarPagoAC extends DispatchAction{
    private final static String SUCCESS = "success"; 
    private final static String FAILURE = "failure:";
    
    public ActionForward cancelarPago(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();  
        cancelarPagoBL cancel = new cancelarPagoBL();
        
        try {                       
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            int precancelacion = Integer.parseInt(request.getParameter("precancelacion"));            
            String idUsuario    = request.getParameter("idUsuario");
            cancel.cancelarPago(jsonObject, Integer.parseInt(request.getParameter("idBitacora")), precancelacion, idUsuario);
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
    
    public ActionForward getSolicitudesRecibosPrecancelados(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");

        try {
            String strQuery = request.getParameter("query") == null ? "" : request.getParameter("query");
            cancelarPagoBL cancel = new cancelarPagoBL();
            salida = cancel.getSolicitudesRecibosPrecancelados(strQuery, start, limit);  
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward aprobarCancelacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        cancelarPagoBL cancel = new cancelarPagoBL();
        try {
            int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));
            String idUsuario    = request.getParameter("idUsuario");
            salida = cancel.aprobarCancelacion(ID_BITACORA, idUsuario);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward denegarCancelacion(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        cancelarPagoBL cancel = new cancelarPagoBL();
        try {
            int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));            
            salida = cancel.denegarCancelacion(ID_BITACORA);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
}
