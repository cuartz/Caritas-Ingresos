/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.bl;

import com.caritas.utils.Base64Coder;
import com.caritas.utils.MConnection;
import com.caritas.utils.MD5Hashing;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author RCastilloc
 */
public class loginBL { //loginBL
    public static String validateUser(String loginusr,String loginpass){
        String resp = "";

        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();

        PreparedStatement st = null;
        ResultSet rs = null;
            
        try {
            String sqlQuery = "SELECT HASHBYTES('MD5',id_usuario) IDUSERMD5 FROM BD_ADMIN.dbo.ADM_USUARIOS WHERE ID_USUARIO=? AND PASSWORD=?";
            st = conn.prepareStatement(sqlQuery);            
            st.setString(1, loginusr.toUpperCase());
            st.setString(2, MD5Hashing.getMD5(loginpass));
            rs = st.executeQuery();
            while (rs.next()){
                resp = loginusr.toUpperCase()+":"+Base64Coder.encodeString(loginusr.toUpperCase());
            }
        } catch (SQLException ex) {
            System.out.println("<SQLException>> " + ex.getMessage());
            Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }
    
    public static String hideLogin(String stringSession){
        if(stringSession.equals("")){
            return "";
        } else {
            return "style=\"display:none\"";
        }
    }
    
    public static String infoLogin(String stringSession){
        if(stringSession.equals("")){
            return "";
        } else {
            String resp= "";
            MConnection objConn = new MConnection();
            Connection conn = objConn.getConnection();
            PreparedStatement st = null;
            ResultSet rs = null;
            
            try {
                String sqlQuery = "SELECT NOMBRE,EMAIL,DESCRIPCION PERFIL FROM BD_ADMIN.dbo.ADM_USUARIOS A INNER JOIN BD_ADMIN.dbo.ADM_PERFIL B ON A.ID_PERFIL=B.ID_PERFIL WHERE ID_USUARIO=?";
                st = conn.prepareStatement(sqlQuery);
                st.setString(1, stringSession.split(":")[0]);
                rs = st.executeQuery();
                while (rs.next())
                {
                    resp = "<table width='100%'><tr><td align='right'>Bienvenid@ " +rs.getString("nombre")+ " " +"<a href='login.do?logout=1' ></td><td><a href='login.do?logout=1' ><img src='img/salir.png' width='30' border='0'></a></td></tr></table>";                    
                }
                
            } catch (SQLException ex) {
                System.out.println("<SQLException>> " + ex.getMessage());
                Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
MConnection.closeAll(conn, st,rs);
            }                
            return resp;
        }
    }    
    
    public static String getMenuUser(String stringSession){
        String resp = "";
        if(stringSession.equals("")){
            return "";
        } else {
            MConnection objConn = new MConnection();
            Connection conn = objConn.getConnection();

            PreparedStatement st = null;
            ResultSet rs = null;
            ResultSet rs2 = null;

            try {//MODIFICADO
                st = conn.prepareStatement("SELECT ID,MODULO FROM BD_ADMIN.dbo.ADM_PERMISOS WHERE ID_PADRE IS NULL AND ID IN (SELECT DISTINCT ID_PADRE FROM BD_ADMIN.dbo.ADM_PERMISOS WHERE ID_APLICACION=3 AND ID_PADRE IS NOT NULL)");
                rs = st.executeQuery();
                while (rs.next())
                {
                    String hijos = "";

                    st = conn.prepareStatement("SELECT A.ID,A.MODULO, B.MODULO PADRE, CASE WHEN (SELECT B.ID FROM BD_ADMIN.dbo.ADM_PERMISOS B WHERE ID IN(SELECT COL AS PERM FROM F_ConvertStringToTable((SELECT PERMISOS FROM BD_ADMIN.dbo.ADM_PERFIL WHERE ID_PERFIL=(SELECT ID_PERFIL FROM BD_ADMIN.dbo.ADM_USUARIOS WHERE ID_USUARIO=?)), ';')) AND B.ID=A.ID) IS NOT NULL THEN 1 ELSE 0 END CHECKED, A.LINK, A.FUNCTIONS FROM BD_ADMIN.dbo.ADM_PERMISOS A INNER JOIN (SELECT * FROM BD_ADMIN.dbo.ADM_PERMISOS WHERE ID_PADRE IS NULL) B ON A.ID_PADRE=B.ID WHERE A.ID_PADRE=?");
                    st.setString(1, stringSession.split(":")[0]);
                    st.setString(2, rs.getString("id"));
                    rs2 = st.executeQuery();
                    boolean isfirst=true;
                    while (rs2.next()){
                        if(isfirst){
                            hijos += "<ul>";
                            isfirst = false;
                        }
                        if(rs2.getString("checked").equals("1")){
                            hijos += "<li class=\"\"><a href=\"#\" title=\"\" onClick=\""+rs2.getString("functions")+"('"+rs2.getString("link")+"','"+rs.getString("modulo")+" - "+rs2.getString("modulo")+"','stage');\">"+rs2.getString("modulo")+"</a></li>";
                        }
                    }
                    if(!isfirst){
                        hijos += "</ul>";
                    }

                    resp += "<ul class=\"sf-menu\"><li class=\"\"><a href=\"#\" title=\""+rs.getString("modulo")+"\">"+rs.getString("modulo")+"</a>"+hijos+"</li></ul><div class=\"mmDivider\"></div>";
                }               
            } catch (SQLException ex) {
                System.out.println("<SQLException>> " + ex.getMessage());
                Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    if (rs2!=null){
                    rs2.close();
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(loginBL.class.getName()).log(Level.SEVERE, null, ex);
                }
MConnection.closeAll(conn, st,rs);
            }
         return resp;
        }
    }                            
    
}
