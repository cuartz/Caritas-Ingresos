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
public class cancelarPagoBL {
    public static int cancelarPago(net.sf.json.JSONObject jsonObject, int idBitacora, int precancelacion, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].CONFIRMACION_CANCELAR_PAGO(?,?,?,?,?)}");
            st.setInt(1, idBitacora);      
            st.setString(2, jsonObject.getString("ID_MOTIVO_CANCELACION"));           
            st.setString(3, jsonObject.getString("COMENTARIOS_CANCELACION"));
            st.setInt(4, precancelacion);
            st.setString(5, idUsuario);
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
    
    public String getSolicitudesRecibosPrecancelados(String strQuery, String start, String limit) {
        String resp = "";       
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_SOLICITUDES_RECIBOS_PRECANCELADOS(?,?)}");           
            st.setString(1, start);
            st.setString(2, limit);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("USUARIO_CANCELACION", rs.getString("USUARIO_CANCELACION"));
                dato.put("FECHA_CANCELACION", rs.getString("FECHA_CANCELACION"));
                dato.put("COMENTARIOS_CANCELACION", rs.getString("COMENTARIOS_CANCELACION"));  
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("NOMBRE_DONANTE", rs.getString("NOMBRE_DONANTE"));
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
    
    public static String aprobarCancelacion(int ID_BITACORA, String idUsuario) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].APROBAR_CANCELACION_RECIBO(?,?)}");
            st.setInt(1, ID_BITACORA);
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
    
    public static String denegarCancelacion(int ID_BITACORA) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DENEGAR_CANCELACION_RECIBO(?)}");
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
}
