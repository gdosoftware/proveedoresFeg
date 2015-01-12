/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;
import com.dog.entity.Factura;
import com.dog.entity.FacturaState;
import com.dog.form.FacturaForm;
import com.dog.modelo.FacturaService;
import com.dog.modelo.UsuarioService;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
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
 @PreAuthorize("hasAnyRole('CONTABLE','ADMIN')")
@SessionAttributes({"facturaValidCommand"})
@RequestMapping(value ="/contable")
public class FacturaContableController extends PaginatorHelper{
      
    private static final String RESULT="resultado";
    private static final String RESULT_MSG="resultmsg";
    
        @Autowired
    private FacturaService svce;
     
        @Autowired
    private UsuarioService userSvce;    
        @Autowired
    private FacturaForm upform;
    
        
 //----------------------------------------------- GESTION DE FACTURAS------------------------------------------
     
//     @RequestMapping(value ="/gestion/{id}" ,method = RequestMethod.GET)
//    public ModelAndView initCrud(@PathVariable("id") int pageId){
//        ModelAndView modelo=new ModelAndView("empleado.factura.gestion.def");
//        Page<Factura> page=(Page<Factura>) svce.ListAllunPaid(new PageRequest(pageId-1,10));//para no empezar las paginas de cero
//        modelo.addObject("facturasunpaid",page.getContent());
//        paginator(page, modelo.getModelMap());
//            
//        return modelo;
//    }
        
      @RequestMapping(value ="/gestion" ,method = RequestMethod.GET)
    public ModelAndView initCrud(){
        ModelAndView modelo=new ModelAndView("contable.factura.gestion.def");
        modelo.addObject("facturasunpaid",svce.ListAllunPaid());
        return modelo;
    }   
    
    
 //----------------------------------------- VALIDACION DE FACTURAS----------------------------------   
    
     @RequestMapping(value ="/validarfactura/{id}" ,method = RequestMethod.GET)
    public ModelAndView initValidarFactura(@PathVariable Long id){
        ModelAndView modelo=new ModelAndView("contable.factura.validar.def");
       
        
        upform.convertFromEntity(svce.retrieve(id));
        
        
         Map<String,String> estados=new LinkedHashMap<String,String>();
         estados.put(FacturaState.CONFIRM.name(),FacturaState.CONFIRM.getEstado());
         estados.put(FacturaState.VALID.name(),FacturaState.VALID.getEstado());
         estados.put(FacturaState.REJECT.name(),FacturaState.REJECT.getEstado());
       
         modelo.addObject("facturaValidCommand",upform);
         modelo.addObject("estados", estados);
        return modelo;
    }

    @RequestMapping(value ="/validarfactura/{id}" ,method = RequestMethod.POST)
      public String submitValidarFactura(@ModelAttribute("facturaValidCommand") FacturaForm uf,
                                        HttpServletRequest request,SessionStatus status){
          uf.setFechaValidacion(new Date());
          uf.setUsername(request.getUserPrincipal().getName());
          svce.update(uf.convertToentity());
          status.setComplete();
         return "redirect:../gestion";
          
      }
 
      
   //-------------------------------------PAGAR FACTURAS------------------------------------------   
      
      
     @RequestMapping(value ="/pagarfactura/{id}" ,method = RequestMethod.GET)
    public ModelAndView initaPagarFactura(@PathVariable Long id){
        ModelAndView modelo=new ModelAndView("contable.factura.pagar.def");
       
        
        upform.convertFromEntity(svce.retrieve(id));
        upform.setFechaLimite(addDate(upform.getFechaFactura(), upform.getProveedor().getDiasCredito()));
        
         Map<String,String> estados=new LinkedHashMap<String,String>();
         estados.put(FacturaState.TOPAY.name(),FacturaState.TOPAY.getEstado());
         estados.put(FacturaState.PAID.name(),FacturaState.PAID.getEstado());
         
       
         modelo.addObject("facturaValidCommand",upform);
         modelo.addObject("estados", estados);
        return modelo;
    }
    
