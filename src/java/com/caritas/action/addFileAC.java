/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.action;

import com.caritas.properties.Dummy;
import com.caritas.utils.MConnection;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

public class addFileAC extends DispatchAction {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    Properties properties; 

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction1,
     * where "method" is the value specified in <action> element : 
     * ( <action parameter="method" .../> )
     */
  public ActionForward saveFile(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println(" va a guardar un archivo");
        String sIdArchivo = request.getParameter("idArchivo");
        int iTipoArchivo = Integer.parseInt(request.getParameter("tipoArchivo"));
        Properties properties = new Properties();
        String sExtension = "";
        String nameFileProperties = "config";
        boolean bTemp = false;
        try {
            properties.load(Dummy.class.getResourceAsStream(nameFileProperties + ".properties"));
            String er = "";
            String datos = "";
            long mb = 1024 * 1024 * 5;//5Mb
            DiskFileItemFactory dfif = new DiskFileItemFactory();
            ServletFileUpload sfu = new ServletFileUpload(dfif);
            sfu.setSizeMax(mb);
            List fileItems = sfu.parseRequest(request);
            if (fileItems == null) {
                System.out.println(" es null el request....");
                return mapping.findForward("");
            }
            Iterator iterator = fileItems.iterator();
            FileItem actual = null;
            if (sIdArchivo.compareTo("0") == 0) {

                long startTime = System.nanoTime();
                SimpleDateFormat sdf = new SimpleDateFormat("SSSSSS");
                er = "" + (int) (startTime/10000000);
            }
            else {
                bTemp = true;
                er = sIdArchivo;
            }

            String file_path = "";
            String file_prefix = "";
            String file_name = "";
            String file_nameOnly = "";

            int e = 0;
            while (iterator.hasNext()) {
                actual = (FileItem) iterator.next();
                if (actual.getSize() <= 0) {
                    continue;
                }
                if (actual.getName() != null) {
                    StringTokenizer strNombreToken = new StringTokenizer(actual.getName(), ".");
                    while (strNombreToken.hasMoreTokens()) {
                        sExtension = strNombreToken.nextToken().toLowerCase();
                    }
                    switch (iTipoArchivo) {
                        case 1:
                            file_path = properties.getProperty("fotoPath");
                            System.out.println("Numero: " + er);
                            System.out.println("Longitud: " + er.length());
                            file_prefix = properties.getProperty("fotoPrefijo").substring(0, properties.getProperty("fotoPrefijo").length()-er.length());
                            break;
                        case 2:
                            file_path = properties.getProperty("filePath");
                            System.out.println("Numero: " + er);
                            System.out.println("Longitud: " + er.length());
                            file_prefix = properties.getProperty("filePrefijo").substring(0, properties.getProperty("filePrefijo").length()-er.length());
                            break;
                    }
                    
                    if (bTemp) {
                        file_name = file_path +sIdArchivo+"\\"+ actual.getName().toLowerCase();
                        file_nameOnly = actual.getName();
                    }
                    else {
                        file_name = file_path + file_prefix + er + "_tmp." + sExtension;
                        file_nameOnly = file_prefix + er + "_tmp." + sExtension;
                    }
                    System.out.println(" size pdf " + file_nameOnly);
                    File uploadedFile = new File(file_name);
                    
                    File dirFile = new File(file_path +sIdArchivo);
                    if (dirFile.exists()){
                        actual.write(uploadedFile);
                    } else {
                        if(dirFile.mkdirs()){
                            actual.write(uploadedFile);
                        }
                    }
                    
                }
            }
            datos = "{'success': 'true', 'data':{'estado':'" + sIdArchivo + "', 'mensaje':'" + file_nameOnly + "'}}";
            response.setContentType("text/html; charset=UTF-8");
            response.setCharacterEncoding("UTF8");
            response.getWriter().write(datos);
            request.setAttribute("resp", datos);
        } catch (Exception e) {
          e.printStackTrace();
        }
        return mapping.findForward(SUCCESS);
    }

    public static double roundToDecimals(double d, int c) {
        int temp=(int)((d*Math.pow(10,c)));
        return (((double)temp)/Math.pow(10,c));
    }

}
