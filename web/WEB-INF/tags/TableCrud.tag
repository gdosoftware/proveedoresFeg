<%-- 
    Document   : TableCrud
    Created on : 27-oct-2014, 9:59:43
    Author     : Administrador
--%>

<%@tag description="put the tag description here" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@attribute name="numeroColumnas" required="true" %>
<%@attribute name="tableBody" required="true" fragment="true" %>
<%@attribute name="header" required="false" %>
   <table class="table-responsive table-bordered table-hover col-xs-12">
    
                            <thead class="${header}">
                                <tr style="text-align: center">
                                     <c:forEach var="ith" items="${requestScope['tableheader']}">
                                            <td>${ith}</td>  
                                     </c:forEach>
                                         
                                </tr>
                            </thead>

                            <tbody>
                                     <jsp:invoke fragment="tableBody"/>
                                
                            </tbody>
                            <tfoot>
                                <%-- <c:if test="${pageable eq 'true'}">
                                       <gdo:tablePager colspan="${fieldCount+1}" cssPager="${cssFooter}"/>
                                  </c:if>--%>
                                <tr >
                                    <td colspan="${numeroColumnas}" style="text-align: center;padding: 5px 0 5px 0"> 

                                       <div class="btn-group">
                                           <button class="crud-btn-create btn-primary">
                                                        <span class="glyphicon glyphicon-plus"></span>
                                                        Crear
                                            </button>  
                                             <button  class="btn-rud crud-btn-update btn-primary" disabled="disabled">
                                                       <span class="glyphicon glyphicon-edit"></span>
                                                        Modificar
                                             </button> 
                                              <button  class="btn-rud  btn-primary" disabled="disabled"
                                                       data-toggle="modal" data-target="#myModal">
                                                       <span class="glyphicon glyphicon-remove"></span>
                                                       Eliminar
                                             </button>
                                              <button class="btn-rud crud-btn-retrieve btn-primary" disabled="disabled" >
                                                       <span class="glyphicon glyphicon-search"></span>
                                                       Consultar
                                             </button>

                                         </div>
                                    </td>              
                                </tr>
                            </tfoot>   
                           </table>
                                    
   <div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">Eliminar Registro</h4>
      </div>
      <div class="modal-body">
        <p>Esta Seguro de Eliminar el Registro?</p>
      </div>
      <div class="modal-footer">
        <a role="button" class="btn btn-default" data-dismiss="modal">Close</a>
        <a role="button" class="btn btn-primary crud-btn-delete" >Eliminar</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->                                 
                       
                            
 
  <script>
//     una vez que oprimo el boton cargo la pagina que corresponda en el dialogo modal lo hago yo con el metodo
//     de jquery load pues si se lo dejo a bootstrap con el atributo href del boton solo lo carga la primera vez
//     que llamo al cuadro modal y el resto me muestra el mismo contenido, de esta manera al forzar la carga se actualiza 
//     el contenido
       $(document).ready(function(){
                                
                $(".td-check").click(function(){
                    $(".td-check").not(this).attr("checked",false);
                   $(this).attr("checked",true);
                   $(".btn-rud").removeAttr("disabled");

                });
                
                
               $(".crud-btn-delete").click(function(){
                   var idx=$(".td-check[checked='checked']").data('id');
                   $(location).attr('href',"delete/"+idx);
                 
                });
                
                $(".crud-btn-update").click(function(){
                    var idx=$(".td-check[checked='checked']").data('id');
                    $(location).attr('href',"update/"+idx);
                });
              
                $(".crud-btn-create").click(function(){
                        $(location).attr('href',"create");
   
                });
                
                 $(".crud-btn-retrieve").click(function(){
                      var idx=$(".td-check[checked='checked']").data('id');
                      $(location).attr('href',"retrieve/"+idx);
                  });
           
      });  

  
   
             
             
             
         
     </script>