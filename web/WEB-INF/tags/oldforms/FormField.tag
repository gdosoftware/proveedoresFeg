<%-- 
    Document   : BasicInputField
    Created on : 21-may-2014, 8:23:25
    Author     : Administrador
--%>

<%@tag import="java.lang.reflect.Field"%>
<%@tag import="com.dog.tools.anotaciones.FormItem"%>
<%@tag import="com.dog.tools.anotaciones.ListItem"%>
<%@tag import="com.dog.tools.anotaciones.Forms"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="msg" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="gdo" uri="/WEB-INF/tlds/GDOTagsLibrary.tld" %>
<%@taglib prefix="gdotools" uri="/WEB-INF/tlds/GDOTools.tld" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- The list of normal or fragment attributes can be specified here: --%>

<%@attribute name="fieldName" required="true"%>
<%@attribute name="formName" required="false" %>
<%@attribute name="size" required="false"%>
<%@attribute name="checkItemlayout" required="false" %>
<%@attribute name="prefix" required="false" description="para el caso de los objetos anidados este es el nombre de la propiedad objeto " %>
<%@attribute name="disabled" required="true"%>

<%--fi e forms estan declarados arriba con scope request 
<c:set var="li" value="<%=request.getAttribute(object).getClass().getDeclaredField(fieldName).getAnnotation(ListItem.class)%>"/>--%>
<c:choose>
    <c:when test="${size eq 'lg'}">
        <c:set var="row" value="5"/>
    </c:when>
    <c:when test="${size eq 'md'}">
        <c:set var="row" value="3"/>
    </c:when>
    <c:otherwise>
        <c:set var="size" value="md"/>
        <c:set var="row" value="3"/>
    </c:otherwise>
    
</c:choose>
<c:if test="${checkItemlayout eq ''}"><c:set var="checkItemlayout" value="stack"/></c:if>

<c:if test="${prefix ne ''}">
    <c:set var="prefix" value="${prefix}."/>
   
</c:if>
<c:set var="validatorClass" value="${fn:replace(prefix, '.','')}${fieldName}"/> <%--esta clase se utiliza para poder realizar la validacion--%>    
<c:if test="${fn:contains(prefix, '[')}">
    <c:set var="validatorClass" value="${fn:substringBefore(prefix, '[')}${fieldName}"/> <%--esta clase se utiliza para poder realizar la validacion--%>
</c:if>


 
<c:choose>
<%------------------------WRITE TEXT----------------------------------------%>
    <c:when test="${fi.type() eq 'WRITETEXT'}">
        <c:set var="prop" value="${prefix}${fieldName}"/>
        <c:out value="${commandName[prop]}" />
    </c:when>
<%------------------------INPUT TEXT----------------------------------------%>
    
    <c:when test="${fi.type() eq 'TEXT'|| fi.type() eq 'TRANSIENT'}">
       <c:if test="${fi.placeholder() eq ''}"><msg:message code="${entity}.${fieldName}.formitem.placeholder" var="placeholder"/></c:if>
      
       <spring:input path="${prefix}${fieldName}" id="${prefix}${fieldName}"
                      cssClass="form-control input-${size} ${validatorClass} ${fi.cssInput()}"  placeholder="${placeholder}"
                      disabled='${disabled}' readonly="${fi.readonly()}"/>
    </c:when>
<%------------------------INPUT PASSWORD----------------------------------------%>
    
    <c:when test="${fi.type() eq 'PASSWORD'}">
       <c:if test="${fi.placeholder() eq ''}"><msg:message code="${entity}.${fieldName}.formitem.placeholder" var="placeholder"/></c:if>
      
       <spring:input path="${prefix}${fieldName}" id="${prefix}${fieldName}" type="password"
                      cssClass="form-control input-${size} ${validatorClass} ${fi.cssInput()}"  
                      placeholder="${placeholder}" disabled='${disabled}' readonly="${fi.readonly()}"/>
    </c:when>
