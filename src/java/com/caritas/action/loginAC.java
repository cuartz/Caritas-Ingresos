/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.loginBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author RCastilloc
 */
public class loginAC extends org.apache.struts.action.Action {

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
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resp = "";

        boolean logout = request.getParameter("logout") == null ? false : true;
        String loginusr = request.getParameter("loginusr") == null ? "" : request.getParameter("loginusr");
        String loginpass = request.getParameter("loginpass") == null ? "" : request.getParameter("loginpass");

        if (!logout) {
            resp = loginAC.validateUser(loginusr, loginpass);
        } else {
            resp = "-1";
            System.out.println(":: LOGOUT ::");
        }

        request.setAttribute("idusersession", resp);
        return mapping.findForward(SUCCESS);
    }
    
    public static String validateUser(String loginusr,String loginpass){
        return loginBL.validateUser(loginusr,loginpass);
    }
}
