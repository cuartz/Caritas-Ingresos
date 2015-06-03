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
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author rnunez
 */
public class reprogramarPagoBL {       
    public static String getFechas(int idBitacora) {
       String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPROGRAMAR_PAGO_GET_FECHAS(?)}");
            st.setInt(1, idBitacora);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
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
    
    public static int updateFechaPago(net.sf.json.JSONObject jsonObject, int idBitacora, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;        
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PROGRAMAR_PAGO_SAVE(?,?,?,?,?,?)}");
            st.setInt(1, idBitacora);      
            st.setString(2, jsonObject.getString("NUEVA_FECHA_VISITA_PR")); 
            st.setInt(3, jsonObject.getInt("ID_DIRECCION_PR")); 
            st.setInt(4, jsonObject.getInt("ID_RECOLECTOR_PR"));                           
            st.setString(5, jsonObject.getString("COMENTARIOS_REPROGRAMAR_PR")); 
            st.setString(6, idUsuario); 
                        
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
    
    public String getHistorialReprogramacion(String idRecibo) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].HISTORIAL_REPROGRAMACION(?)}");
            st.setString(1, idRecibo);            
            
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();                
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                dato.put("FECHA_REPROGRAMACION", rs.getString("FECHA_REPROGRAMACION"));
                dato.put("MOTIVO_REPROGRAMACION", rs.getString("MOTIVO_REPROGRAMACION"));
                dato.put("USUARIO", rs.getString("USUARIO"));
                dato.put("COMENTARIOS_CONFIRMACION", rs.getString("COMENTARIOS_CONFIRMACION"));
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
    
    public String getDonanteInfo(String idRecibo) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DATOS_DONANTE(?)}");
            st.setString(1, idRecibo);            
            
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();                
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("TEL_CASA", rs.getInt("TEL_CASA"));
                dato.put("TEL_MOVIL", rs.getInt("TEL_MOVIL"));
                dato.put("TEL_OFICINA", rs.getInt("TEL_OFICINA"));                
                dato.put("DATOS_CLAVE", rs.getString("DATOS_CLAVE")); 
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
