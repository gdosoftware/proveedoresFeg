<%-- 
    Document   : CrudTable
    Created on : 26-may-2014, 16:34:55
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>
<%@tag import="com.dog.tools.anotaciones.ListItem"%>
<%@tag import="com.dog.tools.anotaciones.Lists"%>
<%@tag import="java.lang.reflect.Field"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@attribute name="listName" required="false" description="es el nombre de la lista a mostrar"%>
<%@attribute name="listSource" required="true" description="es la fuente de datos pagara generar la lista"%>
<%@attribute name="listObject" required="true" description="nombre donde se guarda el objeto del que estan compuestas las filas de la tabla" %>

<%@attribute name="modalCreatePage" required="false" description="pagina de contenido del modal de add" %>
<%@attribute name="modalDeletePage" required="false" description="pagina de contenido del modal de Delete" %>
<%@attribute name="modalUpdatePage" required="false" description="pagina de contenido del modal de Upadate" %>
<%@attribute name="modalRetrievePage" required="false" description="pagina de contenido del modal de informacion cuando se doble clickea en una row" %>

<%@attribute name="cssTable" required="false" %>
<%@attribute name="cssHeader" required="false" %>
<%@attribute name="cssTR" required="false" %>
<%@attribute name="cssTD" required="false" %>

<%@attribute name="cssButtons" required="false" %>
<%@attribute name="pageable" required="false" %>


<%--<%=itemsName%> es igual a decir ${pageScope.itemsName} --%>
 
<style>
    td{
        padding: 3px 5px 3px 5px;
    }
</style>
<c:set var="entityTable"  value='<%=request.getAttribute(listObject).getClass().getSimpleName().toLowerCase()%>'
       scope="request"/>
<jsp:useBean id="kte" class="com.dog.tools.controller.DogConstants"/>

<table class="table-responsive col-xs-12 ${cssTable}">
    
 <thead>
     <tr class="${cssHeader}">
              <td></td>  
     <gdo:tableHead object="${listObject}" listName="${listName}" />
     </tr>
 </thead>
 
 <tbody>
    
     <c:forEach var="item" items="${requestScope[listSource]}">
        <c:set var="itemList" value="${item}" scope="request"/><%--bajo el nombre de itemList se guarda durante el request el reglon de la lista --%>
        <tr class="${cssTR}">
            <td><input type="checkbox" class="td-check" data-id="${item['id']}"></td>
             
             <gdo:tableTR object="itemList" listName="${listName}" 
                         cssTD="${cssTD}" cssTR="${cssTR}" 
                         cssButtonUpdate="${cssButtonUpdate}"
                         cssButtonDelete="${cssButtonDelete}"/>
           
        </tr>
      
     </c:forEach>  
       
 </tbody>
 <tfoot>
      <c:if test="${pageable eq 'true'}">
            <gdo:tablePager colspan="${fieldCount+1}" cssPager="${cssFooter}"/>
        </c:if>
     <tr>
         <td colspan="${fieldCount+1}" style="text-align: center"> 

            <div class="btn-group">
                 <button data-toggle="modal"  data-target="#crudModalDialog" 
                          class="${cssButtons} crud-btn-create" >
                             <span class="glyphicon glyphicon-plus"></span>
                             <msg:message code="crudtable.button.create" text="Create"/>
                 </button>  
                  <button data-toggle="modal"  data-target="#crudModalDialog" 
                           class="${cssButtons} crud-btn-update">
                            <span class="glyphicon glyphicon-edit"></span>
                             <msg:message code="crudtable.button.update" text="Update"/>
                  </button> 
                   <button data-toggle="modal"  data-target="#crudModalDialog" 
                            class="${cssButtons} crud-btn-delete">
                            <span class="glyphicon glyphicon-remove"></span>
                            <msg:message code="crudtable.button.delete" text="Delete"/>
                  </button>
                   <button data-toggle="modal"  data-target="#crudModalDialog" 
                            class="${cssButtons} crud-btn-retrieve">
                            <span class="glyphicon glyphicon-search"></span>
                            <msg:message code="crudtable.button.retrieve" text="Retrieve"/>
                  </button>
                               
              </div>
         </td>              
     </tr>
 </tfoot>   
