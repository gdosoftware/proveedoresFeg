<%-- 
    Document   : usuarioretrieve
    Created on : 27-oct-2014, 11:14:00
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<gdo:titulo titulo="Consulta de Usuario"/> 

<%--<spring:form commandName="usuarioCommand" cssClass="col-lg-5 col-lg-offset-4 col-xs-8 col-xs-offset-2"
             role="form" cssStyle="border:2px solid #6699ff;border-radius:10px;padding:10px">--%>
<spring:form commandName="usuarioCommand" cssClass="usuario-form" role="form" >

            <gdo:formInput label="Nombre" labelSize="3" inputSize="7"
                           placeholder="Nombre o Compañia" readOnly="true"
                           path="nombre" groupSize="12" />
            <gdo:formInput label="Usuario" labelSize="3" inputSize="7"
                           placeholder="Nombre de Usuario" readOnly="true"
                           path="username" groupSize="12"/>
             <gdo:formInput label="Contraseña" labelSize="3" inputSize="5"
                           placeholder="contraseña" readOnly="true"
                           path="password" groupSize="12" />
            <gdo:formInput label="Email" labelSize="3" inputSize="7"
                           placeholder="Cuenta de Email" readOnly="true"
                           path="email"  groupSize="12"/>
            <gdo:formSelect label="Rol" labelSize="3" selectSize="6" readOnly="true"
                            path="rol" values="roles" groupSize="12"/>

          
            <gdo:formInput label="Rfc" labelSize="3" inputSize="7"
                           placeholder="Ingrese su Numero Rfc" readOnly="true"
                           path="rfc"  divclass="rfc"  groupSize="12" />
             <gdo:formInput label="Dias de Credito" labelSize="3" inputSize="3"
                           placeholder="Ingrese dias de credito" readOnly="true"
                           path="diasCredito"  divclass="dcred"  groupSize="12" />


            <gdo:formCheck label="Habilidata" path="enabled" readOnly="true"
                           inputSize="10" labelSize="3" groupSize="12"/>
         
            <hr style="width: 100%">

          <div class='form-group col-xs-12'>
                   <div class='col-xs-3 col-xs-offset-4'>
                       <a  href="../crud" type='button' class="btn btn-primary">
                           Volver
                       </a>
                   </div>


         </div>      


    </spring:form>
<script>
    $(document).ready(function(){
       
       
            if($('#rol').val() === "PROV_LOCAL"){
               $(".rfc").show();
            }else{
                $(".rfc").hide();
            };
            
            if($('#rol').val() === "PROV_LOCAL" || $('#rol').val() === "PROV_EXT"){
               $(".dcred").show();
            }else{
                $(".dcred").hide();
            };
        
    });
  </script>  



