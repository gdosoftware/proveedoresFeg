<%-- 
    Document   : BasicForm
    Created on : 21-may-2014, 10:20:27
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>
<%@tag import="java.lang.reflect.Field"%>

<%@tag import="javax.validation.constraints.NotNull" %>
<%@tag import="javax.validation.constraints.Size" %>
<%@tag import="javax.validation.constraints.Min" %>
<%@tag import="javax.validation.constraints.Digits" %>
<%@tag import="javax.validation.constraints.Max" %>
<%@tag import="javax.validation.constraints.Pattern" %>
<%@tag import="org.hibernate.validator.constraints.Email"%>
<%@tag import="com.dog.tools.validators.EqualTo"%>
<%@tag import="com.dog.tools.validators.Remote"%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<%@attribute name="formName" required="false" description="nombre del fornulario en caso de colocarlo mostrara solo aquellas etiquetas cuyo formname coincida cone "%>
<%@attribute name="commandName" required="false" description="este es el nombre del atributo en el modelo donde se guarda el commandObject" %>
<%@attribute name="formType" required="false" description="puedo ser Raad o write"%>
<%@attribute name="formTitle" required="false" description="es el titulo  del formulario" %>
<%@attribute name="layout" required="true" description="cual es el arreglo de layout que voy a utilizar para mostrar los label y los input puede ser horizontal stack"%>
<%@attribute name="checkItemlayout" required="false" description="es la forma en que se mostraran los radiobutton y los checkbox puede ser stack u horizontal"%>
<%@attribute name="disabled" required="true"  description="habilita y dehabilita el formulario puede ser true o false"%>
<%@attribute name="enctype" required="false" description="utilizado para multipartfile" %>
<%@attribute name="extraContent" fragment="true" required="false" description="contenido extraddel formulario" %>




<c:choose>
    <c:when test="${layout eq 'horizontal'}">
        <c:set var="formClass" value="form-horizontal dg-${formName}"/>
    </c:when>
    <c:when test="${layout eq 'stack'}">
        <c:set var="formClass" value="dg-${formName}"/>
    </c:when>
</c:choose>
<%--si fueron ingresados por el tag prevalecen por los que fueron enviados desde el controller--%>
<c:if test="${formName eq null}"><c:set var="formName" value="${requestScope['formName']}"/></c:if>
<c:if test="${commandName eq null}"><c:set var="commandName" value="${requestScope['commandName']}"/></c:if>
<c:if test="${formType eq null}"><c:set var="formType" value="${requestScope['formType']}"/></c:if>
<c:if test="${formTitle eq null}"><c:set var="formTitle" value="${requestScope['formTitle']}"/></c:if>



<spring:form role='form' method='POST' commandName='commandName'
             cssClass="${formClass}" id="${formName}" enctype="${enctype}">
    <p class="form-title"><span class="glyphicon glyphicon-chevron-left"></span>${formTitle}</p>
    <gdo:formItems layout="${layout}"  checkItemlayout="${checkItemlayout}"  disabled='${disabled}'
                   object="commandName" formName="${formName}" />

   <jsp:invoke fragment="extraContent"/>
   <c:if test="${formType eq 'write'}">
        <hr style="width: 100%">
        <div class='form-group'>
                 
                  <div class='col-xs-5 col-xs-offset-2'>
                       <button type='submit' class="dg-btn-submit">
                           <gdo:out key="button.submit.label" label="Submit"/>
                       </button>
                  </div>

        </div>
  </c:if>
   
  
</spring:form>
<style>
   label.error{
        color:red;
    }
</style>        
      
<script>
 $(document).ready(function(){    
 
   $("#${formName}").validate({
                   onkeyup:false,// valida una vez salido el foco de input
                   focusCleanup:true,//borra los errores una vez que entramos a corregirlos
                   success: function(label,element) {
                                $(element).parent().removeClass("has-error").addClass("has-success");
                                $(element).parent().find('label.error').remove();//elimino el label en caso de exito
//                                $(".glyphicon-remove").remove();
//                                $(element).after("<span class='glyphicon glyphicon-ok form-control-feedback'></span>");
                             },
                   highlight: function(element, errorClass, validClass){
                                $(element).parent().addClass("has-error").removeClass("has-success");
//                                $(".glyphicon-ok").remove();
//                                $(element).after("<span class='glyphicon glyphicon-remove form-control-feedback'></span>");
                            }
               });
 
});        
</script>
 