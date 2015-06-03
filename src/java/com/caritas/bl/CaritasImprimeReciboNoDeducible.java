package com.caritas.bl;

import com.caritas.action.ReciboDataSource;
import com.caritas.action.listaConfirmacionAC;
import java.io.File;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.type.OrientationEnum;

public class CaritasImprimeReciboNoDeducible {

   static  int numParametros = 23; 
  
   public CaritasImprimeReciboNoDeducible(){}
   
   public String imprimeLaser(int[] recibos) {   
        Object [][] data;
        String resp     = "";
        int longitud    = recibos.length;
        Integer par     = 0;
        
        if (longitud > 0){
            data    = new Object[longitud][numParametros];
            data    = getDatosReporte(recibos);
            par     = (longitud%2);
            
            for(int r = 0; r<longitud;r++){
                imprimeReciboNoDeducible2(getDatosRecibo(data,r) ,getDatosRecibo(data,r));
            }
            
            resp = "success";
         }else{
            resp = "failure";
        }
        return resp;
    }
   
   public String Imprime(int[] recibos) {   
        Object [][] data;
        String resp     = "";
        int longitud    = recibos.length;
        Integer par     = 0;
        
        if (longitud > 0){
            data    = new Object[longitud][numParametros];
            data    = getDatosReporte(recibos);
            par     = (longitud%2);
            int cont        = 0;
            int longTmp     = longitud;
            int numRecibo1  = 0;
            int numRecibo2  = 0;
            if (longitud > 1){  // al menos 2
                do{
                    cont++;
                    numRecibo1 = cont*2-2;
                    numRecibo2 = cont*2-1;
                    imprimeReciboNoDeducible2(getDatosRecibo(data,numRecibo1) ,getDatosRecibo(data,numRecibo2));
                    longTmp = longTmp-2;
                }while(longTmp>1);
            }
            if (par > 0){  // Es Impar
                int ultimo = longitud-1;
                imprimeReciboNoDeducible(getDatosRecibo(data,ultimo));                
            }
            resp = "success";
         }else{
            resp = "failure";
        }
        return resp;
    }
    
   private  Object[][] getDatosRecibo(Object [][] data,int recibo){
       Object [][] datosRecibo;
       datosRecibo= new Object [1][numParametros];
       
       for (int i=0; i<numParametros;i++){ 
               datosRecibo[0][i]=data[recibo][i];
     }
      return datosRecibo;
   }
    
   private  Object [][] getDatosReporte(int[] recibos){
       
       int numRecibos= recibos.length;
       Object [][] dataRecibos;
       Object [][] datosRecibo;
       dataRecibos= new Object [numRecibos][numParametros];
       listaConfirmacionBL datosReciboDAO= new listaConfirmacionBL();
       int cont=0;
       for (int recibo :recibos){
           datosRecibo= new Object [1][numParametros];
           datosRecibo=datosReciboDAO.getDatosRecibo(recibo);      
            for (int i=0; i<numParametros; i++){
                       dataRecibos[cont][i]=datosRecibo[0][i];
                       //System.out.println("Dato del recibo "+cont + "  " + "Parametro " + i + "="+dataRecibos[cont][i]);
                   }
           
        cont++;   
       }
       
    return dataRecibos;
       
   }
   
