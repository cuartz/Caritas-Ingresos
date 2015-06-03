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

public class comboboxBL {

    public static String getCatalogByLlave(String llave) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            String qry = "SELECT ID,ID_CATALOG,NOMBRE,STATUS "
                    + "FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES WHERE ID_CATALOG IN "
                    + "(select id from BD_ADMIN.dbo.ADM_CATALOGS where llave like '" + llave + "')ORDER BY NOMBRE ASC";
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID"));
                dato.put("id_catalog", rs.getInt("ID_CATALOG"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("status", rs.getInt("STATUS"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public static String getCatalogByLlaveDos(String llave) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            String qry = "SELECT ID,ID_CATALOG,NOMBRE,NOMBRE2,STATUS "
                    + "FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES WHERE ID_CATALOG IN "
                    + "(select id from BD_ADMIN.dbo.ADM_CATALOGS where llave like '" + llave + "')ORDER BY NOMBRE ASC";
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID"));
                dato.put("id_catalog", rs.getInt("ID_CATALOG"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("nombre2", rs.getString("NOMBRE2"));
                dato.put("status", rs.getInt("STATUS"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getCatalogByNombre(String nombre) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            String qry = "SELECT CATV.ID,"
                    + "	CATV.ID_CATALOG,"
                    + "	CATV.NOMBRE,"
                    + "	CATV.STATUS "
                    + "FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES CATV "
                    + "WHERE CATV.ID_CATALOG = (SELECT CAT.ID FROM BD_ADMIN.dbo.ADM_CATALOGS CAT WHERE CAT.NOMBRE COLLATE Modern_Spanish_CI_AI = LTRIM(RTRIM('" + nombre + "')))";
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID"));
                dato.put("id_catalog", rs.getInt("ID_CATALOG"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("status", rs.getInt("STATUS"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getSearchCaso(String keyword) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            String sql_search = "select 'C'+RTRIM(CAST(ID_BENEFICIARIO AS CHAR))+' - '+NOMBRE+' '+APELLIDO_PATERNO+' '+APELLIDO_MATERNO CASO "
                    + "FROM db_Caritas.dbo.OPE_BENEFICIARIOS "
                    + "WHERE ('C'+RTRIM(CAST(ID_BENEFICIARIO AS CHAR))+' - '+NOMBRE+' '+APELLIDO_PATERNO+' '+APELLIDO_MATERNO) LIKE '%" + keyword + "%' ";
            pstmt = conn.prepareStatement(sql_search);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("CASO", rs.getString("CASO"));
                datos.add(dato);
            }

            net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
            dato.put("id", "");
            dato.put("titular", "");
            datos.add(dato);

            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println("<SQLException>> " + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, pstmt,rs);
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getAllUsuarios() {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT ID_USUARIO,NOMBRE FROM BD_ADMIN.dbo.ADM_USUARIOS WHERE ID_APLICACION=3");

            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID", rs.getString("ID_USUARIO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
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
MConnection.closeAll(conn, st,rs);
            System.out.println("<datos.length>> " + datos.length());
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getBeneficiarioByKeyword(String keyword) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
//            
            String sql_search = "SELECT id_beneficiario,( CAST(id_beneficiario AS VARCHAR(50)) + ' - ' + NOMBRE + ' ' + Apellido_paterno + ' ' + Apellido_materno)  nombre  "
                    + "FROM     [db_Caritas].[dbo].[OPE_BENEFICIARIOS] b  "
                    + "WHERE   (' C'+RTRIM(CAST(B.ID_BENEFICIARIO AS CHAR))+' - '+B.NOMBRE+' '+B.APELLIDO_PATERNO+' '+B.APELLIDO_MATERNO)  COLLATE Modern_Spanish_CI_AI  "
                    + "LIKE '%" + keyword + "%' ORDER BY NOMBRE + ' ' + Apellido_paterno + ' ' + Apellido_materno";

            pstmt = conn.prepareStatement(sql_search);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("id_beneficiario"));
                dato.put("name", rs.getString("nombre"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println("<SQLException>> " + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, pstmt,rs);
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getSearchSustituto(int idBitacora) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            
            String qry = "SELECT E.ID_DONANTE_TMP,E.RAZON_SOCIAL "
                    + "FROM DB_INGRESOS.dbo.OPE_DONANTES a "
                    + "INNER JOIN DB_INGRESOS.dbo.OPE_DONATIVOS_DONANTE c ON a.ID_DONANTE = c.ID_DONANTE "
                    + "INNER JOIN DB_INGRESOS.dbo.OPE_BITACORA_PAGOS_DONATIVOS D ON c.ID_DONATIVO = D.ID_DONATIVO "
                    + "INNER JOIN DB_INGRESOS.dbo.OPE_DONANTES_SUSTITUOS E ON E.ID_DONANTE_PADRE=A.ID_DONANTE "
                    + "WHERE D.ID_BITACORA='" + idBitacora + "'";
            
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("ID_DONANTE_TMP", rs.getInt("ID_DONANTE_TMP"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                datos.add(dato);
            }

            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;

    }
    
    public static String getDireccionesDonante(int idBitacora) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
//            String qry = "SELECT "
//                        + "DIR.ID_DIRECCION AS ID_DIRECCION,	"
//                        + "DIR.CALLE + ' # ' + CAST(DIR.NUMERO AS VARCHAR(10)) + ' COL. ' + DIR.COLONIA + ' ENTRE ' + DIR.ENTRE_CALLES + ' CP. ' + CAST(DIR.COD_POSTAL AS VARCHAR(10)) AS DIRECCION,"
//                    + "DIR.ID_ZONA "
//                    + "FROM DB_INGRESOS.dbo.OPE_DIRECCIONES_DONANTE DIR "
//                    + "WHERE DIR.ID_DONANTE = (SELECT DONA.ID_DONANTE FROM DB_INGRESOS.dbo.OPE_DONATIVOS_DONANTE DONA WHERE DONA.ID_DONATIVO = (SELECT BITA.ID_DONATIVO FROM DB_INGRESOS.dbo.OPE_BITACORA_PAGOS_DONATIVOS BITA WHERE BITA.ID_BITACORA = '" + idBitacora + "')) "
//                    + "ORDER BY DIR.ID_TIPO_DIRECCION";
            
            String qry = "SELECT "
            + "	DIR.ID_DIRECCION, "
            + "	DIR.CALLE + ' # ' + DIR.NUMERO + ' COL. ' + DIR.COLONIA + ', ' + MUN.NOMBRE + ', ' + CV1.NOMBRE + ', ENTRE ' +DIR.ENTRE_CALLES + ', CP. ' + CAST(DIR.COD_POSTAL AS VARCHAR(10)) AS DIRECCION, "
            + "	DIR.ID_ZONA "
            + "FROM DB_INGRESOS.dbo.OPE_DIRECCIONES_DONANTE DIR "
            + "INNER JOIN DB_INGRESOS.dbo.OPE_DONATIVOS_DONANTE DONATIVO ON DONATIVO.ID_DONANTE = DIR.ID_DONANTE "
            + "INNER JOIN DB_INGRESOS.dbo.OPE_BITACORA_PAGOS_DONATIVOS BITA ON BITA.ID_DONATIVO = DONATIVO.ID_DONATIVO "
            + "INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_MUNICIPIOS MUN ON DIR.ID_MUNICIPIO = MUN.ID "
            + "INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES CV1 ON DIR.ID_ESTADO = CV1.ID "
            + "WHERE BITA.ID_BITACORA = '" + idBitacora + "'"
            + "ORDER BY DIR.ID_TIPO_DIRECCION ";

            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID_DIRECCION"));
                dato.put("nombre", rs.getString("DIRECCION"));
                dato.put("idZona", rs.getInt("ID_ZONA"));
                datos.add(dato);
            }

            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;

    }
    
    public static String getRecolectores(int idZona) {               
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        String qry = "";
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            if(idZona == 0){
                qry = "SELECT "
                    + "ID_RECOLECTOR,"
                    + "NOMBRE,"
                    + "ID_ZONA,"
                    + "ID_TIPO_RECOLECTOR "
                    + "FROM DB_INGRESOS.dbo.OPE_RECOLECTORES";
            }else{
                qry = "SELECT "
                    + "ID_RECOLECTOR,"
                    + "NOMBRE,"
                    + "ID_ZONA,"
                    + "ID_TIPO_RECOLECTOR "
                    + "FROM DB_INGRESOS.dbo.OPE_RECOLECTORES WHERE ID_ZONA_2 = '" + idZona + "'";
            }
            
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID_RECOLECTOR"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("idZona", rs.getInt("ID_ZONA"));
                dato.put("idTipoRecolector", rs.getInt("ID_TIPO_RECOLECTOR"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();            
        }
        return resp;
    }
    
    public static String getRecolectores_confirmarPago(int idDireccion) {       
        System.out.println("Entro BL");
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        String qry = "";
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();            
            qry = "SELECT "
                + "ID_RECOLECTOR,"
                + "NOMBRE,"
                + "ID_ZONA,"
                + "ID_TIPO_RECOLECTOR "
                + "FROM DB_INGRESOS.dbo.OPE_RECOLECTORES WHERE ID_ZONA_2 = '" + idDireccion + "'";
            
            
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID_RECOLECTOR"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("idZona", rs.getInt("ID_ZONA"));
                dato.put("idTipoRecolector", rs.getInt("ID_TIPO_RECOLECTOR"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();            
        }
        return resp;
    }
    
    public static String getAllRecolectores() {       
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            String qry = "SELECT "
                    + "ID_RECOLECTOR,"
                    + "NOMBRE,"
                    + "ID_ZONA,"
                    + "ID_TIPO_RECOLECTOR "
                    + "FROM DB_INGRESOS.dbo.OPE_RECOLECTORES WHERE ACTIVO = 1";
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID_RECOLECTOR"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("idZona", rs.getInt("ID_ZONA"));
                dato.put("idTipoRecolector", rs.getInt("ID_TIPO_RECOLECTOR"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();            
        }
        return resp;
    }
    
    public static String getRecolectoresEspeciales() {
        String resp = "";       
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_RECOLECTORES_ESPECIALES}");              
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_RECOLECTOR", rs.getInt("ID_RECOLECTOR"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));                
                dato.put("ID_ZONA", rs.getInt("ID_ZONA"));                
                dato.put("ID_TIPO_RECOLECTOR", rs.getInt("ID_TIPO_RECOLECTOR"));
                dato.put("TIPO_RECOLECTOR", rs.getString("TIPO_RECOLECTOR"));                
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
    
    public static String getCatalogByNombreConfMasiva(String llave) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            String qry = "SELECT ID,"
                    + "ID_CATALOG,"
                    + "NOMBRE,"
                    + "STATUS "
                    + "FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES WHERE ID_CATALOG IN "
                    + "(SELECT ID FROM BD_ADMIN.dbo.ADM_CATALOGS WHERE llAVE LIKE '" + llave + "' AND STATUS = 1)"
                    + "ORDER BY NOMBRE ASC";
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID"));
                dato.put("id_catalog", rs.getInt("ID_CATALOG"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("status", rs.getInt("STATUS"));
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public static String getSearchSustitutoDonativos(int idDonante) {
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();            
            
            String qry = "SELECT "
                    + "SUSTITUTO.ID_DONANTE_TMP, "
                    + "SUSTITUTO.RAZON_SOCIAL  "
                    + "FROM DB_INGRESOS.dbo.OPE_DONANTES_SUSTITUOS SUSTITUTO "
                    + "INNER JOIN DB_INGRESOS.dbo.OPE_DONANTES DONANTE ON SUSTITUTO.ID_DONANTE_PADRE = DONANTE.ID_DONANTE "
                    + "WHERE DONANTE.ID_DONANTE = '" + idDonante + "'";
            
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("ID_DONANTE_TMP", rs.getInt("ID_DONANTE_TMP"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                datos.add(dato);
            }

            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;

    }
    
    public static String getRecolectoresByIdDireccion(int idDireccion) {               
        String resp = "";
        MConnection objConn = null;
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        String qry = "";
        net.sf.json.JSONObject respuesta = new net.sf.json.JSONObject();
        net.sf.json.JSONArray datos = new net.sf.json.JSONArray();
        try {
            objConn = new MConnection();
            conn = objConn.getConnection();
            
            qry = " SELECT "
                    + " ID_RECOLECTOR,"
                    + " NOMBRE,"
                    + " ID_ZONA "
                    + "FROM DB_INGRESOS.dbo.OPE_RECOLECTORES "
                    + "WHERE ID_ZONA_2 = "
                    + "(SELECT ID_ZONA FROM DB_INGRESOS.dbo.OPE_DIRECCIONES_DONANTE WHERE ID_DIRECCION = '" + idDireccion + "' ) "
                    + "OR ID_ZONA = 8";
            
            st = conn.prepareStatement(qry);
            rs = st.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID_RECOLECTOR"));
                dato.put("nombre", rs.getString("NOMBRE"));
                dato.put("idZona", rs.getInt("ID_ZONA"));                
                datos.add(dato);
            }
            respuesta.put("rows", datos);
        } catch (SQLException sql_ex) {
            System.out.println(sql_ex.getClass().getCanonicalName() + ":" + sql_ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, sql_ex);
        } finally {
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();            
        }
        return resp;
    }
    
}
