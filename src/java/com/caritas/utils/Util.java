package com.caritas.utils;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashSet;
import java.util.Set;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.write.NumberFormats;
import jxl.write.WritableFont;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import javax.servlet.http.HttpServletResponse;
import jxl.format.Orientation;
import jxl.*;
import jxl.format.PageOrientation;
import jxl.format.PaperSize;
import jxl.format.VerticalAlignment;

public class Util {

    public static WritableCellFormat getCellFormatHeader() throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
        font.setColour(Colour.BLACK);
        WritableCellFormat cellFormat = new WritableCellFormat(font);
        cellFormat.setBackground(Colour.GRAY_25);
        cellFormat.setAlignment(Alignment.CENTRE);        
        cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
        return cellFormat;
    }
    
    public static WritableCellFormat getCellFormatTitle() throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 16, WritableFont.BOLD);
        font.setColour(Colour.BLACK);
        WritableCellFormat cellFormat = new WritableCellFormat(font);
//        cellFormat.setBackground(Colour.GRAY_25);
        cellFormat.setAlignment(Alignment.CENTRE);
        //cellFormat.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
        return cellFormat;
    }

    public static WritableCellFormat getCellFormatGeneral() throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD);
        font.setColour(Colour.BLACK);
        WritableCellFormat cellFormat = new WritableCellFormat(font);
        cellFormat.setBackground(Colour.WHITE);
        cellFormat.setFont(font);
        cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
        cellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
        cellFormat.setAlignment(Alignment.CENTRE);
        
        return cellFormat;
    }

    public static WritableCellFormat getCellFormatGeneralYellow() throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 10, WritableFont.NO_BOLD);
        font.setColour(Colour.BLACK);
        WritableCellFormat cellFormat = new WritableCellFormat(font);
        cellFormat.setBackground(Colour.YELLOW);
        cellFormat.setFont(font);
        cellFormat.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
        return cellFormat;
    }

    public static WritableCellFormat getCellFormatNumber() throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD);
        font.setColour(Colour.BLACK);
        WritableCellFormat cellFormat = new WritableCellFormat(font, NumberFormats.INTEGER);
        cellFormat.setBackground(Colour.WHITE);
        cellFormat.setFont(font);
        cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
        return cellFormat;
    }
    
    public static WritableCellFormat getCellFormatImporte() throws Exception {
        WritableFont font               = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD);
        WritableCellFormat cellFormat   = new WritableCellFormat(font, NumberFormats.FLOAT);
        font.setColour(Colour.BLACK);        
        cellFormat.setBackground(Colour.WHITE);
        cellFormat.setFont(font);
        cellFormat.setBorder(Border.ALL, BorderLineStyle.THIN);        
        return cellFormat;
    }

    public static void createExcel(ResultSet rset, HttpServletResponse response) throws Exception {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=Reporte.xls;");
        ResultSetMetaData rsetmd                = rset.getMetaData();
        WritableWorkbook workbook               = Workbook.createWorkbook(response.getOutputStream());
        WritableSheet sheet                     = workbook.createSheet("Reporte", 0);
        Label label                             = null;
        WritableCellFormat cellFormatHeader     = Util.getCellFormatHeader();
        int i, il;

        for (i = 0, il = rsetmd.getColumnCount(); i < il; i++) {
            label = new Label(i, 0, rsetmd.getColumnName(i + 1), cellFormatHeader); //col, row, label, format
            sheet.setColumnView(i, 30); //se asigna el ancho, ancho * 7 = numero de pixeles que medirá la columna
            sheet.addCell(label);
        }
        
        int row = 0;

        WritableCellFormat cellFormatGeneral = Util.getCellFormatGeneral();
        WritableCellFormat numberCellFormat = Util.getCellFormatNumber();
        jxl.write.Number numberCell = null;
        
        while (rset.next()) {
            row++;
            for (i = 0; i < il; i++) {
                try {
                    numberCell = new jxl.write.Number(i, row, rset.getDouble(i + 1), numberCellFormat); //col, row, label, format
                    sheet.addCell(numberCell);
                } catch (Exception e) {
                    label = new Label(i, row, rset.getString(i + 1), cellFormatGeneral); //col, row, label, format
                    sheet.addCell(label);
                }
            }
        }
        workbook.write();
        workbook.close();
    }
    
    public static void createExcel_repListadoCobranza(ResultSet rset, HttpServletResponse response, String fechaIni, String FechaFin) throws Exception {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=Reporte.xls;");
        ResultSetMetaData rsetmd                = rset.getMetaData();
        WritableWorkbook workbook               = Workbook.createWorkbook(response.getOutputStream());
        WritableSheet sheet                     = workbook.createSheet("Listado de Cobranza", 0);
        Label encabezado1                       = null;
        Label encabezado2                       = null;
        Label encabezado3                       = null;
        Label encabezado4                       = null;
        Label encabezado5                       = null;
        Label encabezado6                       = null;
        Label encabezado7                       = null;
        Label encabezado8                       = null;
        Label encabezado9                       = null;
        Label encabezado10                      = null;
        Label titulo                            = null;
        Label label                             = null;
        WritableCellFormat cellFormatHeader     = Util.getCellFormatHeader(); 
        WritableCellFormat cellFormatTitle      = Util.getCellFormatTitle(); 
        WritableCellFormat cellFormatGeneral    = Util.getCellFormatGeneral();
        WritableCellFormat numberCellFormat     = Util.getCellFormatNumber();
        WritableCellFormat importeCellFormat    = Util.getCellFormatImporte();        
        jxl.write.Number numberCell             = null;
        int row                                 = 2;   //Fila inicial de los datos      
        
        sheet.setHeader("REPORTE", "", fechaIni+" AL "+FechaFin);
        sheet.setFooter("", "CARITAS DE MONTERREY A.B.P.", "");
        sheet.setPageSetup(PageOrientation.LANDSCAPE);
        
        /* TITULO */
        titulo = new Label(0, 0, "REPORTE LISTADO DE COBRANZA", cellFormatTitle); //col, row, label, format
        sheet.mergeCells(0, 0, 9, 0);
        sheet.addCell(titulo);
        sheet.setRowView(0, 500);
        
        sheet.insertRow(1); /* FILA EN BLANCO */
        
        /* ENCABEZADOS */
        encabezado1 = new Label(0, 2, "RECIBO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(0, rsetmd.getPrecision(1)); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado1);        
        encabezado2 = new Label(1, 2, "DONANTE", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(1, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado2);        
        encabezado3 = new Label(2, 2, "NOMBRE DONANTE", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(2, 50); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado3);        
        encabezado4 = new Label(3, 2, "IMPORTE", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(3, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado4);        
        encabezado5 = new Label(4, 2, "PAGO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(4, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado5);        
        encabezado6 = new Label(5, 2, "FECHA PAGO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(5, 15); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado6);        
        encabezado7 = new Label(6, 2, "FORMA PAGO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(6, 30); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado7);        
        encabezado8 = new Label(7, 2, "CUENTA", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(7, 15); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado8);        
        encabezado9 = new Label(8, 2, "CAMP. FIN.", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(8, 30); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado9);        
        encabezado10 = new Label(9, 2, "ASIGNACIÓN", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(9, 30); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado10);
        
        /* DATOS */
        while (rset.next()) { //Recorrer todos los datos
            row++;            
            label = new Label(0, row, rset.getString(1), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);      
            numberCell = new jxl.write.Number(1, row, rset.getInt(2), numberCellFormat); //col, row, label, format
            sheet.addCell(numberCell);
            label = new Label(2, row, rset.getString(3), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            numberCell = new jxl.write.Number(3, row, rset.getInt(4), importeCellFormat); //col, row, label, format            
            sheet.addCell(numberCell);
            label = new Label(4, row, rset.getString(5), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            label = new Label(5, row, rset.getString(6), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            label = new Label(6, row, rset.getString(7), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            label = new Label(7, row, rset.getString(8), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            label = new Label(8, row, rset.getString(9), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            label = new Label(9, row, rset.getString(10), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
        }
        workbook.write();
        workbook.close();
    }
    
    public static void createExcel_reporteDiarioRecoletoresExtra(ResultSet rset, HttpServletResponse response, String fechaVisita) throws Exception {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=Reporte.xls;");
        ResultSetMetaData rsetmd                = rset.getMetaData();
        WritableWorkbook workbook               = Workbook.createWorkbook(response.getOutputStream());
        WritableSheet sheet                     = workbook.createSheet("Reporte Diario", 0);
        Label encabezado1                       = null;
        Label encabezado2                       = null;
        Label encabezado3                       = null;
        Label encabezado4                       = null;
        Label encabezado5                       = null;
        Label encabezado6                       = null;
        Label encabezado7                       = null;
        Label encabezado8                       = null;
        Label encabezado9                       = null;
        Label encabezado10                      = null;
        Label titulo                            = null;
        Label label                             = null;
        WritableCellFormat cellFormatHeader     = Util.getCellFormatHeader(); 
        WritableCellFormat cellFormatTitle      = Util.getCellFormatTitle(); 
        WritableCellFormat cellFormatGeneral    = Util.getCellFormatGeneral();
        WritableCellFormat numberCellFormat     = Util.getCellFormatNumber();
        WritableCellFormat importeCellFormat    = Util.getCellFormatImporte();        
        jxl.write.Number numberCell             = null;
        int row                                 = 2;   //Fila inicial de los datos      
        
        sheet.setHeader("REPORTE", "CARITAS DE MONTERREY A.B.P.", fechaVisita);        
        sheet.setPageSetup(PageOrientation.LANDSCAPE);
        
        
        /* TITULO */
        titulo = new Label(0, 0, "REPORTE RECOLECCIÓN", cellFormatTitle); //col, row, label, format
        sheet.mergeCells(0, 0, 4, 0);
        sheet.addCell(titulo);
        sheet.setRowView(0, 500);
        
        sheet.insertRow(1); /* FILA EN BLANCO */
        
        /* ENCABEZADOS */
        encabezado1 = new Label(0, 2, "#", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(0, 5); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado1);        
        encabezado2 = new Label(1, 2, "RECIBO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(1, 20); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado2);
        encabezado3 = new Label(2, 2, "REFERENCIA DOMICILIO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(2, 40); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado3);
        encabezado4 = new Label(3, 2, "COMENTARIOS RECIBO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(3, 40); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado4);
        encabezado5 = new Label(4, 2, "COMENTARIOS REPROGRAMACION", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(4, 40); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado5);
        
        /* DATOS */
        while (rset.next()) { //Recorrer todos los datos
            row++;            
            label = new Label(0, row, rset.getString(1), cellFormatGeneral); //col, row, label, format
            sheet.setRowView(row, 900); //Alto de Fila (Fila, Alto)
            sheet.addCell(label);                        
            label = new Label(1, row, rset.getString(2), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
            label = new Label(2, row, rset.getString(3), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
            label = new Label(3, row, rset.getString(4), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
            label = new Label(4, row, rset.getString(5), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
        }
            
        workbook.write();
        workbook.close();
    }
    
    public static void createExcel_reporteDiarioRecoletoresOficial(ResultSet rset, HttpServletResponse response, String fechaVisita) throws Exception {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=Reporte.xls;");
        ResultSetMetaData rsetmd                = rset.getMetaData();
        WritableWorkbook workbook               = Workbook.createWorkbook(response.getOutputStream());
        WritableSheet sheet                     = workbook.createSheet("Reporte Diario", 0);
        Label encabezado1                       = null;
        Label encabezado2                       = null;
        Label encabezado3                       = null;
        Label encabezado4                       = null;
        Label encabezado5                       = null;
        Label encabezado6                       = null;        
        Label titulo                            = null;
        Label label                             = null;
        WritableCellFormat cellFormatHeader     = Util.getCellFormatHeader(); 
        WritableCellFormat cellFormatTitle      = Util.getCellFormatTitle(); 
        WritableCellFormat cellFormatGeneral    = Util.getCellFormatGeneral();
        WritableCellFormat numberCellFormat     = Util.getCellFormatNumber();
        WritableCellFormat importeCellFormat    = Util.getCellFormatImporte();        
        jxl.write.Number numberCell             = null;
        int row                                 = 2;   //Fila inicial de los datos      
        
        sheet.setHeader("Mensajero:__________________", "Control de Recolección Diaria", fechaVisita+"\n\nZona:_________");
        sheet.setFooter("_______________       _______________\n     Tráfico Admon                 Recolector", "_______________    \nAdministración", "Entregados: _____   Recolectados: _____\n\nEfectivo: ______     Devolución: ______");        
        sheet.setPageSetup(PageOrientation.PORTRAIT);
        
        
        /* TITULO */
        titulo = new Label(0, 0, "Departamento de Ingresos", cellFormatTitle); //col, row, label, format
        sheet.mergeCells(0, 0, 5, 0);
        sheet.addCell(titulo);
        sheet.setRowView(0, 500);
        
        sheet.insertRow(1); /* FILA EN BLANCO */
        
        /* ENCABEZADOS */
        encabezado1 = new Label(0, 2, "#", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(0, 5); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado1);
        encabezado2 = new Label(1, 2, "RECIBO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(1, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado2);
        encabezado3 = new Label(2, 2, "DONANTE", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(2, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado3);
        encabezado4 = new Label(3, 2, "CANTIDAD", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(3, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado4);
        encabezado5 = new Label(4, 2, "COBRADO", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(4, 10); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado5);
        encabezado6 = new Label(5, 2, "OBSERVACIONES", cellFormatHeader); //col, row, label, format
        sheet.setColumnView(5, 50); //Ancho de columna (columna, ancho)
        sheet.addCell(encabezado6);
        
        /* DATOS */
        while (rset.next()) { //Recorrer todos los datos
            row++;            
            label = new Label(0, row, rset.getString(1), cellFormatGeneral); //col, row, label, format
            sheet.setRowView(row, 400); //Alto de Fila (Fila, Alto)
            sheet.addCell(label);                        
            label = new Label(1, row, rset.getString(2), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
            label = new Label(2, row, rset.getString(3), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
            label = new Label(3, row, rset.getString(4), cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);            
            label = new Label(4, row, "", cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
            label = new Label(5, row, "", cellFormatGeneral); //col, row, label, format
            sheet.addCell(label);
        }
            
        workbook.write();
        workbook.close();
    }
    
}
