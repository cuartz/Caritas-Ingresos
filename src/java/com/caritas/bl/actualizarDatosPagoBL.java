package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class actualizarDatosPagoBL {
    public static int actualizarDatos(net.sf.json.JSONObject jsonObject, int idBitacora, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        
        try {            
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].BITACORA_ACTUALIZAR_PAGO_HISTORIAL(?,?,?,?,?,?,?,?,?,?,?,?,?)}");                
            st.setInt(1, idBitacora); 
            st.setString(2, jsonObject.getString("ID_RECIBO")); 
            st.setInt(3, jsonObject.getInt("NUM_PAGO")); 
            st.setString(4, jsonObject.getString("FECHA_VENCIMIENTO")); 
            st.setString(5, jsonObject.getString("FECHA_PAGO")); 
            st.setInt(6, jsonObject.getInt("IMPORTE")); 
            st.setInt(7, jsonObject.getInt("ID_FORMA_PAGO")); 
            st.setInt(8, jsonObject.getInt("ID_ESTATUS_PAGO")); 
            st.setString(9, jsonObject.getString("COMENTARIOS"));           
            st.setString(10, jsonObject.getString("FECHA_CANCELACION"));           
            st.setInt(11, jsonObject.getInt("ID_MOTIVO_CANCELACION")); 
            st.setString(12, jsonObject.getString("COMENTARIOS_CANCELACION")); 
            st.setString(13, idUsuario); 
//            System.out.println("fecha vencimiento: "+jsonObject.getString("FECHA_VENCIMIENTO"));
//            System.out.println("fecha vencimiento: "+jsonObject.getString("FECHA_PAGO"));
//            System.out.println("fecha vencimiento: "+jsonObject.getString("FECHA_CANCELACION"));
                        
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
            } 
            
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st, rs);
        }
        return result_insert;
    }
}
