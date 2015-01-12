/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import com.dog.entity.FacturaState;
import com.dog.form.FacturaForm;
import com.dog.modelo.FacturaService;
import com.dog.modelo.UsuarioService;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Administrador
 */
@Controller
@Scope("request")
@PreAuthorize("hasAnyRole('COMPRADOR','ADMIN')")
@SessionAttributes({"facturaConfirmCommand"})
@RequestMapping(value ="/comprador")
public class FacturaCompradorController {
    private static final String RESULT="resultado";
    private static final String RESULT_MSG="resultmsg";
    
        @Autowired
    private FacturaService svce;
        @Autowired
    private UsuarioService userSvce;    
    
        @Autowired
    private FacturaForm upform;
        
 //------------------------------ GESTION--------------------------------------       
           @RequestMapping(value ="/gestion" ,method = RequestMethod.GET)
    public ModelAndView initCrud(){
        ModelAndView modelo=new ModelAndView("comprador.factura.gestion.def");
        modelo.addObject("facturaspend",svce.listAllPend());
        return modelo;
    } 
    
    //----------------------------------------- VALIDACION DE FACTURAS----------------------------------   
    
     @RequestMapping(value ="/confirmarfactura/{id}" ,method = RequestMethod.GET)
    public ModelAndView initValidarFactura(@PathVariable Long id){
        ModelAndView modelo=new ModelAndView("comprador.factura.validar.def");
        upform.convertFromEntity(svce.retrieve(id));
        modelo.addObject("facturaConfirmCommand",upform);
        return modelo;
    }

    @RequestMapping(value ="/confirmarfactura/{id}" ,method = RequestMethod.POST)
      public String submitValidarFactura(@ModelAttribute("facturaConfirmCommand") FacturaForm uf,
                                        HttpServletRequest request,SessionStatus status){
          if(!uf.getOrdenCompra().isEmpty() && !uf.getOrdenEntrada().isEmpty()){
                uf.setEstado(FacturaState.CONFIRM);
                svce.update(uf.convertToentity());
          }
          status.setComplete();
         return "redirect:../gestion";
          
      }
    
}
