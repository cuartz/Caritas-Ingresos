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

public class ingresosBL {
    
    public String getAllCobrosEfectivoPagados(int idRecolector, String fechaVisita, int idZona, String start, String limit, String fechaCobro, String nombre, String numRecibo) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GET_PAGOS_CONFIRMADOS(?,?,?,?,?,?,?,?)}");
            st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona); 
            st.setString(4, start);
            st.setString(5, limit);
            st.setString(6, fechaCobro);
            st.setString(7, nombre);
            st.setString(8, numRecibo);           
            
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
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
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                dato.put("FECHA_REPROGRAMACION", rs.getString("FECHA_REPROGRAMACION"));
                datos.put(dato);
            }
            respuesta.put("rows", datos); 
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_TESORERIA_GET_PAGOS_CONFIRMADOS(?,?,?,?,?,?)}");
            st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona);     
            st.setString(4, fechaCobro);
            st.setString(5, nombre);
            st.setString(6, numRecibo);
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
    
    public String getAllCobrosEspeciePagados(int idRecolector, String fechaVisita, int idZona, String fechaCobro, String nombre, String numRecibo, String start, String limit) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GET_DONATIVOS_ESPECIE_CONFIRMADOS(?,?,?,?,?,?,?,?)}");
            st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona);
            st.setString(4, fechaCobro);
            st.setString(5, nombre);
            st.setString(6, numRecibo);
            st.setString(7, start);
            st.setString(8, limit);
            
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
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
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_TESORERIA_GET_DONATIVOS_ESPECIE_CONFIRMADOS(?,?,?,?,?,?)}");
             st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona);
            st.setString(4, fechaCobro);
            st.setString(5, nombre);
            st.setString(6, numRecibo);           
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
    
    public String getAllRecibosEntregados() {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GET_RECIBOS_POR_ENTREGAR}");             
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("ID_TIPO_ENVIO", rs.getInt("ID_TIPO_ENVIO"));
                dato.put("TIPO_ENVIO", rs.getString("TIPO_ENVIO"));
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
    
    public static int confirmacionCobro(net.sf.json.JSONObject jsonObject, int idBitacora) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].CONFIRMAR_PAGO_PRIMER_FILTRO(?,?,?,?)}");
            st.setInt(1, jsonObject.getInt("CHKBOX_YES")); 
            st.setInt(2, jsonObject.getInt("CHKBOX_NO"));  
            st.setString(3, jsonObject.getString("COMENTARIOS")); 
            st.setInt(4, idBitacora);  
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