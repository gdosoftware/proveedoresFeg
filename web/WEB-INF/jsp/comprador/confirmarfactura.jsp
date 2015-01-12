<%-- 
    Document   : confirmarfactura
    Created on : 09-ene-2015, 11:25:16
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <gdo:titulo titulo="Validación de Facturas"/>                   
                   
<spring:form commandName="facturaConfirmCommand" cssClass="factura-form" role="form">

       <gdo:formInput label="idFactura" labelSize="3" inputSize="3"
                       path="idFactura" readOnly="true" />
        <gdo:formInput label="Fecha Factura" labelSize="3" inputSize="4"
                       path="fechaFactura" inputClass="fechfactura" />
         <gdo:formInput label="Empresa" labelSize="3" inputSize="7"
                       path="proveedor.nombre" readOnly="true" />
        <gdo:formInput label="Factura(UUID)" labelSize="3" inputSize="8"
                       path="uuid" readOnly="true" />
        <gdo:formInput label="Orden de Compra" labelSize="3" inputSize="8"
                       path="ordenCompra" />
        <gdo:formInput label="Orden de Entrada" labelSize="3" inputSize="8"
                       path="ordenEntrada" />
        <gdo:formTextArea label="Comentario" labelSize="3" 
                      inputSize="7" path="comentario" rows="3"/>
      
      <gdo:errors/>
            <hr style="width: 100%">

     <div class='form-group col-xs-12'>
              <div class='col-xs-3 col-xs-offset-3'>
                  <a  href="../gestion" type='button' class="btn btn-default">
                      Cancelar
                  </a>
              </div>

              <div class='col-xs-3 col-xs-offset-2'>
                   <button type='submit' class="btn btn-primary">
                       Aceptar
                   </button>
              </div>

    </div>      


</spring:form>

<script>
      
    $(document).ready(function(){
        
          $( ".fechfactura" ).on("mousedown",function(){
                $(".fechfactura").datepicker();
                $(".fechfactura").datepicker("option", "dateFormat",'dd/mm/yy');
                
                });
        
        
        
        
        
        
                                               
      
    });
  </script>  