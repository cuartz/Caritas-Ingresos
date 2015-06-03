package com.caritas.action;

import com.caritas.bl.datosDepositoBL;
import com.caritas.bl.datosTransferenciaBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class datosTransferenciaAC extends DispatchAction{
    private final static String SUCCESS = "success"; 
    private final static String FAILURE = "failure:";
    
    public ActionForward agregarTransferencia(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();          
        datosTransferenciaBL transferencia = new datosTransferenciaBL();
        
        try {                       
            String jsonData = request.getParameter("jsonData");          
            JSONObject jsonObject = JSONObject.fromObject(jsonData);          
            transferencia.agregarTransferencia(jsonObject, request.getParameter("uid"));              
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
