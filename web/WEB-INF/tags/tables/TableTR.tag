

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags"%>
<%@tag import="com.dog.tools.anotaciones.ListItem"%>
<%@tag import="com.dog.tools.anotaciones.Lists"%>
<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>
<%@tag import="java.lang.reflect.Field"%>

<%@attribute name="listName" required="false" description="utilizado para show y para crud"%>
<%@attribute name="object" required="true" description="viene guardado el nombre del atributo que contiene la row de la lista"%>

<%@attribute name="propertyPrefix" required="false"%>
<%@attribute name="disabled" required="false" description="se utiliza en los casos de form para inhabilitar el formulario en las consultas" %>

<%@attribute name="cssTR" required="false"%>
<%@attribute name="cssTD" required="false"%>

<%@attribute name="cssButtonUpdate" required="false"%>
<%@attribute name="cssButtonDelete" required="false"%>

<c:set var="item" value="<%=request.getAttribute(object)%>"/>


    
  
   <%-- <c:if test="${item.id ne null}">--%>
    <% for(Field field:request.getAttribute(object).getClass().getDeclaredFields()){%>
             <c:set var="li" value="<%=field.getAnnotation(ListItem.class)%>" scope="request"/>
 <%--        <c:set var="fi" value="<%=field.getAnnotation(FormItem.class)%>" scope="request" />--%>
             
             <c:set var="lists" value="<%=field.getAnnotation(Lists.class)%>"/>
      <%--   <c:set var="forms" value="<%=field.getAnnotation(Forms.class)%>" />--%>
            
             <c:set var="fieldName" value="<%=field.getName()%>"/>
             

              <c:if test="${lists ne null}">
                  <c:forEach var="ls" items="${lists.value()}">
                      <c:if test="${ls.listName() eq listName}">
                          <c:set var="li" value="${ls}" scope="request"/>
                      </c:if>
                  </c:forEach>
              </c:if>

          <%--<c:if test="${forms ne null}">
                  <c:forEach var="fs" items="${forms.value()}">
                      <c:if test="${fs.formName() eq formName}">
                          <c:set var="fi" value="${fs}" scope="request"/>
                      </c:if>
                  </c:forEach>
              </c:if>--%>

            
  <%--           <c:if test="${li ne null && fi ne null}">--%>
             <c:if test="${li ne null}">     
                     <gdo:tableTD fieldName="${fieldName}" cssTD="${cssTD}"/>
            </c:if>
      <%}%>

      <%--</c:if>--%>
     
            
               
  <%--  </c:if>                 --%>
  