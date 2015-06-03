/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.cartasBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author user
 */
public class cartasAC extends DispatchAction {

    /*
     * forward name="success" path=""
     */
    private final static String SUCCESS = "success";

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction1, where "method" is the value
     * specified in <action> element : ( <action parameter="method" .../> )
     */
    public ActionForward myAction1(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        return mapping.findForward(SUCCESS);
    }

     public ActionForward getAllGrid_DonantesCartas(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) {
        String salida = "";

//        int ID_DONA = Integer.parseInt((request.getParameter("ID_DONANTE") == null || request.getParameter("ID_DONANTE").equals("")) ? "0" : request.getParameter("ID_DONANTE"));
//        System.out.println("Action Grid Direccion" + ID_DONA);
        org.json.JSONArray jsonList = new org.json.JSONArray();
        try {
            cartasBL scbl = new cartasBL();
            salida = scbl.getAllGrid_DonantesCartas();
//            salida = scbl.getAllGrid_DonantesCartas(ID_DONA);
            System.out.println("Data.toString>>> " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
     
     public ActionForward getAllGrid_listaCartas(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) {
        String salida = "";

//        int ID_DONA = Integer.parseInt((request.getParameter("ID_DONANTE") == null || request.getParameter("ID_DONANTE").equals("")) ? "0" : request.getParameter("ID_DONANTE"));
//        System.out.println("Action Grid Direccion" + ID_DONA);
        org.json.JSONArray jsonList = new org.json.JSONArray();
        try {
            cartasBL scbl = new cartasBL();
            salida = scbl.getAllGrid_listaCartas();
//            salida = scbl.getAllGrid_DonantesCartas(ID_DONA);
            System.out.println("Data.toString>>> " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
     
     
      public ActionForward getAllGrid_DonantesCandidato(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) {
        String salida = "";

//        int ID_DONA = Integer.parseInt((request.getParameter("ID_DONANTE") == null || request.getParameter("ID_DONANTE").equals("")) ? "0" : request.getParameter("ID_DONANTE"));
//        System.out.println("Action Grid Direccion" + ID_DONA);
        org.json.JSONArray jsonList = new org.json.JSONArray();
        try {
            cartasBL scbl = new cartasBL();
            salida = scbl.getAllGrid_DonantesCandidato();
//            salida = scbl.getAllGrid_DonantesCartas(ID_DONA);
            System.out.println("Data.toString>>> " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
   
    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction2, where "method" is the value
     * specified in <action> element : ( <action parameter="method" .../> )
     */
    public ActionForward myAction2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        return mapping.findForward(SUCCESS);
    }
}
