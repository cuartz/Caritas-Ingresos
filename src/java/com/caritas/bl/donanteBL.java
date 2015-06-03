package com.caritas.bl;

import com.caritas.utils.MConnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class donanteBL {

    public static String getComboEstados(int idPais, String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT DISTINCT B.ID,B.NOMBRE FROM BD_ADMIN.dbo.ADM_CATALOGS_MUNICIPIOS A INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES B ON A.ID_ESTADO=B.ID WHERE ID_Pais=? AND B.NOMBRE LIKE '%" + strQuery.replace(" ", "%") + "%' ORDER BY nombre ASC");
            st.setInt(1, idPais);
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
MConnection.closeAll(conn, st,rs);         
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public static String getComboEstadosDos(String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT DISTINCT B.ID,B.NOMBRE FROM BD_ADMIN.dbo.ADM_CATALOGS_MUNICIPIOS A INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS_VALUES B ON A.ID_ESTADO=B.ID WHERE ID_Pais = 196 AND B.NOMBRE LIKE '%" + strQuery.replace(" ", "%") + "%' ORDER BY nombre ASC");           
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
MConnection.closeAll(conn, st,rs);
            resp = respuesta.toString();
        }
        return resp;
    }
    
    public static int saveDonanteSustituto(net.sf.json.JSONObject jsonObject, String idUsuario) {
        int result_insert       = 0;        
        ResultSet rs            = null;
        PreparedStatement st    = null;
        MConnection objConn     = new MConnection();
        Connection conn         = null;
        String razonSocialTmp   = "";
        String razonSocial      = "";
        String rfcTmp           = "";
        String rfc              = "";
        

        try {
            
            razonSocialTmp  = jsonObject.getString("RAZON_SOCIAL");            
            razonSocial     = razonSocialTmp.replace("$", "&");
            rfcTmp          = jsonObject.getString("RFC");            
            rfc             = rfcTmp.replace("$", "&");            
                    
            conn = objConn.getConnection(); 
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].DONATIVO_SUSTITUTO_SAVE(?,?,?,?,?,?,?,?,?,?,?,?,?)}");           
            st.setInt(1, jsonObject.getInt("ID_DONANTE_PADRE"));
            st.setString(2, razonSocial);
            st.setString(3, rfc);
            st.setString(4, jsonObject.getString("CURP"));
            st.setInt(5, jsonObject.getInt("TELEFONO"));
            st.setString(6, jsonObject.getString("EMAIL"));
            st.setString(7, jsonObject.getString("CALLE"));
            st.setString(8, jsonObject.getString("NUMERO"));
            st.setString(9, jsonObject.getString("COLONIA"));
            st.setInt(10, jsonObject.getInt("CP"));
            st.setInt(11, jsonObject.getInt("ID_ESTADO"));
            st.setInt(12, jsonObject.getInt("ID_MUNICIPIO"));
            st.setString(13, idUsuario);
            rs = st.executeQuery();
            if (rs.next()){
                result_insert = rs.getInt("RESULTADO");
            }

        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return result_insert;
    }
    
    public static String getDonantesSustitutos(int idDonante) {
        String resp = "";       
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DONATIVO_SUSTITUTOS_LIST(?)}");
            st.setInt(1, idDonante);      
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE_SUSTITUTO", rs.getInt("ID_DONANTE_SUSTITUTO"));
                dato.put("ID_DONANTE_PADRE", rs.getInt("ID_DONANTE_PADRE"));                
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                dato.put("RFC", rs.getString("RFC"));
                dato.put("CURP", rs.getString("CURP"));
                dato.put("TELEFONO", rs.getInt("TELEFONO"));
                dato.put("EMAIL", rs.getString("EMAIL"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("CP", rs.getInt("CP"));
                dato.put("ESTADO", rs.getString("ESTADO"));
                dato.put("MUNICIPIO", rs.getString("MUNICIPIO"));                
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
    
    public static String getComboMunicipios(int idEstado, String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareStatement("SELECT ID,NOMBRE FROM BD_ADMIN.dbo.ADM_CATALOGS_MUNICIPIOS A WHERE ID_estado=? AND NOMBRE LIKE '%" + strQuery.replace(" ", "%") + "%' ORDER BY nombre ASC");

            st.setInt(1, idEstado);
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
MConnection.closeAll(conn, st,rs);          
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getComboPaises(String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT ID, NOMBRE FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES WHERE ID_CATALOG = 27  AND NOMBRE LIKE '%" + strQuery.replace(" ", "%") + "%' ORDER BY nombre ASC");
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
MConnection.closeAll(conn, st,rs);         
            resp = respuesta.toString();
        }
        return resp;
    }

    public static int savedonante(net.sf.json.JSONObject jsonObject, String idUsuario, int ID_DONANTE) {
        int result_insert = 0;
        String r = "";
        ResultSet rs = null;
        PreparedStatement st = null;
        MConnection objConn = new MConnection();
        Connection conn = null;
        String nombreTmp   = "";
        String nombre      = "";
        String rfcTmp      = "";
        String rfc         = "";

        try {
            
            nombreTmp       = jsonObject.getString("NOMBRE");            
            nombre          = nombreTmp.replace("$", "&");
            rfcTmp          = jsonObject.getString("RAZON_SOCIAL");            
            rfc             = rfcTmp.replace("$", "&");
            
            
            conn = objConn.getConnection();            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].VER_SI_EXISTE(?,?,?)}");
            st.setString(1, jsonObject.getString("NOMBRE"));
            st.setString(2, jsonObject.getString("A_PATERNO"));
            st.setString(3, jsonObject.getString("A_MATERNO"));
            rs = st.executeQuery();
            if (rs.next()) {
                result_insert = rs.getInt("RESULT");
            }
            
            if(result_insert == 0){ //No Existe
                System.out.println("No existe");
                st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].AGREGAR_DONANTE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                st.setInt(1, jsonObject.getInt("ID_AB_DONANTE"));            
                st.setInt(2, jsonObject.getInt("ID_PA_DONANTE"));
                st.setInt(3, jsonObject.getInt("ID_TITULO"));
                st.setString(4, nombre);
                st.setString(5, jsonObject.getString("A_PATERNO"));
                st.setString(6, jsonObject.getString("A_MATERNO"));
                st.setInt(7, jsonObject.getInt("ID_TIPO_DONANTE"));
                st.setString(8, jsonObject.getString("FECHA_NAC"));
                st.setInt(9, jsonObject.getInt("ID_CLASIFICACION"));
                st.setInt(10, jsonObject.getInt("ANT_DONANTE"));
                st.setString(11, jsonObject.getString("TEL_CASA"));
                st.setString(12, jsonObject.getString("TEL_OFICINA"));
                st.setString(13, jsonObject.getString("TEL_MOVIL"));
                st.setString(14, rfc);
                st.setString(15, jsonObject.getString("EMAIL"));
                st.setString(16, jsonObject.getString("DESCRIPCION"));
                st.setString(17, jsonObject.getString("CURP"));
                st.setString(18, idUsuario);
                st.setInt(19, ID_DONANTE);
                st.setInt(20, jsonObject.getInt("PERSONALMENTE_DON"));
                st.setInt(21, jsonObject.getInt("ESPECIAL_DON"));
                st.setInt(22, jsonObject.getInt("FACTURA_DONANTE"));            
                rs = st.executeQuery();
                if (rs.next()) {
                    result_insert = rs.getInt(1);
                }
            }

        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return result_insert;
    }
    
    public static int updateDonante(net.sf.json.JSONObject jsonObject, String idUsuario, int ID_DONANTE) {
        int result_insert = 0;
        String r = "";
        ResultSet rs = null;
        PreparedStatement st = null;
        MConnection objConn = new MConnection();
        Connection conn = null;
        String nombreTmp   = "";
        String nombre      = "";
        String rfcTmp      = "";
        String rfc         = "";
        
        nombreTmp       = jsonObject.getString("NOMBRE");            
        nombre          = nombreTmp.replace("$", "&");
        rfcTmp          = jsonObject.getString("RAZON_SOCIAL");            
        rfc             = rfcTmp.replace("$", "&");

        try {
            
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].ACTUALIZAR_DONANTE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            st.setInt(1, jsonObject.getInt("ID_AB_DONANTE"));            
            st.setInt(2, jsonObject.getInt("ID_PA_DONANTE"));
            st.setInt(3, jsonObject.getInt("ID_TITULO"));
            st.setString(4, nombre);
            st.setString(5, jsonObject.getString("A_PATERNO"));
            st.setString(6, jsonObject.getString("A_MATERNO"));
            st.setInt(7, jsonObject.getInt("ID_TIPO_DONANTE"));
            st.setString(8, jsonObject.getString("FECHA_NAC"));
            st.setInt(9, jsonObject.getInt("ID_CLASIFICACION"));
            st.setInt(10, jsonObject.getInt("ANT_DONANTE"));
            st.setString(11, jsonObject.getString("TEL_CASA"));
            st.setString(12, jsonObject.getString("TEL_OFICINA"));
            st.setString(13, jsonObject.getString("TEL_MOVIL"));
            st.setString(14, rfc);
            st.setString(15, jsonObject.getString("EMAIL"));
            st.setString(16, jsonObject.getString("DESCRIPCION"));
            st.setString(17, jsonObject.getString("CURP"));
            st.setString(18, idUsuario);
            st.setInt(19, ID_DONANTE);
            st.setInt(20, jsonObject.getInt("PERSONALMENTE_DON"));
            st.setInt(21, jsonObject.getInt("ESPECIAL_DON"));
            st.setInt(22, jsonObject.getInt("FACTURA_DONANTE"));            
            rs = st.executeQuery();
            if (rs.next()) {
                result_insert = rs.getInt(1);
            }           

        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return result_insert;
    }

    public static String getAlldireccionDonantes(int ID_DONA) {

        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT "
                    + "ID_DIRECCION,"
                    + "ID_DONANTE,"
                    + "B.NOMBRE ID_TIPO_DIRECCION,"
                    + "CALLE,"
                    + "NUMERO,"
                    + "COLONIA,"
                    + "C.NOMBRE ID_ESTADO,"
                    + "D.NOMBRE ID_MUNICIPIO,"
                    + "COD_POSTAL,"
                    + "ENTRE_CALLES,"
                    + "ID_USUARIO,"
                    + "FECHA_CREACION,"
                    + "FECHA_ACTUALIZACION,"
                    + "REFERENCIA,"
                    + "CONTACTO,"
                    + "E.NOMBRE ID_ZONA "
                    + "FROM [DB_INGRESOS].[dbo].[OPE_DIRECCIONES_DONANTE] A "
                    + "LEFT JOIN  [BD_ADMIN].[dbo].[ADM_CATALOGS_VALUES] B ON A.ID_TIPO_DIRECCION =B.ID "
                    + "LEFT JOIN  [BD_ADMIN].[dbo].[ADM_CATALOGS_VALUES] C ON A.ID_ESTADO =C.ID  "
                    + "LEFT JOIN  [BD_ADMIN].[dbo].[ADM_CATALOGS_MUNICIPIOS] D ON A.ID_MUNICIPIO=D.ID "
                    + "LEFT JOIN  [BD_ADMIN].[dbo].[ADM_CATALOGS_VALUES] E ON A.ID_ZONA=E.ID "
                    + "where ID_DONANTE = ? "
                    + "ORDER BY A.ID_TIPO_DIRECCION");

            st.setInt(1, ID_DONA);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DIRECCION", rs.getInt("ID_DIRECCION"));
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("ID_ESTADO", rs.getString("ID_ESTADO"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("COD_POSTAL", rs.getString("COD_POSTAL"));
                dato.put("ID_USUARIO", rs.getString("ID_USUARIO"));
                dato.put("FECHA_CREACION", rs.getString("FECHA_CREACION"));
                dato.put("REFERENCIA", rs.getString("REFERENCIA"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
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
    
    public static int savedirecciondonante(net.sf.json.JSONObject jsonObject, String idUsuario, int person) {
        int result_insert = 0;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = objConn.getConnection();

            pstmt = conn.prepareCall("{ call [DB_INGRESOS].[dbo].AGREGAR_DIRECCION_DONANTE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

            pstmt.setInt(1, person);
            pstmt.setInt(2, jsonObject.getInt("ID_TIPO_DIRECCION"));
            pstmt.setString(3, jsonObject.getString("CALLE"));
            pstmt.setString(4, jsonObject.getString("NUMERO"));
            pstmt.setString(5, jsonObject.getString("COLONIA"));
            pstmt.setInt(6, jsonObject.getInt("ID_PAIS"));
            pstmt.setInt(7, jsonObject.getInt("ID_ESTADO"));
            pstmt.setInt(8, jsonObject.getInt("ID_MUNICIPIO"));
            pstmt.setInt(9, jsonObject.getInt("COD_POSTAL"));
            pstmt.setString(10, jsonObject.getString("ENTRE_CALLES"));
            pstmt.setString(11, idUsuario);
            pstmt.setString(12, jsonObject.getString("REFERENCIA"));
            pstmt.setString(13, jsonObject.getString("CONTACTO"));
            pstmt.setInt(14, jsonObject.getInt("ID_ZONA"));
            pstmt.setString(15, jsonObject.getString("ESTADO"));
            pstmt.setInt(16, jsonObject.getInt("DIRECCION_PRINCIPAL"));
            pstmt.setInt(17, jsonObject.getInt("DIRECCION_FISCAL"));
            pstmt.setInt(18, jsonObject.getInt("ID_RECOLECTOR"));
            pstmt.setInt(19, jsonObject.getInt("DIRECCION_ENTREGA_COBRO"));

            rs = pstmt.executeQuery();
            if (rs.next()) {
                result_insert = rs.getInt(1);
            }

        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
 MConnection.closeAll(conn, pstmt,rs);
        }
        return result_insert;
    }

    public static int actualizardirecciondonante(net.sf.json.JSONObject jsonObject, String idUsuario, int person, int ID_DIRECCION) {
        int result_insert = 0;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = objConn.getConnection();

            pstmt = conn.prepareCall("{ call [DB_INGRESOS].[dbo].AGREGAR_ACTUALIZAR_DIRECCION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            pstmt.setInt(1, person);
            pstmt.setInt(2, jsonObject.getInt("ID_TIPO_DIRECCION"));
            pstmt.setString(3, jsonObject.getString("CALLE"));
            pstmt.setString(4, jsonObject.getString("NUMERO"));
            pstmt.setString(5, jsonObject.getString("COLONIA"));
            pstmt.setInt(6, jsonObject.getInt("ID_PAIS"));
            pstmt.setInt(7, jsonObject.getInt("ID_ESTADO"));
            pstmt.setInt(8, jsonObject.getInt("ID_MUNICIPIO"));
            pstmt.setInt(9, jsonObject.getInt("COD_POSTAL"));
            pstmt.setString(10, jsonObject.getString("ENTRE_CALLES"));
            pstmt.setString(11, idUsuario);
            pstmt.setString(12, jsonObject.getString("REFERENCIA"));
            pstmt.setString(13, jsonObject.getString("CONTACTO"));
            pstmt.setInt(14, jsonObject.getInt("ID_ZONA"));
            pstmt.setString(15, jsonObject.getString("ESTADO"));
            pstmt.setInt(16, ID_DIRECCION);
            pstmt.setInt(17, jsonObject.getInt("ID_RECOLECTOR"));
            pstmt.setInt(18, jsonObject.getInt("DIRECCION_PRINCIPAL"));
            pstmt.setInt(19, jsonObject.getInt("DIRECCION_FISCAL"));
            pstmt.setInt(20, jsonObject.getInt("DIRECCION_ENTREGA_COBRO"));            

            rs = pstmt.executeQuery();
            if (rs.next()) {
                result_insert = rs.getInt(1);
            }

        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, pstmt,rs);
        }
        return result_insert;
    }

    public static String deleteDireccion(String ID_DIRECCION, String id_user) {
        int result_update = 0;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        net.sf.json.JSONObject data = new net.sf.json.JSONObject();
        net.sf.json.JSONObject fInfo = new net.sf.json.JSONObject();
        try {
            conn = objConn.getConnection();
            String sql_update = "DELETE FROM [DB_INGRESOS].[dbo].[OPE_DIRECCIONES_DONANTE] WHERE ID_DIRECCION=?";
            pstmt = conn.prepareStatement(sql_update);
            pstmt.setString(1, ID_DIRECCION);
            result_update = pstmt.executeUpdate();
            fInfo.element("salida", result_update);
            data.element("success", true);
            data.element("fileinfo", fInfo);
        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            System.out.println("SQLException::>" + sql_ex.getMessage());
        } finally {
MConnection.closeAll(conn, pstmt,null);
        }
        return data.toString();
    }

    public static String getDonanteByKeyword(String keyword) {
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

            String sql_search = "SELECT B.ID_DONANTE,( CAST(B.ID_DONANTE AS VARCHAR(50)) + ' - ' + NOMBRE + ' ' + A_PATERNO + ' ' + A_MATERNO ) nombre "
                    + " FROM [DB_INGRESOS].[dbo].[OPE_DONANTES] b "
                    //                    + "INNER JOIN [DB_INGRESOS].[dbo].[OPE_DIRECCIONES_DONANTE] C ON B.ID_DONANTE=C.ID_DONANTE"
                    + " WHERE   (RTRIM(CAST(B.ID_DONANTE AS CHAR)) + ' - ' + B.NOMBRE + ' ' + B.A_PATERNO + ' ' + B.A_MATERNO + ' '+  RTRIM(CAST(B.TEL_CASA AS CHAR)) + ' ' +  RTRIM(CAST(B.TEL_MOVIL AS CHAR)) + ' ' + RTRIM(CAST(B.TEL_OFICINA AS CHAR)) + ' ' + RTRIM(CAST(B.RAZON_SOCIAL AS CHAR))) COLLATE Modern_Spanish_CI_AI LIKE '%" + keyword + "%' ORDER BY NOMBRE + ' ' + A_PATERNO + ' ' + A_MATERNO";
            // String sql_search = "SELECT B.ID_DONANTE,( CAST(B.ID_DONANTE AS VARCHAR(50)) + ' - ' + NOMBRE + ' ' + A_PATERNO + ' ' + A_MATERNO ) nombre,B.TEL_CASA,B.TEL_MOVIL,B.TEL_OFICINA,B.RAZON_SOCIAL,C.COLONIA  FROM    [DB_INGRESOS].[dbo].[OPE_DONANTES] b INNER JOIN [DB_INGRESOS].[dbo].[OPE_DIRECCIONES_DONANTE] C ON B.ID_DONANTE=C.ID_DONANTE WHERE   ( ' C' + RTRIM(CAST(B.ID_DONANTE AS CHAR)) + ' - ' + B.NOMBRE + ' ' + B.A_PATERNO + ' ' + B.A_MATERNO + ' '+  RTRIM(CAST(B.TEL_CASA AS CHAR)) + ' ' +  RTRIM(CAST(B.TEL_MOVIL AS CHAR)) + ' ' + RTRIM(CAST(B.TEL_OFICINA AS CHAR)) + ' ' + RTRIM(CAST(B.RAZON_SOCIAL AS CHAR)) + ' ' + C.COLONIA ) COLLATE Modern_Spanish_CI_AI LIKE '%" + keyword + "%' ORDER BY NOMBRE + ' ' + A_PATERNO + ' ' + A_MATERNO";

            pstmt = conn.prepareStatement(sql_search);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                net.sf.json.JSONObject dato = new net.sf.json.JSONObject();
                dato.put("id", rs.getInt("ID_DONANTE"));
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

    public static String getdonante(int ID_DONANTE) {
        String resp = "";
        String sql_beneficiario = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            sql_beneficiario = "SELECT "
                    + "A.ID_DONANTE,"
                    + "A.ID_AB_DONANTE,"
                    + "A.ID_PA_DONANTE,"
                    + "A.A_PATERNO,"
                    + "A.A_MATERNO,"
                    + "A.NOMBRE,"
                    + "A.ID_TITULO,"
                    + "A.ID_TIPO_DONANTE,"
                    + "A.RAZON_SOCIAL,"
                    + "CONVERT(VARCHAR(20),A.FECHA_NAC,103) AS FECHA_NAC,"
                    + "A.DESCRIPCION,"
                    + "A.FECHA_NAC,"
                    + "A.EMAIL,"
                    + "A.ID_CLASIFICACION,"
                    + "A.TEL_CASA,"
                    + "A.TEL_OFICINA,"
                    + "A.TEL_MOVIL,"
                    + "A.ESTATUS_DONANTE,"
                    + "A.ID_USUARIO,"
                    + "A.ANT_DONANTE,"
                    + "A.CURP,"
                    + "A.PERSONALMENTE,"
                    + "A.DONANTE_ESPECIAL,"
                    + "A.DONANTE_FACTURA "
                    + "FROM [DB_INGRESOS].[dbo].[OPE_DONANTES] A "
                    + "WHERE A.ID_DONANTE=?";
            st = conn.prepareStatement(sql_beneficiario);
            st.setInt(1, ID_DONANTE);

            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getInt("ID_DONANTE"));
                dato.put("ID_AB_DONANTE", rs.getString("ID_AB_DONANTE"));
                dato.put("ID_PA_DONANTE", rs.getString("ID_PA_DONANTE"));
                dato.put("A_PATERNO", rs.getString("A_PATERNO"));
                dato.put("A_MATERNO", rs.getString("A_MATERNO"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("ID_TITULO", rs.getInt("ID_TITULO"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));                
                dato.put("ID_TIPO_DONANTE", rs.getString("ID_TIPO_DONANTE"));
                dato.put("DESCRIPCION", rs.getString("DESCRIPCION"));
                dato.put("FECHA_NAC", rs.getString("FECHA_NAC"));
                dato.put("EMAIL", rs.getString("EMAIL"));
                dato.put("ID_CLASIFICACION", rs.getString("ID_CLASIFICACION"));
                dato.put("TEL_CASA", rs.getString("TEL_CASA"));
                dato.put("TEL_OFICINA", rs.getString("TEL_OFICINA"));
                dato.put("TEL_MOVIL", rs.getString("TEL_MOVIL"));
                dato.put("ANT_DONANTE", rs.getInt("ANT_DONANTE"));
                dato.put("CURP", rs.getString("CURP"));
                dato.put("PERSONALMENTE", rs.getInt("PERSONALMENTE"));
                dato.put("DONANTE_ESPECIAL", rs.getInt("DONANTE_ESPECIAL"));
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
        } finally {
MConnection.closeAll(conn, st,rs);
           
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getDonanteAB(String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT * FROM DB_INGRESOS.dbo.OPE_DONANTES WHERE NOMBRE LIKE '%" + strQuery.replace(" ", "%").toUpperCase() + "%' ORDER BY NOMBRE DESC");

            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
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
            
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getDonantePA(String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT * FROM DB_INGRESOS.dbo.OPE_DONANTES WHERE NOMBRE LIKE '%" + strQuery.replace(" ", "%").toUpperCase() + "%' ORDER BY NOMBRE DESC");

            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE", rs.getString("ID_DONANTE"));
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
           
            resp = respuesta.toString();
        }
        return resp;
    }

    public static String getDireccionUptInfo(int ID_DIRECCION) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_DIRECCION_UPDATE_INFO(?)}");    
            st.setInt(1, ID_DIRECCION);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DIRECCION", rs.getInt("ID_DIRECCION"));
                dato.put("ID_PAIS", rs.getString("ID_PAIS"));
                dato.put("ID_ESTADO", rs.getString("ID_ESTADO"));
                dato.put("ID_MUNICIPIO", rs.getString("ID_MUNICIPIO"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("COD_POSTAL", rs.getString("COD_POSTAL"));
                dato.put("ENTRE_CALLES", rs.getString("ENTRE_CALLES"));
                dato.put("ID_TIPO_DIRECCION", rs.getString("ID_TIPO_DIRECCION"));
                dato.put("ID_ZONA", rs.getString("ID_ZONA"));
                dato.put("CONTACTO", rs.getString("CONTACTO"));
                dato.put("REFERENCIA", rs.getString("REFERENCIA"));
                dato.put("ID_RECOLECTOR", rs.getInt("ID_RECOLECTOR"));
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
    
    public static String getAllRecolectores() {
        String resp = "";       
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();  
        
        try {            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].RECOLECTORES_LIST}");              
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_RECOLECTOR", rs.getInt("ID_RECOLECTOR"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));                
                dato.put("ID_ZONA", rs.getInt("ID_ZONA"));
                dato.put("ZONA", rs.getString("ZONA"));
                dato.put("ID_TIPO_RECOLECTOR", rs.getInt("ID_TIPO_RECOLECTOR"));
                dato.put("TIPO_RECOLECTOR", rs.getString("TIPO_RECOLECTOR"));                
                dato.put("ESTATUS", rs.getString("ESTATUS"));
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
    
    public static int saveRecolector(net.sf.json.JSONObject jsonObject) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].RECOLECTOR_SAVE(?,?,?)}");
            st.setString(1, jsonObject.getString("NOMBRE"));
            st.setInt(2, jsonObject.getInt("ID_TIPO_RECOLECTOR")); 
            st.setInt(3, jsonObject.getInt("ID_ZONA"));                       
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
    
    public String getRecibosEspeciales(String fechaVisita) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {

            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGOS_CONFIRMADOS_GETLIST_ESPECIALES(?)}");
            st.setString(1, fechaVisita);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
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
                dato.put("ZONA", rs.getString("ZONA"));
                dato.put("ID_TIPO_RECOLECTOR", rs.getInt("ID_TIPO_RECOLECTOR"));
                dato.put("TIPO_RECOLECTOR", rs.getString("TIPO_RECOLECTOR"));                
                datos.put(dato);                
            }
            System.out.println("datos: "+datos);
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
    
    public static int asignarReciboARecolectorEspecial(net.sf.json.JSONObject jsonObject, int ID_BITACORA) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].ASIGNAR_RECIBO_A_REC_ESPECIAL(?,?)}");
            st.setInt(1, jsonObject.getInt("ID_RECOLECTOR"));
            st.setInt(2, ID_BITACORA);                                 
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

    public static String getDonanteSustitutoInfo(int idDonante) {        
        String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_SUSTITUTO_INFO(?)}");
            st.setInt(1, idDonante);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DONANTE_TMP", rs.getInt("ID_DONANTE_TMP"));
                dato.put("RAZON_SOCIAL", rs.getString("RAZON_SOCIAL"));
                dato.put("RFC", rs.getString("RFC"));
                dato.put("CURP", rs.getString("CURP"));
                dato.put("TELEFONO", rs.getInt("TELEFONO"));
                dato.put("EMAIL", rs.getString("EMAIL"));
                dato.put("CALLE", rs.getString("CALLE"));
                dato.put("NUMERO", rs.getString("NUMERO"));
                dato.put("COLONIA", rs.getString("COLONIA"));
                dato.put("CP", rs.getInt("CP"));
                dato.put("ID_ESTADO", rs.getInt("ID_ESTADO"));   
                dato.put("ID_MUNICIPIO", rs.getInt("ID_MUNICIPIO"));                         
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

    public static int actualizarDatosSustituto(net.sf.json.JSONObject jsonObject, int idDonanteLocal) {
        int result_insert = 0;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String razonSocialTmp   = "";
        String razonSocial      = "";
        String rfcTmp           = "";
        String rfc              = "";
        
        try {
            
            razonSocialTmp  = jsonObject.getString("RAZON_SOCIAL_UP");            
            razonSocial     = razonSocialTmp.replace("$", "&");
            rfcTmp          = jsonObject.getString("RFC_UP");            
            rfc             = rfcTmp.replace("$", "&");
            
            conn = objConn.getConnection();

            pstmt = conn.prepareCall("{ call [DB_INGRESOS].[dbo].UPDATE_DONANTE_SUSTITUTO(?,?,?,?,?,?,?,?,?,?,?,?)}");            
            pstmt.setInt(1, idDonanteLocal);            
            pstmt.setString(2, razonSocial);            
            pstmt.setString(3, rfc);
            pstmt.setString(4, jsonObject.getString("CURP_UP"));
            pstmt.setInt(5, jsonObject.getInt("TELEFONO_UP"));
            pstmt.setString(6, jsonObject.getString("EMAIL_UP"));
            pstmt.setString(7, jsonObject.getString("CALLE_UP"));
            pstmt.setString(8, jsonObject.getString("NUMERO_UP"));
            pstmt.setString(9, jsonObject.getString("COLONIA_UP"));          
            pstmt.setInt(10, jsonObject.getInt("CP_UP"));
            pstmt.setInt(11, jsonObject.getInt("ID_ESTADO_UP"));
            pstmt.setInt(12, jsonObject.getInt("ID_MUNICIPIO_UP"));                       

            rs = pstmt.executeQuery();
            if (rs.next()) {
                result_insert = rs.getInt(1);
            }

        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
MConnection.closeAll(conn, pstmt,rs);
        }
        return result_insert;
    }

    public static String deleteRecolector(int ID_RECOLECTOR) {
        int result_update = 0;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        net.sf.json.JSONObject data = new net.sf.json.JSONObject();
        net.sf.json.JSONObject fInfo = new net.sf.json.JSONObject();
        try {
            conn = objConn.getConnection();
            String sql_update = "DELETE FROM [DB_INGRESOS].[dbo].[OPE_RECOLECTORES] WHERE ID_RECOLECTOR = ?";
            pstmt = conn.prepareStatement(sql_update);
            pstmt.setInt(1, ID_RECOLECTOR);
            result_update = pstmt.executeUpdate();
            fInfo.element("salida", result_update);
            data.element("success", true);
            data.element("fileinfo", fInfo);
        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            System.out.println("SQLException::>" + sql_ex.getMessage());
        } finally {
MConnection.closeAll(conn, pstmt,null);
        }
        return data.toString();
    }
    
    public static String deleteSustituto(int ID_SUSTITUTO) {
        int result_update = 0;
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        net.sf.json.JSONObject data = new net.sf.json.JSONObject();
        net.sf.json.JSONObject fInfo = new net.sf.json.JSONObject();
        try {
            conn = objConn.getConnection();
            String sql_update = "DELETE FROM [DB_INGRESOS].[dbo].[OPE_DONANTES_SUSTITUOS] WHERE ID_DONANTE_TMP = ?";
            pstmt = conn.prepareStatement(sql_update);
            pstmt.setInt(1, ID_SUSTITUTO);
            result_update = pstmt.executeUpdate();
            fInfo.element("salida", result_update);
            data.element("success", true);
            data.element("fileinfo", fInfo);
        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        } catch (SQLException sql_ex) {
            System.out.println("SQLException::>" + sql_ex.getMessage());
        } finally {
MConnection.closeAll(conn, pstmt,null);
        }
        return data.toString();
    }

    public static String getInfoRecolector(int idRecolector) {        
        String resp = "";        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GET_INFO_RECOLECTOR(?)}");
            st.setInt(1, idRecolector);    
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_RECOLECTOR", rs.getInt("ID_RECOLECTOR"));
                dato.put("NOMBRE", rs.getString("NOMBRE"));
                dato.put("ID_ZONA", rs.getInt("ID_ZONA"));
                dato.put("ID_TIPO_RECOLECTOR", rs.getInt("ID_TIPO_RECOLECTOR"));
                dato.put("ESTATUS", rs.getInt("ESTATUS"));                
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
