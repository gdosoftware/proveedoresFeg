<%-- 
    Document   : facturaproveedor
    Created on : 31-oct-2014, 9:01:40
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<gdo:titulo titulo="Listado de Facturas Pendientes de Cobro"/> 
<div class="proveedor-gestion">                    
<table class="proveedor-table">

            <thead>
                <tr style="text-align: center">

                      <td>Item</td>  
                      <td>ID Recibo</td>  
                      <td>Fecha Factura</td>
                      <c:if test="${pageContext.request.isUserInRole('PROV_LOCAL')}">
                          <td>Factura(UUID)</td>  
                      </c:if>
                      <td>Validacion</td> 
                      <td>Motivo</td> 
                      <td>Fecha Pago</td>


                </tr>
            </thead>

            <tbody>
                <c:forEach var="item" items="${requestScope['listadofacturaspendientes']}" varStatus="linea">
                   <tr>

                       <td>${linea.index}</td>
                       <td>${item.idFactura}</td>
                       <td><fmt:formatDate value="${item.fechaFactura}" pattern="dd/MM/yy"/></td>

                       <c:if test="${pageContext.request.isUserInRole('PROV_LOCAL')}">
                            <td>${item.uuid}</td>
                       </c:if>
                       
                      <c:if test="${item.estado eq 'PEND'}">
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
                        <td>${item.motivo}</td>
                       <td><fmt:formatDate value="${item.fechaPago}" pattern="dd/MM/yy"/></td>

                   </tr>

                </c:forEach>   

            </tbody>
            <tfoot>
                <gdo:tablePager colspan="7"/>
                
           </tfoot>   
           </table>
</div>              
                       

  