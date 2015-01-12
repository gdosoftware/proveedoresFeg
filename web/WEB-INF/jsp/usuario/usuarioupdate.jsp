<%-- 
    Document   : usuarioupdate
    Created on : 27-oct-2014, 14:44:39
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<div class="col-xs-6 col-xs-offset-3" style="border: 1px solid blue;padding-top: 10px">--%>


<gdo:titulo titulo="Modificación de Usuario"/> 
<spring:form commandName="usuarioCommandUpdate" cssClass="usuario-form" role="form">

         <gdo:formInput label="Nombre" labelSize="3" inputSize="7"
                        placeholder="Nombre o Compañia" readOnly="true"
                           path="nombre" groupSize="12" />
            <gdo:formInput label="Usuario" labelSize="3" inputSize="7"
                           placeholder="Nombre de Usuario"
                           path="username" groupSize="12"/>
             <gdo:formInput label="Contraseña" labelSize="3" inputSize="5"
                           placeholder="contraseña"
                           path="password" groupSize="12" />
            <gdo:formInput label="Email" labelSize="3" inputSize="7"
                           placeholder="Cuenta de Email"
                           path="email"  groupSize="12"/>
            <gdo:formSelect label="Rol" labelSize="3" selectSize="6"
                            path="rol" values="roles" groupSize="12"/>

          
            <gdo:formInput label="Rfc" labelSize="3" inputSize="7"
                           placeholder="Ingrese su Numero Rfc"
                           path="rfc"  divclass="rfc"  groupSize="12" />
              <gdo:formInput label="Dias de Credito" labelSize="3" inputSize="3"
                           placeholder="Ingrese dias de credito"
                           path="diasCredito"  divclass="dcred"  groupSize="12" />

            <gdo:formCheck label="Habilidata" path="enabled" 
                           inputSize="10" labelSize="3" groupSize="12"/>

         <gdo:errors/>


                 <hr style="width: 100%">

          <div class='form-group col-xs-12'>
                   <div class='col-xs-3 col-xs-offset-3'>
                       <a  href="../crud" type='button' class="btn btn-default">
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
<%--</div>   --%>
              
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
