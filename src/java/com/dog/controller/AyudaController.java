/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import com.dog.entity.RoleType;
import com.dog.entity.Usuario;
import com.dog.modelo.UsuarioService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Administrador
 */
@Controller
@Scope("request")
public class AyudaController {
      @Autowired
    private UsuarioService svce;
      
     @RequestMapping(value ="/init" ,method = RequestMethod.GET)
    public String init(HttpServletRequest request){
        if(svce.retrieve("administrador")==null){
            svce.create(new Usuario("Administrador General","administrador",new Md5PasswordEncoder().encodePassword("1234","carancho"), RoleType.ADMIN, Boolean.TRUE));
        }
        return "redirect:home";
    }
    
    
////response.setContentType("application/pdf");
//response.setHeader("Content-Disposition", "attachment;filename=something.pdf");
//OutputStream out = response.getOutputStream();
//out.write(pdfFileContentInBytes);
//out.flush();   
     @RequestMapping(value ="/ayuda" ,method = RequestMethod.GET)
    public @ResponseBody String initAyuda(HttpServletRequest request){
        if(request.isUserInRole(RoleType.PROV_LOCAL.toString()) || request.isUserInRole(RoleType.PROV_EXT.toString())){
            return "<pre>Este en un gestor de facturas a cobrar de proveedores<br>"
                    +"de la empresa FEG Querataro<br>"
                    + "El menu cuenta con 3 modulos.<br>"
                    + "En el modulo Facturas hay 3 items:<br>"
                    + "<strong>SUBIR:</strong> en este apartado podran subir la factura a cobrar<br>"
                    + "        asi como tambien escribir alguna anotacion sobre la misma<br>"
                    + "<strong>PENDIENTES DE COBRO:</strong> en este apartado podran chequear<br>"
                    + "       el estado de las facturas presentadas<br>"
                    + "<strong>COBRADAS:</strong> en este apartado podran visualizar todas aquellas<br>"
                    + "       facturas ya abonadas ordenas desde la mas reciente<br>"
                    + "       hasta la mas antigua<br>"
                    + "Si Desea averiguar por una factura en particular, debera<br>"
                    + "ingresar el ID de factura en la casilla de edicion<br> "
                    + "contigua a la lupa en el menu y luego presionar la lupa<br>"
                    + "En el modulo de perfil podra modificar sus datos personales<br>"
                    + "como ser email y clave de acceso</pre>"
                    ;
        }
         if(request.isUserInRole(RoleType.COMPRADOR.toString())){ 
           return "hacer";
                   
       }
       if(request.isUserInRole(RoleType.ADMIN.toString())){
           return "<pre>Este es el modulo de Administracion del Gestor de facturas<br>"
                   + "de la empresa FEG Querataro.<br>"
                   + "El menu cuenta con 4 modulos<br>"
                   + "El  modulo usuarios es un gestor de usuarios del sistema,<br>"
                   + "aqui el administrador puede crear, modificar,<br>"
                   + "eliminar y consultar cualquier usuario.<br>"
                   + "En el proceso de alta de un usuario se debe ingresar los "
                   + "siguientes datos:<br>"
                   + "<strong>Nombre</strong> Es el nombre y apellido del usuario o nombre<br>"
                   + "de la compania<br>"
                   + "<strong>Usuario</strong> Es el nombre de usuario que se usara<br>"
                   + "para ingresar al sistema, una vez creado este nombre no se puede<br>"
                   + "cambiar ni se puede repetir dentro del sistema<br>"
                   + "<strong>Contrasena</strong> Esta es una contrasena temporal que debera<br>"
                   + "que debera ser modificada luego por el usuario correspondiente<br>"
                   + "<strong>Email</strong> es el mail del empleado o compania<br>"
                   + "<strong>Rol</strong> es el rol del usuario dentro del sistema puede ser<br>"
                   + "Proveedor/Empleado/Administrador<br>"
                   + "<strong>Habilitada</strong> toda cuenta para poder ser utilizada<br>"
                   + "dentro del sistema debe estar habilitada por el administrador<br>"
                   + "En el modulo Facturas hay 3 items:<br>"
                   + "<strong>IMPAGAS:</strong> en este apartado figuran todas las facturas subidas por los<br>"
                   + "proveedores de la empresa que estan pendientes de pago.<br>"
                   + "Se podra distinguir entre dos estados, las pendientes de validacion<br>"
                   + "y las pendientes de fijar fecha de pago y pago efectivo<br>"
                   + "Para realizar la validacion de un factura se debe clickear<br>"
                   + "el boton de validacion para acceder a la misma.<br>"
                   + "Una vez visulizada la factura se puede bien validarla o rechazarla<br>"
                   + "ingresando una razon de rechazo<br>"
                   + "Una vez validada la factura tiene un estado de pendiente de fecha de pago.<br>"
                   + "Para poder fijar la fecha de pago (solo se prodra realizar si la factura <br>"
                   + "previamente fue validada) se clickea el boton de pago.<br>"
                   + "Una vez visulalizada la factura se ingresa el nuevo estado de la factura<br>"
                   + "el cual puede ser A PAGAR, y luego se ingresa la fecha de pago fijada<br>"
                   + "o bien el estado PAGADA y la fecha en el cual se realizo el pago.<br>"
                   + "Todas las facturas que se han pagado o rechazadas no forman mas parte de<br>"
                   + "este listado sino que tendran sendos listados<br>"
                   + "<strong>PAGADAS:</strong>Este es un listado de todas las facturas pagadas por la empresa<br>"
                   + "ordenadas desde la mas reciente hasta la mas antigua<br>"
                   + "<strong>RECHAZADAS:</strong>Este es un listado de todas aquellas facturas que <br>"
                   + "fueron rechazadas por algun motivo<br>"
                   + "Si Desea averiguar por una factura en particular, debera ingresar<br>"
                   + "el ID de factura en la casilla de edicion contigua a la lupa<br>"
                   + "en el menu y luego presionar la lupa<br>"
                   + "En el modulo de perfil podra modificar sus datos personales<br>"
                   + "como ser email y clave de acceso</pre>"
                   ;
       }
         return null;
    }
    
}
