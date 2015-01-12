<%-- 
    Document   : facturasearch
    Created on : 03-nov-2014, 10:09:50
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<gdo:titulo titulo="Consulta de Factura"/> 
<c:if test="${error eq null}">
       
    <spring:form commandName="facturasearchCommand" cssClass="factura-form">


            <gdo:formInput label="idFactura" labelSize="3" inputSize="3"
                           path="idFactura" readOnly="true" />
            <gdo:formInput label="Fecha Factura" labelSize="3" inputSize="4"
                           path="fechaFactura" readOnly="true" />
          
            <gdo:formInput label="Factura(UUID)" labelSize="3" inputSize="8"
                           path="uuid" readOnly="true" />
            <gdo:formInput label="Fecha de Validacion" labelSize="3" inputSize="4"
                          path="fechaValidacion"  readOnly="true" /> 
             <gdo:formInput label="Motivo" labelSize="3" inputSize="7"
                          path="motivo"  readOnly="true" /> 
             <gdo:formSelect label="Estado" labelSize="3" selectSize="5"
                             readOnly="true" path="estado" values="estados"/>
             <gdo:formInput label="Fecha de Pago" labelSize="3" inputSize="4"
                          path="fechaPago"   readOnly="true" />          
             <gdo:formTextArea label="Comentario" labelSize="3" readOnly="true"
                               inputSize="7" path="comentario" rows="3"/>
           


        </spring:form>
    </c:if>
        <c:if test="${error ne null}">
             <div class='form-group col-xs-6 col-xs-offset-3 alert alert-danger'  role="alert" style="text-align: center">
                 <p>${error}</p>
             </div>  
   </c:if>






                    
