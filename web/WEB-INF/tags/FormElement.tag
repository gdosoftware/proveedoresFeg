<%-- 
    Document   : FormElement
    Created on : 23-sep-2014, 11:36:25
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="label" required="true"%>
<%@attribute name="inputSize" required="false"%>
<%@attribute name="labelSize" required="false"%>
<%@attribute name="idt" required="false"%>
<%@attribute name="element" fragment="true" required="true"%>
<%@attribute name="clase" required="false" %>

<c:if test="${inputSize eq null}">
    <c:set var="inputSize" value="10"/>
</c:if>
<c:if test="${labelSize eq null}">
    <c:set var="labelSize" value="10"/>
</c:if>



<div class="form-group col-xs-12 has-feedback ${clase}">
      <label for="${idt}" class="col-xs-${labelSize} control-label">${label}</label>
      <div class="col-xs-${inputSize}">
          <jsp:invoke fragment="element"/>
     
        
      </div>
 </div>