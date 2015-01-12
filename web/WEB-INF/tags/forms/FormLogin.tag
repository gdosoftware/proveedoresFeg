<%-- 
    Document   : FormLogin
    Created on : 15-sep-2014, 10:45:30
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<%@attribute name="labelSize" required="false" description="ancho del label entre 1..12 deacuerdo a la especificacion de bootstrap para col"%>
<%@attribute name="inputSize" required="false" description="ancho del elemento input en todas sus formas el valor al igual que en label esta 1..12"%>
<%@attribute name="layout" required="true" description="cual es el arreglo de layout que voy a utilizar para mostrar los label y los input puede ser horizontal stack"%>
<%@attribute name="size" required="false" description="es la medida en alto deacuerdo a bootstrap puede ser md lg"%>
<%@attribute name="cssClass" required="false" description="clase css que tendra el formulario"%>
<%@attribute name="cssSubmit" required="false" description="clase css que tendra el boton de submit"%>

<msg:message code="login.username.placeholder" var="userplaceholder"/>
<msg:message code="login.password.placeholder" var="passwordplaceholder"/>
<jsp:useBean id="kte" class="com.dog.tools.controller.DogConstants"/>
<form action="${pageContext.request.contextPath}/j_spring_security_check" method="post" role="form">
 <c:choose>
            <c:when test="${layout eq 'stack'}">
                <div class="form-group col-xs-12 has-feedback">
                    <label for="j_username"><gdo:out key="login.username.label" label="UserName"/></label>
                    <input name="j_username" id="j_username" type="text" class="form-control input-${size}"
                           placeholder="${userplaceholder}">
                                  
                </div>
                 <div class="form-group col-xs-12 has-feedback">
                    <label for="j_password"><gdo:out key="login.password.label" label="Password"/></label>
                    <input name="j_password" id="j_username" type="password" class="form-control input-${size}"
                           placeholder="${passwordplaceholder}">
                                  
                </div>  
                  
            </c:when>
            <c:when test="${layout eq 'horizontal'}">
                <div class="form-group col-xs-12 has-feedback">
                    <label for="j_username" class="col-xs-${labelSize} control-label"><gdo:out key="login.username.label" label="UserName"/></label>
                    <div class="col-xs-${inputSize}">
                       <input name="j_username" id="j_username" type="text" class="form-control input-${size}"
                              placeholder="${userplaceholder}">
                    </div>
                </div>
                <div class="form-group col-xs-12 has-feedback">
                    <label for="j_password" class="col-xs-${labelSize} control-label"><gdo:out key="login.password.label" label="UserName"/></label>
                    <div class="col-xs-${inputSize}">
                       <input name="j_password" id="j_username" type="password" class="form-control input-${size}"
                              placeholder="${passwordplaceholder}">
                    </div>
                </div>    
            </c:when>
            
 </c:choose>

 <c:if test="${requestScope[kte.LOGIN_ERROR]}">
    <div class='form-group col-xs-12 alert alert-danger'  role="alert" style="text-align: center">
      <gdo:out key="login.error.message" label="UserName or Password Incorrect"/>
    </div>  
 </c:if>
 <div class='form-group col-xs-12' style="text-align: center">
                     <button type='submit' class="btn ${cssSubmit}">
                           <gdo:out key="login.button.submit.label" label=""/>
                      </button>    
     </div> 
 </form>    