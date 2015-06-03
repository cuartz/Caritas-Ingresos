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

public class tesoreriaBL {
    /* Metodo que trae los donativos en efectivo ya confirmados de cada recolector */
    public String getAllCobrosEfectivo(int idRecolector, String fechaVisita, int idZona, String start, String limit, String idRecibo, String nombre) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GET_COBROS_EFECTIVO_PAGADOS(?,?,?,?,?,?,?)}");
            st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona);
            st.setString(4, start);
            st.setString(5, limit); 
            st.setString(6, idRecibo); 
            st.setString(7, nombre);             
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
                dato.put("FECHA_VISITA", rs.getString("FECHA_VISITA"));
                dato.put("ID_TIPO_DONATIVO", rs.getInt("ID_TIPO_DONATIVO"));
                dato.put("REFERENCIA", rs.getString("REFERENCIA"));
                dato.put("COMENTARIOS", rs.getString("COMENTARIOS"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO")); 
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO")); 
                dato.put("ESTATUS_PAGO", rs.getString("ESTATUS_PAGO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("FECHA_IMPRESION", rs.getString("FECHA_IMPRESION"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_TESORERIA_GET_COBROS_EFECTIVO_PAGADOS(?,?,?,?,?,?,?)}");
            st.setInt(1, idRecolector);
            st.setString(2, fechaVisita);
            st.setInt(3, idZona);
            st.setString(4, start);
            st.setString(5, limit);
            st.setString(6, idRecibo); 
            st.setString(7, nombre); 
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }

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
    
    public String getAllCobrosEfectivoPagadosTmp() {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GET_PAGOS_CONFIRMADOS}");             
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                dato.put("ID_DONATIVO", rs.getInt("ID_DONATIVO"));
                dato.put("NUM_PAGO", rs.getInt("NUM_PAGO"));
                dato.put("ID_RECOLECTOR", rs.getInt("ID_RECOLECTOR"));
                dato.put("FECHA_COBRO", rs.getString("FECHA_COBRO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
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
    
    public static int confirmacionCobro(net.sf.json.JSONObject jsonObject, int idBitacora, String idUsuario, int option) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;
        String fecha        = "";
            
        try {
            if(option == 1){                
                conn = objConn.getConnection();
                st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPROGRAMACION_INGRESOS_DIA_SIGUIENTE(?,?,?,?,?,?)}");            
                st.setString(1, jsonObject.getString("FECHA_REPROGRAMACION_CC"));
                st.setString(2, jsonObject.getString("ID_DIRECCION_CCC"));
                st.setString(3, jsonObject.getString("ID_RECOLECTOR_CCC"));
                st.setString(4, jsonObject.getString("COMENTARIOS"));
                st.setInt(5, idBitacora); 
                st.setString(6, idUsuario);                
                rs = st.executeQuery();
                if (rs.next()){
                    result_insert = rs.getInt("RESULTADO");                
                }
            }else{                
                conn = objConn.getConnection();
                st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPROGRAMACION_INGRESOS_DESPUES(?,?,?)}");                            
                st.setString(1, jsonObject.getString("COMENTARIOS"));
                st.setInt(2, idBitacora); 
                st.setString(3, idUsuario);                
                rs = st.executeQuery();
                if (rs.next()){
                    result_insert = rs.getInt("RESULTADO");                
                }
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
    
    public String reprogramacionLoadInfo(int idBitacora) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPROGRAMACION_LOAD_INFO(?)}");
            st.setInt(1, idBitacora);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_DIRECCION_COBRO", rs.getInt("ID_DIRECCION_COBRO"));
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
  
    public static int tesoreriaConfirmacionCobro(net.sf.json.JSONObject jsonObject, int idBitacora, String idUsuario) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].CONFIRMAR_PAGO_ADMON(?,?,?,?,?)}");             
            st.setInt(1, jsonObject.getInt("CHKBOX_YES"));
            st.setString(2, jsonObject.getString("FECHA_PAGO_ADMON"));
            st.setInt(3, jsonObject.getInt("ID_FORMA_PAGO_ADMON"));
            st.setString(4, idUsuario);
            st.setInt(5, idBitacora); 
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
    
    public static String generarArchivoFactura(int ID_BITACORA) {
        int result_insert = 0; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            System.out.println("ID_BITACORA: "+ID_BITACORA);
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].TESORERIA_GENERAR_ARCHIVO_FACTURA(?)}");
            st.setInt(1, ID_BITACORA);  
            rs = st.executeQuery();
