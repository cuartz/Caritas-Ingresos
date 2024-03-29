package com.caritas.action;

import com.caritas.bl.bitacoraPagosBL;
import com.caritas.bl.cancelarPagoBL;
import com.caritas.bl.comboboxBL;
import com.caritas.bl.donativoBL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class bitacoraPagosAC extends DispatchAction {

    private final static String SUCCESS = "success";
    private final static String FAILURE = "failure:";

    public ActionForward getBitacoraPagosListByDonativo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";

        try {
            bitacoraPagosBL bitacora = new bitacoraPagosBL();
            salida = bitacora.getBitacoraPagosListByDonativo(Integer.parseInt(request.getParameter("idDonativo")));
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getDonativoInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonativo = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();        

        try {
            salida = bitacoraa.getDonativoInfo(idDonativo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getBitacoraComentarios(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();

        try {
            salida = bitacoraa.getBitacoraComentarios(idBitacora);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getInfoCheque(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonativo = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();

        try {
            salida = bitacoraa.getInfoCheque(idDonativo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getInfoDeposito(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonativo = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();

        try {
            salida = bitacoraa.getInfoDeposito(idDonativo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getInfoTarjetaCredito(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonativo = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();

        try {
            salida = bitacoraa.getInfoTarjetaCredito(idDonativo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getInfoTransferencia(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonativo = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();

        try {
            salida = bitacoraa.getInfoTransferencia(idDonativo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward getInfoTarjetaDebito(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idDonativo = Integer.parseInt(request.getParameter("ID_DONATIVO"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();

        try {
            salida = bitacoraa.getInfoTarjetaDebito(idDonativo);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward cancelarRecibo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        bitacoraPagosBL bitaBl = new bitacoraPagosBL();
        try {
            int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));
            salida = bitaBl.cancelarRecibo(ID_BITACORA);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getInfoModificarPago(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        int idBitacora = Integer.parseInt(request.getParameter("ID_BITACORA"));
        bitacoraPagosBL bitacoraa = new bitacoraPagosBL();       

        try {
            salida = bitacoraa.getInfoModificarPago(idBitacora);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward updateInfoRecibo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();
        bitacoraPagosBL bitaBl = new bitacoraPagosBL();
        
        try {           
            String jsonData = request.getParameter("jsonData");           
            int ID_BITACORA = Integer.parseInt(request.getParameter("idBitacora"));          
            JSONObject jsonObject = JSONObject.fromObject(jsonData);         
            bitaBl.updateInfoRecibo(jsonObject, ID_BITACORA);
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
    
    public ActionForward generarPagoUnico(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {        
        String salida = "";
        bitacoraPagosBL bitaAC = new bitacoraPagosBL(); 
        try {
            int ID_BITACORA = Integer.parseInt(request.getParameter("ID_BITACORA"));
            salida = bitaAC.generarPagoUnico(ID_BITACORA);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("resp", salida);
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward cobrarPagoPersonal(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        JSONObject data = new JSONObject();
        JSONObject fInfo = new JSONObject();  
        bitacoraPagosBL bita = new bitacoraPagosBL();      
        
        try {                       
            String jsonData = request.getParameter("jsonData");
            JSONObject jsonObject = JSONObject.fromObject(jsonData);
            bita.cobrarPagoPersonal(jsonObject, Integer.parseInt(request.getParameter("idBitacora")));           
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
