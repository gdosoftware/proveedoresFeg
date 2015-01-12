<%-- 
    Document   : facturaspagas
    Created on : 31-oct-2014, 8:08:35
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<gdo:titulo titulo="Facturas Pagas"/>
<div class="empleado-facturas">                    
<table class="empleado-table">

        <thead class="cabecera">
            <tr style="text-align: center">

                  <td>Item</td>  
                  <td>ID Recibo</td>  
                  <td>Fecha Factura</td>  
                  <td>Empresa</td>  
                  <td>Factura(UUID)</td>  
                  <td>Fecha Pago</td>


            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${requestScope['listadofacturaspagas']}" varStatus="linea">
               <tr>

                   <td>${linea.index}</td>
                   <td>${item.idFactura}</td>
                   <td><fmt:formatDate value="${item.fechaFactura}" pattern="dd/MM/yy"/></td>
                   <td>${item.proveedor.nombre}</td>
                   <td>${item.uuid}</td>
                   <td><fmt:formatDate value="${item.fechaPago}" pattern="dd/MM/yy"/></td>

               </tr>

            </c:forEach>   

        </tbody>
        <tfoot>
            <gdo:tablePager colspan="6"/>
       </tfoot>   
       </table>

</div>
