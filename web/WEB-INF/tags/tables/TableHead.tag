<%-- 
    Document   : TableHead
    Created on : 30-jun-2014, 10:27:18
    Author     : Daniel
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@tag import="com.dog.tools.anotaciones.ListItem"%>
<%@tag import="com.dog.tools.anotaciones.Lists"%>
<%@tag import="java.lang.reflect.Field"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>

<%@attribute name="object" required="true" description="nombre del obejto a iterar" %>
<%@attribute name="listName" required="false"%>


            <% int contador=0;%>
            <% for(Field field:request.getAttribute(object).getClass().getDeclaredFields()){%>
                <c:set var="li" value="<%=field.getAnnotation(ListItem.class)%>"/>
                <c:set var="lists" value="<%=field.getAnnotation(Lists.class)%>"/>
                
                <c:if test="${lists ne null}">
                    <c:forEach var="ls" items="${lists.value()}">
                        <c:if test="${ls.listName() eq listName}">
                            <c:set var="li" value="${ls}"/>
                        </c:if>
                    </c:forEach>
                </c:if>
                
                <c:set var="fieldName" value="<%=field.getName()%>"/>
                <c:if test="${li ne null}">
                   <td style="text-align:center">
                        
                        <gdo:out key="${entityTable}.${fieldName}.listitem.header" label="${li.headName()}"/>
                        <%contador++;%>
                    </td>                    
                </c:if>    
                
            <%}%>
            <c:set var="fieldCount" value="<%=contador%>" scope="request"/>
        


  