<%-- 
    Document   : InnerCrud
    Created on : 08-jul-2014, 10:33:57
    Author     : Daniel
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8" %>

<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>
<%@tag import="com.dog.tools.anotaciones.ListItem"%>
<%@tag import="com.dog.tools.anotaciones.Lists"%>
<%@tag import="java.lang.reflect.Field"%>
<%@tag import="javax.validation.constraints.NotNull" %>
<%@tag import="javax.validation.constraints.Size" %>
<%@tag import="javax.validation.constraints.Min" %>
<%@tag import="javax.validation.constraints.Digits" %>
<%@tag import="javax.validation.constraints.Max" %>
<%@tag import="javax.validation.constraints.Pattern" %>
<%@tag import="org.hibernate.validator.constraints.Email"%>
<%@tag import="com.dog.tools.validators.EqualTo"%>
<%@tag import="com.dog.tools.validators.Remote"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@attribute name="formName" required="false"%>
<%@attribute name="listName" required="false"%>
<%@attribute name="object" required="true"%>
<%@attribute name="propertyPrefix" required="true" %>
<%@attribute name="disabled" required="true" %>

<%@attribute name="cssTable" required="false" %>
<%@attribute name="cssHeader" required="false" %>
<%@attribute name="cssTR" required="false" %>
<%@attribute name="cssTD" required="false" %>

<%@attribute name="cssButtonAdd" required="false" %>
<%@attribute name="cssButtonDelete" required="false" %>


<%--<%=itemsName%> es igual a decir ${pageScope.itemsName} --%>
 
<style>
    td{
        padding: 3px 5px 3px 5px;
    }
   
</style>
<c:set var="entityTable"  value='<%=request.getAttribute(object).getClass().getSimpleName().toLowerCase()%>'
       scope="request"/>
<c:set var="listLength" value="<%=request.getAttribute(object).getClass().getDeclaredFields().length%>"/>
<c:set var="lastRow" value="${fn:length(requestScope['list'])}"/>

<table class="table-responsive col-xs-12 ${cssTable} table-${propertyPrefix}">
    <thead>
 <thead>
     <tr  cssHeader="${cssHeader}">
         <gdo:tableHead object="${object}" listName="${listName}"/>
     </tr>    
     
 </thead>
 
 <tbody id="table-body">

     <c:forEach var="item" items="${requestScope['list']}" varStatus="vs">
        <c:set var="itemList" value="${item}" scope="request"/><%--bajo el nombre de itemList se guarda durante el request el reglon de la lista --%>
        <c:set var="entity" value="${propertyPrefix}" scope="request"/>
        <tr class="${cssTR}">
            <gdo:formItems layout="table" disabled='${disabled}'
                      object="itemList" formName="${formName}" 
                       propertyPrefix="${propertyPrefix}[${vs.index}]"/> 
             <c:if test="${disabled eq 'false'}">
               <td>
                   <button type="button" class="btn btn-danger btn-xs form-btn-delete" name="">
                       <span class="glyphicon glyphicon-remove"></span>
                   </button>
               </td>          
           </c:if> 
        </tr>
     
     </c:forEach>  
    
 </tbody>
  <tfoot>
      <c:if test="${disabled eq 'false'}">
        <tr>
            <td colspan="${listLength-1}" style="text-align: center">
                <a  class="${cssButtonAdd} form-btn-add" role="button" ><gdo:out key="crudtable.button.add" label="Add"/></a>
            </td>
       </tr>
    </c:if>
 </tfoot>  
</table>
       
     <script>

       $(document).ready(function(){


          function sort(){//reordeno los indices para que no queden los barrodas como regisdtros en blanco en la tabla  
               $('.table-${propertyPrefix} #table-body tr').each(function(index) {
                   $(this).find('td').children().each(function(){
                       if($(this).attr("name")!=null){//debo preguntar pues esta en juego el label de la validacion que no contiene name
                            var valor=$(this).attr("name").replace(/\[(.+?)\]/g,"["+index+"]"); 
                            $(this).attr("name",valor);
                            $(this).attr("id",valor);
                       }

                   });
           
              });
           };

           
           $(".form-btn-add").click(function(){
               var $tableBody= $('.table-${propertyPrefix} #table-body');
               var $newTr= $('.table-${propertyPrefix} #table-body tr').last().clone();
               $newTr.find('td').each(function(index){
                   $(this).children().val('');
               }); 
               $tableBody.append($newTr);
               sort();// llamo areordenar para que le coloquen el indice

           });
          
            $('.table-${propertyPrefix}').on('click','.form-btn-delete', function () { //hay que hacer delegacion de evnetos para reconozca a los intem agregados dinamicamente               
               console.log($(this).parent().parent().remove());
                sort();
            });
         
           }); 
       
     </script>