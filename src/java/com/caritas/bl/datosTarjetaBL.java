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
public class datosTarjetaBL {   
    public static int saveTarjetaCredito(net.sf.json.JSONObject jsonObject, String uid, int idTarjeta) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_ADD_TARJETA_CREDITO(?,?,?,?,?,?,?,?,?,?,?)}");            
            st.setString(1, uid);              
            st.setString(2, jsonObject.getString("TITULAR"));  
            st.setString(3, jsonObject.getString("NUM_TARJETA_CREDITO"));
            st.setInt(4, jsonObject.getInt("ID_BANCO"));            
            st.setString(5, jsonObject.getString("FECHA_VENCIMIENTO"));  
            st.setInt(6, jsonObject.getInt("CVV"));             
            st.setInt(7, jsonObject.getInt("NUM_INICIAL"));  
            st.setInt(8, jsonObject.getInt("VISA"));  
            st.setInt(9, jsonObject.getInt("MASTER_CARD"));  
            st.setInt(10, jsonObject.getInt("AM_EXPRESS"));
            st.setInt(11, idTarjeta);            
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
    
    public static String getDatosTarjetaCredito(int idTarjeta) {       
        String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DATOS_TARJETA_CREDITO(?)}");
            st.setInt(1, idTarjeta);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("TITULAR", rs.getString("TITULAR"));
                dato.put("ID_BANCO", rs.getInt("ID_BANCO"));
                dato.put("NUM_TARJETA", rs.getString("NUM_TARJETA"));
                dato.put("FECHA_VENCIMIENTO", rs.getString("FECHA_VENCIMIENTO"));
                dato.put("CVV", rs.getInt("CVV"));
                dato.put("NUM_INICIAL", rs.getInt("NUM_INICIAL"));
                dato.put("VISA", rs.getInt("VISA"));
                dato.put("MASTER_CARD", rs.getInt("MASTER_CARD"));   
                dato.put("AM_EXPRESS", rs.getInt("AM_EXPRESS"));                               
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
