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
<%@attribute name="commandObject" required="true" description="objeto comando del form" %>
<%@attribute name="labelSize" required="false" description="ancho del label entre 1..12 deacuerdo a la especificacion de bootstrap para col"%>
<%@attribute name="inputSize" required="false" description="ancho del elemento input en todas sus formas el valor al igual que en label esta 1..12"%>
<%@attribute name="layout" required="true" description="cual es el arreglo de layout que voy a utilizar para mostrar los label y los input puede ser horizontal stack"%>
<%@attribute name="size" required="false" description="es la medida en alto deacuerdo a bootstrap puede ser md lg"%>
<%@attribute name="checkItemlayout" required="false" description="es la forma en que se mostraran los radiobutton y los checkbox puede ser stack u horizontal"%>
<%@attribute name="cssClass" required="false" description="clase css que tendra el formulario"%>
<%@attribute name="cssSubmit" required="false" description="clase css que tendra el boton de submit"%>
<%@attribute name="cssCancel" required="false" description="clase css que tendra el boton de cancel"%>
<%@attribute name="onCancel" required="false" description="funcion javascript que se llama al momento de cancelar"%>
<%@attribute name="disabled" required="true"  description="habilita y dehabilita el formulario puede ser true o false"%>
<%@attribute name="enctype" required="false" description="utilizado para multipartfile" %>
<%@attribute name="extraContent" fragment="true" required="false" description="contenido extraddel formulario" %>
<%@attribute name="disabledButtons" required="false" description="si true dehabilita los botone esto es para reemplazarlos por otros propios" %>
<!--<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">

 Optional theme 
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
 Latest compiled and minified JavaScript 
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>  
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.12.0/jquery.validate.min.js"  type="text/javascript"></script>   
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.12.0/additional-methods.min.js" type="text/javascript"></script>-->

<jsp:useBean id="kte" class="com.dog.tools.controller.DogConstants"/>

<c:choose>
    <c:when test="${layout eq 'horizontal'}">
        <c:set var="formClass" value="form-horizontal ${cssClass}"/>
    </c:when>
    <c:when test="${layout eq 'stack'}">
        <c:set var="formClass" value="${cssClass}"/>
    </c:when>
</c:choose>

<c:if test="${disabled eq true}">
    <c:set var="button_state" value="disabled"/>
</c:if>
 <c:if test="${disabled eq false}">
    <c:set var="button_state" value=""/>
 </c:if>
<c:if test="${disabledButtons eq null}">
    <c:set var="disabledButtons" value="false"/>
 </c:if>
<c:if test="${formName eq null}"><c:set var="formName" value="formulario"/></c:if><%--para que funcione la validacion--%>



<spring:form role='form' method='POST' commandName='${commandObject}'
             cssClass="${formClass}" id="${formName}" enctype="${enctype}">
   
    <gdo:formItems layout="${layout}"  checkItemlayout="${checkItemlayout}" inputSize="${inputSize}"
                   labelSize="${labelSize}" size="${size}"  disabled='${disabled}'
                   object="${commandObject}" formName="${formName}" />

   <jsp:invoke fragment="extraContent"/>
   
  
   
   <c:if test="${disabledButtons eq 'false' && disabled eq 'false'}">
        <c:set var="etty"  value='<%=request.getAttribute(commandObject).getClass().getSimpleName().toLowerCase()%>'/>
        <hr style="width: 100%">
        <div class='form-group col-xs-12'>
                  <div class='col-xs-3 col-xs-offset-3'>
                      <button type='button' class="btn ${cssCancel} ${button_state} btn-form-cancel" onclick="${onCancel}">
                          <gdo:out key="${etty}.button.cancel.label" label=""/>
                      </button>
                  </div>

                  <div class='col-xs-3 col-xs-offset-2'>
                       <button type='submit' class="btn ${cssSubmit} ${button_state}">
                           <gdo:out key="${etty}.button.submit.label" label=""/>
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
 