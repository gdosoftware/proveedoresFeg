<%-- 
    Document   : TableFoot
    Created on : 03-sep-2014, 9:00:45
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@attribute name="colspan" required="true" description="cuantas columnas debera abarcar el foot" %>
<%@attribute name="cssPager" required="false" %>



<c:set var="totalPages" value="${requestScope['total']}"/>
<c:set var="currentIndex" value="${requestScope['current']}"/>
<c:set var="beginIndex" value="${requestScope['begin']}"/>
<c:set var="endIndex" value="${requestScope['end']}"/>

<c:url var="firstUrl" value="1" />
<c:url var="lastUrl" value="${totalPages}" />
<c:url var="prevUrl" value="${currentIndex-1}" />
<c:url var="nextUrl" value="${currentIndex+1}" />



<tr class="${cssFooter}">
         <td colspan="${colspan}" style="text-align: center">
             <ul class="pagination pagination-sm" style="margin: 3px 0px">
               <c:choose>
                    <c:when test="${currentIndex == 1}">
                        <li class="disabled"><a href="#">&lt;&lt;</a></li>
                        <li class="disabled"><a href="#">&lt;</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${firstUrl}">&lt;&lt;</a></li>
                        <li><a href="${prevUrl}">&lt;</a></li>
                    </c:otherwise>
                </c:choose>
                <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                    <c:url var="pageUrl" value="${i}" />
                    <c:choose>
                        <c:when test="${i == currentIndex}">
                            <li class="active"><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:choose>
                    <c:when test="${currentIndex == totalPages}">
                        <li class="disabled"><a href="#">&gt;</a></li>
                        <li class="disabled"><a href="#">&gt;&gt;</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${nextUrl}">&gt;</a></li>
                        <li><a href="${lastUrl}">&gt;&gt;</a></li>
                    </c:otherwise>
                </c:choose>
             </ul>
         </td>
 </tr>

    
