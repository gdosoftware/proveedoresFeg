<%-- 
    Document   : Errors
    Created on : 01-nov-2014, 0:19:56
    Author     : Daniel
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${requestScope['resultado'] eq 'failed'}">
    <div class='form-group col-xs-12 alert alert-danger'  role="alert" style="text-align: center">
    <ul>
        <c:forEach var="oe" items="${resultmsg}">
            <li>${oe.defaultMessage}</li>
        </c:forEach>
    </ul>
    </div>  
</c:if>           
