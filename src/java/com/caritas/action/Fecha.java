package com.caritas.action;

/**
 *
 * @author rnunez
 */

// Utileria de fecha

import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Vector;

public class Fecha{	
	
	public String getFecha( String Formato ){
		String s_fecha = "";
		Calendar fecha = new GregorianCalendar();
		String dia = null;
		String mes = null;
		if (Formato.equals("1")){
			dia = Integer.toString(fecha.get(Calendar.DAY_OF_MONTH));
			if (dia.length() == 1) dia = "0" + dia;
			mes = Integer.toString(fecha.get(Calendar.MONTH)+1);
			if (mes.length() == 1) mes = "0" + mes;
			
			s_fecha = dia+"/"+mes+"/"+Integer.toString(fecha.get(Calendar.YEAR));
		}else{			
		
			switch(fecha.get(Calendar.DAY_OF_WEEK)) {
			case Calendar.SUNDAY: 		dia = "Domingo";	break;
			case Calendar.MONDAY: 		dia = "Lunes";		break;
			case Calendar.TUESDAY:		dia = "Martes";		break;
			case Calendar.WEDNESDAY:	dia = "Miercoles";	break;
			case Calendar.THURSDAY:		dia = "Jueves";		break;
			case Calendar.FRIDAY:		dia = "Viernes";	break;
			case Calendar.SATURDAY:		dia = "Sabado";		break;
			}
			
			switch(fecha.get(Calendar.MONTH)) {
			case Calendar.JANUARY:		mes = "Enero";		break;
			case Calendar.FEBRUARY:		mes = "Febrero";	break;
			case Calendar.MARCH:		mes = "Marzo";		break;
			case Calendar.APRIL:		mes = "Abril";		break;
			case Calendar.MAY:			mes = "Mayo";		break;
			case Calendar.JUNE:			mes = "Junio";		break;
			case Calendar.JULY:			mes = "Julio";		break;
			case Calendar.AUGUST:		mes = "Agosto";		break;
			case Calendar.SEPTEMBER:	mes = "Setiembre";	break;
			case Calendar.OCTOBER:		mes = "Octubre";	break;
			case Calendar.NOVEMBER:		mes = "Noviembre";	break;
			case Calendar.DECEMBER:		mes = "Diciembre";	break;
			}
		
			s_fecha = dia + ", "+Integer.toString(fecha.get(Calendar.DAY_OF_MONTH))+"/ "+mes+"/ "+
				Integer.toString(fecha.get(Calendar.YEAR));
		}	
		return s_fecha;
	}
	
	public String getDia( String Fecha ){
		String s_dia = "";
		
		s_dia = Fecha.substring(0,2);
		
		return s_dia;
	}
	
	public String getMesNombre( String Fecha ){		
		int nmes = Integer.parseInt(Fecha.substring(3,5));
		String mes = "";
		switch(nmes) {
			case 1:		mes = "enero";		break;
			case 2:		mes = "febrero";	break;
			case 3:		mes = "marzo";		break;
			case 4:		mes = "abril";		break;
			case 5:		mes = "mayo";		break;
			case 6:		mes = "junio";		break;
			case 7:		mes = "julio";		break;
			case 8:		mes = "agosto";		break;
			case 9:		mes = "septiembre";	break;
			case 10:	mes = "octubre";	break;
			case 11:	mes = "noviembre";	break;
			case 12:	mes = "diciembre";	break;
		}		
		return mes;
	}
	
	public static String getMesNombre( int nMes ){		
		String mes = "";
		switch(nMes) {
			case 1:		mes = "Enero";		break;
			case 2:		mes = "Febrero";	break;
			case 3:		mes = "Marzo";		break;
			case 4:		mes = "Abril";		break;
			case 5:		mes = "Mayo";		break;
			case 6:		mes = "Junio";		break;
			case 7:		mes = "Julio";		break;
			case 8:		mes = "Agosto";		break;
			case 9:		mes = "Septiembre";	break;
			case 10:	mes = "Octubre";	break;
			case 11:	mes = "Noviembre";	break;
			case 12:	mes = "Diciembre";	break;
		}		
		return mes;
	}

