<%-- 
    Document   : RetrieveAttributes
    Created on : 02-jun-2014, 14:14:54
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%
   out.write("=== ================================Request data ==="+"<br>");
  java.util.Enumeration<String> reqEnum = request.getAttributeNames();
  while (reqEnum.hasMoreElements()) {
    String s = reqEnum.nextElement();
    out.write(s+"==" + request.getAttribute(s)+"<br>");
    
    
  }
 
   out.write("**************************************** Session data ***"+"<br>");
 java.util.Enumeration<String> e = request.getSession().getAttributeNames();
  while (e.hasMoreElements()){
    String s = e.nextElement();
   out.write(s+"==" + session.getAttribute(s)+"<br>");
   
  }
 







%>