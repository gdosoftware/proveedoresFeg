<%-- 
    Document   : BasicTable
    Created on : 26-may-2014, 14:47:08
    Author     : Daniel
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@tag import="com.dog.tools.anotaciones.ListItem"%>
<%@tag import="com.dog.tools.anotaciones.Lists"%>
<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>
<%@tag import="java.lang.reflect.Field"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%@attribute name="listName" required="false" description="es el nombre de la lista a mostrar"%>
<%@attribute name="listSource" required="true" description="es la fuente de datos pagara generar la lista"%>
<%@attribute name="listObject" required="true" description="nombre donde se guarda el objeto del que estan compuestas las filas de la tabla" %>

<%@attribute name="pageable" required="false" description="si es o no paginada la tabla"%>
<%@attribute name="cssTable" required="false" %>
<%@attribute name="cssHeader" required="false" %>
<%@attribute name="cssFooter" required="false" %>
<%@attribute name="cssTR" required="false" %>
<%@attribute name="cssTD" required="false" %>

<%--<%=itemsName%> es igual a decir ${pageScope.itemsName} --%>

<style>
    td{
        padding: 0 5px 0 5px;
    }
</style>
<%--<c:set var="listacompleta" value="${requestScope[listSource]}"/>
<c:set var="className" value=" ${commandObject['class'].simpleName}"/>
<c:set var="entityTable"  value="${fn:toLowerCase(className)}" scope="request"/>--%>

 <c:set var="entityTable"  value='<%=request.getAttribute(listObject).getClass().getSimpleName().toLowerCase()%>'
       scope="request"/>  

<c:if test="${pagebale eq ''}">
    <c:set var="pageable" value="false"/>
</c:if>

<table class="table-responsive col-xs-12 ${cssTable}">
    <thead>
        <tr class="${cssHeader}">
             <gdo:tableHead object="${listObject}" listName="${listName}" />
        </tr>
    </thead>
    <tbody>
        <%--bajo el nombre de list guardo cualquier list que se me pida   --%>
       
       <c:forEach var="item" items="${requestScope[listSource]}">
           <c:set var="itemList" value="${item}" scope="request"/>
           <tr class="${cssTR}" data-id="${item.id}">
           <gdo:tableTR object="itemList" listName="${listName}"
                        cssTD="${cssTD}" cssTR="${cssTR}" />
           </tr>
       </c:forEach>
    </tbody>
    <tfoot>
        <c:if test="${pageable eq 'true'}">
            <gdo:tablePager colspan="${fieldCount}" cssPager="${cssFooter}"/>
        </c:if>
    </tfoot>
</table>
