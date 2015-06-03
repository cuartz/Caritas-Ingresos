package com.caritas.action;

import com.caritas.bl.listaConfirmacionBL;
import com.caritas.bl.reporteBL;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

public class reportesAC extends DispatchAction {
    private final static String SUCCESS = "success";
    
    /* ------------------------------------------ REPORTES DE TESORERIA ----------------------------------------------------------------- */
    public ActionForward reporte_TESORERIA_ListadoDeCobranza(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida           = "";
        reporteBL reportesBL    = new reporteBL();
        
        //Parametros
        String fechaPagoIni     = request.getParameter("FECHA_INI");
        String fechaPagoFin     = request.getParameter("FECHA_FIN");
        String idCampFin        = request.getParameter("CAMP_FIN");
        String idFormaPago      = request.getParameter("FORMA_PAGO");
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        String option           = request.getParameter("TIPO_REPORTE");        
        
        if(fechaPagoIni == "") fechaPagoIni = null;       
        if(fechaPagoFin == "") fechaPagoFin = null;
        if(idCampFin == "") idCampFin = null;
        if(option == null || option == "") option = "1";
        if(idFormaPago == "") idFormaPago = null;
        
        try {            
            salida = reportesBL.reporte_TESORERIA_ListadoDeCobranza(fechaPagoIni, fechaPagoFin, idCampFin, idFormaPago, start, limit, option);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
        
    public ActionForward reporte_TESORERIA_ConcentradoDeCobranza(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida   = "";        
        int chkbxProy   = 0;
        int chkbxAsign  = 0;
        reporteBL reporteBL  = new reporteBL();
        
        //Parametros
        String fechaini = request.getParameter("FECHA_INI");
        String fechafin = request.getParameter("FECHA_FIN");        
        if(request.getParameter("CHKBX_PROY") == null) chkbxProy = 0; else chkbxProy   = Integer.parseInt(request.getParameter("CHKBX_PROY"));            
        if(request.getParameter("CHKBX_ASIGN") == null) chkbxAsign = 0; else chkbxAsign  = Integer.parseInt(request.getParameter("CHKBX_ASIGN"));            
        if(chkbxProy == 0 && chkbxAsign == 0){
            chkbxProy = 0;
            chkbxAsign = 1;
        }
        
        if(fechaini == "") fechaini = null;
        if(fechafin == "") fechafin = null;        
        
        try {
            salida = reporteBL.reporte_TESORERIA_ConcentradoDeCobranza(fechaini, fechafin, chkbxProy, chkbxAsign);           
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    public ActionForward reporte_TESORERIA_recibosImpresos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        reporteBL reporteBL = new reporteBL();
        
        //Parametros
        String fechaini    = request.getParameter("FECHA_INI");
        String fechafin     = request.getParameter("FECHA_FIN");
        String usuario      = request.getParameter("USUARIO");
        String start        = request.getParameter("start");
        String limit        = request.getParameter("limit");
        
        if(fechaini == "") fechaini = null;
        if(fechafin == "") fechafin = null;
        if(usuario == "") usuario = null; 
        
        try {                      
            salida = reporteBL.reporte_TESORERIA_recibosImpresos(fechaini, fechafin, usuario, start, limit);                        
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward reporte_TESORERIA_seguimiento(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        reporteBL reporteBL = new reporteBL();
        
        //Parametros
        String fechaini = request.getParameter("FECHA_INI");
        String fechafin = request.getParameter("FECHA_FIN");
        String idCampFin = request.getParameter("idCampFin");
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");           
        
        if(fechaini == "") fechaini = null;
        if(fechafin == "") fechafin = null;
        
        try {            
            salida = reporteBL.reporte_TESORERIA_seguimiento(fechaini, fechafin, idCampFin, start, limit);             
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward reporte_TESORERIA_ListadoDeCobranzaExportToPDF(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        try {
            String fechainicial = request.getParameter("fechainicial") == null ? "" : request.getParameter("fechainicial");
            String fechafinal = request.getParameter("fechafinal") == null ? "" : request.getParameter("fechafinal");
            int tipo_reporte = Integer.parseInt(request.getParameter("tipo_reporte"));
            String destino = "ERROR";
            
            try {
                String nameReport = "";
                switch (tipo_reporte) {
                    case 1:
                        nameReport = "listadoCobranza_Te.jasper";
                        break;
                }
                reporteBL hs = new reporteBL();
                byte[] informePDF = hs.generarInformeListA(fechainicial, fechafinal, nameReport);
                mostrarPDFLA(informePDF, response);//LINEA PARA MOSTRAR EL PDF
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("Error", "Error interno. Por favor, inténtelo otra vez en unos minutos.");
            }
            return null;//mapping.findForward(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /* ------------------------------------------ REPORTES DE OPERACION ----------------------------------------------------------------- */
    
    
    
    
    
    
    
    /* ------------------------------------------ REPORTES DE OPERACION [MONITOREO Y SUPERVISIÓN] ----------------------------------------------------------------- */
    
    
    
    
    
    
    /* ------------------------------------------ REPORTES DE OPERACIÓN [DONANTES O BENEFACTORES] ----------------------------------------------------------------- */
    
    
    
    
    
    
    
    
    /* ------------------------------------------ REPORTES DE SHCP ----------------------------------------------------------------- */

    public ActionForward getExpediente(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
//            String id_beneficiario = request.getParameter("id_beneficiario")==null?"":request.getParameter("id_beneficiario");
//            System.out.println("getExpediente::: id Beneficiario " + id_beneficiario );
            reporteBL scbl = new reporteBL();

            salida = scbl.getExpediente();

            System.out.println("getExpediente: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllR_totalRegistrosDonantes(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            System.out.println("entrando el AC");
            reporteBL scbl = new reporteBL();

            salida = scbl.getAllR_totalRegistrosDonantes(fechaini, fechafin);

            System.out.println("getAllR_totalRegistrosDonantes: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllR_totalRegistrosDonativos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            System.out.println("entrando el AC");
            reporteBL scbl = new reporteBL();

            salida = scbl.getAllR_totalRegistrosDonativos(fechaini, fechafin);

            System.out.println("getAllR_totalRegistrosDonantes: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllR_totalRegistrosBitacora(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            System.out.println("entrando el AC");
            reporteBL scbl = new reporteBL();

            salida = scbl.getAllR_totalRegistrosBitacora(fechaini, fechafin);

            System.out.println("getAllR_totalRegistrosBitacora: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    public ActionForward getAllReport_Ortografia2(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getAllReport_Ortografia2(fechaini, fechafin, usuario, start, limit);
            System.out.println("getAllReport_Ortografia2 AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    //SHCPaportacionesAnuales_1
    public ActionForward getR_aportacionesAnualesSHCP(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getR_aportacionesAnualesSHCP(fechaini, fechafin, usuario, start, limit);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //SHCPuniversodeDonantes_2
    public ActionForward getR_universodeDonantesSHCP(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getR_universodeDonantesSHCP(fechaini, fechafin, usuario, start, limit);
            System.out.println("getR_universodeDonantesSHCP AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //SHCPdeduciblesEmitidosAnoAnterior_3
    public ActionForward getR_deduciblesEmitidosAnoAnteriorSHCP(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getR_deduciblesEmitidosAnoAnteriorSHCP(fechaini, fechafin, usuario, start, limit);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    //SHCPuniversoDonantesAnualesAlfa_4
    public ActionForward getR_universoDonantesAnualesAlfaSHCP(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getR_universoDonantesAnualesAlfaSHCP(fechaini, fechafin, usuario, start, limit);
            System.out.println("getR_universoDonantesAnualesAlfaSHCP AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    //SHCPinstitucionesDE_5

    public ActionForward getR_institucionesDESHCP(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getR_institucionesDESHCP(fechaini, fechafin, usuario, start, limit);
            System.out.println("getR_aportacionesAnualesSHCP AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //OPERATIVOS
    //OPE_CancelaciondeDonativos_1
    public ActionForward getR_OPE_CancelaciondeDonativos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String UsuarioAT = request.getParameter("UsuarioAT");
            String TipoListado = request.getParameter("TipoListado") == null ? "" : request.getParameter("TipoListado");
            String chekbox = request.getParameter("chekbox") == null ? "" : request.getParameter("chekbox");            
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.getR_OPE_CancelaciondeDonativos(fechaini, fechafin, UsuarioAT, TipoListado, chekbox, start, limit);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //REPORT DEL MENU DE MONITOREO Y SUPERVISION
    //Rep_MYS_RECIBOS_IMPRESOSMES_1
    public ActionForward report_Rep_MYS_RECIBOS_IMPRESOSMES(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            System.out.println("entrando el AC");
            reporteBL scbl = new reporteBL();

            salida = scbl.report_Rep_MYS_RECIBOS_IMPRESOSMES(fechaini, fechafin);

            System.out.println("getAllR_totalRegistrosDonantes: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //Rep_MYS_RECIBOS_COBRADOS_2
    public ActionForward report_Rep_MYS_RECIBOS_COBRADOS(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_MYS_RECIBOS_COBRADOS(fechaini, fechafin, usuario, start, limit);
            System.out.println("getAllReport_Ortografia2 AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //Rep_MYS_RECIBOS_POR_COBRAR_3
    public ActionForward report_Rep_MYS_RECIBOS_POR_COBRAR(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_MYS_RECIBOS_POR_COBRAR(fechaini, fechafin, usuario, start, limit);
            System.out.println("Rep_MYS_RECIBOS_POR_COBRAR AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //Rep_MYS_RECIBOS_POR_CONFIRMADO_4
    public ActionForward report_Rep_MYS_RECIBOS_POR_CONFIRMADO(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_MYS_RECIBOS_POR_CONFIRMADO(fechaini, fechafin, usuario, start, limit);
            System.out.println("report_Rep_MYS_RECIBOS_POR_CONFIRMADO AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    //Rep_MYS_RECIBOS_POR_EMPRESA_5

    public ActionForward report_Rep_MYS_RECIBOS_POR_EMPRESA(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_MYS_RECIBOS_POR_EMPRESA(fechaini, fechafin, usuario, start, limit);
            System.out.println("report_Rep_MYS_RECIBOS_POR_EMPRESA AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //Rep_MYS_RECIBOS_POR_TIPODONANTE_6
    public ActionForward report_Rep_MYS_RECIBOS_POR_TIPODONANTE(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");


            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_MYS_RECIBOS_POR_TIPODONANTE(fechaini, fechafin, usuario, start, limit);
            System.out.println("report_Rep_MYS_RECIBOS_POR_TIPODONANTE AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    //Rep_DB_ListadoDonantes_Activos

    public ActionForward report_Rep_DB_ListadoDonantes_Activos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_DB_ListadoDonantes_Activos(fechaini, fechafin, usuario, start, limit);
            System.out.println("report_TES_concentradocobranza AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    //Rep_DB_ListadoDonantes_Inactivos

    public ActionForward report_Rep_DB_ListadoDonantes_Inactivos(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_Rep_DB_ListadoDonantes_Inactivos(fechaini, fechafin, usuario, start, limit);
            System.out.println("report_TES_concentradocobranza AC: " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }

    //_OPE_reProspectar_5
    public ActionForward report_OPE_reProspectar(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_OPE_reProspectar(fechaini, fechafin, usuario, start, limit);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    //OPE_agradecimiento_6

    public ActionForward report_OPE_agradecimiento(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        try {
            String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
            String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
            String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
            String start = request.getParameter("start") == null ? "" : request.getParameter("start");
            String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
            reporteBL scbl = new reporteBL();
            salida = scbl.report_OPE_agradecimiento(fechaini, fechafin, usuario, start, limit);            
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
   
    
    //OTROS
    public ActionForward reportAyudaPrensa(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        String fechaIni  = request.getParameter("FECHA_PAGO_INI");
        String fechaFin  = request.getParameter("FECHA_PAGO_FIN");
        
        if(fechaIni == "") fechaIni = null;
        if(fechaFin == "") fechaFin = null;
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        
        try {
            reporteBL reportAyudaPrensa = new reporteBL();
            salida = reportAyudaPrensa.reportAyudaPrensa(fechaIni, fechaFin, start, limit);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
    
    private void mostrarPDFLA(byte[] reportPDF, HttpServletResponse response) throws IOException {
        //Incializamos el array 
        System.out.println(" va a mostrar el pdf... .");
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ServletOutputStream out = response.getOutputStream();
        bos.write(reportPDF);//
        response.setContentType("application/pdf");
        //para que el pdf se pueda ver en microsoft explorer para que aparezca el diálogo abrir/guardar
        response.setHeader("Cache-Control", "cache");
//        response.setHeader("Content-Disposition", "attachment; filename=archivo.pdf");
        System.out.println(" tamaño del archivo " + bos.size());
//        response.setHeader("Pragma", "cache");
        response.setContentLength(bos.size());
        out.write(bos.toByteArray());
        out.flush();
        bos.close();
        out.close();
        response.flushBuffer();

        /*
         * ByteArrayOutputStream bos = new ByteArrayOutputStream();
         * ServletOutputStream out = response.getOutputStream();
         * bos.write(reportPDF);// response.setContentType("application/pdf");
         * //para que el pdf se pueda ver en microsoft explorer
         * response.setHeader("Cache-Control", "cache");
         * response.setContentLength(bos.size()); out.write(bos.toByteArray());
         * out.flush(); bos.close(); out.close(); response.flushBuffer();
         */

    }

    public ActionForward reportIngresoMensual(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        String fechaIni  = request.getParameter("FECHA_INI");
        String fechaFin  = request.getParameter("FECHA_FIN");
        
        if(fechaIni == "") fechaIni = null;
        if(fechaFin == "") fechaFin = null;
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");
        
        try {
            reporteBL reportIngresoMensual = new reporteBL();
            salida = reportIngresoMensual.reportIngresoMensual(fechaIni, fechaFin, start, limit);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
    
}