   private  Object [][] DAO(int recibo){
          Object [][] dataDAO; 
          dataDAO= new Object[1][numParametros];
          dataDAO[0][0]="Uno"+recibo;
          dataDAO[0][1]="Dos"+recibo;
          dataDAO[0][2]="Tres"+recibo;
          dataDAO[0][3]="Cuatro"+recibo;
          dataDAO[0][4]="Cinco"+recibo;
          dataDAO[0][5]="Seis"+recibo;
          dataDAO[0][6]="Siete"+recibo;
          dataDAO[0][7]="Ocho"+recibo;
          dataDAO[0][8]="Nueve"+recibo;
          dataDAO[0][9]="Diez"+recibo;
          dataDAO[0][10]="Once"+recibo;
          dataDAO[0][11]="Doce"+recibo;
          dataDAO[0][12]="Trece"+recibo;
          dataDAO[0][13]="Catorce"+recibo;
          dataDAO[0][14]="Quince"+recibo;
          dataDAO[0][15]="Diez y Seis"+recibo;
          dataDAO[0][16]="Diez y Siete"+recibo;
          dataDAO[0][17]="Dies y Ocho"+recibo;
          dataDAO[0][18]="Dies y Nueve"+recibo;
          dataDAO[0][19]="Veinte"+recibo;
          dataDAO[0][20]="Veintiuno"+recibo;
          dataDAO[0][21]="Veintidos"+recibo;
          dataDAO[0][22]="Veintitres"+recibo;
        return dataDAO;     
   }
   
    private void imprimeReciboNoDeducible2(Object[][] data1, Object[][] data2) {
        String ruta = "reciboNoDeducible2_rs.jasper"; 
        JasperPrint reciboImpreso;
        HashMap<String, Object> parametros = new HashMap<String, Object>();
        parametros.put("IMAGE_PATH", "C:/Proyecto/Ingresos/web/img/logo.jpg");
//        parametros.put("IMAGE_PATH", "C:/Users/rnunez/Documents/Proyectos/Caritas Ingresos/web/img/logo.jpg");
        ruta = ((listaConfirmacionAC.class.getResource(ruta)).toString().replace("file:/", "").replace("%20", " "));
        File reportFile = new File(ruta);
        if (!reportFile.exists()) {
            throw new JRRuntimeException("File x.jasper not found. The report design must be compiled first.");
        }
        try {
            Object[][] datosCarta;
            datosCarta = new Object[1][numParametros * 2];
            for (int k = 0; k < numParametros * 2; k++) {
                if (k < numParametros) {
                    datosCarta[0][k] = data1[0][k];
                } else {
                    datosCarta[0][k] = data2[0][k - numParametros];
                }
            }

            reciboImpreso = JasperFillManager.fillReport(ruta, parametros, new ReciboDataSource(datosCarta));
            reciboImpreso.setOrientation(OrientationEnum.PORTRAIT);
            reciboImpreso.setPageWidth(612);
            reciboImpreso.setPageHeight(792);
            //reciboImpreso.setTopMargin(0);
            //reciboImpreso.setLeftMargin(0);
            //reciboImpreso.setBottomMargin(0);
            //reciboImpreso.setRightMargin(0);
            JasperPrintManager.printReport(reciboImpreso, false);
        } catch (JRException ex) {
            Logger.getLogger(CaritasImprimeReciboNoDeducible.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
   
    private void imprimeReciboNoDeducible(Object[][] data1) {
        String ruta = "reciboNoDeducible_rs.jasper";
        JasperPrint reciboImpreso;
        HashMap<String, Object> parametros = new HashMap<String, Object>();
        parametros.put("IMAGE_PATH", "C:/Proyecto/Ingresos/web/img/logo.jpg");
//        parametros.put("IMAGE_PATH", "C:/Users/rnunez/Documents/Proyectos/Caritas Ingresos/web/img/logo.jpg");
        ruta = ((listaConfirmacionAC.class.getResource(ruta)).toString().replace("file:/", "").replace("%20", " "));
        File reportFile = new File(ruta);
        if (!reportFile.exists()) {
            throw new JRRuntimeException("File x.jasper not found. The report design must be compiled first.");
        }
        try {
            reciboImpreso = JasperFillManager.fillReport(ruta, parametros, new ReciboDataSource(data1));
            reciboImpreso.setOrientation(OrientationEnum.PORTRAIT);
            reciboImpreso.setPageWidth(612);
            reciboImpreso.setPageHeight(792);            
            JasperPrintManager.printReport(reciboImpreso, false);
        } catch (JRException ex) {
            Logger.getLogger(CaritasImprimeReciboNoDeducible.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
  
    
}