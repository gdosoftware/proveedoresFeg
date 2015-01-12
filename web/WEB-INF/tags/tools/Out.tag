<%-- 
    Document   : Out
    Created on : 06-jun-2014, 10:16:29
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="key" required="true" rtexprvalue="true"%>
<%@attribute name="label" required="true" rtexprvalue="true"%>


<c:if test="${label ne ''}">
    ${label}
</c:if>
<c:if test="${label eq ''}">
    <msg:message code="${key}"/>
</c:if>