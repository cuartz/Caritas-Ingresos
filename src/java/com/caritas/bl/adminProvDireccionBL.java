    /*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.sql.CallableStatement;
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
 * @author jzamora
 */
public class adminProvDireccionBL {
    
    public static String getProveedor() {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT B.ID,B.NOMBRE FROM BD_ADMIN.dbo.ADM_CATALOGS A INNER JOIN BD_ADMIN.dbo.AMD_CATALOGS_VALUES B ON A.ID=B.ID_CATALOG WHERE A.LLAVE='TIPO_PROVEEDORES' AND B.STATUS=1 ORDER BY NOMBRE ASC");
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("id", rs.getInt("id"));
                dato.put("nombre", rs.getString("nombre"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rs);
            System.out.println("<datos.length>> " + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }
    
 public static String getCatalogs(){
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        PreparedStatement st = null;
        ResultSet rs = null;

        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        
        try {
            st = conn.prepareStatement("SELECT B.ID,B.NOMBRE FROM BD_ADMIN.dbo.ADM_CATALOGS A INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES B ON A.ID=B.ID_CATALOG WHERE A.LLAVE='TIPO_PROVEEDORES' AND B.STATUS=1 ORDER BY NOMBRE ASC");
            rs = st.executeQuery();
            while (rs.next())
            {
                JSONObject dato = new JSONObject();
                dato.put("id", rs.getString("id"));
                dato.put("nombre", rs.getString("nombre"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st, rs);
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public static String getCatalogValues(int idcatalog){
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        PreparedStatement st = null;
        ResultSet rs = null;

        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        
        try {
            st = conn.prepareStatement("SELECT * FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES WHERE ID_CATALOG=?");
            System.out.println(idcatalog);
            st.setInt(1, idcatalog);
            rs = st.executeQuery();
            while (rs.next())
            {
                JSONObject dato = new JSONObject();
                dato.put("id", rs.getString("id"));
                dato.put("nombre", rs.getString("nombre"));
                dato.put("status", rs.getString("status"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
 MConnection.closeAll(conn, st, rs);
            resp = respuesta.toString();
        }
        return resp;
    }    
            
    public static String addCatalog(String value)
    {
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        CallableStatement call = null;

        try {
            String sqlQuery = "INSERT INTO BD_ADMIN.dbo.ADM_CATALOGS (NOMBRE) VALUES(UPPER(?))";
            call = conn.prepareCall(sqlQuery);
            call.setString(1,value);

            if (!call.execute()) {
                resp = "OK";
            }
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            resp = ex.getMessage();
        } finally {
MConnection.closeAll(conn, call);
        }
        return resp;
    }            
    
    public static String addValue(int idcatalog,String value)
    {
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        CallableStatement call = null;

        try {
            String sqlQuery = "INSERT INTO BD_ADMIN.dbo.ADM_CATALOGS_VALUES (ID_CATALOG,NOMBRE,STATUS) VALUES(?,UPPER(?),1)";
            call = conn.prepareCall(sqlQuery);
            call.setInt(1,idcatalog);
            call.setString(2,value);

            if (!call.execute()) {
                resp = "OK";
            }
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            resp = ex.getMessage();
        } finally {
MConnection.closeAll(conn, call);
        }
        return resp;
    }    
    
    public static String uptValue(int idvalue,String value, int status)
    {
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        CallableStatement call = null;

        try {
            String sqlQuery = "UPDATE BD_ADMIN.dbo.ADM_CATALOGS_VALUES SET NOMBRE=UPPER(?), STATUS=? WHERE ID=?";
            call = conn.prepareCall(sqlQuery);
            call.setString(1,value);
            call.setInt(2,status);
            call.setInt(3,idvalue);

            if (!call.execute()) {
                resp = "OK";
            }
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            resp = ex.getMessage();
        } finally {
MConnection.closeAll(conn, call);
        }
        return resp;
    }      
    
    public static String delValue(int idvalue)
    {
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        CallableStatement call = null;

        try {
            String sqlQuery = "DELETE BD_ADMIN.dbo.ADM_CATALOGS_VALUES WHERE ID=?";
            call = conn.prepareCall(sqlQuery);
            call.setInt(1,idvalue);

            if (!call.execute()) {
                resp = "OK";
            }
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            resp = ex.getMessage();
        } finally {
MConnection.closeAll(conn, call);
        }
        return resp;
    }       
    
 
}
