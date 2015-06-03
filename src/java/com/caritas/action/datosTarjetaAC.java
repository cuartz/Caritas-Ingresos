/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.datosTarjetaBL;
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
public class datosTarjetaAC extends DispatchAction{
    private final static String SUCCESS = "success";
    
    public ActionForward saveTarjetaCredito(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        String uid = request.getParameter("uid");
        int idTarjeta   = Integer.parseInt(request.getParameter("idTarjeta"));
        
        System.out.println("idTarjeta: "+idTarjeta);
        
        try {              
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);           
            int salida = datosTarjetaBL.saveTarjetaCredito(jsonObject, uid, idTarjeta);        
            fInfo.element("salida", salida);
            data.element("success", "true");
            data.element("fileinfo", fInfo);            
        } catch (Exception e) {
            e.printStackTrace();
    //            return mapping.findForward(FAILURE);            
        }
        request.setAttribute("resp", data.toString());       
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getDatosTarjetaCredito(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idTarjeta = Integer.parseInt(request.getParameter("ID_TARJETA_TMP"));
        datosTarjetaBL dattos = new datosTarjetaBL();

        try {
            salida = dattos.getDatosTarjetaCredito(idTarjeta);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
}
