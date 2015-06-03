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
public class confirmacionPagoBL {
    public static int saveDonativo(net.sf.json.JSONObject jsonObject, int idBitacora, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].CONFIRMACION_PAGO_SAVE(?,?,?,?,?,?,?,?)}");            
            st.setInt(1, idBitacora);
            st.setString(2, jsonObject.getString("FECHA_VISITA"));
            st.setInt(3, jsonObject.getInt("FACTURA_ELECTRONICA"));            
            st.setInt(4, jsonObject.getInt("ID_FORMA_ENVIO"));            
            st.setString(5, jsonObject.getString("COMENTARIOS"));
            st.setInt(6, jsonObject.getInt("ID_DIRECCION"));
            st.setInt(7, jsonObject.getInt("ID_RECOLECTOR_CPP"));            
            st.setString(8, idUsuario);            
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
    
    public static String getInfoFacturacion(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONANTE_FACTURA(?)}");
            st.setInt(1, idBitacora);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("DONANTE_FACTURA", rs.getInt("DONANTE_FACTURA"));                
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
    
    public static String getInfoDireccion(int idBitacora) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_DIRECCION_RECIBO(?)}");
            st.setInt(1, idBitacora);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DIRECCION", rs.getInt("ID_DIRECCION"));                
                dato.put("ID_ESTADO", rs.getInt("ID_ESTADO"));                
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
