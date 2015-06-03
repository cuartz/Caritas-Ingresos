/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author rnunez
 */
public class bitacoraPagosBL {
    public static int saveAll(int idDonativo, int numPago, int idFormaPago, int cantidad, Calendar fechaCobro, Calendar fechaCreacion) {
        int result_insert = 0;
        MConnection objConn = new MConnection();
        SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");  
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = objConn.getConnection();            
            String sql_insert = "INSERT INTO [DB_INGRESOS].[dbo].[OPE_BITACORA_PAGOS_DONATIVOS] "
                    + "(ID_DONATIVO, "
                    + "ID_NUM_PAGO, "
                    + "FECHA_COBRO, "
                    + "ID_FORMA_PAGO, "
                    + "IMPORTE, "
                    + "FECHA_CREACION) "
                    + "VALUES (?,?,?,?,?,?)";       

            pstmt = conn.prepareStatement(sql_insert);          
            pstmt.setInt(1, idDonativo);               
            pstmt.setInt(2, numPago);                           
            pstmt.setString(3, formato.format(fechaCobro.getTime()));  //fechaCobro                 
            pstmt.setInt(4, idFormaPago);           
            pstmt.setInt(5, cantidad);
            pstmt.setString(6, formato.format(fechaCreacion.getTime()));  //fechaCobro   
            result_insert = pstmt.executeUpdate();           
           
        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());            
        } catch (SQLException sql_ex) {            
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, pstmt,null);
        }
        return result_insert;
    }
    
    public String getBitacoraPagosListByDonativo(int idDonativo) {
        String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DONATIVO_BITACORA_PAGOS_LIST(?)}");
            st.setInt(1, idDonativo);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("ID_NUM_PAGO", rs.getInt("ID_NUM_PAGO"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));   
                dato.put("IMPORTE", rs.getDouble("IMPORTE"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_ESTATUS_PAGO_TMP", rs.getInt("ID_ESTATUS_PAGO_TMP"));
                dato.put("ESTATUS_PAGO_TMP", rs.getString("ESTATUS_PAGO_TMP"));
                dato.put("ESTATUS_PAGO", rs.getString("ESTATUS_PAGO"));
                dato.put("ESTATUS_RECIBO", rs.getInt("ESTATUS_RECIBO"));
                dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                dato.put("ID_MOTIVO_CANCELACION", rs.getInt("ID_MOTIVO_CANCELACION"));
                dato.put("MOTIVO_CANCELACION", rs.getString("MOTIVO_CANCELACION"));
                dato.put("FECHA_CANCELACION", rs.getString("FECHA_CANCELACION"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));
                dato.put("COMENTARIOS_CANCELACION", rs.getString("COMENTARIOS_CANCELACION"));                
                dato.put("PERSONALMENTE_RECIBO", rs.getString("PERSONALMENTE_RECIBO"));
                dato.put("STATUS_IMPRESO", rs.getString("STATUS_IMPRESO"));
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
    
    public static String getDonativoInfo(int idDonativo) {
       int numCelular        = 0;
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DONATIVO_INFO_GRAL(?)}");
            st.setInt(1, idDonativo);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("ID_FRECUENCIA", rs.getInt("ID_FRECUENCIA"));
                dato.put("FRECUENCIA", rs.getString("FRECUENCIA"));
                dato.put("NUM_FRECUENCIA", rs.getInt("NUM_FRECUENCIA"));   
                dato.put("CANTIDAD", rs.getDouble("CANTIDAD"));
                dato.put("ID_PRODUCTO", rs.getInt("ID_PRODUCTO"));
                dato.put("PRODUCTO", rs.getString("PRODUCTO"));
                dato.put("ID_TIPO_FRECUENCIA", rs.getInt("ID_TIPO_FRECUENCIA"));
                dato.put("TIPO_FRECUENCIA", rs.getString("TIPO_FRECUENCIA"));
                dato.put("PAGO_UNICO", rs.getString("PAGO_UNICO"));
                dato.put("ID_ASIGNACION", rs.getInt("ID_ASIGNACION"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getInt("ID_CAMPANA_FINANCIERA"));
                dato.put("CAMPANA_FINANCIERA", rs.getString("CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getInt("ID_CATEGORIA"));
                dato.put("CATEGORIA", rs.getString("CATEGORIA"));
                dato.put("NUM_CASO", rs.getInt("NUM_CASO"));
                dato.put("ID_UNIDAD_MEDIDA", rs.getInt("ID_UNIDAD_MEDIDA"));
                dato.put("UNIDAD_MEDIDA", rs.getString("UNIDAD_MEDIDA"));
                dato.put("IMPORTE", rs.getDouble("IMPORTE"));
                dato.put("CANTIDAD", rs.getDouble("CANTIDAD"));
                dato.put("TIPO_DONANTE", rs.getString("TIPO_DONANTE"));
                dato.put("TEL_CASA", rs.getInt("TEL_CASA"));
                dato.put("TEL_OFICINA", rs.getInt("TEL_OFICINA"));                
                dato.put("TEL_CEL", rs.getString("TEL_CEL"));                
                dato.put("EMAIL", rs.getString("EMAIL"));
                dato.put("DATOS_CLAVE", rs.getString("DATOS_CLAVE"));
                dato.put("DIRECCION", rs.getString("DIRECCION"));
                dato.put("FECHA_ALTA", rs.getString("FECHA_ALTA"));
                dato.put("FECHA_ALTA_DONATIVO", rs.getString("FECHA_ALTA_DONATIVO"));                
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
    
    public static String getBitacoraComentarios(int idBitacora) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_BITACORA_COMENTARIOS(?)}");
            st.setInt(1, idBitacora);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));
                dato.put("ID_MOTIVO_CANCELACION", rs.getInt("ID_MOTIVO_CANCELACION"));
                dato.put("MOTIVO_CANCELACION", rs.getString("MOTIVO_CANCELACION"));
                dato.put("FECHA_CANCELACION", rs.getString("FECHA_CANCELACION"));
                dato.put("FECHA_ACTUALIZACION", rs.getString("FECHA_ACTUALIZACION"));
                dato.put("COMENTARIOS_CANCELACION", rs.getString("COMENTARIOS_CANCELACION"));
                dato.put("ID_MOTIVO_REPROGRAMAR", rs.getInt("ID_MOTIVO_REPROGRAMAR"));
                dato.put("COMENTARIOS_REPROGRAMAR", rs.getString("COMENTARIOS_REPROGRAMAR"));               
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
    
    public static String getInfoCheque(int idDonativo) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_CHEQUE(?)}");
            st.setInt(1, idDonativo);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_CHEQUE", rs.getInt("ID_CHEQUE"));
                dato.put("NUM_CHEQUE", rs.getString("NUM_CHEQUE"));
                dato.put("ID_BANCO", rs.getInt("ID_BANCO"));
                dato.put("BANCO", rs.getString("BANCO"));                               
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
    
    public static String getInfoDeposito(int idDonativo) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_DEPOSITO(?)}");
            st.setInt(1, idDonativo);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DEPOSITO", rs.getInt("ID_DEPOSITO"));
                dato.put("CUENTA_55", rs.getString("CUENTA_55"));
                dato.put("DEPOSITO_SORTEOS", rs.getString("DEPOSITO_SORTEOS"));
                dato.put("OTRAS_CUENTAS", rs.getString("OTRAS_CUENTAS"));                               
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
    
    public static String getInfoTarjetaCredito(int idDonativo) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_TARJETA_CREDITO(?)}");
            st.setInt(1, idDonativo);             
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_TARJETA", rs.getInt("ID_TARJETA"));
                dato.put("TITULAR", rs.getString("TITULAR"));
                dato.put("BANCO", rs.getString("BANCO"));
                dato.put("NUM_TARJETA", rs.getString("NUM_TARJETA"));                               
                dato.put("FECHA_VENCIMIENTO", rs.getString("FECHA_VENCIMIENTO"));                               
                dato.put("CVV", rs.getInt("CVV"));                               
                dato.put("NUM_INICIAL", rs.getInt("NUM_INICIAL"));                               
                dato.put("TIPO", rs.getString("TIPO"));                               
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
    
    public static String getInfoTransferencia(int idDonativo) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_TRANSFERENCIA(?)}");
            st.setInt(1, idDonativo);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_TRANSFERENCIA", rs.getInt("ID_TRANSFERENCIA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("CUENTA", rs.getString("CUENTA"));                                               
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
    
    public static String getInfoTarjetaDebito(int idDonativo) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_TARJETA_DEBITO(?)}");
            st.setInt(1, idDonativo);             
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_TARJETA_DEBITO", rs.getInt("ID_TARJETA_DEBITO"));
                dato.put("ID_DONATIVO", rs.getString("ID_DONATIVO"));
                dato.put("NUM_TARJETA", rs.getString("NUM_TARJETA")); 
                dato.put("FECHA_VENCIMIENTO", rs.getString("FECHA_VENCIMIENTO"));                               
                dato.put("CVV", rs.getInt("CVV"));                
                dato.put("BANCO", rs.getString("BANCO"));                
                dato.put("IFE", rs.getString("IFE"));                               
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
    
    public static String cancelarRecibo(int ID_BITACORA) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].RECIBO_BITACORA_CANCEL(?)}");
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
    
    public static String getInfoModificarPago(int idBitacora) {     
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].BITACORA_MODIFICAR_RECIBO(?)}");
            st.setInt(1, idBitacora);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_NUM_PAGO", rs.getInt("ID_NUM_PAGO"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));                                
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
    
    public static int updateInfoRecibo(net.sf.json.JSONObject jsonObject, int idBitacora) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;                
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].BITACORA_MODIFICAR_RECIBO_UPDATE(?,?,?)}");
            st.setInt(1, idBitacora);           
            st.setInt(2, jsonObject.getInt("NUM_PAGO_MP"));           
            st.setString(3, jsonObject.getString("FECHA_COBRO_MP"));                                   
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
    
    public static String generarPagoUnico(int ID_BITACORA) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].RECIBO_GENERAR_COMO_PAGO_UNICO(?)}");
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
    
    public static int cobrarPagoPersonal(net.sf.json.JSONObject jsonObject, int idBitacora) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].CONFIRMAR_PAGO_PERSONAL(?,?,?,?,?,?)}");           
            st.setInt(1, jsonObject.getInt("FACTURA_ELECTRONICA_PAGO_PERSONAL"));
            st.setInt(2, jsonObject.getInt("ID_FORMA_ENVIO_PAGO_PERSONAL"));            
            st.setString(3, jsonObject.getString("COMENTARIOS_PAGO_PERSONAL"));            
            st.setInt(4, jsonObject.getInt("ID_SUSTITUTO_PAGO_PERSONAL"));
            st.setString(5, jsonObject.getString("FECHA_PAGO_PERSONAL"));            
            st.setInt(6, idBitacora);                    
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
    
}
