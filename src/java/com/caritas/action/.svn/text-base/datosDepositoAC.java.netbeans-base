/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.datosChequeBL;
import com.caritas.bl.datosDepositoBL;
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
public class datosDepositoAC extends DispatchAction{
    private final static String SUCCESS = "success"; 
    private final static String FAILURE = "failure:";
    
    public ActionForward agregarDeposito(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();          
        datosDepositoBL deposito = new datosDepositoBL();
        
        try {                       
            String jsonData = request.getParameter("jsonData");          
            JSONObject jsonObject = JSONObject.fromObject(jsonData);          
            deposito.agregarDeposito(jsonObject, request.getParameter("uid"));              
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
