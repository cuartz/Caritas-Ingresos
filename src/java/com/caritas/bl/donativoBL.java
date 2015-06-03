package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author rnunez
 */
public class donativoBL { 
    public String getAllDonativos(String strQuery, int idDonante, String start, String limit) {
        String resp = "";       
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONANTE_DONATIVOS_LIST(?,?,?)}");
            st.setInt(1, idDonante);      
            st.setString(2, start);
            st.setString(3, limit);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("ID_DONATIVO_ANTIGUO", rs.getInt("ID_DONATIVO_ANTIGUO"));                
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("DONANTE", rs.getString("DONANTE"));
                dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO"));
                dato.put("TIPO_DONATIVO", rs.getString("TIPO_DONATIVO"));
                dato.put("CANTIDAD", rs.getInt("CANTIDAD"));
                dato.put("IMPORTE", rs.getDouble("IMPORTE"));
                dato.put("ID_UNIDAD_MEDIDA", rs.getInt("ID_UNIDAD_MEDIDA"));
                dato.put("UNIDAD_MEDIDA", rs.getString("UNIDAD_MEDIDA"));
                dato.put("ID_PRODUCTO", rs.getString("ID_PRODUCTO"));
                dato.put("PRODUCTO", rs.getString("PRODUCTO"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("PAGO_UNICO", rs.getString("PAGO_UNICO"));
                dato.put("ID_FRECUENCIA", rs.getInt("ID_FRECUENCIA"));
                dato.put("FRECUENCIA", rs.getString("FRECUENCIA"));
                dato.put("ID_TIPO_FRECUENCIA", rs.getInt("ID_TIPO_FRECUENCIA"));
                dato.put("TIPO_FRECUENCIA", rs.getString("TIPO_FRECUENCIA"));
                dato.put("NUM_FRECUENCIA", rs.getInt("NUM_FRECUENCIA"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getInt("ID_CAMPANA_FINANCIERA"));
                dato.put("CAMPANA_FINANCIERA", rs.getString("CAMPANA_FINANCIERA"));
                dato.put("ID_ASIGNACION", rs.getInt("ID_ASIGNACION"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                //dato.put("NUM_CASO", rs.getInt("NUM_CASO"));
                dato.put("PAGOS_PENDIENTES", rs.getInt("PAGOS_PENDIENTES"));
                dato.put("PAGOS_COBRADOS", rs.getInt("PAGOS_COBRADOS"));
                dato.put("PAGOS_CANCELADOS", rs.getInt("PAGOS_CANCELADOS"));
                dato.put("ESTATUS_DONATIVO", rs.getString("ESTATUS_DONATIVO"));
                dato.put("NUM_CASO", rs.getString("CREACION"));                           
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_DONANTE_DONATIVOS_LIST(?)}");
            st.setInt(1, idDonante);                 
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
    
    public static String getLastID() {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            
            st = conn.prepareStatement("SELECT MAX(SCOPE_IDENTITY()) AS ID_DONATIVO FROM [DB_INGRESOS].[dbo].[OPE_DONATIVOS_DONANTE];");                
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));                  
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
    
    public static int saveDonativo(net.sf.json.JSONObject jsonObject, String uid, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_BITACORA_SAVE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            st.setInt(1, jsonObject.getInt("ID_DONANTE"));           
            st.setInt(2, jsonObject.getInt("ID_TIPO_DONATIVO"));           
            st.setInt(3, jsonObject.getInt("ID_FORMA_PAGO"));           
            st.setInt(4, jsonObject.getInt("ID_FRECUENCIA"));           
            st.setInt(5, jsonObject.getInt("NUM_FRECUENCIA"));           
            st.setDouble(6, jsonObject.getDouble("CANTIDAD"));           
            st.setInt(7, jsonObject.getInt("ID_PRODUCTO"));     
            st.setInt(8, jsonObject.getInt("ID_TIPO_FRECUENCIA"));            
            st.setInt(9, jsonObject.getInt("PAGO_UNICO"));            
            st.setInt(10, jsonObject.getInt("ID_CAMPANA_FINANCIERA"));
            st.setInt(11, jsonObject.getInt("ID_CATEGORIA")); 
            st.setInt(12, jsonObject.getInt("ID_ASIGNACION"));                               
            st.setInt(13, jsonObject.getInt("NUM_CASO"));           
            st.setInt(14, jsonObject.getInt("ID_UNIDAD_MEDIDA")); 
            st.setDouble(15, jsonObject.getDouble("IMPORTE"));
            st.setInt(16, jsonObject.getInt("ID_DONATIVO_ANT"));
            st.setString(17, uid);
            st.setInt(18, jsonObject.getInt("comboSearchBeneficiario"));
            st.setString(19, idUsuario);
            st.setInt(20, jsonObject.getInt("PERSONALMENTE_DONATIVO"));
            st.setInt(21, jsonObject.getInt("ID_SUSTITUTO_DONATIVO"));
            st.setString(22, jsonObject.getString("FECHA_INICIO"));
            
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("ID_DONATIVO");
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
    
    public static String getNameDonante(int idDonante) {
       String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT "
                    + "DON.NOMBRE + ' ' + DON.A_PATERNO + ' ' + DON.A_MATERNO AS NOMBRE,"
                    + "DON.PERSONALMENTE AS PERSONALMENTEE, "
                    + "DON.DONANTE_FACTURA AS DONANTEF "
                    + "FROM DB_INGRESOS.dbo.OPE_DONANTES DON "
                    + "WHERE DON.ID_DONANTE = ?");     
            st.setInt(1, idDonante);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("NOMBRE", rs.getString("NOMBRE"));                
                dato.put("PERSONALMENTEE", rs.getInt("PERSONALMENTEE"));
                dato.put("DONANTEF", rs.getInt("DONANTEF"));
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
    
    public static String deleteDonativo(int ID_DONATIVO) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_BITACORA_DELETE(?)}");
            st.setInt(1, ID_DONATIVO);  
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
    
    public static String cancelarDonativo(net.sf.json.JSONObject jsonObject, int ID_DONATIVO, String idUsuario, int precancelacion) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_BITACORA_CANCEL(?,?,?,?,?)}");
            st.setInt(1, ID_DONATIVO); 
            st.setString(2, jsonObject.getString("MOTIVO_CANCELACION"));
            st.setInt(3, jsonObject.getInt("ID_MOTIVO_CANCELACION_DONATIVO")); 
            st.setString(4, idUsuario);
            st.setInt(5, precancelacion); 
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

    public static String getDonativoUpdateInfo(int ID_DONATIVO) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DONATIVO_INFO_UPDATE(?)}");    
            st.setInt(1, ID_DONATIVO);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ANT_DONATIVO", rs.getInt("ANT_DONATIVO"));
                dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("CANTIDAD", rs.getInt("CANTIDAD"));
                dato.put("ID_UNIDAD_MEDIDA", rs.getInt("ID_UNIDAD_MEDIDA"));
                dato.put("ID_PRODUCTO", rs.getInt("ID_PRODUCTO"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("PERSONALMENTE", rs.getInt("PERSONALMENTE"));
                dato.put("PAGO_UNICO", rs.getInt("PAGO_UNICO"));
                dato.put("ID_FRECUENCIA", rs.getInt("ID_FRECUENCIA"));
                dato.put("ID_TIPO_FRECUENCIA", rs.getInt("ID_TIPO_FRECUENCIA"));
                dato.put("NUM_FRECUENCIA", rs.getInt("NUM_FRECUENCIA"));
                dato.put("ID_CAMPANA_FINANCIERA", rs.getInt("ID_CAMPANA_FINANCIERA"));
                dato.put("ID_CATEGORIA", rs.getInt("ID_CATEGORIA"));
                dato.put("ID_ASIGNACION", rs.getInt("ID_ASIGNACION"));
                dato.put("NUM_CASO", rs.getInt("NUM_CASO"));
                dato.put("CASO_NEW", rs.getInt("CASO_NEW"));
                dato.put("ID_SUSTITUTO_DONATIVO", rs.getInt("ID_SUSTITUTO"));
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
    
    public static int updateDonativo(net.sf.json.JSONObject jsonObject, String idUsuario, int idDonativo) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_UPDATE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            st.setInt(1, jsonObject.getInt("ID_DONATIVO_ANT"));           
            st.setInt(2, jsonObject.getInt("ID_TIPO_DONATIVO"));           
            st.setInt(3, jsonObject.getInt("IMPORTE"));           
            st.setInt(4, jsonObject.getInt("CANTIDAD"));
            st.setInt(5, jsonObject.getInt("ID_UNIDAD_MEDIDA"));
            st.setInt(6, jsonObject.getInt("ID_PRODUCTO"));           
            st.setInt(7, jsonObject.getInt("ID_FORMA_PAGO"));           
            st.setInt(8, jsonObject.getInt("PERSONALMENTE_DONATIVO"));     
            st.setInt(9, jsonObject.getInt("PAGO_UNICO"));            
            st.setInt(10, jsonObject.getInt("ID_FRECUENCIA"));            
            st.setInt(11, jsonObject.getInt("ID_TIPO_FRECUENCIA"));
            st.setInt(12, jsonObject.getInt("NUM_FRECUENCIA")); 
            st.setInt(13, jsonObject.getInt("ID_CAMPANA_FINANCIERA"));                               
            st.setInt(14, jsonObject.getInt("ID_CATEGORIA"));           
            st.setInt(15, jsonObject.getInt("ID_ASIGNACION")); 
            st.setInt(16, jsonObject.getInt("NUM_CASO"));
            st.setInt(17, idDonativo);            
            st.setString(18, idUsuario);
            st.setInt(19, jsonObject.getInt("ID_SUSTITUTO_DONATIVO"));
           
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULT");
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
    
    public static String terminarDonativo(int ID_DONATIVO) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TERMINAR_DONATIVO(?)}");
            st.setInt(1, ID_DONATIVO);  
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
    
    public static String moverDonativo(net.sf.json.JSONObject jsonObject, int ID_DONATIVO) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TRASLADAR_DONATIVO(?,?)}");                        
            st.setInt(1, jsonObject.getInt("ID_DONANTE_NUEVO")); 
            st.setInt(2, ID_DONATIVO); 
             
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
    
    public String getSolicitudesDonativosPrecancelados(String strQuery, String start, String limit) {
        String resp = "";       
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_SOLICITUDES_DONATIVOS_PRECANCELADOS(?,?)}");           
            st.setString(1, start);
            st.setString(2, limit);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("FECHA_CANCELACION", rs.getString("FECHA_CANCELACION"));
                dato.put("MOTIVO_CANCELACION", rs.getString("MOTIVO_CANCELACION"));
                dato.put("ID_USUARIO_CANCELACION", rs.getString("ID_USUARIO_CANCELACION"));
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
    
    public static String aprobarCancelacionDonativo(int ID_DONATIVO, String idUsuario) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].APROBAR_CANCELACION_DONATIVO(?,?)}");
            st.setInt(1, ID_DONATIVO);
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
    
    public static String denegarCancelacionDonativo(int ID_DONATIVO) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DENEGAR_CANCELACION_DONATIVO(?)}");
            st.setInt(1, ID_DONATIVO);            
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