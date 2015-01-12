<%-- 
    Document   : ModalLayout
    Created on : 13-jun-2014, 16:01:57
    Author     : Administrador
--%>

<%@tag description="layout para formularios de retrieve y delete, lo botones los ponesmos nosotros" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>

<%@attribute name="content" fragment="true" required="true" description="contenido del modal" %>
<%@attribute name="type" required="true" description="create/retrieve/update/delete" %>
<%@attribute name="cssHeader" required="false" description="css para el modal" %>
<%@attribute name="cssBody" required="false" description="css para el modal" %>
<%@attribute name="cssFooter" required="false" description="css para el modal" %>
<%@attribute name="cssCancel" required="false" description="css para el modal" %>
<%@attribute name="cssAccept" required="false" description="css para el modal" %>

<c:if test="${cssCancel eq null}">
    <c:set var="cssCancel" value="btn btn-default"/>
</c:if>
<c:if test="${cssAccept eq null}">
    <c:set var="cssAccept" value="btn btn-primary"/>
</c:if>


 <div class="modal-header ${cssHeader}">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel"></h4>
 </div>
 
 <div  class="modal-body ${cssBody}" style="min-height:100px;overflow: hidden">     
     <jsp:invoke fragment="content"/>
 </div>
<c:choose>
    <c:when test="${type eq 'retrieve' || type eq 'delete'}">
            <div class="modal-footer ${cssFooter}" style="position: relative">
                <button type="button" class="${cssCancel}" data-dismiss="modal"><msg:message code="modal.button.cancel" text="Cancel"/></button>
                <a  href="#" id="accept" class="${cssAccept} modal-btn-accept" role="button"></a>
            </div>
    </c:when>
</c:choose>
 
                      
     
      