package com.caritas.bl;

import com.caritas.action.reportesAC;
import com.caritas.utils.MConnection;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.*;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class reporteBL {
    
    /* ------------------------------------------ REPORTES DE TESORERIA ----------------------------------------------------------------- */
    public static String reporte_TESORERIA_ListadoDeCobranza(String fechaPagoIni, String fechaPagoFin, String idCampFin, String idFormaPago, String start, String limit, String option) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_TESORERIA_LISTADO_DE_COBRANZA(?,?,?,?,?,?,?)}");
            st.setString(1, fechaPagoIni);
            st.setString(2, fechaPagoFin);
            st.setString(3, idCampFin);
            st.setString(4, idFormaPago);
            st.setString(5, start);
            st.setString(6, limit);
            st.setString(7, option);
            rs = st.executeQuery();            
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ROWNUMBER", rs.getInt("ROWNUMBER"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("PROYECTO", rs.getString("PROYECTO"));
                dato.put("NUM_FRECUENCIA", rs.getString("NUM_FRECUENCIA"));                
                dato.put("FECHA_VENCIMIENTO", rs.getString("FECHA_VENCIMIENTO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("IMPORTE", rs.getDouble("IMPORTE"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("CUENTA", rs.getString("CUENTA"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("RECOLECTOR", rs.getString("RECOLECTOR"));
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);            
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_TESORERIA_LISTADO_DE_COBRANZA_PAGINADO(?,?,?,?,?)}");
            st.setString(1, fechaPagoIni);
            st.setString(2, fechaPagoFin);
            st.setString(3, idCampFin);
            st.setString(4, idFormaPago);
            st.setString(5, option);
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }            

        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);         
            resp = respuesta.toString();
        }
        return resp;
    }
       
    public static String reporte_TESORERIA_ConcentradoDeCobranza(String fechaini, String fechafin, int chkbxProy, int chkbxAsign) {
        String resp             = "";
        MConnection objConn     = new MConnection();
        Connection conn         = objConn.getConnection();
        PreparedStatement st    = null;
        ResultSet rs            = null;
        JSONObject respuesta    = new JSONObject();
        JSONArray datos         = new JSONArray();
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_MENSUAL_ASIGNACION(?,?,?,?)}");
            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setInt(3, chkbxProy);
            st.setInt(4, chkbxAsign);                        
            rs = st.executeQuery();
            
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("CANTIDAD", rs.getInt("CANTIDAD"));
                dato.put("IMPORTE", rs.getDouble("IMPORTE"));                
                datos.put(dato);
            }
            respuesta.put("rows", datos);

        } catch (SQLException ex) {
            System.out.println("<report_TES_concentradocobranza1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_TES_concentradocobranza2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);            
            resp = respuesta.toString();
        }
        return resp;
    }
  
    public static String reporte_TESORERIA_recibosImpresos(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_TES_RASTREORECIBOSDEDUCIBLES (?,?,?,?,?)}");
            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);            
            rs = st.executeQuery();            
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ROWNUMBER", rs.getInt("ROWNUMBER"));
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_NUM_PAGO", rs.getInt("ID_NUM_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("RECOLECTOR", rs.getString("RECOLECTOR"));
                dato.put("ID_RECOLECTOR", rs.getInt("ID_RECOLECTOR"));
                dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("USUARIO_IMPRESO", rs.getString("USUARIO_IMPRESO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);

        } catch (SQLException ex) {
            System.out.println("<report_TES_listadoCobranza1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_TES_listadoCobranza2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);          
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public static String reporte_TESORERIA_seguimiento(String fechaini, String fechafin, String idCampFin, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {           
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_TESORERIA_SEGUIMIENTO(?,?,?,?,?)}");
            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, idCampFin);
            st.setString(4, start);
            st.setString(5, limit);            
            rs = st.executeQuery();           
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("STATUS_RECIBO", rs.getString("STATUS_RECIBO"));
                dato.put("CAMP_FIN", rs.getString("CAMP_FIN"));
                dato.put("CATEGORIA", rs.getString("CATEGORIA"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("USUARIO", rs.getString("USUARIO"));
                dato.put("NUM_CASO", rs.getInt("NUM_CASO"));
                dato.put("DIRECCION", rs.getString("DIRECCION"));                
                datos.put(dato);
                
            }
            respuesta.put("rows", datos);
            
//            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_TESORERIA_SEGUIMIENTO(?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini);
//            st.setString(2, fechafin);
//            st.setString(3, usuario);
//            st.setString(4, start);
//            st.setString(5, limit);            
//            rs = st.executeQuery();
//            if(rs.next()){
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
            
        } catch (SQLException ex) {
            System.out.println("<report_TES_listadoCobranza1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_TES_listadoCobranza2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);         
            resp = respuesta.toString();
        }
        return resp;
    }   
    
    /* ------------------------------------------ REPORTES DE OPERACION ----------------------------------------------------------------- */
    
    
    
    
    
    
    
    /* ------------------------------------------ REPORTES DE OPERACION [MONITOREO Y SUPERVISIÓN] ----------------------------------------------------------------- */
    
    
    
    
    
    
    /* ------------------------------------------ REPORTES DE OPERACIÓN [DONANTES O BENEFACTORES] ----------------------------------------------------------------- */
    
    
    
    
    
    
    
    
    /* ------------------------------------------ REPORTES DE SHCP ----------------------------------------------------------------- */
    
    
    public static String getExpediente() {
        String path = "C:\\Media\\web\\plantillas\\";
        String[] arrFiles;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        File file = new File(path);
        arrFiles = file.list();
        try {
            for (String fileIterator : arrFiles) {
                JSONObject dato = new JSONObject();
                dato.put("nombre_archivo", fileIterator);
                dato.put("ruta_archivo", fileIterator);
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return respuesta.toString();
    }

    public static String getAllR_totalRegistrosDonantes(String fechaini, String fechafin) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        System.out.println("entrando el BL");
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonantes(?,?,?,?)");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "250");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("CANTIDAD_DONANTES", rs.getInt("CANTIDAD_REGISTROS"));
//                dato.put("USUARIO", rs.getString("USUARIO")+" ("+rs.getInt("CANTIDAD_REGISTROS")+")");//pARA AGREGARLE LA CANTIDAD CON EL NOMBRE
                dato.put("USUARIO", rs.getString("USUARIO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllR_totalRegistrosDonantes" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getAllR_totalRegistrosDonativos(String fechaini, String fechafin) {
        //System.err.println("");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        System.out.println("entrando el BL");
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosDonativos(?,?,?,?)");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "250");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                //el put es el enlace de el data del JSP del Grid // el int es el que resibe la informacion de la funcion o store
                dato.put("CANTIDAD_DONATIVOS", rs.getInt("CANTIDAD_REGISTROS"));
//                dato.put("USUARIO", rs.getString("USUARIO")+" ("+rs.getInt("CANTIDAD_REGISTROS")+")");//pARA AGREGARLE LA CANTIDAD CON EL NOMBRE
                dato.put("USUARIO", rs.getString("USUARIO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllR_totalRegistrosDonantes" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getAllR_totalRegistrosBitacora(String fechaini, String fechafin) {
        //System.err.println("");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        System.out.println("entrando el BL");
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_totalRegistrosBitacora(?,?,?,?)");
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, "0");
            st.setString(4, "250");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("CANTIDAD_BITACORAS", rs.getInt("CANTIDAD_REGISTROS"));
//                dato.put("USUARIO", rs.getString("USUARIO")+" ("+rs.getInt("CANTIDAD_REGISTROS")+")");//pARA AGREGARLE LA CANTIDAD CON EL NOMBRE
                dato.put("USUARIO", rs.getString("USUARIO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllR_totalRegistrosDonantes" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getAllReport_Ortografia2(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_ALTA", rs.getString("FECHA_ALTA"));
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
//                System.out.println("Resultado de Nombre Donante"+rs.getString("NOMBRE_DONANTE"));
                dato.put("USUARIO_DONANTE", rs.getString("USUARIO_DONANTE"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ENTRE_CALLES", rs.getString("ENTRE_CALLES"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //SHCP
    //SHCPaportacionesAnuales_1
    public static String getR_aportacionesAnualesSHCP(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_aportacionesAnualesSHCP (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);            
            rs = st.executeQuery();
            
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("NUM_FRECUENCIA", rs.getString("NUM_FRECUENCIA"));
                dato.put("IMPORTE", rs.getString("IMPORTE"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_Rep_aportacionesAnualesSHCP (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);            
            rs = st.executeQuery();
            if (rs.next()) {
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //SHCPuniversodeDonantes_2
    public static String getR_universodeDonantesSHCP(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_SHCPUNIVERSODEDONANTES (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_universodeDonantesSHCP(?,?,?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);

            System.out.println("Mostrando el Resultado de  ST:" + st);


            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                dato.put("NUM_FRECUENCIA", rs.getString("NUM_FRECUENCIA"));
                dato.put("IMPORTE", rs.getString("IMPORTE"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);

//            //Metodos para la paginacion
////            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);
//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();
//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //SHCPdeduciblesEmitidosAnoAnterior_3
    public static String getR_deduciblesEmitidosAnoAnteriorSHCP(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_deduciblesEmitidosAnoAnteriorSHCP(?,?,?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            rs = st.executeQuery();

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_CREACION", rs.getString("FECHA_CREACION"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                dato.put("ID_TIPO_DONATIVO", rs.getString("ID_TIPO_DONATIVO"));
                dato.put("IMPORTE", rs.getString("IMPORTE"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_deduciblesEmitidosAnoAnteriorSHCP(?,?,?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);
//            st.setString(4, start);
//            st.setString(5, limit);
//            rs = st.executeQuery();
//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //SHCPuniversoDonantesAnualesAlfa_4
    public static String getR_universoDonantesAnualesAlfaSHCP(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_SHCPUNIVERSO_DONANTE_ANUAL_ALFA (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].R_universodeDonantesSHCP(?,?,?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);

            System.out.println("Mostrando el Resultado de  ST:" + st);


            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                dato.put("NUM_FRECUENCIA", rs.getString("NUM_FRECUENCIA"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
                dato.put("IMPORTE", rs.getString("IMPORTE"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);

//            //Metodos para la paginacion
//
////            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);
//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();
//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //SHCPinstitucionesDE_5
    public static String getR_institucionesDESHCP(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REP_INSTITUCIONESDESHCP (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);

            System.out.println("Mostrando el Resultado de  ST:" + st);


            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
                dato.put("TIPO_INSTITUCION", rs.getString("TIPO_INSTITUCION"));
                dato.put("IMPORTE", rs.getString("IMPORTE"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);

//            //Metodos para la paginacion
//
////            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);
//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();
//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

                                                            //OPERATIVOS
    //OPE_CancelaciondeDonativos_1
    public static String getR_OPE_CancelaciondeDonativos(String fechaini, String fechafin, String UsuarioAT, String TipoListado, String chekbox, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REP_CANCELACION_DONATIVOS (?,?,?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, UsuarioAT);
            st.setString(4, TipoListado);
            st.setString(5, chekbox);
            st.setString(6, start);
            st.setString(7, limit);
            rs = st.executeQuery();

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("DONANTE", rs.getString("DONANTE"));
                dato.put("ID_DONATIVO", rs.getString("ID_DONATIVO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("IMPORTE", rs.getString("IMPORTE"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("COMENTARIOS_CANCELACION", rs.getString("COMENTARIOS_CANCELACION"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_REP_CANCELACION_DONATIVOS(?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini);
            st.setString(2, fechafin);
            st.setString(3, UsuarioAT);
            st.setString(4, TipoListado);
            st.setString(5, chekbox);
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }

        } catch (SQLException ex) {
            System.out.println("<getR_OPE_CancelaciondeDonativos>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getR_OPE_CancelaciondeDonativos>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getR_OPE_CancelaciondeDonativos >>> " + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //REPORT DEL MENU DE MONITOREO Y SUPERVISION
    //Rep_MYS_RECIBOS_IMPRESOSMES_1
    public static String report_Rep_MYS_RECIBOS_IMPRESOSMES(String fechaini, String fechafin) {
        //System.err.println("");
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        System.out.println("entrando el BL");
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_IMPRESOSMES (?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(4, start);
//            st.setString(5, limit);
            st.setString(3, "0");
            st.setString(4, "1000");
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_FORMA_PAGO", rs.getString("ID_FORMA_PAGO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getString("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getString("ID_ASIGNACION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllR_totalRegistrosDonantes>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllR_totalRegistrosDonantes" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //Rep_MYS_RECIBOS_COBRADOS_2 
    public static String report_Rep_MYS_RECIBOS_COBRADOS(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_COBRADOS (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_FORMA_PAGO", rs.getString("ID_FORMA_PAGO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getString("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getString("ID_ASIGNACION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //Rep_MYS_RECIBOS_POR_COBRAR_3
    public static String report_Rep_MYS_RECIBOS_POR_COBRAR(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_POR_COBRAR (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_FORMA_PAGO", rs.getString("ID_FORMA_PAGO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getString("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getString("ID_ASIGNACION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }
    
    //Rep_MYS_RECIBOS_POR_CONFIRMADO_4
    public static String report_Rep_MYS_RECIBOS_POR_CONFIRMADO(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_CONFIRMADO (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_FORMA_PAGO", rs.getString("ID_FORMA_PAGO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getString("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getString("ID_ASIGNACION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<report_Rep_MYS_RECIBOS_POR_CONFIRMADO>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_Rep_MYS_RECIBOS_POR_CONFIRMADO>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.report_Rep_MYS_RECIBOS_POR_CONFIRMADO" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }
    
    //Rep_MYS_RECIBOS_POR_EMPRESA_5
    public static String report_Rep_MYS_RECIBOS_POR_EMPRESA(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_EMPRESA (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_FORMA_PAGO", rs.getString("ID_FORMA_PAGO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getString("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getString("ID_ASIGNACION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<report_Rep_MYS_RECIBOS_POR_CONFIRMADO>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_Rep_MYS_RECIBOS_POR_CONFIRMADO>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.report_Rep_MYS_RECIBOS_POR_CONFIRMADO" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //Rep_MYS_RECIBOS_POR_TIPODONANTE_6
    public static String report_Rep_MYS_RECIBOS_POR_TIPODONANTE(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_MYS_RECIBOS_POR_TIPODONANTE (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);


            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
//               dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_FORMA_PAGO", rs.getString("ID_FORMA_PAGO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getString("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getString("ID_ASIGNACION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<report_TES_concentradocobranza1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_TES_concentradocobranza2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.report_TES_concentradocobranza4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //Rep_DB_ListadoDonantes_Activos
    public static String report_Rep_DB_ListadoDonantes_Activos(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_DB_LISTADO_DONANTES_ACTIVOS (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("TIPO_FRECUENCIA", rs.getString("TIPO_FRECUENCIA"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
//                System.out.println("Resultado de Nombre Donante"+rs.getString("NOMBRE_DONANTE"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("CAMPANA_FINANCIERA", rs.getString("CAMPANA_FINANCIERA"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<report_TES_concentradocobranza1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_TES_concentradocobranza2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.report_TES_concentradocobranza4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //Rep_DB_ListadoDonantes_Inactivos_2
    public static String report_Rep_DB_ListadoDonantes_Inactivos(String fechaini, String fechafin, String usuario, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_DB_LISTADO_DONANTES_INACTIVOS (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            System.out.println("datos.fechaini" + fechaini);
            System.out.println("datos.fechafin" + fechafin);
            System.out.println("datos.usuario" + usuario);
            System.out.println("Mostrando el Resultado de  ST:" + st);
            rs = st.executeQuery();
            System.out.println("Mostrando el Resultado de RS:" + rs);
            System.out.println(rs.next());
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("TIPO_FRECUENCIA", rs.getString("TIPO_FRECUENCIA"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
//                System.out.println("Resultado de Nombre Donante"+rs.getString("NOMBRE_DONANTE"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("CAMPANA_FINANCIERA", rs.getString("CAMPANA_FINANCIERA"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
//            //Metodos para la paginacion
//            st = conn.prepareStatement("select * from [db_Caritas].[dbo].ReportePaginacionAtencionestotalcount(?,?,?)");
//            st = conn.prepareStatement("select * from [DB_INGRESOS].[dbo].Rep_Ortografia(?,?,?)");//Para poner parametros y usar una funcion para ahorrar codigo.
//            st.setString(1, fechaini + " 00:00:00.000");
//            st.setString(2, fechafin + " 23:59:59.999");
//            st.setString(3, usuario);

//            System.out.println("datos.fechaini" + fechaini);
//            System.out.println("datos.fechafin" + fechafin);
//            System.out.println("datos.usuario" + usuario);
//            rs = st.executeQuery();

//            if (rs.next()) {
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }
        } catch (SQLException ex) {
            System.out.println("<report_TES_concentradocobranza1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<report_TES_concentradocobranza2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.report_TES_concentradocobranza4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //OPE_reProspectar_5
    public static String report_OPE_reProspectar(String fechaini, String fechafin, String usuario, String start, String limit) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_OPE_REPROSPECTAR (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            rs = st.executeQuery();

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("ID_TITULO", rs.getString("ID_TITULO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("MUNICIPIO", rs.getString("MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("TEL_OFICINA", rs.getString("TEL_OFICINA"));
                dato.put("TEL_MOVIL", rs.getString("TEL_MOVIL"));
                dato.put("EMAIL", rs.getString("EMAIL"));
                dato.put("ID_TIPO_DONATIVO", rs.getString("ID_TIPO_DONATIVO"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_Rep_OPE_REPROSPECTAR(?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }

        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    //OPE_agradecimiento_6
    public static String report_OPE_agradecimiento(String fechaini, String fechafin, String usuario, String start, String limit) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].Rep_OPE_AGRADECIMIENTO (?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            rs = st.executeQuery();

            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("ID_TITULO", rs.getString("ID_TITULO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("TEL_OFICINA", rs.getString("TEL_OFICINA"));
                dato.put("TEL_MOVIL", rs.getString("TEL_MOVIL"));
                dato.put("EMAIL", rs.getString("EMAIL"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getString("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_Rep_OPE_AGRADECIMIENTO(?,?,?,?,?)}");//Para poner parametros y usar una funcion para ahorrar codigo.
            st.setString(1, fechaini + " 00:00:00.000");
            st.setString(2, fechafin + " 23:59:59.999");
            st.setString(3, usuario);
            st.setString(4, start);
            st.setString(5, limit);
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }


        } catch (SQLException ex) {
            System.out.println("<getAllreporteAtenciones1>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<getAllreporteAtenciones2>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            MConnection.closeAll(conn, st,rs);
            System.out.println("datos.getAllreporteAtenciones4" + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

  
    public String reportAyudaPrensa(String fechaPagoIni, String fechaPagoFin, String start, String limit) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_AYUDA_PRENSA(?,?,?,?)}");
            st.setString(1, fechaPagoIni);
            st.setString(2, fechaPagoFin);
            st.setString(3, start);
            st.setString(4, limit);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ESTATUS", rs.getString("ESTATUS"));
                dato.put("FECHA_ALTA", rs.getString("FECHA_ALTA"));
                dato.put("CAMP_FINANCIERA", rs.getString("CAMP_FINANCIERA"));                
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("NUM_CASO", rs.getInt("NUM_CASO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));                
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_REPORTE_AYUDA_PRENSA(?,?)}");
            st.setString(1, fechaPagoIni);
            st.setString(2, fechaPagoFin);            
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }

        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            MConnection.closeAll(conn, st,rs);         
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public String reportIngresoMensual(String fechaIni, String fechaFin, String start, String limit) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_INGRESO_MENSUAL(?,?)}");
            st.setString(1, fechaIni);
            st.setString(2, fechaFin);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("TARJETA_CREDITO", rs.getDouble("TARJETA_CREDITO"));
                dato.put("TARJETA_DEBITO", rs.getDouble("TARJETA_DEBITO"));
                dato.put("TRANSFERENCIA", rs.getDouble("TRANSFERENCIA"));
                dato.put("DEPOSITO", rs.getDouble("DEPOSITO"));                
                dato.put("CHEQUE", rs.getDouble("CHEQUE"));
                dato.put("EFECTIVO", rs.getDouble("EFECTIVO"));
                dato.put("NO_ESPECIFICADO", rs.getDouble("NO_ESPECIFICADO"));                             
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            MConnection.closeAll(conn, st,rs);         
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public byte[] generarInformeListA(String fechainicial, String fechafinal, String ruta) {
        byte[] pdf = null;
        HashMap<String, Object> parametros = new HashMap<String, Object>();
        
        parametros.put("FECHAINICIAL", fechainicial);
        parametros.put("FECHAFINAL", fechafinal);
        System.out.println("BLfechaini  :::: " + fechainicial);
        System.out.println("BL fechafin  :::: " + fechafinal);
        
        MConnection objConn = new MConnection();
        Connection conn = null;
        conn = objConn.getConnection();
        try {
            ruta = ((reportesAC.class.getResource(ruta)).toString().replace("file:/", "").replace("%20", " "));
            System.out.println("RUTA:" + ruta);
            File reportFile = new File(ruta);
            if (!reportFile.exists()) {
                System.out.println("File x.jasper not found. The report design must be compiled first.");
                throw new JRRuntimeException("File x.jasper not found. The report design must be compiled first.");
            }
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportFile.getPath());
            pdf = JasperRunManager.runReportToPdf(jasperReport, parametros, conn);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            MConnection.closeAll(conn, null,null);
        }
        return pdf;
    }

    public void metodoImprimirListA(byte[] informePDF) {
        PrintService service = PrintServiceLookup.lookupDefaultPrintService();
        DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
        DocPrintJob pj = service.createPrintJob();
        Doc doc = new SimpleDoc(informePDF, flavor, null);
        System.out.println(" va a imprimir.. . . .");
        try {
            pj.print(doc, null);
            System.out.println(" fin del proceso de impresion... ");
        } catch (PrintException e) {
            System.out.println("Error al imprimir: " + e.getMessage());
        }
    }
}
