<%-- 
    Document   : layout
    Created on : 31-oct-2014, 23:00:06
    Author     : Daniel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">


<!--        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">-->
         <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/smoothness/jquery-ui.css" />
       <%--  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />--%>
        <!-- Optional theme -->
<!--        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">-->
        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<%-- --%>       <link rel="stylesheet/less" type="text/css" href="<c:url value='/less/styles.less'/>" />
        <!-- Latest compiled and minified JavaScript -->
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script> 
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
<%--        <script src="<c:url value='/js/less-1.7.0.js'/>" type="text/javascript"></script>--%>
<!---->        <script src="//cdnjs.cloudflare.com/ajax/libs/less.js/2.0.0-b2/less.min.js"></script>
<%--        <link type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />--%>
        <title>Factura FEG Querataro</title>
       
    </head>
    <body>
        <div class="container">
            <div class="cabecera">
                   <div class="cabecera-col">
                        <tiles:insertAttribute name="header" />
                    </div>
            </div>
             <div class="menu">
                <div class="menu-col">
                    <tiles:insertAttribute name="menu" />
                </div>
            </div>
           
             <div class="cuerpo">
                
                    <tiles:insertAttribute name="body" />
                
            </div>
            <div class="pie">
                <div class="pie-col">
                    <tiles:insertAttribute name="footer" />
                </div>
            </div>    
        </div>
       
    </body>
</html>
