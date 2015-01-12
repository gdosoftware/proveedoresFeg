<%-- 
    Document   : FormSelect
    Created on : 04-nov-2014, 14:47:58
    Author     : Administrador
--%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="label" required="true"%>
<%@attribute name="path" required="true"%>
<%@attribute name="selectSize" required="false"%>
<%@attribute name="labelSize" required="false"%>
<%@attribute name="groupSize" required="false"%>
<%@attribute name="readOnly" required="false"%>
<%@attribute name="divclass" required="false" %>
<%@attribute name="values" required="true" description="nombre del atributo en el modelmap donde figuran los options" %>

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


<div class="form-group col-xs-${groupSize} has-feedback ${divclass}" style="padding-right:0px;padding-left: 0px" >
      <label for="${path}" class="col-xs-${labelSize} control-label">${label}</label>
      <div class="col-xs-${selectSize}">
          <c:if test="${readonly ne null}">
               <spring:select path="${path}" items="${requestScope[values]}" 
                                cssClass="form-control" id="${path}" disabled="true"/>
            
        </c:if>
           <c:if test="${readonly eq null}">
                <spring:select path="${path}" items="${requestScope[values]}" 
                                cssClass="form-control" id="${path}"/>
            
        </c:if>
        
      </div>
 </div>