<%-- 
    Document   : FormElement
    Created on : 22-sep-2014, 22:37:18
    Author     : Daniel
--%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="label" required="true"%>
<%@attribute name="path" required="true"%>
<%@attribute name="inputClass" required="false"%>
<%@attribute name="inputSize" required="false"%>
<%@attribute name="groupSize" required="false" description="sirva para poder fijar un contenedor al label y al input"%>
<%@attribute name="labelSize" required="false"%>
<%@attribute name="placeholder" required="false"%>
<%@attribute name="readOnly" required="false"%>
<%@attribute name="divclass" required="false" %>
<%@attribute name="type" required="false" %>
<%@attribute name="accept" required="false" description="tipo de archivos que se aceptan en le caso del type file"%>
<!--cuando se quiere compone un formulario colocando varios  label-input en line una opcion es utilizar el gruopSize
y por ejemplo darle un valor de 6 esto hara que tyenga dos label-input en la misma linea-->

<c:if test="${inputSize eq null}">
    <c:set var="inputSize" value="8"/>
</c:if>
<c:if test="${labelSize eq null}">
    <c:set var="labelSize" value="4"/>
</c:if>
<c:if test="${groupSize eq null}">
    <c:set var="groupSize" value="12"/>
</c:if>

<c:if test="${readOnly ne null}">
    <c:set var="readonly" value="readonly"/>
</c:if>

<c:if test="${type eq null}">
    <c:set var="type" value="text"/>
</c:if>


<div class="form-group col-xs-${groupSize}  ${divclass}" style="padding-right:0px;padding-left: 0px" >
      <label for="${path}" class="col-xs-${labelSize} control-label">${label}</label>
      <div class="col-xs-${inputSize}">
        <c:if test="${readonly ne null}">
            <spring:input path="${path}" cssClass="form-control  ${inputClass}" id="${path}"
                          placeholder="${placeholder}" readonly="true" type="${type}" />
        </c:if>
        <c:if test="${readonly eq null}">
            <spring:input path="${path}" cssClass="form-control  ${inputClass}" id="${path}"
                          placeholder="${placeholder}" type="${type}" accept="${accept}"/>
        </c:if>
        
        
      </div>
 </div>
          
         