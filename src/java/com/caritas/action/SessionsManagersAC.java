/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.SessionsManagersBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author monjaraz
 */
public class SessionsManagersAC extends DispatchAction {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";

    /**
     * Este metodo te trae toda la informacion relacionada con el usuario que en este momento esta logeado
     * http://.../actionPath?method=myAction1,
     * where "method" is the value specified in <action> element : 
     * ( <action parameter="method" .../> )
     */
    public ActionForward getInformationOfUser(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession sesion = request.getSession();
        String id_user = "";
        if (sesion.getAttribute("idusersession") != null) {
            id_user = sesion.getAttribute("idusersession").toString().split(":")[0];
        }
        JSONObject jsonInformationOfUser = SessionsManagersBL.getInformationOfUser(id_user);
        System.out.println("perfil:>" + jsonInformationOfUser.toString());
        request.setAttribute("resp", jsonInformationOfUser.toString());
        return mapping.findForward(SUCCESS);
    }

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction2,
     * where "method" is the value specified in <action> element : 
     * ( <action parameter="method" .../> )
     */
    public ActionForward myAction2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        return mapping.findForward(SUCCESS);
    }
}