//            if (rs.next()){
//                result_insert = rs.getInt("RESULTADO");
//                if(result_insert == 1)
//                    resp = "success";
//                else
//                     resp = "failure";
//            } 
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
            MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }    
    
    public static int reciboModificarFechaPago(net.sf.json.JSONObject jsonObject, int idBitacora) {        
        int result_insert = 0;     
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;               
            
        try {
            conn = objConn.getConnection();
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].RECIBO_MODIFICAR_FECHA_PAGO_TESORERIA(?,?)}");             
            st.setString(1, jsonObject.getString("FECHA_PAGO_TESORERIA")); 
            st.setInt(2, idBitacora); 
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
    
    public String getReporteDiarioEspecie(String fechaPago) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_DIARIO_DESGLOSE_ESPECIE(?)}");
            st.setString(1, fechaPago); // fechaPago);                       
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("NUM", rs.getInt("NUM"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("PROYECTO", rs.getString("PROYECTO"));
                dato.put("NUM_FRECUENCIA", rs.getString("NUM_FRECUENCIA"));                
                dato.put("FECHA_VENCIMIENTO", rs.getString("FECHA_VENCIMIENTO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("CUENTA", rs.getString("CUENTA"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("RECOLECTOR", rs.getString("RECOLECTOR"));
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
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
    
    public String getReporteDiarioTres(String fechaIni, String fechaFin, String start, String limit) {
        String resp = "";
        
        MConnection objConn = new MConnection();        
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();       
        try {
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].REPORTE_MENSUAL_DESGLOSE(?,?,?,?)}");
            st.setString(1, fechaIni);
            st.setString(2, fechaFin);
            st.setString(3, start);
            st.setString(4, limit);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("NUM", rs.getInt("NUM"));
                dato.put("ID_RECIBO", rs.getString("ID_RECIBO"));
                dato.put("PROYECTO", rs.getString("PROYECTO"));
                dato.put("NUM_FRECUENCIA", rs.getString("NUM_FRECUENCIA"));                
                dato.put("FECHA_VENCIMIENTO", rs.getString("FECHA_VENCIMIENTO"));
                dato.put("FECHA_PAGO", rs.getString("FECHA_PAGO"));
                dato.put("IMPORTE", rs.getInt("IMPORTE"));
                dato.put("FORMA_PAGO", rs.getString("FORMA_PAGO"));
                dato.put("CUENTA", rs.getString("CUENTA"));
                dato.put("ASIGNACION", rs.getString("ASIGNACION"));
                dato.put("RECOLECTOR", rs.getString("RECOLECTOR"));
                dato.put("ID_BITACORA", rs.getInt("ID_BITACORA"));
                datos.put(dato);
            }
            respuesta.put("rows", datos);
            
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].PAGINADO_REPORTE_MENSUAL_DESGLOSE(?,?)}");
            st.setString(1, fechaIni);
            st.setString(2, fechaFin);            
            rs = st.executeQuery();
            if(rs.next()){
                respuesta.put("totalcount", rs.getString("TOTAL"));
            }

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
    
    public static String generarArchivoAdminPack(String bitacoras) {
        int result_insert = 1; 
        String resp = "";
        ResultSet rs = null;
        PreparedStatement st = null;       
        MConnection objConn = new MConnection();
        Connection conn = null;        
            
        try {
            conn = objConn.getConnection();
            System.out.println("ID_BITACORA: "+bitacoras);
            st = conn.prepareCall("{ call [DB_INGRESOS].[dbo].GENERAR_ARCHIVO_PARA_ADMIN_PAQ(?)}");
            st.setString(1, bitacoras);  
            rs = st.executeQuery();
            if (rs.next()){
                //result_insert = rs.getInt("RESULTADO");
                if(result_insert == 1)
                    resp = "success";
                else
                     resp = "failure";
            } 
        }catch (net.sf.json.JSONException json_ex) {
            System.out.println("JSONException::>" + json_ex.getMessage());
        }catch (SQLException sql_ex) {
            sql_ex.printStackTrace();
        } finally {
            MConnection.closeAll(conn, st,rs);
        }
        return resp;
    }
    
     public static String getFormaDePagoByBitacora(int idBitacora) {
       String resp = "";
        MConnection objConn = new MConnection();
        Connection conn = objConn.getConnection();
        PreparedStatement st = null;
        ResultSet rs = null;
        JSONObject respuesta = new JSONObject();
        JSONArray datos = new JSONArray();
        try {
            st = conn.prepareStatement("SELECT ID_FORMA_PAGO FROM DB_INGRESOS.dbo.OPE_BITACORA_PAGOS_DONATIVOS BITA WHERE BITA.ID_BITACORA = ?");     
            st.setInt(1, idBitacora);
            rs = st.executeQuery();
            while (rs.next()) {
                JSONObject dato = new JSONObject();
                dato.put("ID_FORMA_PAGO", rs.getInt("ID_FORMA_PAGO"));                
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