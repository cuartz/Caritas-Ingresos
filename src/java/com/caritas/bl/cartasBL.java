/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author jzamora
 */
public class cartasBL {

    
    public static String getAllGrid_DonantesCartas() {
//    public static String getAllGrid_DonantesCartas(int ID_DONA) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT  A.ID_DONANTE,C.NOMBRE +' '+ A.NOMBRE + ' ' + A.A_PATERNO + ' ' + A.A_MATERNO DONANTE,B.CALLE,B.COLONIA,D.NOMBRE MUNICIPIO,A.TEL_CASA "
                    + "FROM    DB_INGRESOS.dbo.OPE_DONANTES A "
                    + "INNER JOIN DB_INGRESOS.dbo.OPE_DIRECCIONES_DONANTE B ON A.ID_DONANTE = B.ID_DONANTE "
                    + "INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES C ON A.ID_TITULO=C.ID "
                    + "INNER JOIN BD_ADMIN.DBO.ADM_CATALOGS_MUNICIPIOS D ON D.ID=B.ID_MUNICIPIO");

            System.out.print(rs);
//            System.out.println("Variable GRIG Pasando Parametro:::" + ID_DONA);

//            st.setInt(1, ID_DONA);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("DONANTE", rs.getString("DONANTE"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("MUNICIPIO", rs.getString("MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
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
            System.out.println("<datos.length>> " + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }
    public static String getAllGrid_listaCartas() {
//    public static String getAllGrid_DonantesCartas(int ID_DONA) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT A.ID_DONANTE,E.ID_ESTATUS_CARTA,C.NOMBRE +' '+ A.NOMBRE + ' ' + A.A_PATERNO + ' ' + A.A_MATERNO DONANTE,B.CALLE,B.COLONIA,D.NOMBRE MUNICIPIO,A.TEL_CASA,E.MOTIVO_DEVOLUCION FROM DB_INGRESOS.dbo.OPE_DONANTES A INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES C ON A.ID_TITULO=C.ID INNER JOIN DB_INGRESOS.dbo.OPE_DIRECCIONES_DONANTE B ON A.ID_DONANTE = B.ID_DONANTE INNER JOIN BD_ADMIN.DBO.ADM_CATALOGS_MUNICIPIOS D ON D.ID=B.ID_MUNICIPIO INNER JOIN DB_INGRESOS.DBO.OPE_BITACORA_CARTAS E ON E.ID_DONANTE=A.ID_DONANTE");

            System.out.print(rs);
//            System.out.println("Variable GRIG Pasando Parametro:::" + ID_DONA);

//            st.setInt(1, ID_DONA);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("ID_ESTATUS_CARTA", rs.getInt("ID_ESTATUS_CARTA"));
                dato.put("DONANTE", rs.getString("DONANTE"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("MUNICIPIO", rs.getString("MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
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
            System.out.println("<datos.length>> " + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }
    
    
     public static String getAllGrid_DonantesCandidato() {
//    public static String getAllGrid_DonantesCartas(int ID_DONA) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT  A.ID_DONANTE,C.NOMBRE +' '+ A.NOMBRE + ' ' + A.A_PATERNO + ' ' + A.A_MATERNO DONANTE,B.CALLE,B.COLONIA,D.NOMBRE MUNICIPIO,A.TEL_CASA "
                    + "FROM    DB_INGRESOS.dbo.OPE_DONANTES A "
                    + "INNER JOIN DB_INGRESOS.dbo.OPE_DIRECCIONES_DONANTE B ON A.ID_DONANTE = B.ID_DONANTE "
                    + "INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES C ON A.ID_TITULO=C.ID "
                    + "INNER JOIN BD_ADMIN.DBO.ADM_CATALOGS_MUNICIPIOS D ON D.ID=B.ID_MUNICIPIO");

            System.out.print(rs);
//            System.out.println("Variable GRIG Pasando Parametro:::" + ID_DONA);

//            st.setInt(1, ID_DONA);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("DONANTE", rs.getString("DONANTE"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("MUNICIPIO", rs.getString("MUNICIPIO"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
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
            System.out.println("<datos.length>> " + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }
  
}
