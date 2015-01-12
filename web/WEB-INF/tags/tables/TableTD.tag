<%-- 
    Document   : TableTD
    Created on : 30-jun-2014, 14:18:58
    Author     : Daniel
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- The list of normal or fragment attributes can be specified here: --%>

<%@attribute name="fieldName" required="true"%>
<%@attribute name="cssTD" required="false" %>

<td style="text-align:center" class="${cssTD}">
    
     <c:choose>
            <%------------------------INPUT TEXT----------------------------------------%>
             <c:when test="${li.type() eq 'TEXT' ||
                             li.type() eq 'TEXTAREA'||
                             li.type() eq 'HIDDEN'}">
                              ${itemList[fieldName]}
             </c:when>
          
         
           <%------------------------SELECT------------------------------------------%>
            <c:when test="${li.type() eq 'SELECT' && !li.multiple()}">
                  <c:set var="mapa" value="${requestScope[fieldName]}" />
                  <c:set var="val" value="${itemList[fieldName]}"/>
                  ${mapa[val]}
            </c:when>
        <%-----------------------MULTI-SELECT------------------------------------------%>
            <c:when test="${li.type() eq 'SELECT' && li.multiple()}">
                  <c:set var="mapa" value="${requestScope[fieldName]}" />
                  <c:forEach var="val" items="${itemList[fieldName]}">
                        ${mapa[val]}
                  </c:forEach>    
            </c:when>     
          <%------------------------RADIOBUTTONS---------------------------------------%>
            <c:when test="${li.type() eq 'RADIO'}">
               <c:set var="mapa" value="${requestScope[fieldName]}" />
               <c:set var="val" value="${itemList[fieldName]}"/>
               ${mapa[val]}
            </c:when>

            <%------------------------CHECKBOXES----()---------------------------------------%>
             <c:when test="${li.type() eq 'CHECKBOX'}">
                   <c:forEach var="op" items="${itemList[fieldName]}">
                       ${op}
                   </c:forEach>

            </c:when>
             
            <%--------------------------IMAGE---------------------------------------%>
            <c:when test="${li.type() eq 'IMG'}">
                 <c:set var="prop" value="${fi.fileDescriptor()}"/>
                 <c:set var="objeto" value="${itemList[prop]}"/>
                <c:if test="${!li.multiple()}">
                   <c:set var="propertyName" value="fileName"/>

                   <img src="${pageContext.request.contextPath}/image/${objeto[propertyName]}" 
                        class="img-responsive" > 
               </c:if>
               <c:if test="${li.multiple()}">
                   <c:set var="itlst" value="${objeto[0]}"/>

                   <img src="${pageContext.request.contextPath}/image/${itlst['fileName']}" 
                        class="img-responsive" > 
               </c:if>    
            </c:when>

            <%------------------------ENTITY------------------------------------------%>
            <c:when test="${(li.type() eq 'ENTITY'|| li.type() eq 'NEWENTITY') && !li.multiple()}">
             <c:set var="objeto" value="${itemList[fieldName]}"/>
                <c:set var="propertyName" value="${li.foreignProperty()}"/>
                    ${objeto[propertyName]}
            </c:when> 
            <%----------------------MULTI-ENTITY------------------------------------------%> 
            <c:when test="${(li.type() eq 'ENTITY'|| li.type() eq 'NEWENTITY') && li.multiple()}">
                <c:set var="foreignProperty" value="${li.foreignProperty()}"/>
                 <ul>
                    <c:forEach var="op" items="${itemList[fieldName]}">
                        <li type="none">${op[foreignProperty]}</li>
                    </c:forEach>    
                    </ul> 
            </c:when>  
             <%------------------------INPUT DATE----------------------------------------%>
             <c:when test="${li.type() eq 'DATE'}">
                
                 <%--<fmt:formatDate value="${itemList[fieldName]}"  pattern="${fn:replace(fi.dateFormat(),'mm','MM')}"/> --%>
                  <fmt:formatDate value="${itemList[fieldName]}"  pattern="${li.pattern()}"/> 
             </c:when>
 
</c:choose>  
     
</td>   