<%------------------------INPUT HIDDEN----------------------------------------%>
    
    <c:when test="${fi.type() eq 'HIDDEN'}">
             <spring:hidden path="${prefix}${fieldName}" id="${prefix}${fieldName}"/>
    </c:when>
 <%------------------------TEXTAREA------------------------------------------%>  
 <c:when test="${fi.type() eq 'TEXTAREA'}">
        <c:if test="${fi.placeholder() eq ''}"><msg:message code="${entity}.${fieldName}.formitem.placeholder" var="placeholder"/></c:if>
        <spring:textarea path="${prefix}${fieldName}" rows="${row}" cssClass="form-control disabled='${disabled}' ${validatorClass} ${fi.cssInput()}"
                         placeholder="${placeholder}" readonly="${fi.readonly()}"/>
    </c:when>
    <%------------------------SELECT------------------------------------------%>
    <c:when test="${fi.type() eq 'SELECT'}">
        
        <c:if test="${fi.readonly() eq false}">
            <spring:select path="${prefix}${fieldName}" id="${fieldName}" cssClass="form-control ${fi.cssInput()}"
                           multiple="${fi.multiple()}" items="<%=request.getAttribute(fieldName)%>" 
                           disabled='${disabled}' />
        </c:if>

        <c:if test="${fi.readonly() eq true}">
            <spring:select path="${prefix}${fieldName}" id="${fieldName}" cssClass="form-control ${fi.cssInput()}"
                           multiple="${fi.multiple()}" items="<%=request.getAttribute(fieldName)%>" 
                           disabled='${disabled}' readonly="true"/>
        </c:if>
        
    </c:when>
  <%------------------------RADIOBUTTONS------------------------------------------%>
    <c:when test="${fi.type() eq 'RADIO' && checkItemlayout eq 'inline'}">
        <c:forEach var="op" items="<%=request.getAttribute(fieldName)%>">
            <label class="radio-inline">
              <spring:radiobutton path="${prefix}${fieldName}" id="${fieldName}" value="${op.key}"
                                  disabled='${disabled}' readonly="${fi.readonly()}" cssClass="${fi.cssInput()}"/>
              ${op.value}
            </label>
        </c:forEach>
    </c:when>
    <c:when test="${fi.type() eq 'RADIO' && checkItemlayout eq 'stack'}">
           <c:forEach var="op" items="<%=request.getAttribute(fieldName)%>">
            <div class="radio">
                <label>
                    <spring:radiobutton path="${prefix}${fieldName}" id="${fieldName}" value="${op.key}" 
                                              disabled='${disabled}' readonly="${fi.readonly()}" cssClass="${fi.cssInput()}"/>
                  ${op.value}
                </label>
            </div>
        </c:forEach>
    </c:when>
    <%------------------------CHECKBOXGROUP------------------------------------------%>
     <c:when test="${fi.type() eq 'CHECKBOXGROUP' && checkItemlayout eq 'inline'}">
        <c:forEach var="op" items="<%=request.getAttribute(fieldName)%>">
            <label class="checkbox-inline">
                <spring:checkbox path="${prefix}${fieldName}" id="${fieldName}" value="${op}" 
                                 disabled='${disabled}' readonly="${fi.readonly()}" cssClass="${fi.cssInput()}"/>
                 ${op}
            </label>
        </c:forEach>
    </c:when>
    <c:when test="${fi.type() eq 'CHECKBOXGROUP' && checkItemlayout eq 'stack'}">
        <c:forEach var="op" items="<%=request.getAttribute(fieldName)%>">
            <div class="checkbox">
                <label>
                    <spring:checkbox path="${prefix}${fieldName}" id="${fieldName}" value="${op}" 
                                     disabled='${disabled}' readonly="${fi.readonly()}" cssClass="${fi.cssInput()}"/>
                    ${op}
                </label>
            </div>
        </c:forEach>
          
    </c:when>
     <%------------------------CHECKBOX------------------------------------------%>
     <c:when test="${fi.type() eq 'CHECKBOX' && checkItemlayout eq 'inline'}">
            <label class="checkbox-inline">
                <spring:checkbox path="${prefix}${fieldName}" id="${fieldName}" 
                                 disabled='${disabled}' readonly="${fi.readonly()}" 
                                 cssClass="${fi.cssInput()}"/>
            </label>
    </c:when>
    <c:when test="${fi.type() eq 'CHECKBOX' && checkItemlayout eq 'stack'}">
           <div class="checkbox">
                <label>
                    <spring:checkbox path="${prefix}${fieldName}" id="${fieldName}" 
                                     disabled='${disabled}' readonly="${fi.readonly()}"
                                     cssClass="${fi.cssInput()}"/>
        
                </label>
            </div>
    </c:when>
  
  
  <%------------------------ENTITY=SELECT-----------------------------------------%>
  <c:when test="${fi.type() eq 'ENTITY'}">
      <c:choose>
               <%--select cuya fuente no depende del valor de otra propiedad--%>
          <c:when test="${fi.entityDependOn() eq ''}">
              <c:set var="entitySource" value="${fi.entitySource()}"/>
              <c:if test="${fi.readonly() eq true}">
                  <spring:select path="${prefix}${fieldName}"  cssClass="form-control" disabled='${disabled}'
                             items="${requestScope[entitySource]}"  readonly="true" 
                             cssStyle="${fi.cssInput()}" multiple="${fi.multiple()}" /> 
              </c:if>
              <c:if test="${fi.readonly() eq false}">
                  <spring:select path="${prefix}${fieldName}"  cssClass="form-control" disabled='${disabled}'
                             items="${requestScope[entitySource]}"  
                             cssStyle="${fi.cssInput()}" multiple="${fi.multiple()}" /> 
              </c:if>
              
          </c:when>
                <%--select cuya fuente depende del valor de otra propiedad--%>
          <c:when test="${fi.entityDependOn() ne ''}">
               <spring:select path="${prefix}${fieldName}"  cssClass="form-control" disabled='${disabled}'
                    cssStyle="${fi.cssInput()}" multiple="${fi.multiple()}"  /> 
                    <script>
                        $("#${fi.entityDependOn()}").change(function(e){
                             $("#${fieldName}").empty();
                             $.getJSON("./${fi.entitySource()}",//+$("#${fi.entityDependOn()}").val(), 
                                    {id: $("#${fi.entityDependOn()}").val()},
                                    function(data) {
                                        $.each( data, function( key, val ) {
                                            $("#${fieldName}").append("<option value='"+key+"'>"+val+"</option>");

                                          });
                                 }
                            );
                        });
                    </script>    
          </c:when>
      </c:choose>
 </c:when>
 
 
 <%-----------------------NEW-ENTITY-----------------------------------------%>
 <c:when test="${fi.type() eq 'NEWENTITY'}">
     
       
    <c:if test="${!fi.multiple()}">
         <c:set var="fieldObject" value="${commandName[fieldName]}" scope="request"/><%--guardo el valor en el ambito de request para luego recuperarlo en el formitems y recorerlo--%>
        <c:if test="${fi.accordion()}">
            <div class="panel-group" id="accordion">
               <div class="panel ${fi.cssInput()}">

                    <div class="panel-heading">
                        <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#accordion-${prefix}${fieldName}">
                          ${fieldName}
                        </a>
                       </h4>
                    </div>

                    <div id="accordion-${prefix}${fieldName}" class="panel-collapse collapse">

                      <div class="panel-body">
                           
                            <gdo:formItems propertyPrefix="${prefix}${fieldName}" object="fieldObject" 
                                    layout="stack" checkItemlayout="stack" size="md" formName="${fi.formName()}"
                                     inputSize="8" labelSize="4" disabled="${disabled}" /> 
                      </div>
                    </div>
              </div>
          </c:if>            
        <c:if test="${!fi.accordion()}">
                 <gdo:formItems propertyPrefix="${prefix}${fieldName}" object="fieldObject" 
                                    layout="stack" checkItemlayout="stack" size="md" formName="${fi.formName()}"
                                     inputSize="8" labelSize="4" disabled="${disabled}" /> 
        </c:if>      
      </c:if> 
     
     <c:if test="${fi.multiple()}">
     
      <c:set var="list" value="${commandName[fieldName]}" scope="request"/><%--list es el nombre que espera recibir el crudtable--%>
        <c:set var="newEntityObject" value="${list[0]}" scope="request"/>
     
       <gdo:tableForm object="newEntityObject" formName="${formName}" disabled="${disabled}"
                       propertyPrefix="${prefix}${fieldName}" cssTable="table-bordered table-hover"
                       cssButtonAdd="btn btn-default btn-md" cssButtonDelete="btn btn-danger btn-md"/> 
         
     
    </c:if>
 </c:when>
    <%-----------------------------IMAGE----------------------------------------%>
    <c:when test="${fi.type() eq 'IMG'}">
        <c:set var="fileDescriptor" value="${commandName[fieldName]}"/>
        <spring:hidden path="${prefix}${fieldName}.id"/>  
        <spring:hidden path="${prefix}${fieldName}.fileContentType"/>
        <spring:hidden path="${prefix}${fieldName}.fileName"/>
         <spring:hidden path="${prefix}${fieldName}.fileSize"/>
          
         <c:if test="${fileDescriptor['fileName'] ne null}">
                 <c:set var="ruta" value="${pageContext.request.contextPath}/image/${fileDescriptor['fileName']}"/>  
        </c:if>
       
        <img src="${ruta}" class="img-responsive img-${prefijo}-${fieldName}">
        
       <spring:input path="${prefix}${fieldName}.file" id="${prefix}${fieldName}" type="file"
                    cssClass="form-control input-${size} ${validatorClass} ${fi.cssInput()}"  placeholder="${placeholder}"
                    disabled='${disabled}' readonly="${fi.readonly()}" 
                    data-img=".img-${prefijo}-${fieldName}" onchange="onChangeFile(this)"/>
        <script>
              function onChangeFile(inp){
                
                if (inp.files && inp.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var img=$(inp).data('img');
                        
                        $(img).attr('src', e.target.result);
                         //.width('auto')
                         //.height('auto');
                    };
                    reader.readAsDataURL(inp.files[0]);
                };
                
                              
            };
        </script>
    </c:when>
  <%-----------------------------IMAGE----------------------------------------
  <c:when test="${fi.type() eq 'IMG'}">
        <c:set var="prefijo" value="${fn:substringBefore(prefix,'.')}"/>
         <c:set var="fd" value="${prefix}${fi.fileDescriptor()}"/>
         <c:set var="fileprop" value="${commandName[fd]}"/>        
                  
            <c:if test="${!fi.multiple()}">
                     
                   <c:if test="${fileprop['fileName'] ne null}">
                        <c:set var="path" value="${pageContext.request.contextPath}/image/${fileprop['fileName']}"/>  
                   </c:if>
                    <img src="${path}" class="img-responsive img-${prefijo}-${fieldName}">  

                    <spring:input path="${prefix}${fieldName}" id="${prefix}${fieldName}" type="file"
                                   cssClass="form-control input-${size} ${validatorClass} ${fi.cssInput()}"  placeholder="${placeholder}"
                                   disabled='${disabled}' readonly="${fi.readonly()}" 
                                   data-img=".img-${prefijo}-${fieldName}" onchange="onChangeFile(this)"/>
                </c:if>
              
               <c:if test="${fi.multiple()}">
                 
                   <div id="dog-carousel" >
                            <!-- Wrapper for slides -->
                            <div class="carousel-inner">
                               <c:forEach var="itimg" items="${fileprop}">
                                     <c:if test="${itimg['fileName'] ne null}">
                                          <div class="item">
                                              <img src="${pageContext.request.contextPath}/image/${itimg['fileName']}" >
                                          </div>
                                     </c:if>
                                   
                                </c:forEach>

                            </div>
                            <!-- Controls -->
                           
                            <c:if test="${fn:length(fileprop) > 1}">
                                <a class="left carousel-control" href="#dog-carousel" role="button" data-slide="prev">
                                  <span class="glyphicon glyphicon-chevron-left"></span>
                                </a>
                                <a class="right carousel-control" href="#dog-carousel" role="button" data-slide="next">
                                  <span class="glyphicon glyphicon-chevron-right"></span>
                                </a>
                                <script> 
                                    $('#dog-carousel').carousel({//arranco el carrousel
                                        interval: 1500
                                      });
                                </script>
                            </c:if>
                       </div>
              
                 <spring:input path="${prefix}${fieldName}" id="${prefix}${fieldName}" type="file"
                                   cssClass="form-control input-${size} ${validatorClass} ${fi.cssInput()}"  placeholder="${placeholder}"
                                   disabled='${disabled}' readonly="${fi.readonly()}" multiple="true"
                                   data-img=".img-${prefijo}-${fieldName}" onchange="onChangeFileMultiple(this)"/> 
                 
                  
                 
               </c:if>
           
            
       
    </c:when>----%>
    <c:when test="${fi.type() eq 'DATE'}">
         <c:if test="${fi.placeholder() eq ''}"><msg:message code="${entity}.${fieldName}.formitem.placeholder" var="placeholder"/></c:if>

         <spring:input path="${prefix}${fieldName}" id="${prefix}${fieldName}"  placeholder="${placeholder}"
                       cssClass="form-control input-${size} ${validatorClass} ${fi.cssInput()}" 
                       disabled='${disabled}' readonly="${fi.readonly()}" value="${dateString}"/>
        <script>
           <c:if test="${disabled ne 'true'}">
               $( "#${prefix}${fieldName}" ).on("mousedown",function(){
                                                     $(this).datepicker();
                                                     $(this).datepicker({  minDate:${fi.minDate()}, 
                                                                                                    maxDate:${fi.maxDate()},
                                                                                                    changeMonth: true,
                                                                                                    changeYear: true});
                                                     $(this).datepicker("option", "dateFormat",'${fi.dateFormat()}');
                    
                    
                    
                });
            <%--    $( "#${prefix}${fieldName}" ).datepicker()
                $( "#${prefix}${fieldName}" ).datepicker({  minDate:${fi.minDate()}, 
                                                            maxDate:${fi.maxDate()},
                                                            changeMonth: true,
                                                            changeYear: true});
                $( "#${prefix}${fieldName}" ).datepicker("option", "dateFormat",'${fi.dateFormat()}');--%>

            </c:if>

        </script>
    </c:when>
 
