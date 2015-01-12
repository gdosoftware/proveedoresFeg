<%-- 
    Document   : facturaupload
    Created on : 28-oct-2014, 11:26:04
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<gdo:titulo titulo="Presentación de Factura"/> 
<spring:form commandName="commandUpload" enctype="multipart/form-data" 
             cssClass="proveedor-upload" role="form">
    
    <gdo:formTextArea label="Comentario" labelSize="3" inputSize="8" rows="3"
                      path="comentario" placeholder="Deje un comentario si lo desea" />
      
    <gdo:formInput label="Factura" labelSize="3" inputSize="8" 
                   path="fileupload" type="file" accept="application/pdf,text/xml" 
                   placeholder="seleccione un Archivo"/>
    <gdo:errors/> 

     <hr style="width: 100%">

     <div class='form-group col-xs-12'>
              <div class='col-xs-3 col-xs-offset-3'>
                  <a  href="../home" type='button' class="btn btn-default">
                      Cancelar
                  </a>
              </div>

              <div class='col-xs-3 col-xs-offset-2'>
                   <button type='submit' class="btn btn-primary">
                       Upload
                   </button>
              </div>

    </div>             

</spring:form>
                    

        
      
                    
                        
   