</table>
     
          <%--<a href="javascript:$('#modal .modal-body').load('remote.html',function(e){$('#modal').modal('show');});">Click me</a>--%>              

<div class="modal fade ${cssClass}" id="crudModalDialog" tabindex="-1" role="dialog" 
           aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
     <div class="modal-content">
        
         <%--  contenido a insertar  HAY QUE FORZAR POR CUENTA DE UNO QUE SE RECARGE EL CONTENIDO--%>
     </div>
   </div>
</div>
     

  
         <msg:message code="modal.delete.button" text="Delete" var="modaldelete" />
         <msg:message code="modal.update.title" text="Update..?" var="modalupdatetitle" />
         <msg:message code="modal.delete.title" text="Delete..?" var="modaldeletetitle" />
         <msg:message code="modal.create.title" text="Create a new Record" var="modalcreatetitle" />
         <msg:message code="modal.retrieve.title" text="Retrieve a  Record" var="modalretrievetitle" />
        
     <script>
//     una vez que oprimo el boton cargo la pagina que corresponda en el dialogo modal lo hago yo con el metodo
//     de jquery load pues si se lo dejo a bootstrap con el atributo href del boton solo lo carga la primera vez
//     que llamo al cuadro modal y el resto me muestra el mismo contenido, de esta manera al forzar la carga se actualiza 
//     el contenido
       $(document).ready(function(){
                                
                $(".td-check").click(function(){
                    $(".td-check").not(this).attr("checked",false);
                   $(this).attr("checked",true);

                });
  
                
              <%--  <c:set var="id" value='<%=request.getParameter("id")%>'/>
                <c:if test="${id ne null}">
                         var url='../update/${modalUpdatePage}/'+${id};
                         $('#crudModalDialog').modal({remote:url});
                </c:if>--%>
                
               $(".crud-btn-delete").click(function(){
                   var idx=$(".td-check[checked='checked']").data('id');
                    $('#crudModalDialog .modal-content').load("retrieve/${modalDeletePage}/"+idx,
                        function(){
                            $(".modal-btn-accept").attr("href","delete/"+idx);//coloco el href en el boton del cuadro modal para que llame a borrar
                            $(".modal-btn-accept").text('${modaldelete}');
                            $(".modal-title").text('${modaldeletetitle}');
                        });
                    
                    
                });
                
                $(".crud-btn-update").click(function(){
                    var idx=$(".td-check[checked='checked']").data('id');
                   // var idx=$(this).data('id');
                     // sessionStorage.setItem("idpupi", idx);
                    $('#crudModalDialog .modal-content').load("update/${modalUpdatePage}/"+idx,
                        function(){
                            $(".modal-title").text('${modalupdatetitle}');
                            $('.btn-form-cancel').attr("data-dismiss","modal");
                        });
                    
                });
              
                $(".crud-btn-create").click(function(){
                    
                    $('#crudModalDialog .modal-content').load("create/${modalCreatePage}",
                        function(){
                            $(".modal-title").text('${modalcreatetitle}');
                            $('.btn-form-cancel').attr("data-dismiss","modal");
                        });
                    
                });
                
                 $(".crud-btn-retrieve").click(function(){
                    var idx=$(".td-check[checked='checked']").data('id');
                    $('#crudModalDialog .modal-content').load("retrieve/${modalRetrievePage}/"+idx,
                        function(){
                            $(".modal-title").text('${modalretrievetitle}');
                            $('.btn-form-cancel').attr("data-dismiss","modal");
                        });
                    
                });
           
      });  

  
   
             
             
             
         
     </script>