package com.caritas.action;

import java.math.BigDecimal;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRField;

public class ReciboDataSource implements JRDataSource {

    /*
      <field name="ID_BITACORA" class="java.math.BigDecimal"/> 
      <field name="ID_RECIBO" class="java.lang.String"/> 
      <field name="NOMBRE_DONANTE" class="java.lang.String"/> 
      <field name="RAZON_SOCIAL" class="java.lang.String"/> 
      <field name="ITEM_CODE" class="java.lang.String"/> 
      <field name="DESCRIPTION" class="java.lang.String"/> 
      <field name="UEN_CODE"  class="java.lang.String"/> 
      <field name="UEN_NAME" class="java.lang.String"/> 
      <field name="CAGE_NUMBER" class="java.lang.String"/> 
      <field name="CARRIER_CODE" class="java.lang.String"/>     
      <field name="NAME" class="java.lang.String"/>
      <field name="COMMENTS" class="java.lang.String"/> 
      <field name="SHIFT_ID" class="java.math.BigDecimal"/> 
      <field name="USER_ID_IN" class="java.lang.String"/> 
      <field name="DRIVER_INPUT_NAME" class="java.lang.String"/> 
      <field name="INPUT_DATETIME" class="java.sql.Timestamp"/> 
      <field name="INPUT_WEIGHT" class="java.math.BigDecimal"/> 
      <field name="EXIT_DATETIME" class="java.sql.Timestamp"/> 
      <field name="EXIT_WEIGHT" class="java.math.BigDecimal"/> 
      <field name="DRIVER_OUTPUT_NAME" class="java.lang.String"/> 
      <field name="USER_ID_OUT" class="java.lang.String"/> 
      <field name="BILLING_NUMBER" class="java.lang.String"/> 
      <field name="EXIT_ORDER" class="java.lang.String"/> 
      <field name="DESTINATION" class="java.lang.String"/> 
      <field name="INPUT_REASON" class="java.lang.String"/> 
      <field name="FOLIO_CUSTOMER_PROVIDER" class="java.lang.String"/> 
      <field name="USER_ID_SAVE" class="java.lang.String"/> 
      <field name="STATUS" class="java.math.BigDecimal"/> 
      <field name="CUSTOMER_NUMBER" class="java.lang.String"/> 
      <field name="ESTATUSBOLETA" class="java.lang.String"/> 
      <field name="PESONETO" class="java.math.BigDecimal"/> 
      <field name="VIGILANTESALIDA" class="java.lang.String"/>
    */ 
    private Object[][] data;
    private int index = -1;
    
    public ReciboDataSource(Object[][] dataP) {
        data = dataP;
    }

