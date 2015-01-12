<%-- 
    Document   : avisorecepcion
    Created on : 29-oct-2014, 14:24:58
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-xs-6 col-xs-offset-3" style="border: 1px solid blue;padding-top: 10px">



                       <div class='form-group col-xs-12 alert alert-success'  role="alert" style="text-align: center;height: 100px">
                           <p>Hemos recibido su factura con el nro: ${requestScope['idFactura']}</p>
                           <p>Guarde este numero para una futura consulta</p>
                       </div>  



                       <hr style="width: 100%">

          <div class='form-group col-xs-12'>
                   <div class='col-xs-3 col-xs-offset-3'>
                       <a  href="../home" type='button' class="btn btn-default">
                           Inicio
                       </a>
                   </div>

                   <div class='col-xs-3 col-xs-offset-2'>
                        <a href="./upload" type='button' class="btn btn-primary">
                            Nueva Factura
                        </a>
                   </div>

         </div>             



</div>   
           
