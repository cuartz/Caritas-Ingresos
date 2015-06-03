/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.adminusersBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
/**
 *
 * @author RCastilloc
 */
public class adminusersAC extends org.apache.struts.action.Action {

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
        
        boolean addprofile = request.getParameter("addprofile")==null?false:true;
        boolean uptprofile = request.getParameter("uptprofile")==null?false:true;
        boolean getprofiles = request.getParameter("getprofiles")==null?false:true;
        boolean getusers = request.getParameter("getusers")==null?false:true;
        boolean delUser = request.getParameter("delUser")==null?false:true;
        boolean uptUser = request.getParameter("uptUser")==null?false:true;
        boolean addUser = request.getParameter("addUser")==null?false:true;
        boolean delProfile = request.getParameter("delProfile")==null?false:true;
        boolean getPermisos = request.getParameter("getPermisos")==null?false:true;
        boolean getZona = request.getParameter("getZona")== null?false:true;
        
        boolean getApps = request.getParameter("getApps")==null?false:true;

        String id_user = request.getParameter("id_user")==null?"":request.getParameter("id_user");
        String name = request.getParameter("name")==null?"":request.getParameter("name");
        String password = request.getParameter("password")==null?"":request.getParameter("password");
        String email = request.getParameter("email")==null?"":request.getParameter("email");
        String perfil = request.getParameter("perfil")==null?"":request.getParameter("perfil");
//        String id_zona = request.getParameter("id_zona")==null?"":request.getParameter("id_zona");
        String id_zona = request.getParameter("id_zona") != null && !request.getParameter("id_zona").equals("") ? request.getParameter("id_zona") : "0";
        String permissions = request.getParameter("permissions")==null?"0":request.getParameter("permissions");
        
        //        String permissions = request.getParameter("permissions")==null?"":request.getParameter("permissions");
        
        if(uptprofile){
            resp=adminusersBL.uptProfile(perfil,permissions);
        }                
        
        if(getPermisos){
            resp=adminusersBL.getPermisos(perfil);
        }
        
        if(addUser){
            resp=adminusersBL.addUser(id_user,name,password,email,perfil,id_zona);
        }
        
        if(getusers){
            resp=adminusersBL.getUsers(perfil);
        }      
        
        if(uptUser){
            resp=adminusersBL.uptUser(id_user,name,password,email,perfil,id_zona);
        }
        
        if(delUser){
            resp=adminusersBL.delUser(id_user);
        }  
        
        
        if(getprofiles){
            resp=adminusersBL.getProfiles();
        }
        
        if(getZona){
            resp=adminusersBL.getZona();
        }

        if(addprofile){
            resp=adminusersBL.addProfile(name,permissions);
        }
              
        if(delProfile){
            resp=adminusersBL.delProfile(perfil);
        }
        
        if(getApps){
            resp=adminusersBL.getApps();
        }
                
        request.setAttribute("resp", resp);
        return mapping.findForward(SUCCESS);
    }
}
