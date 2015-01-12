<%-- 
    Document   : usuarioprofile
    Created on : 31-oct-2014, 10:13:10
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<gdo:titulo titulo="Perfil"/> 
                   
<spring:form commandName="usuarioCommandUpdate" cssClass="usuario-form" role="form">

<%--el groupSize si no se lo pongo es 12--%>
        <gdo:formInput label="Nombre" labelSize="3" inputSize="8"
                       path="nombre" readOnly="true" />
        <gdo:formInput label="Usuario" labelSize="3" inputSize="7"
                       readOnly="true"  path="username" />
         <gdo:formInput label="Email" labelSize="3" inputSize="7"
                       path="email" />
         <gdo:formInput label="Contraseña anterior" labelSize="3" inputSize="5"
                       placeholder="Contraseña anterior"
                       path="oldpassword" type="password"/>
         <gdo:formInput label="Contraseña Nueva" labelSize="3" inputSize="5"
                       placeholder="Contraseña Nueva"
                       path="password" type="password"/>
         <gdo:formInput label="Contraseña Nueva" labelSize="3" inputSize="5"
                       placeholder="Reingrese Contraseña "
                       path="repassword" type="password"/>

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
                            Aceptar
                        </button>
                   </div>

         </div>      


    </spring:form>

