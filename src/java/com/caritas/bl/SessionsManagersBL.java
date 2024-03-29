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
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

/**
 *
 * @author monjaraz
 */
public class SessionsManagersBL {

    public static JSONObject getInformationOfUser(String id_user) {

        ResultSet rs = null;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        JSONObject dato = new JSONObject();
        try {
            conn = objConn.getConnection();
            String sql = "select ou.id_usuario,ou.nombre,ou.email,op.id_perfil,op.descripcion,op.permisos "
                    + "from BD_ADMIN.dbo.ADM_USUARIOS ou left join BD_ADMIN.dbo.ADM_PERFIL op  on (ou.id_perfil=op.id_perfil) "
                    + "where ou.id_usuario like '" + id_user + "'";
            pstmt = conn.prepareStatement(sql);
//            pstmt.setString(1, id_user);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                dato.element("id_usuario", rs.getString("id_usuario"));
                dato.element("nombre", rs.getString("nombre"));
                dato.element("email", rs.getString("email"));
                dato.element("id_perfil", rs.getString("id_perfil"));
                dato.element("descripcion", rs.getString("descripcion"));
                dato.element("permisos", rs.getString("permisos"));
            }
        } catch (JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            System.out.println("SQLException::>" + sql_ex.getMessage());
        } finally {
MConnection.closeAll(conn, pstmt, rs);
        }
        System.out.println("<getInformationOfUser>> " + dato.toString());
        return dato;
    }
}
