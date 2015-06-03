<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<html:html lang="true">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%--LISTA DE IMPORT DE LOS JSP QUE MOSTRARAN LAS VENTANAS--%>
        <title><bean:message key="welcome.title"/></title>
        <script type="text/javascript">           
            function createNewObj(typeClass){
                var p_width=850;
                var p_height=450;              
                winObj=Ext.create(typeClass, {
                    name: 'test'
                });
                if(winObj.height!=undefined)
                    p_height=winObj.height;
                else
                    winObj.height=p_height;
                if(winObj.width!=undefined)
                    p_width=winObj.width;
                else
                    winObj.width=p_width;               
                winObj.v_person='1';               
                winObj.maximizable=true;  
                winObj.show();              
                
                return winObj;
            }
            
            function createNewObj2(typeClass,parametro){
                var p_width=850;
                var p_height=450;
                winObj=Ext.create(typeClass, {            
                    //VARIABLE PARA AGREGAR UN SEGUNDO PARAMETRO AL CREAR EL OBJETO 
                    name: parametro
                });
                if(winObj.height!=undefined)
                    p_height=winObj.height;
                else
                    winObj.height=p_height;
                if(winObj.width!=undefined)
                    p_width=winObj.width;
                else
                    winObj.width=p_width;        
                winObj.v_person='1';
                winObj.maximizable=true;                    
                winObj.show();
        
                return winObj;
            }
            
            function createNewObj3(typeClass,parametro,parametroDos){
                var p_width=850;
                var p_height=450;
                winObj=Ext.create(typeClass, {            
                    name: parametro,
                    nameDos: parametroDos
                });
                if(winObj.height!=undefined)
                    p_height=winObj.height;
                else
                    winObj.height=p_height;
                if(winObj.width!=undefined)
                    p_width=winObj.width;
                else
                    winObj.width=p_width;
        
                winObj.v_person='1';
                winObj.maximizable=true;                    
                winObj.show();
        
                return winObj;
            }
            
            function createNewObj4(typeClass,parametro,parametroDos,parametroTres){
                var p_width=850;
                var p_height=450;
                winObj=Ext.create(typeClass, {            
                    name: parametro,
                    nameDos: parametroDos,
                    nameTres: parametroTres
                });
                if(winObj.height!=undefined)
                    p_height=winObj.height;
                else
                    winObj.height=p_height;
                if(winObj.width!=undefined)
                    p_width=winObj.width;
                else
                    winObj.width=p_width;
        
                winObj.v_person='1';
                winObj.maximizable=true;                    
                winObj.show();
        
                return winObj;
            }
        </script>
    </head>
    <body >
    </body>
</html:html>