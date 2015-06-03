///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
package com.caritas.bl;

//import com.caritas.action.solicitudchequeAC;
import com.caritas.action.proveedorAC;

import com.caritas.utils.MConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.HashMap;
import java.io.File;

import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

import java.sql.SQLException;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author jzamora
 */
public class proveedorBL {

    public static String getAllproveedoresDir(String strQuery) {
        String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT A.ID,A.NOMBRE,C.Id_Direccion_Proveedor,C.Prov_Direccion,C.Prov_RFC,C.Prov_Telefono,C.Prov_Email,C.Prov_Contacto,C.Prov_Observaciones,C.Id_Proveedor,C.Id_CUENTA,C.Prov_Numero_d_Cuenta FROM BD_ADMIN.dbo.ADM_CATALOGS_VALUES A "
                    + " INNER JOIN BD_ADMIN.dbo.ADM_CATALOGS B ON A.ID_CATALOG=B.ID "
                    + " LEFT JOIN BD_ADMIN.dbo.ADM_DIRECCION_PROVEEDOR C ON A.ID = C.Id_Proveedor"
                    + " WHERE B.LLAVE='TIPO_PROVEEDORES' AND A.NOMBRE LIKE '%"+strQuery.replace(" ", "%").toUpperCase()+"%' order by a.ID desc ");

            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID", rs.getInt("ID"));
                dato.put("NOMBRE", rs.getString("NOMBRE").toUpperCase().replace(strQuery.toUpperCase(), "<font color='orange'>"+strQuery+"</font>"));
                dato.put("Id_Direccion_Proveedor", rs.getInt("Id_Direccion_Proveedor"));
                dato.put("Prov_Direccion", rs.getString("Prov_Direccion"));
                dato.put("Prov_RFC", rs.getString("Prov_RFC"));
                dato.put("Prov_Telefono", rs.getString("Prov_Telefono"));
                dato.put("Prov_Email", rs.getString("Prov_Email"));
                dato.put("Prov_Contacto", rs.getString("Prov_Contacto"));
                dato.put("Prov_Observaciones", rs.getString("Prov_Observaciones"));
                dato.put("Id_Proveedor", rs.getInt("Id_Proveedor"));
                dato.put("Id_CUENTA", rs.getInt("Id_CUENTA"));
                dato.put("Prov_Numero_d_Cuenta", rs.getInt("Prov_Numero_d_Cuenta"));

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

    
// public static String guardaProveedor(net.sf.json.JSONObject jsonObject, int Id_Direccion_Proveedor,String idUsuario/*, int idDomicilio, String nombreArchivo, String idUsuario*/) {
 public static String guardaProveedor(int ID,int Id_Direccion_Proveedor,String Prov_Direccion,String Prov_RFC,String Prov_Telefono,String Prov_Email,String Prov_Contacto,String Prov_Observaciones,int Id_Proveedor,int Id_CUENTA,int Prov_Numero_d_Cuenta) {
        MConnection objConn = new MConnection();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql_insert = "";
        String sql_update = "";
        String result = "FAILED";

        try {
            conn = objConn.getConnection();
            String UID = UUID.randomUUID().toString();
            
            if (Id_Direccion_Proveedor == 0) {
                sql_insert = "INSERT INTO ADM_DIRECCION_PROVEEDOR ( "
	+ " Prov_Direccion, "
	+ " Prov_RFC, "
	+ " Prov_Telefono, "
	+ " Prov_Email, "
	+ " Prov_Contacto, "
	+ " Prov_Observaciones, "
	+ " Id_Proveedor, "
	+ " Id_CUENTA, "
	+ " Prov_Numero_d_Cuenta "
+ " ) VALUES ( ?,?,?,?,?,?,?,?,? ) ";
                //Id_Proveedor
                pstmt = conn.prepareStatement(sql_insert);
//                
                pstmt.setInt(1,Id_Direccion_Proveedor);
                pstmt.setString(2,Prov_Direccion);
                pstmt.setString(3,Prov_RFC);
                pstmt.setString(4, Prov_Telefono);
                pstmt.setString(5,Prov_Email);
                pstmt.setString(6, Prov_Contacto);
                pstmt.setString(7, Prov_Observaciones);
                pstmt.setInt(8,Id_Proveedor);
                pstmt.setInt(9, Id_CUENTA);
                pstmt.setInt(10, Prov_Numero_d_Cuenta);
                

                if(pstmt.executeUpdate()==1){
                    System.out.println("Se Inserto un nuevo Beneficiario UID: " + UID);
//                    if(proveedorBL.guardaProveedor(jsonObject,UID,false)==1){
//                        if(registroBL.guardaRegistro(jsonObject,UID,idUsuario)==1){
//                            result = UID;
//                        }
//                    }
                }
            } else {
                sql_update = "UPDATE ADM_DIRECCION_PROVEEDOR SET Prov_Direccion=?, "
	+ " Prov_RFC=?, "
	+ " Prov_Telefono=?, "
	+ " Prov_Email=?, "
	+ " Prov_Contacto=?, "
	+ " Prov_Observaciones=?, "
	+ " Id_Proveedor=?, "
	+ " Id_CUENTA=?, "
	+ " Prov_Numero_d_Cuenta=? "
	+ " WHERE Id_Direccion_Proveedor= ? ";
                pstmt = conn.prepareStatement(sql_update);
                  pstmt.setInt(1,ID);
                pstmt.setInt(3,Id_Direccion_Proveedor);
                pstmt.setString(4,Prov_Direccion);
                pstmt.setString(5,Prov_RFC);
                pstmt.setString(6, Prov_Telefono);
                pstmt.setString(7,Prov_Email);
                pstmt.setString(8, Prov_Contacto);
                pstmt.setString(9, Prov_Observaciones);
                pstmt.setInt(10, Id_Proveedor);
                pstmt.setInt(11, Id_CUENTA);
                pstmt.setInt(12, Prov_Numero_d_Cuenta);

                
                if(pstmt.executeUpdate()==1){
                    System.out.println("Se Actualizo Beneficiario : " + Id_Direccion_Proveedor);
                    PreparedStatement st = null;
//                    st = conn.prepareStatement("SELECT UID FROM OPE_BENEFICIARIOS WHERE ID_BENEFICIARIO = ?");
                    st.setInt(1, Id_Direccion_Proveedor);  
                    rs = st.executeQuery();
                    if (rs.next()) {
//                        UID = rs.getString("uid");
//                        if(proveedorBL.guardaProveedor(jsonObject,UID,true)==1){
////                            if(registroBL.guardaRegistro(jsonObject,UID,idUsuario)==1){
////                                result = UID;
////                            }
//                        }
                    }
                }
            }
        } catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
            json_ex.printStackTrace();
        } catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
            System.out.println("SQLException::>" + sql_ex.getMessage());
        } finally {
MConnection.closeAll(conn, pstmt,rs);
        }
        return result;
    }

}
