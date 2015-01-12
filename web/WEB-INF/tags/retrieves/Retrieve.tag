<%-- 
    Document   : RetrieveForm
    Created on : 27-may-2014, 15:28:06
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%@tag import="java.lang.reflect.Field"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>

<%@attribute name="formName" required="false" description="nombre del fornulario en caso de colocarlo mostrara solo aquellas etiquetas cuyo formname coincida cone "%>
<%@attribute name="labelSize" required="false" description="ancho del label entre 1..12 deacuerdo a la especificacion de bootstrap para col"%>
<%@attribute name="inputSize" required="false" description="ancho del elemento input en todas sus formas el valor al igual que en label esta 1..12"%>
<%@attribute name="layout" required="true" description="cual es el arreglo de layout que voy a utilizar para mostrar los label y los input puede ser horizontal stack"%>
<%@attribute name="size" required="false" description="es la medida en alto deacuerdo a bootstrap puede ser md lg"%>
<%@attribute name="checkItemlayout" required="false" description="es la forma en que se mostraran los radiobutton y los checkbox puede ser stack u horizontal"%>
<%@attribute name="cssClass" required="false" description="clase css que tendra el formulario"%>





<c:choose>
    <c:when test="${layout eq 'horizontal'}">
        <c:set var="formClass" value="form-horizontal ${cssClass}"/>
    </c:when>
    <c:when test="${layout eq 'stack'}">
        <c:set var="formClass" value="${cssClass}"/>
    </c:when>
</c:choose>



<c:set var="entity"  value='<%=request.getAttribute("commandName").getClass().getSimpleName().toLowerCase()%>'
       scope="request"/>  

<spring:form role='form' method='POST' commandName='commandName'
             cssClass="${formClass}" id="${formName}"  >
   

 <% for(Field field:request.getAttribute("commandName").getClass().getDeclaredFields()){%>
  
       <c:set var="fieldName" value="<%=field.getName()%>"/>
      
       <gdo:formItems  fieldName="${fieldName}"  formName="${formName}" disabled='${true}' 
                      layout="${layout}" checkItemlayout="${checkItemlayout}" 
                      inputSize="${inputSize}" labelSize="${labelSize}" size="${size}" 
                      object="commandName"/>
    
            
<%}%>
    

</spring:form>
 