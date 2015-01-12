/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Administrador
 * Esta clase se debe implementar para poder informarle al controlador de autenticacion cuales son 
 * las paginas de login/logout/denied y darle un path que coincidira con lo que tengo declarado
 * en el spring-security
 */
@Controller
@Scope("request")
@RequestMapping("/auth")
public class AutenticaionController {

     public static final String LOGIN_ERROR="loginerror";
    
    
   @RequestMapping(value ="/login" ,method = RequestMethod.GET)
   public ModelAndView logIn(){       
       ModelAndView modelo=new ModelAndView("login.def");
   return modelo;
   }
   @RequestMapping(value ="/login/error" ,method = RequestMethod.GET)
   public ModelAndView logInError(){
       ModelAndView modelo=new ModelAndView("login.def");
       modelo.getModelMap().addAttribute(LOGIN_ERROR, true);
   return modelo;
   }
   @RequestMapping(value ="/logout" ,method = RequestMethod.GET)
   public ModelAndView logOut(@RequestParam(value = "success",required = false) boolean success,
                                HttpServletRequest request ){
       ModelAndView modelo=new ModelAndView("logout.def");
      // modelo.addObject("userlogout",request.getUserPrincipal().getName());
      
   return modelo;
   }
   @RequestMapping(value ="/denied" ,method = RequestMethod.GET)
   public ModelAndView denied(){
       ModelAndView modelo=new ModelAndView("denied.def");
   return modelo;
   }
    
}
