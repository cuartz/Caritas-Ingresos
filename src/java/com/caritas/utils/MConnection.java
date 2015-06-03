/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.utils;

import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author RCastilloc
 */
public class MConnection {

    //   private static Connection con1 = null;
    private static DataSource dataSource;
    private static final String DATASOURCE_RESOURCE = "java:comp/env/Caritas";

    static {
        try {
            dataSource = (DataSource) new InitialContext().lookup(DATASOURCE_RESOURCE);
            //displayDbProperties(dataSource.getConnection());
        } catch (NamingException e) {
            throw new ExceptionInInitializerError(e);
        } catch (Exception e) {

        }
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
        } catch (Exception e) {
            System.out.println("Error de seguimiento en getConnection() : " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    private static void closeConnection(Connection con) {
        try {
            if (con != null) {
                con.close();
            }
            con = null;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void rollBack(Connection conn) {
        if (conn != null) {
            try {
                System.out.print("Transaction is being rolled back");
                conn.rollback();
            } catch (SQLException excep) {
                excep.printStackTrace();
            }
        }
    }

//    private DataSource getCaritas() throws NamingException {
//        Context c = new InitialContext();
//        return (DataSource) c.lookup("java:comp/env/Caritas");
//    }
//    private DataSource getCaritas() throws NamingException {
//        Context c = new InitialContext();
//        return (DataSource) c.lookup("java:comp/env/Caritas");
//    }
    public static void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (Exception ext) {
        }
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (Exception ext) {
        }
        try {
            if (conn != null) {
                MConnection.closeConnection(conn);
            }

        } catch (Exception ext) {
            System.out.println("<<Exception>> " + ext.getMessage());
        }
        pstmt = null;
        conn = null;
        rs = null;
    }

    public static void closeAll(Connection conn, CallableStatement call) {
        try {
            if (call != null) {
                call.close();
            }
        } catch (Exception ext) {
        }
        try {
            if (conn != null) {
                MConnection.closeConnection(conn);
            }

        } catch (Exception ext) {
            System.out.println("<<Exception>> " + ext.getMessage());
        }
        call = null;
        conn = null;
    }

    public static void commit(Connection conn) {
        if (conn != null) {
            try {
                conn.commit();
                conn.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println("<<Exception>> " + ex.getMessage());
                Logger.getLogger(MConnection.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

//    public Connection getConnection() {
//        try {
//            //Conexion directa
////            String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
//////            String URLSQL = "jdbc:sqlserver://localhost:1433;databaseName=db_Caritas";
//////            String URLSQL = "0jdbc:sqlserver://192.168.40.32:1433;databaseName=db_Caritas";
////            String URLSQL = "jdbc:sqlserver://192.168.0.11:1433;databaseName=db_Caritas";
////            String USERSQL = "karitas";
////            String PASSSQL = "karitas2011";
//            
//            //CONEXION DIRECTA
//              DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
//           con = getCaritas().getConnection();
//
//        } catch (Exception e) {
//            System.out.println("Error de seguimiento en getConnection() : " + e.getMessage());
//            e.printStackTrace();
//        }
//        return con;
//    }
//
//    /* Mostrar las propiedades del controlador y los detalles de la base de datos */
    public static void displayDbProperties(Connection conn) {
        java.sql.DatabaseMetaData dm = null;
        try {
            if (conn != null) {
                dm = conn.getMetaData();
                System.out.println("URL " + conn.getMetaData().getURL());
                System.out.println("Driver Loaded");
                System.out.println("\tName: " + dm.getDriverName() + " Version:" + dm.getDriverVersion());
                System.out.println("\tDatabase : " + dm.getDatabaseProductName() + " Version:" + dm.getDatabaseProductVersion());
            } else {
                System.out.println("Error: No hay ninguna conexión activa");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        dm = null;
    }
//
//    public void closeConnection() {
//        try {
//            if (con != null) {
//                con.close();
//            }
//            con = null;
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
////    private DataSource getCaritas() throws NamingException {
////        Context c = new InitialContext();
////        return (DataSource) c.lookup("java:comp/env/Caritas");
////    }
//    private DataSource getCaritas() throws NamingException {
//        Context c = new InitialContext();
//        return (DataSource) c.lookup("java:comp/env/Caritas");
//    }
}
