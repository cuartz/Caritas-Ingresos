/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.caritas.bl.catalogsBL;
/**
 *
 * @author RCastilloc
 */
public class catalogsAC extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String resp = "";
        
        boolean val = request.getParameter("val")==null?false:true;
        boolean list = request.getParameter("list")==null?false:true;
        boolean addCatalog = request.getParameter("addCatalog")==null?false:true;
        boolean addValue = request.getParameter("addValue")==null?false:true;
        boolean uptValue = request.getParameter("uptValue")==null?false:true;
        boolean delValue = request.getParameter("delValue")==null?false:true;
        int idcatalog = request.getParameter("idcatalog")==null?0:Integer.parseInt(request.getParameter("idcatalog"));
        int idvalue = request.getParameter("idvalue")==null?0:Integer.parseInt(request.getParameter("idvalue"));
        int status = request.getParameter("status")==null?1:Integer.parseInt(request.getParameter("status"));
        String value = request.getParameter("value")==null?"":request.getParameter("value");
        
        String value2 = request.getParameter("value2")==null?"":request.getParameter("value2");
        
        
        if(list){
            resp=catalogsBL.getCatalogs();
        }
        
        if(val){
            resp=catalogsBL.getCatalogValues(idcatalog);
        }
        
        if(addValue){
            resp=catalogsBL.addValue(idcatalog,value,value2);
        }
        
        if(uptValue){
            resp=catalogsBL.uptValue(idvalue,value,value2,status);
//            resp=catalogsBL.uptValue(idvalue,value,status);
        }
        
        if(delValue){
            resp=catalogsBL.delValue(idvalue);
        }
        
        if(addCatalog){
            resp=catalogsBL.addCatalog(value);
        }
        
        request.setAttribute("resp", resp);
        return mapping.findForward(SUCCESS);
    }
}
