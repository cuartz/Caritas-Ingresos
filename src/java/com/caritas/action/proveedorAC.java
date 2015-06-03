/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.bl.proveedorBL;
//import com.caritas.bl.registroBL;
import com.caritas.properties.Dummy;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


/**
 *
 * @author jzamora
 */
public class proveedorAC extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";

    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
       public ActionForward execute(ActionMapping mapping, ActionForm form,
//       public ActionForward getAllproveedoresDir(ActionMapping mapping, ActionForm form,
            
            HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
        JSONArray jsonList = new JSONArray();
        System.out.println("Execute- proveedorAC" );
        try {
            String strQuery = request.getParameter("query")==null?"":request.getParameter("query");
            
            proveedorBL scbl = new proveedorBL();
            
            salida = scbl.getAllproveedoresDir(strQuery);
//            salida = scbl.getAllproveedoresDir();
            
            System.out.println("<datasss.toString()>> " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mapping.findForward(SUCCESS);
    }

        public ActionForward guardaProveedor(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response) {
        String salida = "";
   
            int ID = (request.getParameter("ID")==null||request.getParameter("ID").equals("null")||request.getParameter("ID").equals(""))?0:Integer.parseInt(request.getParameter("ID"));
            int Id_Direccion_Proveedor = (request.getParameter("Id_Direccion_Proveedor")==null||request.getParameter("Id_Direccion_Proveedor").equals("null")||request.getParameter("Id_Direccion_Proveedor").equals(""))?0:Integer.parseInt(request.getParameter("Id_Direccion_Proveedor"));
            String Prov_Direccion = request.getParameter("Prov_Direccion")==null?"":request.getParameter("Prov_Direccion");
            String Prov_RFC = request.getParameter("Prov_RFC")==null?"":request.getParameter("Prov_RFC");
            String Prov_Telefono = request.getParameter("Prov_Telefono")==null?"":request.getParameter("Prov_Telefono");
            String Prov_Email = request.getParameter("Prov_Email")==null?"":request.getParameter("Prov_Email");
            String Prov_Contacto = request.getParameter("Prov_Contacto")==null?"":request.getParameter("Prov_Contacto");
            String Prov_Observaciones = request.getParameter("Prov_Observaciones")==null?"":request.getParameter("Prov_Observaciones");
            int Id_Proveedor = (request.getParameter("Id_Proveedor")==null||request.getParameter("Id_Proveedor").equals("null")||request.getParameter("Id_Proveedor").equals(""))?0:Integer.parseInt(request.getParameter("Id_Proveedor"));
            int Id_CUENTA = (request.getParameter("Id_CUENTA")==null||request.getParameter("Id_CUENTA").equals("null")||request.getParameter("Id_CUENTA").equals(""))?0:Integer.parseInt(request.getParameter("Id_CUENTA"));
            int Prov_Numero_d_Cuenta = (request.getParameter("Prov_Numero_d_Cuenta")==null||request.getParameter("Prov_Numero_d_Cuenta").equals("null")||request.getParameter("Prov_Numero_d_Cuenta").equals(""))?0:Integer.parseInt(request.getParameter("Prov_Numero_d_Cuenta"));

            JSONArray jsonList = new JSONArray();
        try {
            
            proveedorBL rbl = new proveedorBL();
            
            salida = rbl.guardaProveedor(ID,Id_Direccion_Proveedor,Prov_Direccion,Prov_RFC,Prov_Telefono,Prov_Email,Prov_Contacto,Prov_Observaciones,Id_Proveedor,Id_CUENTA,Prov_Numero_d_Cuenta);
            
            System.out.println("<datasss.toString()>> " + salida);
            request.setAttribute("resp", salida);
        } catch (Exception e) {
        }
        return mapping.findForward(SUCCESS);
    }
       
       
       
       
       
//    public ActionForward guardaProveedor(ActionMapping mapping, ActionForm form,
//            HttpServletRequest request, HttpServletResponse response) throws Exception {
//        String salida = "";
//        Properties properties = new Properties();
//        String sExtension = "";
//        String file_path = "";
//        String file_prefix ="";
//        String file_name = "";
//        String file_nameOnly = "";
//        
//        String jsonValues = request.getParameter("jsonData");
//        int Id_Direccion_Proveedor = (request.getParameter("Id_Direccion_Proveedor")==null||request.getParameter("Id_Direccion_Proveedor").equals("null")||request.getParameter("Id_Direccion_Proveedor").equals(""))?0:Integer.parseInt(request.getParameter("Id_Direccion_Proveedor"));
//        String idUsuario = request.getParameter("idUsuario");
////        String nombreArchivo = request.getParameter("nombreArchivo");
//        
//        System.out.println("jsonValues: " + jsonValues);
//
//        try {
//            JSONObject jsonObject = JSONObject.fromObject(jsonValues);
//            String UID = registroBL.guardaRegistro(jsonObject, Id_Direccion_Proveedor,idUsuario);
//            
//            properties.load(Dummy.class.getResourceAsStream("config.properties"));
//            
//            long maxSize = 1024 * 1024 * 1;//1Mb
//            DiskFileItemFactory DiskFile = new DiskFileItemFactory();
//            ServletFileUpload srvFileUpload = new ServletFileUpload(DiskFile);
//            srvFileUpload.setSizeMax(maxSize);
//            
//            List fileItems = srvFileUpload.parseRequest(request);
//            if (fileItems != null) {
//                Iterator iterator = fileItems.iterator();
//                FileItem actual = null;
////                long startTime = System.nanoTime();
////                SimpleDateFormat simpleDate = new SimpleDateFormat("SSSSSS");
//                String idFile = UID.split("-")[0]+"_"+Id_Direccion_Proveedor;
//                while (iterator.hasNext()) {
//                    actual = (FileItem) iterator.next();
//                    if (actual.getSize() <= 0) {
//                        continue;
//                    }
//                    if (actual.getName() != null) {
//                        StringTokenizer strNombreToken = new StringTokenizer(actual.getName(), ".");
//                        while (strNombreToken.hasMoreTokens()) {
//                            sExtension = strNombreToken.nextToken();
//                        }
//                        file_path = properties.getProperty("fotoPath");
//                        file_prefix = properties.getProperty("fotoPrefijo");
//                    }
//                    if(!sExtension.equals("")){
//                        file_name = file_path + file_prefix+idFile + "." + sExtension;
//                        file_nameOnly = file_prefix + idFile + "." + sExtension;
//
//                        File uploadedFile = new File(file_name);
//                        actual.write(uploadedFile);
//                        registroBL.actualizaFoto(UID,file_nameOnly);
//                    }
//                }
//            }
//            
//            Id_Direccion_Proveedor = registroBL.getIdBeneficiarioByUID(UID);
//            int idRegistro = registroBL.getIdRegistroByUID(UID);
//            String datos = "{'success': 'true','data':{'uid':'" + UID + "','id_beneficiario':"+Id_Direccion_Proveedor+",'id_registro':"+idRegistro+"}}";
//            request.setAttribute("resp", datos);
//        } catch (JSONException e){
//            System.out.println(e.getMessage());
//        } catch (Exception ex){
//            ex.printStackTrace();
//            System.out.println(ex.getMessage());
//        }
//        return mapping.findForward(SUCCESS);
//    }
    
//    public ActionForward uptInfoproveedoresDir(ActionMapping mapping, ActionForm form,
//            
//        HttpServletRequest request, HttpServletResponse response) {
//        
//        String salida = "";
//
//        try {
//            System.out.println(request.getCharacterEncoding());
//                    
//            int ID = request.getParameter("ID")==null?0:Integer.parseInt(request.getParameter("ID"));
//            String NOMBRE = request.getParameter("NOMBRE")==null?"":request.getParameter("NOMBRE");
//            int Id_Direccion_Proveedor = request.getParameter("Id_Direccion_Proveedor")==null?0:Integer.parseInt(request.getParameter("Id_Direccion_Proveedor"));
//            String Prov_Direccion = request.getParameter("Prov_Direccion")==null?"":request.getParameter("Prov_Direccion");
//            String Prov_RFC = request.getParameter("Prov_RFC")==null?"":request.getParameter("Prov_RFC");
//            String Prov_Telefono = request.getParameter("Prov_Telefono")==null?"":request.getParameter("Prov_Telefono");
//            String Prov_Email = request.getParameter("Prov_Email")==null?"":request.getParameter("Prov_Email");
//            String Prov_Contacto = request.getParameter("Prov_Contacto")==null?"":request.getParameter("Prov_Contacto");
//            String Prov_Observaciones = request.getParameter("Prov_Observaciones")==null?"":request.getParameter("Prov_Observaciones");
//            String Id_Proveedor = request.getParameter("Id_Proveedor")==null?"":request.getParameter("Id_Proveedor");
//            String Id_CUENTA = request.getParameter("Id_CUENTA")==null?"":request.getParameter("Id_CUENTA");
//            String Prov_Numero_d_Cuenta = request.getParameter("Prov_Numero_d_Cuenta")==null?"":request.getParameter("Prov_Numero_d_Cuenta");
//           
//            proveedorBL scbl = new proveedorBL();
//            
//            System.out.println("<datasss.toString()>> " + salida);
//            request.setAttribute("resp", salida);
//        } catch (Exception e) {
//        }
//        return mapping.findForward(SUCCESS);
//    }          
//            
//    public ActionForward cancelaproveedoresDir(ActionMapping mapping, ActionForm form,
//            
//        HttpServletRequest request, HttpServletResponse response) {
//        String salida = "";
//
//        try {
//            
//            String id = request.getParameter("id")==null?"":request.getParameter("id");
//            
//            proveedorBL scbl = new proveedorBL();
//            
//            salida = scbl.cancelaproveedoresDir(id);
//            
//            System.out.println("<datasss.toString()>> " + salida);
//            request.setAttribute("resp", salida);
//        } catch (Exception e) {
//        }
//        return mapping.findForward(SUCCESS);
//    }

  
 
}
