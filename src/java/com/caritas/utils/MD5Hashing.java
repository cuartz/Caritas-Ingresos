/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.caritas.utils;
import java.security.MessageDigest;

/**
 *
 * @author RCastilloc
 * 
 * Create MD5 function to authenticate user´s
 */
public class MD5Hashing {
    public static String getMD5(String keyWord){
        StringBuffer hexString = new StringBuffer();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(keyWord.getBytes());

            byte byteData[] = md.digest();

            for (int i=0;i<byteData.length;i++) {
                    String hex=Integer.toHexString(0xff & byteData[i]);
                    if(hex.length()==1) hexString.append('0');
                    hexString.append(hex);
            }

        } catch(Exception ex){
            return "";
        }
        return hexString.toString();
    }
}
