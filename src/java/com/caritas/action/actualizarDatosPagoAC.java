package com.caritas.action;

import com.caritas.bl.actualizarDatosPagoBL;
import com.caritas.bl.datosDepositoBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class actualizarDatosPagoAC extends DispatchAction{
    private final static String SUCCESS = "success"; 
    private final static String FAILURE = "failure:";
    
    public ActionForward actualizarDatos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();          
        actualizarDatosPagoBL updatePago = new actualizarDatosPagoBL();
        
        try {                       
            String jsonData = request.getParameter("jsonData");          
            JSONObject jsonObject = JSONObject.fromObject(jsonData);          
            updatePago.actualizarDatos(jsonObject, Integer.parseInt(request.getParameter("idBitacora")), request.getParameter("idUsuario"));              
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
