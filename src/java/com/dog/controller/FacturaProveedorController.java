/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import com.dog.definiciones.cfdv.Comprobante;
import com.dog.entity.Factura;
import com.dog.entity.FacturaState;
import com.dog.entity.RoleType;
import com.dog.entity.Usuario;
import com.dog.form.FacturaForm;
import com.dog.modelo.FacturaService;
import com.dog.modelo.UsuarioService;
import com.dog.modelo.XmlService;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Administrador
 */
@Controller
@Scope("request")
 @PreAuthorize("hasAnyRole('PROV_LOCAL','PROV_EXT')")
@SessionAttributes({"commandUpload"})
 @RequestMapping(value = "/proveedor")
public class FacturaProveedorController extends PaginatorHelper {
   
    private static final String RESULT="resultado";
    private static final String RESULT_MSG="resultmsg";
     //private static final  Resource res = new ClassPathResource("resources/facturas");C:\pdf
    private static final  Resource res = new FileSystemResource("C:\\pdf");
        @Autowired
    private FacturaService svce;
        @Autowired
    private XmlService xmlSvce;  
        @Autowired
    private UsuarioService userSvce;    
        @Autowired
    private FacturaForm upform;
        
//---------------------------------------  FACTURA UPLOAD------------------------------------------------------      
        @RequestMapping(value = "/upload",method = RequestMethod.GET)
    public ModelAndView initUpload(){
        ModelAndView modelo=new ModelAndView("proveedor.factura.upload.def");
        modelo.addObject("commandUpload", upform);
        return modelo;
    }
 
        @RequestMapping(value = "/upload",method = RequestMethod.POST)
    public String submitUpload(@ModelAttribute("commandUpload") @Valid FacturaForm uf,
              BindingResult result, SessionStatus status,HttpServletRequest request,ModelMap modelo){
          
      
       if(result.hasErrors()){
         
           modelo.addAttribute(RESULT,"failed");
           modelo.addAttribute(RESULT_MSG,result.getAllErrors());
           return "proveedor.factura.upload.def";
       }else{
           try {
               File root=res.getFile();
               File file=new File(root,uf.getFileupload().getOriginalFilename());
               uf.getFileupload().transferTo(file);
              //lo hago repetitivo para que quede clarop cuales son las opciones en cada caso
               if(request.isUserInRole(RoleType.PROV_LOCAL.toString())){//si es proveedor local
                   if(uf.getFileupload().getContentType().equals("text/xml")){//si es formato xml
                        Comprobante comprobante=xmlSvce.getComprobante(file);
                        if(comprobante != null){
                            Long last=svce.nextAvailableNumber()+1L; 
                            uf.setFechaFactura(xmlSvce.getFechaFactura(comprobante));
                            uf.setUuid(xmlSvce.getUUIDFactura(comprobante));
                            uf.setIdFactura(last);
                            uf.setFileName(file.getName());
                            uf.setProveedor(userSvce.retrieve(request.getUserPrincipal().getName()));
                            uf.setPagada(false);
                            uf.setEstado(FacturaState.PEND);//coloco null que no es ni aceptada ni rechazada
                            svce.create(uf.convertToentity());
                            status.setComplete();
                            modelo.addAttribute("idFactura",String.format("%07d", last));
                            return "proveedor.factura.avisorecepcion.def";

                        }
                   }
                   if(uf.getFileupload().getContentType().equals("application/pdf")){//si el comprobante es 
                            Long last=svce.nextAvailableNumber()+1L; 
                            uf.setIdFactura(last);
                            uf.setFileName(file.getName());
                            uf.setProveedor(userSvce.retrieve(request.getUserPrincipal().getName()));
                            uf.setPagada(false);
                            uf.setEstado(FacturaState.PEND);//coloco null que no es ni aceptada ni rechazada
                            svce.create(uf.convertToentity());
                            status.setComplete();
                            modelo.addAttribute("idFactura",String.format("%07d", last));
                            return "proveedor.factura.avisorecepcion.def";
                   
                   } 
                                     
               }
               if(request.isUserInRole(RoleType.PROV_EXT.toString())){
                       if(uf.getFileupload().getContentType().equals("application/pdf")){
                            Long last=svce.nextAvailableNumber()+1L; 
                            uf.setIdFactura(last);
                             uf.setUuid("No Corresponde");
                            uf.setFileName(file.getName());
                            uf.setProveedor(userSvce.retrieve(request.getUserPrincipal().getName()));
                            uf.setPagada(false);
                            uf.setEstado(FacturaState.PEND);//coloco null que no es ni aceptada ni rechazada
                            svce.create(uf.convertToentity());
                            status.setComplete();
                            modelo.addAttribute("idFactura",String.format("%07d", last));
                            return "proveedor.factura.avisorecepcion.def";
                        }
               
               }
                file.delete();
                result.addError(new ObjectError("","El archivo no cuenta con el formato requerido"));
                modelo.addAttribute(RESULT,"failed");
                modelo.addAttribute(RESULT_MSG,result.getAllErrors());
                return "proveedor.factura.upload.def";
        
           } catch (IOException ex) {
               Logger.getLogger(FacturaProveedorController.class.getName()).log(Level.SEVERE, null, ex);
                result.addError(new ObjectError("","Archivo Inexistente"));
                modelo.addAttribute(RESULT,"failed");
                modelo.addAttribute(RESULT_MSG,result.getAllErrors());
                 return "proveedor.factura.upload.def";
           }
           
       }
      
        
       
                
      }
    
    
 //-------------------------------------- LISTADO DE FACTURAS IMPAGAS-----------------------------------------
    
