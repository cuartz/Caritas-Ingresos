/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.utils;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*; 


/**
 *
 * @author RCastilloc
 */
public class sendmail {
    public static void main(String[] args)
    {
        try
        {
            // Propiedades de la conexión
            Properties props = new Properties();
            props.setProperty("mail.smtp.host", "caritas.org.mx");
            props.setProperty("mail.smtp.port", "25");
            props.setProperty("mail.smtp.user", "siec@caritas.org.mx");
            props.setProperty("mail.smtp.auth", "true");

            // Preparamos la sesion
            Session session = Session.getDefaultInstance(props);

            // Construimos el mensaje
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("siec@caritas.org.mx"));
            message.addRecipient(
                Message.RecipientType.TO,
                new InternetAddress("roberto.castillo.conde@metalsa.com"));
            message.setSubject("Hola");
            message.setText(
                "Mensaje de prueba con Java Mail" + "Para las OA." + "Comprobacion");

            // Lo enviamos.
            Transport t = session.getTransport("smtp");
            t.connect("siec@caritas.org.mx", "siec4179");
            t.sendMessage(message, message.getAllRecipients());

            // Cierre.
            t.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}



