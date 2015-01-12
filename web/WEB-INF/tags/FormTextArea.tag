<%-- 
    Document   : FormTextArea
    Created on : 05-nov-2014, 10:06:09
    Author     : Administrador
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
<%@attribute name="rows" required="false" %>
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




<div class="form-group col-xs-${groupSize}  ${divclass}" style="padding-right:0px;padding-left: 0px" >
      <label for="${path}" class="col-xs-${labelSize} control-label">${label}</label>
      <div class="col-xs-${inputSize}">
        <c:if test="${readonly ne null}">
             <spring:textarea path="${path}" rows="${rows}" readonly="true"
                              cssClass="form-control  ${inputClass}"
                              placeholder="${placeholder}"/>
            
        </c:if>
        <c:if test="${readonly eq null}">
            <spring:textarea path="${path}" rows="${rows}" 
                              cssClass="form-control  ${inputClass}"
                              placeholder="${placeholder}"/>
        </c:if>
        
      </div>
 </div>
          
         