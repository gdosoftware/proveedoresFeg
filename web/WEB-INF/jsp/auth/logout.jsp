<%-- 
    Document   : logout
    Created on : 05-sep-2014, 14:22:51
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<h1>Hasta Luego ${pageContext.request.userPrincipal.name}</h1>
 ${pageContext.request.session.invalidate()}