<%-- 
    Document   : FormInner
    Created on : 17-jun-2014, 9:18:04
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
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@attribute name="labelSize" required="false" description="ancho del label entre 1..12 deacuerdo a la especificacion de bootstrap para col"%>
<%@attribute name="inputSize" required="false" description="ancho del elemento input en todas sus formas el valor al igual que en label esta 1..12"%>
<%@attribute name="layout" required="true" description="cual es el arreglo de layout que voy a utilizar para mostrar los label y los input puede ser horizontal stack"%>
<%@attribute name="size" required="false" description="es la medida en alto deacuerdo a bootstrap puede ser md lg"%>
<%@attribute name="checkItemlayout" required="false" description="es la forma en que se mostraran los radiobutton y los checkbox puede ser stack u horizontal"%>
<%@attribute name="disabled" required="true"  description="habilita y dehabilita el formulario puede ser true o false"%>

<%@attribute name="object"  required="true" description="objeto a iterar las propiedades"%>
<%@attribute name="propertyPrefix" required="false" description="para el caso de los objetos anidados este es el nombre de la propiedad objeto " %>
<%@attribute name="formName" required="false" description="nombre del fornulario en caso de colocarlo mostrara solo aquellas etiquetas cuyo formname coincida cone "%>


<c:set var="prefixValidatorClass" value="${fn:replace(propertyPrefix, '.','')}"/> <%--esta clase se utiliza para poder realizar la validacion--%>    
<c:if test="${fn:contains(propertyPrefix, '[')}">
    <c:set var="prefixValidatorClass" value="${fn:substringBefore(propertyPrefix, '[')}"/> <%--esta clase se utiliza para poder realizar la validacion--%>
</c:if>

<% for(Field field:request.getAttribute(object).getClass().getDeclaredFields()){%>
     <!--       cssItem es una clase que le agrego para poder hacer la validacion-->
       <c:set var="fieldName" value="<%=field.getName()%>"/>

  <gdo:formLayout  fieldName="${fieldName}" formName="${formName}" disabled='${disabled}' 
                      layout="${layout}" checkItemlayout="${checkItemlayout}" 
                      inputSize="${inputSize}" labelSize="${labelSize}" size="${size}" 
                      propertyPrefix="${propertyPrefix}" object="${object}"/> 
    
       
<%}%>

<style>
   label.error{
        color:red;
    }
</style>        
      
<script>
 $(document).ready(function(){    
    $.validator.addMethod("cRequired", $.validator.methods.required,'<msg:message code="error.required"/>');
     $.validator.addMethod("cRangeLength", $.validator.methods.rangelength,'<msg:message code="error.range"/>');
     $.validator.addMethod("cMin", $.validator.methods.min,'<msg:message code="error.min"/>');
     $.validator.addMethod("cMax", $.validator.methods.max,'<msg:message code="error.max"/>');
     $.validator.addMethod("cDigits", $.validator.methods.digits,'<msg:message code="error.digits"/>');
     $.validator.addMethod("cPattern", $.validator.methods.pattern,'<msg:message code="error.pattern"/>');
     $.validator.addMethod("cEmail", $.validator.methods.email,'<msg:message code="error.email"/>');//funciona con additional method"
     $.validator.addMethod("cEqualTo", $.validator.methods.equalTo,'<msg:message code="error.equalTo"/>');
     $.validator.addMethod("cRemote", $.validator.methods.remote, '<msg:message code="error.remote"/>');
     <% for(Field field:request.getAttribute(object).getClass().getDeclaredFields()){%>
         <c:set var="notNull" value="<%=field.getAnnotation(NotNull.class)%>"/>
         <c:set var="min" value="<%=field.getAnnotation(Min.class)%>"/>
         <c:set var="max" value="<%=field.getAnnotation(Max.class)%>"/>    
         <c:set var="digits" value="<%=field.getAnnotation(Digits.class)%>"/>        
         <c:set var="size" value="<%=field.getAnnotation(Size.class)%>"/>
         <c:set var="pattern" value="<%=field.getAnnotation(Pattern.class)%>"/>     
         <c:set var="email" value="<%=field.getAnnotation(Email.class)%>"/>       
         <c:set var="equalto" value="<%=field.getAnnotation(EqualTo.class)%>"/>     
         <c:set var="remote" value="<%=field.getAnnotation(Remote.class)%>"/>
        
            
         <c:if test="${notNull ne null || min ne null || size ne null || max ne null
                       || digits ne null || pattern ne null || email ne null 
                       || equalto ne null || remote ne null}">
                        
                 $.validator.addClassRules("${prefixValidatorClass}<%=field.getName()%>", { 
                      <c:if test="${notNull ne null}">cRequired:true,</c:if>
                       <c:if test="${min ne null}">cMin:${min.value()},</c:if>        
                      <c:if test="${max ne null}">cMax:${max.value()},</c:if>
                       <c:if test="${digits ne null}">cDigits:'true',</c:if>             
                      <c:if test="${size ne null}">cRangeLength:[${size.min()},${size.max()}],</c:if>     
                      <c:if test="${pattern ne null}">cPattern:'${pattern.value()}',</c:if>         
                      <c:if test="${email ne null}">cEmail:true,</c:if>             
                      <c:if test="${equalto ne null}">cEqualTo:'#${equalto.field()}',</c:if>                 
                      <c:if test="${remote ne null}">cRemote:'${remote.url()}',</c:if>    
                 });
          </c:if>    
     <%};%>    
 
});        
</script>
 