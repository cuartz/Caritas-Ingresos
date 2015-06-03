package com.caritas.action;

import com.caritas.utils.MConnection;
import com.caritas.utils.Util;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Date;
import java.text.SimpleDateFormat;

public class ShowExcel extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idOperationType = request.getParameter("idOperationType");
        switch (Integer.parseInt(idOperationType)) {
            case 0:
                getAllR_totalRegistrosDonantes(request, response);
                break;
            case 1:
                getAllReport_Ortografia2(request, response);
                break;
            case 2: //Lista de los pagos confirmados que se llevara el recolector                
                int idRecolector        = Integer.parseInt(request.getParameter("idRecolector"));
                int idZona              = Integer.parseInt(request.getParameter("idZona"));//                           
                String fechaVisita      = request.getParameter("fechaVisita");
                String fechaCaptura     = request.getParameter("fechaCaptura");
                int idCampFin           = Integer.parseInt(request.getParameter("idCampFin"));                
                String nombre           = request.getParameter("nombre");
                if(nombre == "") nombre = null;               
                
                getAllPagos_Confirmados(request, response, idZona, idRecolector, fechaVisita, idCampFin, fechaCaptura, nombre);
                break;
            case 220:
                getAllR_totalRegistrosDonativos(request, response);
                break;
            case 3:
                getAllR_totalRegistrosBitacora(request, response);
                break;
            case 4: //SHCP
                getR_aportacionesAnualesSHCP(request, response);
                break;
            case 5:
                getR_universodeDonantesSHCP(request, response);
                break;
            case 6:
                getR_deduciblesEmitidosAnoAnteriorSHCP(request, response);
                break;
            case 7:
                getR_universoDonantesAnualesAlfaSHCP(request, response);
                break;
            case 8:
                getR_institucionesDESHCP(request, response);
                break;
            case 9://OPERATIVOS
                getR_OPE_CancelaciondeDonativos(request, response);
                break;
            case 91://OPERATIVOS MS
                report_Rep_MYS_RECIBOS_IMPRESOSMES(request, response);
                break;
            case 92:
                report_Rep_MYS_RECIBOS_COBRADOS(request, response);
                break;
            case 93:
                report_Rep_MYS_RECIBOS_POR_COBRAR(request, response);
                break;
            case 94:
                report_Rep_MYS_RECIBOS_POR_CONFIRMADO(request, response);
                break;
            case 95:
                report_Rep_MYS_RECIBOS_POR_EMPRESA(request, response);
                break;
            case 96:
                report_Rep_MYS_RECIBOS_POR_TIPODONANTE(request, response);
                break;
            case 901://OPERATIVOS DONANTES BIENECHORES
                report_Rep_DB_ListadoDonantes_Activos(request, response);
                break;
            case 902:
                report_Rep_DB_ListadoDonantes_Inactivos(request, response);
                break;
            case 10://TESORERIA
                report_TES_listadoCobranza(request, response);
                break;
            case 11: //CONCENTRADO DE COBRANZA                
                report_TES_concentradocobranza(request, response);
                break;
            case 12:
                report_TES_rastreoRecibosDeducibles(request, response);
                break;
            case 13:
                report_TES_seguimiento(request, response);
                break;
            case 14:
                ingresosCobrosEfectivo(request, response);
                break;
            case 15: //Exportar reporte diario de contabilidad
                String fechaPago  = request.getParameter("fechaPago");
                if(fechaPago == ""){
                    fechaPago = null;
                }                
                reporteDiarioContabilidad(request, response, fechaPago);
                break;
            case 16: //Exportar reporte diario de contabilidad
                String fechaaPago  = request.getParameter("fechaPago");
                if(fechaaPago == ""){
                    fechaPago = null;
                }                
                reporteDiarioContabilidad2(request, response, fechaaPago);
                break;
            case 17: //REPORTE TESORERIA - LISTADO DE COBRANZA
                String fechaIni             = request.getParameter("fechaPagoIni");
                String fechaFin             = request.getParameter("fechaPagoFin");
                String idCampFinLisCobr     = request.getParameter("CAMP_FINN");
                String idFormaPagoLisCobr   = request.getParameter("FORMA_PAGO");
                String option               = request.getParameter("TIPO_REPORTE");                 
                if(idFormaPagoLisCobr == "" || idFormaPagoLisCobr == "undefined") idFormaPagoLisCobr = "0";                
                reporteContabilidadMensualDesglosado(request, response, fechaIni, fechaFin, idCampFinLisCobr, idFormaPagoLisCobr, option);
                break;
            case 18: //Reporte mensual asignacion
                String fechaaIni  = request.getParameter("fechaIni");
                String fechaaFin  = request.getParameter("fechaFin");                                
                reporteContabilidadMensualAsignacion(request, response, fechaaIni, fechaaFin);
                break;
             case 19: //Reporte mensual asignacion
                String fechaaaIni  = request.getParameter("fechaIni");
                String fechaaaFin  = request.getParameter("fechaFin");                                
                reporteContabilidadMensualProyecto(request, response, fechaaaIni, fechaaaFin);
                break;
            case 20:
                String fechaaaaIni  = request.getParameter("fechaIni");
                String fechaaaaFin  = request.getParameter("fechaFin");                                
                reporteAyudaPrensa(request, response, fechaaaaIni, fechaaaaFin);
                break;
            case 21: //Lista de los pagos confirmados que se llevara el recolector                
                int idRecolectorr        = Integer.parseInt(request.getParameter("idRecolector"));
                int idZonaa              = Integer.parseInt(request.getParameter("idZona"));//                           
                String fechaVisitaa      = request.getParameter("fechaVisita");
                String fechaCapturaa     = request.getParameter("fechaCaptura");
                int idCampFinn           = Integer.parseInt(request.getParameter("idCampFin"));                
                String nombree           = request.getParameter("nombre");
                if(nombree == "") nombre = null;               
                
                getReporteExtraRecolector(request, response, idZonaa, idRecolectorr, fechaVisitaa, idCampFinn, fechaCapturaa, nombree);
                break;
            default:
                break;
        }
    }

    private void getAllR_totalRegistrosDonantes(HttpServletRequest request, HttpServletResponse response) {
        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonantes(?,?,?,?)");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "1000");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rset = st.executeQuery();
            Util.createExcel(rset, response);
        } catch (Exception ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st, rset);
        }
    }

    private void getAllR_totalRegistrosDonativos(HttpServletRequest request, HttpServletResponse response) {
        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonativos(?,?,?,?)");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "1000");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rset = st.executeQuery();
            Util.createExcel(rset, response);
        } catch (Exception ex) {
            System.out.println("<getAllR_totalRegistrosDonativos>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getAllR_totalRegistrosBitacora(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosBitacora(?,?,?,?)");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "1000");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rset = st.executeQuery();
            Util.createExcel(rset, response);
        } catch (Exception ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getAllReport_Ortografia2(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?,?,?)");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getAllReport_Ortografia2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    //SHCP
    private void getR_aportacionesAnualesSHCP(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_aportacionesAnualesSHCP (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getR_universodeDonantesSHCP(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_SHCPUNIVERSODEDONANTES (?,?,?,?,?)}");


            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getR_deduciblesEmitidosAnoAnteriorSHCP(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_deduciblesEmitidosAnoAnteriorSHCP(?,?,?,?,?)");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getR_universoDonantesAnualesAlfaSHCP(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_SHCPUNIVERSO_DONANTE_ANUAL_ALFA (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getR_institucionesDESHCP(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REP_INSTITUCIONESDESHCP (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    //OPERATIVOS 
    private void getR_OPE_CancelaciondeDonativos(HttpServletRequest request, HttpServletResponse response) {

//        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
//        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
//        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String UsuarioAT = request.getParameter("UsuarioAT");
        String TipoListado = request.getParameter("TipoListado") == null ? "" : request.getParameter("TipoListado");
        String chekbox = request.getParameter("chekbox") == null ? "" : request.getParameter("chekbox");


        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REP_CANCELACION_DONATIVOS (?,?,?,?,?)}");

//            st.setString(1, fechaini);
//            st.setString(2, fechafin);
//            st.setString(3, usuario);
//            st.setString(4, "0");
//            st.setString(5, "1000");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, UsuarioAT);
            st.setString(4, TipoListado);
            st.setString(5, chekbox);

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    //OPERATIVOS menu de movimientos
    private void report_Rep_MYS_RECIBOS_IMPRESOSMES(HttpServletRequest request, HttpServletResponse response) {
        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_IMPRESOSMES (?,?,?,?)}");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "1000");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rset = st.executeQuery();
            Util.createExcel(rset, response);
        } catch (Exception ex) {
            System.out.println("<report_Rep_MYS_RECIBOS_COBRADOS>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_Rep_MYS_RECIBOS_COBRADOS(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_COBRADOS (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_Rep_MYS_RECIBOS_POR_COBRAR(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_POR_COBRAR (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_Rep_MYS_RECIBOS_POR_CONFIRMADO(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_CONFIRMADO (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_Rep_MYS_RECIBOS_POR_EMPRESA(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_EMPRESA (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_Rep_MYS_RECIBOS_POR_TIPODONANTE(HttpServletRequest request, HttpServletResponse response) {
        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_POR_TIPODONANTE (?,?,?,?,?)}");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    //OPERATIVOS DONANTES BIENECHORES
    private void report_Rep_DB_ListadoDonantes_Activos(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_DB_LISTADO_DONANTES_ACTIVOS (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_Rep_DB_ListadoDonantes_Inactivos(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_DB_LISTADO_DONANTES_INACTIVOS (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    //TESORERIA
    private void report_TES_listadoCobranza(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_TES_listadoCobranza (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_TES_concentradocobranza(HttpServletRequest request, HttpServletResponse response) {
        MConnection objConn     = new MConnection();
        Connection conn         = null;//objConn.getConnection();
        PreparedStatement st    = null;
        ResultSet rset          = null;        
        int chkbxProy       = 0;
        int chkbxAsign      = 0;
        String fechaTmp1    = "";
        String fechaTmp2    = "";
        Date fechaTmpUno    = null; 
        Date fechaTmpDos    = null; 
        
        //Parametros
        String fechaini = request.getParameter("FECHA_INI");
        String fechafin = request.getParameter("FECHA_FIN");                            
        String start = request.getParameter("start") == null ? "" : request.getParameter("start");
        String limit = request.getParameter("limit") == null ? "" : request.getParameter("limit");            
        if(request.getParameter("CHKBX_PROY") == null) chkbxProy = 0; else chkbxProy   = Integer.parseInt(request.getParameter("CHKBX_PROY"));            
        if(request.getParameter("CHKBX_ASIGN") == null) chkbxAsign = 0; else chkbxAsign  = Integer.parseInt(request.getParameter("CHKBX_ASIGN"));            
        if(chkbxProy == 0 && chkbxAsign == 0){
            chkbxProy = 0;
            chkbxAsign = 1;
        }
        
        if(fechaini == "") fechaini = null;
        if(fechafin == "") fechafin = null;
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");        
        fechaTmp1                       = formatoDeFecha.format(fechaTmpUno.parse(fechaini));
        fechaTmp2                       = formatoDeFecha.format(fechaTmpDos.parse(fechafin));
        
        try {
            conn=MConnection.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_MENSUAL_ASIGNACION(?,?,?,?)}");
            st.setString(1, fechaTmp1);
            st.setString(2, fechaTmp2);
            st.setInt(3, chkbxProy);
            st.setInt(4, chkbxAsign);
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_TES_rastreoRecibosDeducibles(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_TES_RASTREORECIBOSDEDUCIBLES (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void report_TES_seguimiento(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");
        String usuario = request.getParameter("usuario") == null ? "" : request.getParameter("usuario");

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_TES_SEGUIMIENTO (?,?,?,?,?)}");

            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, "0");
            st.setString(5, "1000");

            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getR_aportacionesAnualesSHCP>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getAllingresos(HttpServletRequest request, HttpServletResponse response) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {

            st = conn.prepareStatement("SELECT * FROM dbo.CAPTURA_INGRESOS ");

            rset = st.executeQuery();
            Util.createExcel(rset, response);



        } catch (Exception ex) {
            System.out.println("<getAllingresos>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void getAllPagos_Confirmados(HttpServletRequest request, HttpServletResponse response, int idZona, int idRecolector, String fechaVisita, int idCampFin, String fechaCaptura, String nombre) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        //PreparedStatement stt = null;
        ResultSet rset = null;
        ResultSet rs = null;
        Date fechaVisitaDos = null;
        Date fechaCapturaDos = null;
        String fechaVisitaaDos = "";
        String fechaCapturaaDos = "";
        Calendar calendario = GregorianCalendar.getInstance();
        Date fecha = calendario.getTime();          
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");

        try {
            if(fechaVisita.equals("null")) fechaVisitaaDos = "01/01/1900"; else fechaVisitaaDos = formatoDeFecha.format(fechaVisitaDos.parse(fechaVisita));
            if(fechaCaptura.equals("null")) fechaCapturaaDos = "01/01/1900"; else fechaCapturaaDos = formatoDeFecha.format(fechaCapturaDos.parse(fechaCaptura));            
                       
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGOS_CONFIRMADOS_GETLIST_EXCEL(?,?,?,?,?,?)}");
            st.setInt(1, idZona);
            st.setInt(2, idRecolector);            
            st.setInt(3, idCampFin);            
            st.setString(4, nombre);            
            st.setString(5, fechaVisitaaDos);            
            st.setString(6, fechaCapturaaDos);
            rset = st.executeQuery();
            Util.createExcel_reporteDiarioRecoletoresOficial(rset, response, fechaVisitaaDos);           

        } catch (Exception ex) {
            System.out.println("getAllPagos_Confirmados | " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    private void getReporteExtraRecolector(HttpServletRequest request, HttpServletResponse response, int idZona, int idRecolector, String fechaVisita, int idCampFin, String fechaCaptura, String nombre) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        PreparedStatement stt = null;
        ResultSet rset = null;
        ResultSet rs = null;
        Date fechaVisitaDos = null;
        Date fechaCapturaDos = null;
        String fechaVisitaaDos = "";
        String fechaCapturaaDos = "";
        Calendar calendario = GregorianCalendar.getInstance();
        Date fecha = calendario.getTime();          
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");

        try {
            conn=MConnection.getConnection();
            if(fechaVisita.equals("null")) fechaVisitaaDos = "01/01/1900"; else fechaVisitaaDos = formatoDeFecha.format(fechaVisitaDos.parse(fechaVisita));
            if(fechaCaptura.equals("null")) fechaCapturaaDos = "01/01/1900"; else fechaCapturaaDos = formatoDeFecha.format(fechaCapturaDos.parse(fechaCaptura));            
                       
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGOS_CONFIRMADOS_GETLIST_EXCEL_REPORTE_EXTRA(?,?,?,?,?,?)}");
            st.setInt(1, idZona);
            st.setInt(2, idRecolector);            
            st.setInt(3, idCampFin);            
            st.setString(4, nombre);            
            st.setString(5, fechaVisitaaDos);            
            st.setString(6, fechaCapturaaDos);
            rset = st.executeQuery();
            Util.createExcel_reporteDiarioRecoletoresExtra(rset, response, fechaVisitaaDos);           

        } catch (Exception ex) {
            System.out.println("getAllPagos_Confirmados | " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }

    private void ingresosCobrosEfectivo(HttpServletRequest request, HttpServletResponse response) {

        String fechaini = request.getParameter("fechaini") == null ? "" : request.getParameter("fechaini");
        String fechafin = request.getParameter("fechafin") == null ? "" : request.getParameter("fechafin");

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;

        try {
            //st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonantes(?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GET_PAGOS_CONFIRMADOS}");
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    private void reporteDiarioContabilidad(HttpServletRequest request, HttpServletResponse response, String fechaPago) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        String fechaTmp = "";
        Date fechaTmpDos = null; 
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");
        
        fechaTmp = formatoDeFecha.format(fechaTmpDos.parse(fechaPago));

        try {
            conn=MConnection.getConnection();
            //st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonantes(?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_DIARIO_DESGLOSE_EXCEL(?)}");
            st.setString(1, fechaTmp);
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<reporteDiarioContabilidad> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    private void reporteDiarioContabilidad2(HttpServletRequest request, HttpServletResponse response, String fechaPago) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        String fechaTmp = "";
        Date fechaTmpDos = null; 
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");
        
        fechaTmp = formatoDeFecha.format(fechaTmpDos.parse(fechaPago));

        try {
            conn=MConnection.getConnection();
            //st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonantes(?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_DIARIO_DESGLOSE_ESPECIE(?)}");
            st.setString(1, fechaTmp);
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<reporteDiarioContabilidad> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    private void reporteContabilidadMensualDesglosado(HttpServletRequest request, HttpServletResponse response, String fechaIni, String fechaFin, String idCampFin, String idFormaPago, String option) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        String fechaIniTmp = "";
        String fechaFinTmp = "";
        Date fechaTmpDos = null; 
        Date fechaTmpFin = null;
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");
        
        fechaIniTmp = formatoDeFecha.format(fechaTmpDos.parse(fechaIni));
        fechaFinTmp = formatoDeFecha.format(fechaTmpFin.parse(fechaFin));                             
        
        try {    
            conn=MConnection.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_TESORERIA_LISTADO_DE_COBRANZA_EXCEL(?,?,?,?,?)}");
            st.setString(1, fechaIniTmp);
            st.setString(2, fechaFinTmp);
            st.setString(3, idCampFin);
            st.setString(4, idFormaPago);
            st.setString(5, option);
            rset = st.executeQuery();
            Util.createExcel_repListadoCobranza(rset, response, fechaIniTmp, fechaFinTmp);

        } catch (Exception ex) {
            System.out.println("<reporteDiarioContabilidad> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    private void reporteContabilidadMensualAsignacion(HttpServletRequest request, HttpServletResponse response, String fechaIni, String fechaFin) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        String fechaIniTmp = "";
        String fechaFinTmp = "";
        Date fechaTmpDos = null; 
        Date fechaTmpFin = null;
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");
        
        fechaIniTmp = formatoDeFecha.format(fechaTmpDos.parse(fechaIni));
        fechaFinTmp = formatoDeFecha.format(fechaTmpFin.parse(fechaFin));

        try {    
            conn=MConnection.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_MENSUAL_ASIGNACION(?,?)}");
            st.setString(1, fechaIniTmp);
            st.setString(2, fechaFinTmp);
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<reporteDiarioContabilidad> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rset);
        }
    }

    private void reporteContabilidadMensualProyecto(HttpServletRequest request, HttpServletResponse response, String fechaIni, String fechaFin) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        String fechaIniTmp = "";
        String fechaFinTmp = "";
        Date fechaTmpDos = null; 
        Date fechaTmpFin = null;
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");
        
        fechaIniTmp = formatoDeFecha.format(fechaTmpDos.parse(fechaIni));
        fechaFinTmp = formatoDeFecha.format(fechaTmpFin.parse(fechaFin));

        try {         
            conn=MConnection.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_MENSUAL_PROYECTO(?,?)}");
            st.setString(1, fechaIniTmp);
            st.setString(2, fechaFinTmp);
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<reporteDiarioContabilidad> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    private void reporteAyudaPrensa(HttpServletRequest request, HttpServletResponse response, String fechaInicial, String fechaFin) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = null;//objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rset = null;
        String fechaTmp1 = "";
        String fechaTmp2 = "";
        Date fechaTmpUno = null;
        Date fechaTmpDos = null; 
        SimpleDateFormat formatoDeFecha = new SimpleDateFormat("dd/MM/yyyy");
        
        fechaTmp1 = formatoDeFecha.format(fechaTmpUno.parse(fechaInicial));
        fechaTmp2 = formatoDeFecha.format(fechaTmpDos.parse(fechaFin));

        try {
            conn=MConnection.getConnection();
            //st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonantes(?,?,?,?)");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_AYUDA_PRENSA_EXCEL(?,?)}");
            st.setString(1, fechaTmp1);
            st.setString(2, fechaTmp2);
            rset = st.executeQuery();
            Util.createExcel(rset, response);

        } catch (Exception ex) {
            System.out.println("<reporteDiarioContabilidad> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rset);
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
}