	public String getMes( String Fecha ){		
		String s_mes = "";
		
		s_mes = Fecha.substring(3,5);
		
		return s_mes;
	}	
	
	public String getYear( String Fecha ){
		String s_year = "";
		
		s_year = Fecha.substring(6,10);
		
		return s_year;
	}
	
	public static String getHoy( ){
		String s_fecha = "";
		Calendar fecha = new GregorianCalendar();		
		String dia = null;
		String mes = null;		
		
		dia = Integer.toString(fecha.get(Calendar.DAY_OF_MONTH));
		if (dia.length() == 1) dia = "0" + dia;
		mes = Integer.toString(fecha.get(Calendar.MONTH)+1);
		if (mes.length() == 1) mes = "0" + mes;
		
		s_fecha = dia+"/"+mes+"/"+Integer.toString(fecha.get(Calendar.YEAR));
		
		return s_fecha;
	}	
	
	public String getNombreDia(String fecha)throws Exception{
		String dia = "";
		Calendar calendario = new GregorianCalendar();
		java.text.DateFormat datef = java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT,new Locale("es","SPANISH"));
		calendario.setTime(datef.parse(fecha));
		switch(calendario.get(Calendar.DAY_OF_WEEK)) {
			case Calendar.SUNDAY: 		dia = "Domingo";	break;
			case Calendar.MONDAY: 		dia = "Lunes";		break;
			case Calendar.TUESDAY:		dia = "Martes";		break;
			case Calendar.WEDNESDAY:	dia = "Miercoles";	break;
			case Calendar.THURSDAY:		dia = "Jueves";		break;
			case Calendar.FRIDAY:		dia = "Viernes";	break;
			case Calendar.SATURDAY:		dia = "Sabado";		break;
		}
		return dia;
	}
	
	public String getStringFecha(Calendar calendario){
		String fecha = "", dia="",mes="";		
		dia = String.valueOf(calendario.get(Calendar.DAY_OF_MONTH));
		if (dia.length() == 1) dia = "0" + dia;
		mes = Integer.toString(calendario.get(Calendar.MONTH)+1);
		if (mes.length() == 1) mes = "0" + mes;
		fecha = dia+"/"+mes+"/"+String.valueOf(calendario.get(Calendar.YEAR));
		return fecha;		
	}
	
        public int getUltimoDiaMes(String fechaActual) throws Exception{
            int mesActual = Integer.parseInt(fechaActual.substring(3,5));
            int dia = 0;
            int year = Integer.parseInt(this.getYear(fechaActual));
            int febrero = 0;
            
            if ((year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0)))
                febrero = 29;
            else
                febrero = 28;
            
            int mes1 = 31;
            int mes2 = febrero;
            int mes3 = 31;
            int mes4 = 30;
            int mes5 = 31;
            int mes6 = 30;
            int mes7 = 31;
            int mes8 = 31;
            int mes9 = 30;
            int mes10 = 31;
            int mes11 = 30;
            int mes12 = 31;
            
            switch(mesActual){
                case 1: dia = mes1;      break;
                case 2: dia = mes2;      break;
                case 3: dia = mes3;      break;
                case 4: dia = mes4;      break;
                case 5: dia = mes5;      break;
                case 6: dia = mes6;      break;
                case 7: dia = mes7;      break;
                case 8: dia = mes8;      break;
                case 9: dia = mes9;      break;
                case 10: dia = mes10;    break;
                case 11: dia = mes11;    break;
                case 12: dia = mes12;    break;
                
            }
            
            return dia;
        }
        
	public Vector<String> getSemana(String fechaActual)throws Exception{
		GregorianCalendar calendario = new GregorianCalendar();
		java.text.DateFormat datef = java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT,new Locale("es","SPANISH"));
		calendario.setTime(datef.parse(fechaActual));
		Vector<String> vector	= new Vector<String>();
		vector.addElement(getStringFecha(calendario));
		for (int i=1;i<7;i++){
			calendario.add(Calendar.DATE,1);
			vector.addElement(getStringFecha(calendario));
		}
		return vector;
	}
	
	public Vector<String> getSemanaActual()throws SQLException{
		GregorianCalendar calendario = new GregorianCalendar();
		//java.text.DateFormat datef = java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT,new Locale("es","SPANISH"));
		Vector<String>vector	= new Vector<String>();
		vector.addElement(getStringFecha(calendario));
		for (int i=1;i<7;i++){
			calendario.add(Calendar.DATE,1);
			vector.addElement(getStringFecha(calendario));
		}
		return vector;
	}
	
	public String getSemanaAnterior(String fechaInicio)throws Exception{
		GregorianCalendar calendario = new GregorianCalendar();
		java.text.DateFormat datef = java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT,new Locale("es","SPANISH"));
		calendario.setTime(datef.parse(fechaInicio));
		calendario.add(Calendar.DATE,-7);
		return getStringFecha(calendario);
	}
	
	public String getSemanaSiguiente(String fechaInicio)throws Exception{
		GregorianCalendar calendario = new GregorianCalendar();
		java.text.DateFormat datef = java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT,new Locale("es","SPANISH"));
		calendario.setTime(datef.parse(fechaInicio));
		calendario.add(Calendar.DATE,7);
		
		return getStringFecha(calendario);
	}
	
	public String getFechaTexto(String fecha){
		String texto = "";
		texto = fecha.substring(0,2)+" de "+ getMesNombre(fecha)+" de "+fecha.substring(6);
		return texto;
	}
	
	public static String getPeriodoActual(){
		String hoy = getHoy();
		Fecha fecha = new Fecha();
		String texto="";
		
		if(Integer.parseInt(fecha.getMes(hoy)) < 8){
			texto = (Integer.parseInt(fecha.getYear(hoy))-1) + "-" +fecha.getYear(hoy);
		}
		if(Integer.parseInt(fecha.getMes(hoy)) == 8){
			if(Integer.parseInt(fecha.getDia(hoy)) < 20){
				texto = (Integer.parseInt(fecha.getYear(hoy))-1) + "-" +fecha.getYear(hoy);
			}else{
				texto =  fecha.getYear(hoy) + "-" + (Integer.parseInt(fecha.getYear(hoy))+1);
			}
		}
		if(Integer.parseInt(fecha.getMes(hoy)) > 8){
			texto =  fecha.getYear(hoy) + "-" + (Integer.parseInt(fecha.getYear(hoy))+1);
		}
		
		return texto;
	}
	
	public static String getPeriodoMes(String fecha){
		Fecha date = new Fecha();
		String texto="";
		
		if(Integer.parseInt(date.getMes(fecha)) >= 1 && Integer.parseInt(date.getMes(fecha)) <= 6){
			if(Integer.parseInt(date.getMes(fecha)) == 6){
				if(Integer.parseInt(date.getDia(fecha)) < 10){
					texto = "enero a mayo";
				}
			}else{
				texto = "enero a mayo";
			}
		}
		
		if(Integer.parseInt(date.getMes(fecha)) >= 6 && Integer.parseInt(date.getMes(fecha)) <= 8){
			if(Integer.parseInt(date.getMes(fecha)) == 6){
				if(Integer.parseInt(date.getDia(fecha)) >= 10){
					texto = "junio a agosto";
				}
			}
			if(Integer.parseInt(date.getMes(fecha)) == 8){
				if(Integer.parseInt(date.getDia(fecha)) <= 15){
					texto = "junio a agosto";
				}
			}else{
				texto = "junio a agosto";
			}
		}
		
		if(Integer.parseInt(date.getMes(fecha)) >= 8 && Integer.parseInt(date.getMes(fecha)) <= 12){
			if(Integer.parseInt(date.getMes(fecha)) == 8){
				if(Integer.parseInt(date.getDia(fecha)) > 15){
					texto = "agosto a diciembre";
				}
			}else{
				texto = "agosto a diciembre";
			}
		}
		
		return texto;
	}
		
}
