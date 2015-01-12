<%-- 
    Document   : facturagestion
    Created on : 09-ene-2015, 10:44:23
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<gdo:titulo titulo="Gestión de Confirmacion de Facturas"/>
<div class="empleado-gestion">
<table class="empleado-table">

        <thead>
            <tr>

                  <td>Item</td>  
                  <td>ID Recibo</td>  
                  <td>Fecha Factura</td>  
                  <td>Empresa</td>  
                  <td>Factura(UUID)</td>
                  <td>Confirmar</td>
                  

            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${requestScope['facturaspend']}" varStatus="linea">
               <tr>

                   <td>${linea.index}</td>
                   <td>${item.idFactura}</td>
                   <td><fmt:formatDate value="${item.fechaFactura}" pattern="dd/MM/yy"/></td>
                   <td>${item.proveedor.nombre}</td>
                   <td>${item.uuid}</td>
                   
                    
                <%--   <c:if test="${item.estado eq 'PEND'}">
                       <td>Pendiente</td>
                   </c:if>
                   <c:if test="${item.estado eq 'CONFIRM'}">
                       <td>Conforme</td>
                   </c:if>    
                   <c:if test="${item.estado eq 'VALID'}">
                       <td style="color: green">OK</td>
                   </c:if>
                   <c:if test="${item.estado eq 'REJECT'}">
                       <td style="color: red">Rechazada</td>
                   </c:if>
                    <c:if test="${item.estado eq 'TOPAY'}">
                       <td style="color: green">a Pagar</td>
                   </c:if>    

                   <td><fmt:formatDate value="${item.fechaPago}" pattern="dd/MM/yy"/></td>--%>
                    <td>
                       <a class="btn btn-primary" href="confirmarfactura/${item['id']}">
                                <span class="glyphicon glyphicon-check"></span>
                       </a>

                   </td> 
                   
               </tr>

            </c:forEach>   

        </tbody>
        <tfoot>
           <%--  <gdo:tablePager colspan="9"/>--%>
       </tfoot>   
       </table>
                
</div>                      
