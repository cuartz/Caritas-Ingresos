<%-- 
    Document   : administracion
    Created on : 25/05/2011, 10:26:06 AM
    Author     : RCastilloc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   x
<html>
    <head>
        <script>    
    
            var tabs2 = Ext.createWidget('tabpanel', {
                renderTo: 'stage_users',
                activeTab: 0,
                width: 2000,
                anchor: '100%',
                height: 500,
                plain: true,
                defaults :{
                    autoScroll: true,
                    bodyPadding: 10
                },
                items: [
                    {
                        title: 'Usuarios',
                        loader: {
                            url: 'usuarios.jsp',
                            contentType: 'html',
                            autoLoad: true,
                            params: 'foo=123&bar=abc'
                        }
                    }/*,{
                        title: 'Sistema',
                        loader: {
                            url: 'ajax2.htm',
                            contentType: 'html',
                            autoLoad: true,
                            params: 'foo=123&bar=abc'
                        }
                    }*/
                ]
            });
        </script>
    </head>
    <body>
        <div id="stage_users"></div>
    </body>
</html>