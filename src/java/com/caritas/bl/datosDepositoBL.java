
package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class datosDepositoBL {
    public static int agregarDeposito(net.sf.json.JSONObject jsonObject, String uid) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_ADD_DEPOSITO(?,?,?,?)}");
            st.setString(1, uid);      
            st.setInt(2, jsonObject.getInt("CUENTA_55"));           
            st.setInt(3, jsonObject.getInt("DEPOSITO_SORTEOS"));           
            st.setString(4, jsonObject.getString("OTRAS_CUENTAS"));           
                        
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
