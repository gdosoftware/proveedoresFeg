<%-- 
    Document   : BasicFormItem
    Created on : 21-may-2014, 8:19:10
    Author     : Administrador
--%>


<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>



<%@attribute name="fieldName" required="true"%>
<%@attribute name="formName" required="false" description="nombre del fornulario en caso de colocarlo mostrara solo aquellas etiquetas cuyo formname coincida cone "%>
<%@attribute name="propertyPrefix" required="false" description="para el caso de los objetos anidados este es el nombre de la propiedad objeto " %>
<%@attribute name="object"  required="true" description="objeto a iterar las propiedades"%>
<%@attribute name="disabled" required="true"%>

<%@attribute name="labelSize" required="false"%>
<%@attribute name="inputSize" required="false"%>
<%@attribute name="layout" required="true"%>
<%@attribute name="size" required="false"%>
<%@attribute name="checkItemlayout" required="false"%>
<%@attribute name="cssTD" required="false"%>


<c:set var="fi" value="<%=request.getAttribute(object).getClass().getDeclaredField(fieldName).getAnnotation(FormItem.class)%>" 
       scope="request"/>
<c:set var="forms" value="<%=request.getAttribute(object).getClass().getDeclaredField(fieldName).getAnnotation(Forms.class)%>" />

<c:if test="${forms ne null}">
           <c:forEach var="fs" items="${forms.value()}">
              
               <c:if test="${fs.formName() eq formName}">
                   <c:set var="fi" value="${fs}" scope="request"/>
               </c:if>
           </c:forEach>
          
 </c:if>
<c:set var="entity"  value='<%=request.getAttribute(object).getClass().getSimpleName().toLowerCase()%>' 
       scope="request"/>

<c:if test="${fi ne null && fi.type() ne 'HIDDEN'}">
   
        <c:choose>
            <c:when test="${layout eq 'stack'}">
                <div class="form-group col-xs-12 has-feedback">
                    <label for="${fieldName}"><gdo:out key="${entity}.${fieldName}.formitem.label" label="${fi.label()}"/></label>
                  <gdo:formField fieldName="${fieldName}"  prefix="${propertyPrefix}" formName="${formName}"
                                   size="${size}" checkItemlayout="${checkItemlayout}" disabled="${disabled}"/> 
                                  
                </div>
            </c:when>
            <c:when test="${layout eq 'horizontal'}">
                <div class="form-group col-xs-12 has-feedback">
                    <label for="${fieldName}" class="col-xs-${labelSize} control-label"><gdo:out key="${entity}.${fieldName}.formitem.label" label="${fi.label()}"/></label>
                    <div class="col-xs-${inputSize}">
                        <gdo:formField fieldName="${fieldName}" prefix="${propertyPrefix}" formName="${formName}"
                                      size="${size}" checkItemlayout="${checkItemlayout}"
                                      disabled="${disabled}"/> 
                                      
                    </div>
                </div>
            </c:when>
            <c:when test="${layout eq 'table'}">
                 <td style="text-align:center"  class="${cssTD}">
                      <gdo:formField fieldName="${fieldName}" prefix="${propertyPrefix}" formName="${formName}"
                                      size="${size}" checkItemlayout="${checkItemlayout}"
                                      disabled="${disabled}"/> 
                 </td>                     
            </c:when>
        </c:choose>
    
</c:if>
<c:if test="${fi.type() eq 'HIDDEN'}"><%--este es para los casos que es necesario preservar los datos como es en el caso de varios formularios en un update--%>
     <gdo:formField fieldName="${fieldName}" prefix="${propertyPrefix}" formName="${formName}"
                                      size="${size}" checkItemlayout="${checkItemlayout}"
                                      disabled="${disabled}"/> 
</c:if>                 