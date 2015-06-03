<%-- 
    Document   : showImg
    Created on : 30/06/2011, 09:43:34 AM
    Author     : rblazquez
--%>

<%@page import="java.util.StringTokenizer"%>
<%@page import="com.caritas.bl.fotografiasBL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*" %>
<%@ page import = "com.caritas.properties.Dummy" %>
<%@ page import = "java.util.Properties" %>

<%
    try {
    Properties properties;
    String nameFileProperties = "config";
    String file_path = "";
    //String file_url = "";
    String file_prefix = "";
    int idBeneficiario = 0;
    String er = "";
    String file_name = "";
    String sExtension = "";
    String uid = "";

//    if(request.getParameter("idBeneficiario")!=null){

        properties = new Properties();
        properties.load(Dummy.class.getResourceAsStream(nameFileProperties + ".properties"));
        try {
            idBeneficiario = Integer.parseInt(request.getParameter("id_beneficiario"));
            file_name = request.getParameter("file_name");
       } catch( NumberFormatException ex){
           idBeneficiario = 0;
       }
        er = "" + idBeneficiario;

        file_path = properties.getProperty("filePath");
        
        StringTokenizer strNombreToken = new StringTokenizer(file_name, ".");
        while (strNombreToken.hasMoreTokens()) {
            sExtension = strNombreToken.nextToken().toLowerCase();
        }


        //Se crea el objecto del archivo
        
        File file = new File(file_path+idBeneficiario+"\\"+file_name);
        
        try {
            //Se crea el objecto FileInputStream
            FileInputStream fin = new FileInputStream(file);
            /*
             * Se Crea un arreglo de bytes lo suficientemente grande para alojar el
             * contenido del archivo.
             * Se usa File.length para determinar el tamaño del archivo en bytes.
             */
            byte fileContent[] = new byte[(int)file.length()];
            /*
             * Para leer el contenido del archivo en un arreglo de bytes, se usa
             * el metodo int read(byte[] byteArray) de clase de java FileInputStream.
             */
            fin.read(fileContent);

            byte[] imgData = fileContent;

            String imageType = sExtension;
            if(!imageType.equals("jpg")&&!imageType.equals("png")&&!imageType.equals("gif")&&!imageType.equals("jpeg"))
            response.setHeader("Content-disposition", "attachment; filename="+file_name.replaceAll(" ", ""));
            
            response.setContentType(imageType);
            OutputStream o = response.getOutputStream();
            o.write(imgData);
            o.flush();
            o.close();
        }
        catch(FileNotFoundException e) {
            System.out.println("File not found" + e);
            file_name = "foto.gif";
            //Se crea el objecto del archivo
            file = new File(file_path+file_name);
            FileInputStream fin = new FileInputStream(file);
            byte fileContent[] = new byte[(int)file.length()];
            fin.read(fileContent);

            byte[] imgData = fileContent;

            String imageType = "gif";
            response.setContentType(imageType);
            OutputStream o = response.getOutputStream();
            o.write(imgData);
            o.flush();
            o.close();
        }
        catch(IOException ioe) {
            System.out.println("Exception while reading the file " + ioe);
        }
    }catch(Exception ex){
        
    }
%>