    @RequestMapping(value ="/facturaspendientes/{id}" ,method = RequestMethod.GET)
    public ModelAndView initFacturasImpagas(@PathVariable("id") int pageId,HttpServletRequest request){
        ModelAndView modelo=new ModelAndView("proveedor.factura.pendiente.def");
          Usuario usuario=userSvce.retrieve(request.getUserPrincipal().getName());
          
         Page<Factura> page=(Page<Factura>) svce.ListAllByProveedorUnPaid(usuario,new PageRequest(pageId-1,10));
         modelo.addObject("listadofacturaspendientes",page.getContent());
         paginator(page, modelo.getModelMap());
         
        return modelo;
    }
    
//---------------------------------------------LISTADO DE FACTURAS PAGAS----------------------------    
    
    @RequestMapping(value ="/facturascobradas/{id}" ,method = RequestMethod.GET)
    public ModelAndView initFacturasPagas(@PathVariable("id") int pageId,HttpServletRequest request){
        ModelAndView modelo=new ModelAndView("proveedor.factura.cobradas.def");
          Usuario usuario=userSvce.retrieve(request.getUserPrincipal().getName());
          
           Page<Factura> page=(Page<Factura>) svce.ListAllByProveedorPaid(usuario,new PageRequest(pageId-1,10));//para no empezar las paginas de cero
           modelo.addObject("listadofacturascobradas",page.getContent());
           paginator(page, modelo.getModelMap());
          
        return modelo;
    }
    
 //-----------------------------------------SEARCH FACTURA------------------------------ 
      @RequestMapping(value ="/facturasearch" ,method = RequestMethod.GET)
    public ModelAndView initFacturasSearch(@RequestParam(value = "id",required = false,defaultValue = "")String id,HttpServletRequest request){
        ModelAndView modelo=new ModelAndView("proveedor.factura.search.def");
         Usuario usuario=userSvce.retrieve(request.getUserPrincipal().getName());
        
        Factura fact=null;
        try{
              Long idlong=Long.parseLong(id);
              fact=svce.findFacturaById(idlong,usuario);  
              if(fact != null){
                    Map<String,String> estados=new LinkedHashMap<String,String>();
                    estados.put(FacturaState.PEND.name(),FacturaState.PEND.getEstado());
                    estados.put(FacturaState.CONFIRM.name(),FacturaState.CONFIRM.getEstado());
                    estados.put(FacturaState.VALID.name(),FacturaState.VALID.getEstado());
                    estados.put(FacturaState.REJECT.name(),FacturaState.REJECT.getEstado());
                    estados.put(FacturaState.TOPAY.name(),FacturaState.TOPAY.getEstado());
                    estados.put(FacturaState.PAID.name(),FacturaState.PAID.getEstado());

                    modelo.addObject("estados", estados);  
                    modelo.addObject("facturasearchCommand",fact);
                  }else{
                    modelo.addObject("error","Numero de Factura: "+id+" erroneo o Factura Inexistente");  
                  }
          }catch(NumberFormatException pe){
               modelo.addObject("error","Dato ingresado erroneo"); 
          }
            
        return modelo;
    }
    
    
    
    
    
    
    
    //--------------------------------------------PAGINATOR------------------------------------
//     private void paginator(Page page,ModelMap modelo){//envia en el mmodelo los paremetros de pagina actual/cantidad maxima de paginas/comienzo y fin de paginacion
//        int current = page.getNumber()+1;
//        int begin = Math.max(1, current - 10);
//        int end = Math.min(begin + 10, page.getTotalPages());
//        modelo.addAttribute(PAGINATION_BEGIN_INDEX,begin);
//        modelo.addAttribute(PAGINATION_END_INDEX, end);
//        modelo.addAttribute(PAGINATION_CURRENT_INDEX, current); 
//        modelo.addAttribute(PAGINATION_TOTAL_PAGES, page.getTotalPages()); 
//    }
    
}
