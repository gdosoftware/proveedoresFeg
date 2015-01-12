/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import com.dog.entity.Usuario;
import com.dog.modelo.UsuarioService;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Administrador
 */
@Controller
@Scope("request")
@PreAuthorize("hasAnyRole('CONTABLE','ADMIN','PROV_LOCAL','PROV_EXT','COMPRADOR')")

public class FrontEndController {
     @Autowired
    private UsuarioService svce;
    @RequestMapping(value ="/home" ,method = RequestMethod.GET)
    public ModelAndView initCrud(HttpServletRequest request){
        ModelAndView modelo=new ModelAndView("home.def");
        Usuario user=svce.retrieve(request.getUserPrincipal().getName());
        modelo.addObject("usuariorol",user.getRol());
       
        return modelo;
    }
}