</c:choose>  
                
<script>
      
//            function onChangeFile(inp){
//                
//                if (inp.files && inp.files[0]) {
//                    var reader = new FileReader();
//                    reader.onload = function(e) {
//                        var img=$(inp).data('img');
//                        
//                        $(img).attr('src', e.target.result);
//                         //.width('auto')
//                         //.height('auto');
//                    };
//                    reader.readAsDataURL(inp.files[0]);
//                };
//                
//                              
//            };
//            function onChangeFileMultiple(inp){
//                console.log(inp.files);
//                var reader = new FileReader();
//                var lista=$(inp)[0].files;//array de files que contienen las fotos
//                var contador=0;
//                $('#dog-carousel').empty().append($('<div>').attr('class','carousel-inner'));
//                reader.readAsDataURL(lista[contador]);
//                reader.onload = function(e) {
//                               $("#dog-carousel .carousel-inner").append($("<div class='item'>").append($("<img>").attr('src',e.target.result)
//                                                                                                    .width('auto')
//                                                                                                    .height('auto')
//                                                           ));
//                                                   
//                                contador++;
//               
//                                if(contador<lista.length){
//                                   reader.readAsDataURL(lista[contador]); //cuando termina de cargarse una foto mando a leer la otra sino se produce un error al querer leerse todas juntas                                                            
//                                }else{//una vex cargadas las imagenes agrego los botones de navegacion
//                                     $('#dog-carousel').append($('<a>').attr('class','left carousel-control')
//                                              .attr('href','#dog-carousel')  
//                                              .attr('role','button')
//                                              .attr('data-slide','prev')
//                                              .append($('<span>').attr('class','glyphicon glyphicon-chevron-left'))
//                                     );
//                                    $('#dog-carousel').append($('<a>').attr('class','right carousel-control')
//                                                                 .attr('href','#dog-carousel')  
//                                                                 .attr('role','button')
//                                                                 .attr('data-slide','next')
//                                                                 .append($('<span>').attr('class','glyphicon glyphicon-chevron-right'))
//                                                        ); 
//                                    
//                                };    
//                };
//                           
//                $('#dog-carousel').carousel({//arranco el carrousel
//                                        interval: 1500
//                                      });
//            };
//       
//    </script>                
 
   <%--buen manejo EL    <c:set var="innerObject" value="${commandName[fieldName]}"/>
                            <c:forEach var="fg" items="${innerObject['class'].declaredFields}">
                                ${fg.name}: <spring:input path="${fieldName}.${fg.name}"/><br>
                            </c:forEach>--%>          
   
   
    <%-- <c:forEach var="item" items="${requestScope[fieldName]}">
                <c:set var="select" value=""/>
                <c:forEach var="op" items="${commandName[fieldName]}">
                    <c:if test="${op.id eq item.key}">
                        <c:set var="select" value="${true}"/>
                    </c:if>
                 </c:forEach>
            <spring:option value="${item.key}" selected="${select}">${item.value}</spring:option>
           </c:forEach>
       </spring:select> solo es necesario si usamos los property editors si usamos formatters no --%>
      <%--   Nombre:<spring:input path="${prefix}${fieldName}[0].nombre" /><br>
         Capital:<spring:input path="${prefix}${fieldName}[0].capital"/><br>
         Nombre:<spring:input path="${prefix}${fieldName}[1].nombre" /><br>
         Capital:<spring:input path="${prefix}${fieldName}[1].capital"/><br>
         Nombre:<spring:input path="${prefix}${fieldName}[3].nombre" /><br>
         Capital:<spring:input path="${prefix}${fieldName}[3].capital"/><br>--%>
         
        
       