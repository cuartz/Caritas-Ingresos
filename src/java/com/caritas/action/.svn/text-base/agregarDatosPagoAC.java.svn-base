package com.caritas.action;

import com.caritas.bl.actualizarDatosPagoBL;
import com.caritas.bl.agregarDatosPagoBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class agregarDatosPagoAC extends DispatchAction{
    private final static String SUCCESS = "success"; 
    private final static String FAILURE = "failure:";
    
    public ActionForward agregarDatos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();   
        String jsonData = request.getParameter("jsonData");          
        JSONObject jsonObject = JSONObject.fromObject(jsonData);
        agregarDatosPagoBL addPago = new agregarDatosPagoBL();
        
        try {         
            int salida = addPago.agregarPago(jsonObject, request.getParameter("idUsuario"));
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
