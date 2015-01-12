<%-- 
    Document   : menu
    Created on : 31-oct-2014, 23:04:37
    Author     : Daniel
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<c:if test="${usuariorol eq 'PROVEEDOR_ROLE'}">
    proveedor
</c:if>
<c:if test="${usuariorol eq 'EMPLEADO_ROLE'}">
    empleado
</c:if>
<c:if test="${usuariorol eq 'ADMIN_ROLE'}">
    admin
</c:if>
    --%>
    
    <c:set var="root" value="${pageContext.request.contextPath}"/>
    
    
    <nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" 
              data-toggle="collapse" data-target="#bs-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Menu</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-navbar-collapse-1">
      <ul class="nav navbar-nav">
         <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
             <li class="active"><a href="${root}/usuario/crud">Usuarios</a></li>
            
        </c:if> 
           
        <c:if test="${pageContext.request.isUserInRole('CONTABLE') || pageContext.request.isUserInRole('ADMIN')}">
             <li><a href="${root}/usuario/perfil">Perfil</a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="${root}/contable/gestion">Impagas</a></li>
                  <li><a href="${root}/contable/facturasrechazadas/1">Rechazadas</a></li>
                  <li><a href="${root}/contable/facturaspagas/1">Pagadas</a></li>
                  <li><a href="${root}/contable/excel">Excel</a></li>

                </ul>
              </li>
        </c:if>    
              
        <c:if test="${pageContext.request.isUserInRole('COMPRADOR')}">
             <li><a href="${root}/usuario/perfil">Perfil</a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="${root}/comprador/gestion">a Confirmar</a></li>
                  <%--<li><a href="${root}/comprador/facturasrechazadas/1">Rechazadas</a></li>
                  <li><a href="${root}/comprador/facturaspagas/1">Pagadas</a></li>--%>

                </ul>
              </li>
        </c:if>          
              
              
          <c:if test="${pageContext.request.isUserInRole('PROV_LOCAL') || pageContext.request.isUserInRole('PROV_EXT')}">
              <li><a href="${root}/usuario/perfil">Perfil</a></li> 
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturas <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="${root}/proveedor/upload">Subir</a></li>
                  <li><a href="${root}/proveedor/facturaspendientes/1">Pendientes de Cobro</a></li>
                  <li><a href="${root}/proveedor/facturascobradas/1">Cobradas</a></li>

                </ul>
              </li>
        </c:if>          
       
        <c:if test="${pageContext.request.isUserInRole('CONTABLE') || pageContext.request.isUserInRole('ADMIN')}">
             <li><a href="${root}/contable/reportes">Reportes</a></li>
        </c:if>
      
      <c:if test="${pageContext.request.isUserInRole( 'CONTABLE') || pageContext.request.isUserInRole('ADMIN')}">
          <form class="navbar-form navbar-left" role="search" action="${root}/contable/facturasearch">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Id Factura" name="id">
            </div>
              <button type="submit" class="btn btn-default">
                  <span class="glyphicon glyphicon-search"></span>
              </button>
          </form>
      </c:if>
       <c:if test="${pageContext.request.isUserInRole('PROV_LOCAL') || pageContext.request.isUserInRole('PROV_EXT')}">
          <form class="navbar-form navbar-left" role="search" action="${root}/proveedor/facturasearch">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Id Factura" name="id">
            </div>
              <button type="submit" class="btn btn-default">
                  <span class="glyphicon glyphicon-search"></span>
              </button>
          </form>
      </c:if>  
      
              <li><a href=""  data-toggle="modal" data-target="#myModal" class="btn-ayuda">Ayuda</a></li>        
        <li><a href="<c:url value='/j_spring_security_logout' />" > Logout</a></li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Ayuda</h4>
      </div>
      <div class="modal-body">
       
      </div>
    <%--  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
       
      </div>--%>
    </div>
  </div>
</div> 
      <script>
           $(".btn-ayuda").click(function(){
                    $('#myModal .modal-body').load("${root}/ayuda");
                    
                    
                });
      </script>    