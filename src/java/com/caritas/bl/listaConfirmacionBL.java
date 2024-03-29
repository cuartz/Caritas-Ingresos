package com.caritas.bl;

import com.caritas.action.listaConfirmacionAC;
import com.caritas.utils.MConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.print.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.jpedal.PdfDecoder;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.PrinterJob;
import javax.print.PrintService;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;
import java.io.File;
import java.util.HashMap;

public class listaConfirmacionBL {

    public static String getAllzonas() {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT * FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES A INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS B ON A.ID_CATALOG=B.ID WHERE B.LLAVE='INGRESOS_ZONAS'");
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID", rs.getInt("ID"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;
    }

    public String getAllDonativos(String strQuery, String idUsuario, String fechaCobro, int idZona, int numCaso, int idCampFin, String fechaAltaCF, String nombreDonante, int idFormaPago, String start, String limit, int idFormaPago2, int idCampFin2, int idClasificacion2, int personalmente, int especial) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVOS_LIST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            st.setString(1, idUsuario);            
            st.setString(2, fechaCobro);            
            st.setInt(3, idZona);
            st.setInt(4, numCaso);
            st.setInt(5, idCampFin);
            st.setString(6, fechaAltaCF);
            st.setString(7, nombreDonante);
            st.setInt(8, idFormaPago);
            st.setString(9, start);
            st.setString(10, limit);
            st.setInt(11, idFormaPago2);
            st.setInt(12, idCampFin2);
            st.setInt(13, idClasificacion2);
            st.setInt(14, personalmente);
            st.setInt(15, especial);
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("NUM_PAGO", rs.getInt("NUM_PAGO"));
                dato.put("ESTATUS_PAGO", rs.getInt("ESTATUS_PAGO"));
                dato.put("ESTATUS_PAGO_DESC", rs.getString("ESTATUS_PAGO_DESC"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("IMPORTE", rs.getDouble("IMPORTE"));
                dato.put("ID_TIPO_ENVIO", rs.getInt("ID_TIPO_ENVIO"));
                dato.put("TIPO_ENVIO", rs.getString("TIPO_ENVIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("TEL_CEL", rs.getString("TEL_CEL"));
                dato.put("TEL_OFICINA", rs.getString("TEL_OFICINA"));
                dato.put("DATOS_CLAVE", rs.getString("DATOS_CLAVE"));
                dato.put("FECHA_ALTA_RECIBO", rs.getString("FECHA_ALTA_RECIBO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_DONATIVOS_LIST(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            st.setString(1, idUsuario);            
            st.setString(2, fechaCobro);
            st.setInt(3, idZona);
            st.setInt(4, numCaso);
            st.setInt(5, idCampFin);
            st.setString(6, fechaAltaCF);
            st.setString(7, nombreDonante);
            st.setInt(8, idFormaPago);
            st.setString(9, start);
            st.setString(10, limit);
            st.setInt(11, idFormaPago2);
            st.setInt(12, idCampFin2);
            st.setInt(13, idClasificacion2);
            st.setInt(14, personalmente);
            st.setInt(15, especial);
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

    public String getAllCobrosConfirmados(int idRecolector, String fechaVisita, int idZona, int idCampFin, String fechaAltaCF, String nombreDonante, String idRecibo, String start, String limit, int idFormaPago2, int idCampFin2, int idClasificacion2, int personalmente, int especial) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGOS_CONFIRMADOS_GETLIST(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona);
            st.setInt(4, idCampFin);
            st.setString(5, fechaAltaCF);
            st.setString(6, nombreDonante);
            st.setString(7, idRecibo);
            st.setString(8, start);
            st.setString(9, limit);
            st.setInt(10, idFormaPago2);
            st.setInt(11, idCampFin2);
            st.setInt(12, idClasificacion2);
            st.setInt(13, personalmente);
            st.setInt(14, especial);            
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                    dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                    dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                    dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                    dato.put("NOMBRE", rs.getString("NOMBRE"));
                    dato.put("NUM_PAGO", rs.getInt("NUM_PAGO"));
                    dato.put("IMPORTE", rs.getDouble("IMPORTE"));
                    dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                    dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                    dato.put("DIRECCION", rs.getString("DIRECCION"));
                    dato.put("ID_ESTATUS_PAGO_TMP", rs.getInt("ID_ESTATUS_PAGO_TMP"));
                    dato.put("ESTATUS_PAGO", rs.getString("ESTATUS_PAGO"));
                    dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                    dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO")); 
                    dato.put("REFERENCIA", rs.getString("REFERENCIA"));
                    dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));
                    dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                    dato.put("STATUS_IMPRESO", rs.getString("STATUS_IMPRESO"));
                    dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                    dato.put("ID_RECOLECTOR", rs.getString("ID_RECOLECTOR"));
                    dato.put("ID_ZONA", rs.getInt("ID_ZONA"));
                    dato.put("USUARIO_CONFIRMACION", rs.getString("USUARIO_CONFIRMACION"));
                    datos.put(dato);                
                }
                respuesta.put("rows", datos);                 
               
                st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_PAGOS_CONFIRMADOS_GETLIST(?,?,?,?,?,?,?,?)}");
                st.setInt(1, idRecolector);
                st.setString(2, fechaVisita);
                st.setInt(3, idZona);
                st.setInt(4, idCampFin);
                st.setString(5, fechaAltaCF);
                st.setString(6, nombreDonante);
                st.setString(7, start);
                st.setString(8, limit);
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

    public String getDonativosParaConfirmacionMasiva(String strQuery, String fechaCobroIni, String fechaCobroFin, int idCampFin, String start, String limit, int idZona) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_RECIBOS_POR_CAMPANA_FINANCIERA_PARA_CONFIRMACION_MASIVA(?,?,?,?,?,?)}");                       
            st.setString(1, fechaCobroIni);            
            st.setString(2, fechaCobroFin);
            st.setInt(3, idCampFin);            
            st.setString(4, start);
            st.setString(5, limit);
            st.setInt(6, idZona);            
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                //dato.put("totalcount", rs.getInt("totalcount"));
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("NUM_PAGO", rs.getInt("NUM_PAGO"));
                dato.put("ESTATUS_PAGO", rs.getInt("ESTATUS_PAGO"));
                dato.put("ESTATUS_PAGO_DESC", rs.getString("ESTATUS_PAGO_DESC"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("ID_TIPO_ENVIO", rs.getInt("ID_TIPO_ENVIO"));
                dato.put("TIPO_ENVIO", rs.getString("TIPO_ENVIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("TEL_CEL", rs.getString("TEL_CEL"));
                dato.put("TEL_OFICINA", rs.getString("TEL_OFICINA"));
                dato.put("DATOS_CLAVE", rs.getString("DATOS_CLAVE"));
                dato.put("ID_ZONA", rs.getInt("ID_ZONA"));
                dato.put("DIRECCION", rs.getString("DIRECCION"));
                dato.put("FECHA_ALTA_RECIBO", rs.getString("FECHA_ALTA_RECIBO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
//            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_DONATIVOS_LIST(?,?,?,?,?,?,?,?,?,?)}");
//            st.setString(1, idUsuario);            
//            st.setString(2, fechaCobro);
//            st.setInt(3, idZona);
//            st.setInt(4, numCaso);
//            st.setInt(5, idCampFin);
//            st.setString(6, fechaAltaCF);
//            st.setString(7, nombreDonante);
//            st.setInt(8, idFormaPago);
//            st.setString(9, start);
//            st.setString(10, limit);
//            rs = st.executeQuery();
//            if(rs.next()){
//                respuesta.put("totalcount", rs.getString("TOTAL"));
//            }

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
    
    public String getDonativosPagosReprogramados(String nombre, int idZona, String start, String limit) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();        
        
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVOS_LISTA_PAGOS_REPROGRAMADOS(?,?,?,?)}");            
            st.setString(1, nombre);
            st.setInt(2, idZona);
            st.setString(3, start);
            st.setString(4, limit);
            
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();                
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ESTATUS_PAGO_TMP", rs.getInt("ESTATUS_PAGO_TMP"));
                dato.put("ESTATUS", rs.getString("ESTATUS"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("ID_NUM_PAGO", rs.getInt("ID_NUM_PAGO"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                dato.put("TEL_CASA", rs.getInt("TEL_CASA"));
                dato.put("TEL_MOVIL", rs.getInt("TEL_MOVIL"));
                dato.put("TEL_OFICINA", rs.getInt("TEL_OFICINA"));
                dato.put("COMENTARIOS_REPROGRAMAR", rs.getString("COMENTARIOS_REPROGRAMAR"));
                dato.put("FECHA_REPROGRAMACION", rs.getString("FECHA_REPROGRAMACION"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_DONATIVOS_LISTA_PAGOS_REPROGRAMADOS(?,?)}");           
            st.setString(1, nombre);
            st.setInt(2, idZona);                 
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
    
    public String getAllRecibosPorEntregar() {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].RECIBOS_PARA_ENTREGAR_GETLIST}");

            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("NUM_PAGO", rs.getInt("NUM_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("ESTATUS_PAGO", rs.getString("ESTATUS_PAGO"));
                dato.put("ID_TIPO_ENVIO", rs.getInt("ID_TIPO_ENVIO"));
                dato.put("TIPO_ENVIO", rs.getString("TIPO_ENVIO"));
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                dato.put("DIRECCION", rs.getString("DIRECCION"));
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

    public String generarInforme(int[] id_solicitud, String ruta) {
        String salida = "";
        CaritasImprimeReciboNoDeducible imprime= new CaritasImprimeReciboNoDeducible();        
        salida = imprime.imprimeLaser(id_solicitud);
        byte[] pdf = null;
        return salida;
    }

    public void metodoImprimir(byte[] informePDF) {
        PrintService service = PrintServiceLookup.lookupDefaultPrintService();        
        DocFlavor flavor = DocFlavor.BYTE_ARRAY.AUTOSENSE;
        DocPrintJob pj = service.createPrintJob();
        
        String sc_mensaje=new String("Texto a imprimir");//para imprmir texto de ejemplo
        byte[] sc_bytes=sc_mensaje.getBytes();//para imprmir texto de ejemplo
//        Doc doc = new SimpleDoc(sc_bytes, flavor, null);//para imprmir texto de ejemplo
        
        Doc doc = new SimpleDoc(informePDF, flavor, null);        
        System.out.println(" va a imprimir.. . . .");
        try {
            pj.print(doc, null);
            System.out.println(" fin del proceso de impresion... ");
        } catch (PrintException e) {
            System.out.println("Error al imprimir: " + e.getMessage());
        }
    }
    
    public void imprimirPDF(byte[] informePDF) {
        PdfDecoder pdf = null;   

        try {
            pdf = new PdfDecoder(true);
            //Asignar la impresora predeterminada
            PrintService service = PrintServiceLookup.lookupDefaultPrintService();
            PrinterJob printJob = PrinterJob.getPrinterJob();
            printJob.setPrintService(service);
            Paper paper = new Paper();
            PageFormat pf = printJob.defaultPage();
            
            //Se asigna el tamaño del papel media carta            
            paper.setSize(612, 385); //ANCHO, ALTO (EN PUNTOS)
            paper.setImageableArea(20, -91, 595, 595); //X,Y,ANCHO,ALTO                        
            pf.setPaper(paper);
            pf.setOrientation(pf.LANDSCAPE); //Asignarle orientacion a horizontal
            //Cargar el pdf para imprimir
            pdf.openPdfArray(informePDF); //Asignar el pdf
            pdf.setTextPrint(pdf.TEXTSTRINGPRINT); //Usar las fuentes como texto
            pdf.PDFContainsEmbeddedFonts();
            pdf.hasEmbeddedFonts();
            
            pdf.setPageFormat(pf);
            //Enviar a imprimir
            printJob.setPageable(pdf);  
            printJob.print();
        } catch (Exception e) {
            e.printStackTrace();  
        } finally {  
            pdf.closePdfFile();  
        }  
    }
    
    public String getCobrosConfirmadosFiltros(int idRecolector) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            System.out.println("getCobrosConfirmadosFiltros");
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGOS_CONFIRMADOS_GETLIST(?)}");
            st.setInt(1, idRecolector);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("NUM_PAGO", rs.getInt("NUM_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("DIRECCION", rs.getString("DIRECCION"));
                dato.put("ID_ESTATUS_PAGO_TMP", rs.getInt("ID_ESTATUS_PAGO_TMP"));
                dato.put("ESTATUS_PAGO", rs.getString("ESTATUS_PAGO"));
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO")); 
                dato.put("REFERENCIA", rs.getString("REFERENCIA"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));
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
    
    public static String asignarRecolectorEspecial(int ID_BITACORA) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].ASIGNAR_RECIBO_RECOLECTOR_ESPECIAL(?)}");
            st.setInt(1, ID_BITACORA);  
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
                if(result_insert == 1)
                    resp = "success";
                else
                     resp = "failure";
            } 
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }
    
    public static String statusImpresion(int ID_BITACORA, String idUsuario, int reimpresion, String motivoReimpresion) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].BITACORA_IMPRESION(?,?,?,?)}");
            st.setInt(1, ID_BITACORA); 
            st.setString(2, idUsuario);  
            st.setInt(3, reimpresion);
            st.setString(4, motivoReimpresion);
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
                if(result_insert == 1)
                    resp = "success";
                else
                    resp = "failure";
            } 
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }
    
    public Object[][] getDatosRecibo(int idBitacora) {
        Object[][] resp = new Object[1][23];
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
       
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].QUERY_PRUEBA_RECIBOS_PDF(?)}");
            st.setInt(1, idBitacora);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();                
                resp[0][0] = String.valueOf(rs.getInt("ID_BITACORA"));
                resp[0][1] = rs.getString("ID_RECIBO");
                resp[0][2] = rs.getString("NOMBRE_DONANTE");
                resp[0][3] = rs.getString("RAZON_SOCIAL");
                resp[0][4] = String.valueOf(rs.getInt("TEL_CASA"));
                resp[0][5] = String.valueOf(rs.getInt("TEL_OFICINA"));
                resp[0][6] = rs.getString("LETRA");                
                resp[0][7] = rs.getString("ID_TIPO_DIRECCION");
                resp[0][8] = rs.getString("DOMICILIO");
                resp[0][9] = rs.getString("ENTRE_CALLES");
                resp[0][10] = rs.getString("ESTATUS_PAGO_TMP");
                resp[0][11] = rs.getString("ID_FORMA_PAGO");
                resp[0][12] = rs.getString("ID_CAMPANA_FINANCIERA");
                resp[0][13] = String.valueOf(rs.getInt("NUM_FRECUENCIA"));
                resp[0][14] = rs.getString("ID_ASIGNACION");
                resp[0][15] = rs.getString("NUM_CASO");
                resp[0][16] = String.valueOf(rs.getInt("ID_ZONA"));
                resp[0][17] = rs.getString("ID_TIPO_DONATIVO");                
                resp[0][18] = String.valueOf(rs.getInt("ID_DONANTE"));
                resp[0][19] = String.valueOf(rs.getInt("ID_NUM_PAGO"));
                resp[0][20] = rs.getString("ID_USUARIO");
                resp[0][21] = rs.getString("FECHA_ACTUAL");
                resp[0][22] = String.valueOf(rs.getInt("ID_DONATIVO"));
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
//            resp = respuesta.toString();
        }
        return resp;
    }
    
    public byte[] generarInformeOriginal(int id_solicitud, String ruta) {
        byte[] pdf = null;
        HashMap<String, Object> parametros = new HashMap<String, Object>();
        Integer ID_SOLICITUD = new Integer(id_solicitud);
        parametros.put("ID_BITACORA", ID_SOLICITUD);

        MConnection objConn = new MConnection();
        Connection conn = null;
        conn = objConn.getConnection();
        try {
            ruta = ((listaConfirmacionAC.class.getResource(ruta)).toString().replace("file:/", "").replace("%20", " "));
            //System.out.println("RUTA:" + ruta);
            File reportFile = new File(ruta);
            if (!reportFile.exists()) {                
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
    
    public static String confirmacionMasiva(String idUsuario, String result) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].CONFIRMACION_MASIVA(?,?)}");
            st.setString(1, result);  
            st.setString(2, idUsuario);  
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
                if(result_insert == 1)
                    resp = "success";
                else
                    resp = "failure";
            } 
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }
    
    public String facturacion(String idCampFin, String fechaCobro, String fechaConfirmacion, String idRecibo) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].INGRESOS_FACTURACION(?,?,?,?)}");
            st.setString(1, idCampFin);
            st.setString(2, fechaCobro);
            st.setString(3, fechaConfirmacion);           
            st.setString(4, idRecibo); 
            System.out.println("idReciboBL: "+idRecibo);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();                                       
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO")); 
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE", rs.getString("NOMBRE")); 
                dato.put("FECHA_CONFIRMACION", rs.getString("FECHA_CONFIRMACION")); 
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO")); 
                dato.put("ID_SUSTITUTO", rs.getInt("ID_SUSTITUTO")); 
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("NUM_SUSTITUTO", rs.getInt("NUM_SUSTITUTO"));
                dato.put("ASIGNADO", rs.getString("ASIGNADO")); 
                dato.put("NOMBRE_SUSTITUTO", rs.getString("NOMBRE_SUSTITUTO")); 
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
    
    public static int asignarSustituto_ingresosFacturacion(net.sf.json.JSONObject jsonObject, int idBitacora) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].ASGINAR_SUSTITUTO_INGRESOS_FACTURACION(?,?)}");            
            st.setInt(1, idBitacora);
            st.setInt(2, jsonObject.getInt("ID_SUSTITUTO_FACT"));            
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
            }
            
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return result_insert;
    }

    public static String recibosReimpresion(String idUsuario, String result, String motivo) {
        String result_insert = ""; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].BITACORA_REIMPRESION_SAVE(?,?,?)}");
            st.setString(1, result);  
            st.setString(2, idUsuario);  
            st.setString(3, motivo); 
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getString("RESULTADO");
                if(result_insert == "1")
                    resp = "success";
                else
                    resp = result_insert;
            } 
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }
    
    public String getComentariosConfirmacion(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].COMENTARIOS_CONFIRMACION_RECIBO(?)}");
            st.setInt(1, idBitacora);
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));                
                dato.put("USUARIO_CONFIRMACION", rs.getString("USUARIO_CONFIRMACION"));
                dato.put("FECHA_CONFIRMACION", rs.getString("FECHA_CONFIRMACION"));
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
    
    public String getComentariosCancelacion(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].COMENTARIOS_CANCELACION_RECIBO(?)}");
            st.setInt(1, idBitacora);
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));                
                dato.put("USUARIO_CANCELACION", rs.getString("USUARIO_CANCELACION"));
                dato.put("FECHA_CANCELACION", rs.getString("FECHA_CANCELACION"));
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
    
    public String getComentariosReprogramacion(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].COMENTARIOS_REPROGRAMACION_RECIBO_2(?)}");
            st.setInt(1, idBitacora);
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));                               
                dato.put("FECHA_REPROGRAMACION", rs.getString("FECHA_REPROGRAMACION")); 
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
    
    public String getComentariosBitacoraReprogramacion(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].COMENTARIOS_REPROGRAMACION_RECIBO(?)}");
            st.setInt(1, idBitacora);
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));                
                dato.put("MOTIVO_REPROGRAMACION", rs.getString("MOTIVO_REPROGRAMACION"));                
                dato.put("USUARIO", rs.getString("USUARIO"));
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
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

    public static int addCall(net.sf.json.JSONObject jsonObject, int idBitacora, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null; 
        int respuestaa = 0;
            
        try {            
            if(jsonObject.getInt("CALL_CHKBOX_NO") == 1) {
                respuestaa = 0;
            }            
            if(jsonObject.getInt("CALL_CHKBOX_YES") == 1) {
                respuestaa = 1;
            }            
            conn = objConn.getConnection();            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].ADD_CALL(?,?,?,?)}");
            st.setInt(1, idBitacora);
            st.setString(2, idUsuario);
            st.setInt(3, respuestaa);
            st.setString(4, jsonObject.getString("COMENTARIOS_ADDCALL"));             
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
            } 
            
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return result_insert;
    }
    
    public String getBitacoraLlamadas(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_LLAMADAS_BY_BITACORA(?)}");
            st.setInt(1, idBitacora);
           
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                dato.put("FECHA", rs.getString("FECHA"));                
                dato.put("HORA", rs.getString("HORA"));
                dato.put("RESPUESTA", rs.getString("RESPUESTA"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));
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
    
}