    /*
     * (non-Javadoc) @see
     * net.sf.jasperreports.engine.JRDataSource#getFieldValue(net.sf.jasperreports.engine.JRField)
     */
    @Override
    public Object getFieldValue(JRField field) throws JRException {
        Object value = null;
        String fieldName = field.getName();

        if ("ID_BITACORA".equals(fieldName)){
            value = data[index][0];
        }else if ("ID_RECIBO".equals(fieldName)){
            value = data[index][1];
        }else if ("NOMBRE_DONANTE".equals(fieldName)){
            value = data[index][2];
        }else if ("RAZON_SOCIAL".equals(fieldName)){
            value = data[index][3];
        }else if ("TEL_CASA".equals(fieldName)){
            value = data[index][4];
        }else if ("TEL_OFICINA".equals(fieldName)){
            value = data[index][5];
        }else if ("LETRA".equals(fieldName)){
            value = data[index][6];
        }else if ("ID_TIPO_DIRECCION".equals(fieldName)){
            value = data[index][7];
        }else if ("DOMICILIO".equals(fieldName)){
            value = data[index][8];
        }else if ("ENTRE_CALLES".equals(fieldName)){
            value = data[index][9];
        }else if ("ESTATUS_PAGO_TMP".equals(fieldName)){
            value = data[index][10];
        }else if ("ID_FORMA_PAGO".equals(fieldName)){
            value = data[index][11];
        }else if ("ID_CAMPANA_FINANCIERA".equals(fieldName)){
            value = data[index][12];
        }else if ("NUM_FRECUENCIA".equals(fieldName)){
            value = data[index][13];
        }else if ("ID_ASIGNACION".equals(fieldName)){
            value = data[index][14];
        }else if ("NUM_CASO".equals(fieldName)){
            value = data[index][15];
        }else if ("ID_ZONA".equals(fieldName)){
            value = data[index][16];
        }else if ("ID_TIPO_DONATIVO".equals(fieldName)){
            value = data[index][17];
        }else if ("ID_DONANTE".equals(fieldName)){
            value = data[index][18];
        }else if ("ID_NUM_PAGO".equals(fieldName)){
            value = data[index][19];
        }else if ("ID_USUARIO".equals(fieldName)){
            value = data[index][20];
        }else if ("FECHA_ACTUAL".equals(fieldName)){
            value = data[index][21];
        }else if ("ID_DONATIVO".equals(fieldName)){
            value = data[index][22];
        }else if ("ID_BITACORA_1".equals(fieldName)){
            value = data[index][23];
        }else if ("ID_RECIBO_1".equals(fieldName)){
            value = data[index][24];
        }else if ("NOMBRE_DONANTE_1".equals(fieldName)){
            value = data[index][25];
        }else if ("RAZON_SOCIAL_1".equals(fieldName)){
            value = data[index][26];
        }else if ("TEL_CASA_1".equals(fieldName)){
            value = data[index][27];
        }else if ("TEL_OFICINA_1".equals(fieldName)){
            value = data[index][28];
        }else if ("LETRA_1".equals(fieldName)){
            value = data[index][29];
        }else if ("ID_TIPO_DIRECCION_1".equals(fieldName)){
            value = data[index][30];
        }else if ("DOMICILIO_1".equals(fieldName)){
            value = data[index][31];
        }else if ("ENTRE_CALLES_1".equals(fieldName)){
            value = data[index][32];
        }else if ("ESTATUS_PAGO_TMP_1".equals(fieldName)){
            value = data[index][33];
        }else if ("ID_FORMA_PAGO_1".equals(fieldName)){
            value = data[index][34];
        }else if ("ID_CAMPANA_FINANCIERA_1".equals(fieldName)){
            value = data[index][35];
        }else if ("NUM_FRECUENCIA_1".equals(fieldName)){
            value = data[index][36];
        }else if ("ID_ASIGNACION_1".equals(fieldName)){
            value = data[index][37];
        }else if ("NUM_CASO_1".equals(fieldName)){
            value = data[index][38];
        }else if ("ID_ZONA_1".equals(fieldName)){
            value = data[index][39];
        }else if ("ID_TIPO_DONATIVO_1".equals(fieldName)){
            value = data[index][40];
        }else if ("ID_DONANTE_1".equals(fieldName)){
            value = data[index][41];
        }else if ("ID_NUM_PAGO_1".equals(fieldName)){
            value = data[index][42];
        }else if ("ID_USUARIO_1".equals(fieldName)){
            value = data[index][43];
        }else if ("FECHA_ACTUAL_1".equals(fieldName)){
            value = data[index][44];
        }else if ("ID_DONATIVO_1".equals(fieldName)){
            value = data[index][45];
        }
        return value;
    }
    /*
     * Object[][] data = { { 0 partnerName, 1 new BigDecimal(ticketNumber), 2
     * customerNumber, 3 inputDate,4 exitDate,5 description,6 name,7
     * platesNumber,8 uenName, 9 pesoEntrada,10 pesoSalida,11 pesoNeto,12
     * vigilanteSalida,13 destino,14 comentarios,15 turno,16 ordenDeSalida}
	 };
     */


    /*
     * (non-Javadoc) @see net.sf.jasperreports.engine.JRDataSource#next()
     */
    @Override
    public boolean next() throws JRException {
        index++;
        return (index < data.length);
    }
}