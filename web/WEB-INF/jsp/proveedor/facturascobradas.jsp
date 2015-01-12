<%-- 
    Document   : facturaspagas
    Created on : 31-oct-2014, 8:08:35
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<gdo:titulo titulo="Listado Facturas Cobradas"/> 
<div class="proveedor-gestion">                   
<table class="proveedor-table">

        <thead class="cabecera">
            <tr style="text-align: center">

                  <td>Item</td>  
                  <td>ID Recibo</td>  
                  <td>Fecha Factura</td>  
                   <c:if test="${pageContext.request.isUserInRole('PROV_LOCAL')}">
                          <td>Factura(UUID)</td>  
                   </c:if> 
                  <td>Fecha Pago</td>


            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${requestScope['listadofacturascobradas']}" varStatus="linea">
               <tr>

                   <td>${linea.index}</td>
                   <td>${item.idFactura}</td>
                   <td><fmt:formatDate value="${item.fechaFactura}" pattern="dd/MM/yy"/></td>
                   <c:if test="${pageContext.request.isUserInRole('PROV_LOCAL')}">
                       <td>${item.uuid}</td>
                   </c:if>
                   <td><fmt:formatDate value="${item.fechaPago}" pattern="dd/MM/yy"/></td>

               </tr>

            </c:forEach>   

        </tbody>
        <tfoot>
            
            <gdo:tablePager colspan="5"/>
            

        </tfoot>   
       </table>

</div>
