<%-- 
    Document   : login
    Created on : 05-sep-2014, 12:16:56
    Author     : Administrador
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="login">
    <form action="${pageContext.request.contextPath}/j_spring_security_check" 
          method="post" role="form" >

            <div class="login-element has-feedback">
                <label for="j_username">Usuario</label>
                <input name="j_username" id="j_username" type="text" class="form-control input-sm"
                       placeholder="Nombre de Usuario">

            </div>
             <div class="login-element has-feedback">
                <label for="j_password">Contraseña</label>
                <input name="j_password" id="j_username" type="password" class="form-control input-sm"
                       placeholder="Contraeña">

            </div>  
            <c:if test="${requestScope['loginerror']}">
               <div class='login-element alert alert-danger'  role="alert" style="text-align: center">
                   <p>Usuario o contraseña incorrecta</p>
               </div>  
            </c:if>
            <div class='login-element' style="text-align: center">
                                <button type='submit' class="btn btn-primary">
                                      Ingresar
                                 </button>    
             </div> 
        </form>    
  </div>