     @RequestMapping(value ="/pagarfactura/{id}" ,method = RequestMethod.POST)
      public String submitPagarFactura(@PathVariable Long id,@ModelAttribute("facturaValidCommand") FacturaForm uf,
                                       BindingResult result, SessionStatus status, HttpServletRequest request, ModelMap modelo){
          
          uf.setUsername(request.getUserPrincipal().getName());
          if(uf.getEstado().equals(FacturaState.TOPAY) && uf.getFechaPago() == null){
               Map<String,String> estados=new LinkedHashMap<String,String>();
                estados.put(FacturaState.TOPAY.name(),FacturaState.TOPAY.getEstado());
                estados.put(FacturaState.PAID.name(),FacturaState.PAID.getEstado());

              result.addError(new ObjectError("","Si el estado es A pagar debe ingresar una fecha de pago"));
              modelo.addAttribute(RESULT,"failed");
              modelo.addAttribute(RESULT_MSG,result.getAllErrors());
              modelo.addAttribute("estados", estados);
              return "contable.factura.pagar.def";
          }
          svce.update(uf.convertToentity());
          status.setComplete();
         return "redirect:../gestion";
          
      }
 
      
    //---------------------------------------- LISTADO DE FACTURAS PAGAS-------------------------------------  
      
      
//     @RequestMapping(value ="/facturaspagas" ,method = RequestMethod.GET)
//    public ModelAndView initFacturasPagas(){
//        ModelAndView modelo=new ModelAndView("empleado.factura.pagas.def");
//            
//         modelo.addObject("listadofacturaspagas",svce.ListAllPaid());
//        
//        return modelo;
//    }
     @RequestMapping(value ="/facturaspagas/{id}" ,method = RequestMethod.GET)
    public ModelAndView initFacturasPagasPageable(@PathVariable("id") int pageId){
        ModelAndView modelo=new ModelAndView("contable.factura.pagas.def");
        Page<Factura> page=(Page<Factura>) svce.ListAllPaid(new PageRequest(pageId-1,10));//para no empezar las paginas de cero
        modelo.addObject("listadofacturaspagas",page.getContent());
        paginator(page, modelo.getModelMap());//envia en el mmodelo los paremetros de pagina actual/cantidad maxima de paginas/comienzo y fin de paginacion

        return  modelo;
        
        
    }
    
//----------------------------------------- LISTADO FACTURAS RECHAZADAS-----------------------------------------------   
    
    @RequestMapping(value ="/facturasrechazadas/{id}" ,method = RequestMethod.GET)
    public ModelAndView initFacturasRechazadas(@PathVariable("id") int pageId){
        ModelAndView modelo=new ModelAndView("contable.factura.rechazadas.def");
            
        Page<Factura> page=(Page<Factura>) svce.ListAllReject(new PageRequest(pageId-1,10));//para no empezar las paginas de cero
        modelo.addObject("listadofacturasrechazadas",page.getContent());
        paginator(page, modelo.getModelMap());
        
        return modelo;
    }
    
 //----------------------------------------Reportes-------------------------------
         @RequestMapping(value ="/reportes" ,method = RequestMethod.GET)
    public ModelAndView initReportes(){
        //ModelAndView modelo=new ModelAndView("excelView","listfacturas",svce.ListAllunPaid());
       // modelo.addObject("facturasunpaid",svce.ListAllunPaid());
        ModelAndView modelo=new ModelAndView("contable.factura.reportes");
        
        return modelo;
    }   
    
    //-----------------------------------------SEARCH FACTURA------------------------------ 
      @RequestMapping(value ="/facturasearch" ,method = RequestMethod.GET)
    public ModelAndView initFacturasSearch(@RequestParam(value = "id",required = false,defaultValue = "")String id){
        ModelAndView modelo=new ModelAndView("contable.factura.search.def");
        Factura fact=null;
        try{
              Long idlong=Long.parseLong(id);
              fact=svce.findFacturaById(idlong); 
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
    
 //------------------calculo de fecha limite de pago------------------------------   
private Date addDate(Date fecha, int dias){
if(fecha !=null)    {
    Calendar calendar = new GregorianCalendar(/* remember about timezone! */);
    calendar.setTime(fecha);
    calendar.add(Calendar.DATE, dias);
    return calendar.getTime();
}
return null;
}
//-------------------------------------PAGINATOR------------------------------------   
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


    

