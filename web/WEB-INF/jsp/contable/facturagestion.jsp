<%-- 
    Document   : facturasempleado
    Created on : 29-oct-2014, 15:38:54
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<gdo:titulo titulo="Gestión de Facturas sin Pago"/>
<div class="empleado-gestion">
<table class="empleado-table">

        <thead>
            <tr>

                  <td>Item</td>  
                  <td>ID Recibo</td>  
                  <td>Fecha Factura</td>  
                  <td>Empresa</td>  
                  <td>Factura(UUID)</td>
                  <td>Orden de Compra</td>
                  <td>Orden de Entrada</td>
                  <td>Validacion</td> 
                  <td>Fecha Pago</td>
                  <td>Validar</td>
                  <td>Pagar</td>

            </tr>
        </thead>

        <tbody>
            <c:forEach var="item" items="${requestScope['facturasunpaid']}" varStatus="linea">
               <tr>

                   <td>${linea.index}</td>
                   <td>${item.idFactura}</td>
                   <td><fmt:formatDate value="${item.fechaFactura}" pattern="dd/MM/yy"/></td>
                   <td>${item.proveedor.nombre}</td>
                   <td>${item.uuid}</td>
                   <td>${item.ordenCompra}</td>
                   <td>${item.ordenEntrada}</td>
                    
                 <%-- <c:if test="${item.estado eq 'PEND'}">
                       <td>Pendiente</td>
                   </c:if>--%>
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
                   <td><fmt:formatDate value="${item.fechaPago}" pattern="dd/MM/yy"/></td>
                    <td>
                        <c:if test="${item.estado eq 'CONFIRM'}">
                            <a class="btn btn-primary" href="validarfactura/${item['id']}">
                                <span class="glyphicon glyphicon-check"></span>
                            </a>
                        </c:if>
                        <c:if test="${item.estado eq 'TOPAY' || item.estado eq 'VALID'}">
                            <a class="btn btn-primary disabled" href="validarfactura/${item['id']}">
                                <span class="glyphicon glyphicon-check"></span>
                            </a>
                        </c:if>

                   </td> 
                    <td>
                        <c:if test="${item.estado eq 'CONFIRM' || item.estado eq 'REJECT'}">
                            <a class="btn btn-primary disabled" href="pagarfactura/${item['id']}">
                                <span class="glyphicon glyphicon-usd"></span>
                              </a>
                        </c:if>
                        <c:if test="${item.estado eq 'VALID' || item.estado eq 'TOPAY'}">
                            <a class="btn btn-primary" href="pagarfactura/${item['id']}">
                                <span class="glyphicon glyphicon-usd"></span>
                              </a>
                        </c:if>

                   </td> 
               </tr>

            </c:forEach>   

        </tbody>
        <tfoot>
           <%--  <gdo:tablePager colspan="9"/>--%>
       </tfoot>   
       </table>
                
</div>                      

  