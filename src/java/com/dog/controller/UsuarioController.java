/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import com.dog.entity.RoleType;
import com.dog.entity.Usuario;
import com.dog.form.UsuarioForm;
import com.dog.modelo.FacturaService;
import com.dog.modelo.UsuarioService;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
@RequestMapping("/usuario")
@SessionAttributes({"usuarioCommandCreate","usuarioCommandUpdate"})
// @PreAuthorize("hasRole('ADMIN')")
public class UsuarioController {
    
    private static final String RESULT="resultado";
    private static final String RESULT_MSG="resultmsg";
    @Autowired
    private UsuarioService svce;
     @Autowired
    private FacturaService svceFact;
   @Autowired
   private UsuarioForm form;
//-------------------------------------------------CRUD DE USUARIOS-----------------------------    
   @PreAuthorize("hasRole('ADMIN')") 
   @RequestMapping(value ="/crud" ,method = RequestMethod.GET)
    public ModelAndView initCrud(){
        ModelAndView modelo=new ModelAndView("usuario.crud.def");
//        String[] header={"Sel","Usuario","Nombre","Email","Rol"};
//        modelo.addObject("tableheader",header);
        modelo.addObject("listausuario",svce.listAll());
        return modelo;
    }
  //----------------------------------------- CREAR USUARIO------------------------------------
    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value ="/create" ,method = RequestMethod.GET)
    public ModelAndView initCreate(ModelMap model){
       ModelAndView modelo=new ModelAndView("usuario.create.def");
        form.setPassword("1234");
        form.setEnabled(Boolean.TRUE);
        modelo.addObject("usuarioCommandCreate",form);
      
        return modelo;
    } 
   
      @PreAuthorize("hasRole('ADMIN')")
      @RequestMapping(value = "/create" ,method = RequestMethod.POST)
    public String submitCreate(@ModelAttribute("usuarioCommandCreate") @Valid UsuarioForm uf,
              BindingResult result, SessionStatus status,ModelMap modelo){
             
       if(result.hasErrors()){
            userNameCheck(result, uf);
            PasswordCheck(result, uf);
           
           modelo.addAttribute(RESULT,"failed");
           modelo.addAttribute(RESULT_MSG,result.getAllErrors());
           return "usuario.create.def";
       }else{
           if(!userNameCheck(result, uf) || !PasswordCheck(result, uf)){
               modelo.addAttribute(RESULT,"failed");
               modelo.addAttribute(RESULT_MSG,result.getAllErrors());
               return "usuario.create.def";
           }
             
           
           uf.setMypassword(new Md5PasswordEncoder().encodePassword(uf.getPassword(),"carancho"));
           svce.create(uf.convertToentity());
           status.setComplete();
       }
      
        
        return "redirect:crud";
        
    }
     
   //---------------------------------------------CONSULTAR USUARIO-------------------------- 
    @PreAuthorize("hasRole('ADMIN')")
     @RequestMapping(value ="/retrieve/{id}" ,method = RequestMethod.GET)
   public ModelAndView initRetrieve(@PathVariable Long id){
        ModelAndView modelo=new ModelAndView("usuario.retrieve.def");
        form.convertFromEntity(svce.retrieve(id));
        modelo.addObject("usuarioCommand",form);
      
        
         return modelo;
    }
   //-------------------------------------------AVISO DELETE--------------------------
    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value ="/avisodelete/{id}" ,method = RequestMethod.GET)
   public @ResponseBody String avisoDelete(@PathVariable("id") Long id) {
       Usuario user=svce.retrieve(id);
       if(user.getRol().equals(RoleType.PROV_EXT) || user.getRol().equals(RoleType.PROV_LOCAL)){
           return "Desea Borra al Proveeedor "+user.getNombre()+" junto a todas sus Facturas";
       }
       return "Desea Borrar al Usuario "+user.getNombre();
   }
   
   //---------------------------------------------BORRAR USUARIO----------------------------------------
   @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value ="/delete/{id}" ,method = RequestMethod.GET)
   public ModelAndView delete(@PathVariable("id") Long id,HttpServletRequest request){
         ModelAndView  modelo=new ModelAndView("redirect:../crud");
         svceFact.deleteFacturasByProveedor(svce.retrieve(id));
         svce.delete(id);
         return modelo;
    }
   
  //-------------------------------------------MODIFICAR USUARIO--------------------------------------- 
      @PreAuthorize("hasRole('ADMIN')")
      @RequestMapping(value ="/update/{id}" ,method = RequestMethod.GET)
   public ModelAndView initUpdate(@PathVariable Long id){
        ModelAndView modelo=new ModelAndView("usuario.update.def");
        form.convertFromEntity(svce.retrieve(id));
        modelo.addObject("usuarioCommandUpdate",form);
  
        
         return modelo;
    }
      @PreAuthorize("hasRole('ADMIN')")
      @RequestMapping(value ="/update/{id}" ,method = RequestMethod.POST)
   public String submitUpdate(@PathVariable Long id,@ModelAttribute("usuarioCommandUpdate") @Valid UsuarioForm uf,
              BindingResult result, SessionStatus status,ModelMap model){
        String fordward;
       
       if(result.hasErrors()){
           model.addAttribute(RESULT,"failed");
           model.addAttribute(RESULT_MSG,result.getAllErrors());
           fordward="usuario.update.def";
       }else{
           fordward="redirect:../crud";
           svce.create(uf.convertToentity());
           status.setComplete();
       }
      
        
        return fordward;
    }
   
   //------------------------------------ cambiar contraseña------------------------------------
   
      @RequestMapping(value ="/perfil" ,method = RequestMethod.GET)
   public ModelAndView initProfile(HttpServletRequest request){
        ModelAndView modelo=new ModelAndView("usuario.profile.def");
        Usuario usuario=svce.retrieve(request.getUserPrincipal().getName());
        form.convertFromEntity(usuario);
        modelo.addObject("usuarioCommandUpdate",form);
  
        
         return modelo;
    }
     @RequestMapping(value ="/perfil" ,method = RequestMethod.POST)
   public String submitUpdate(@ModelAttribute("usuarioCommandUpdate") @Valid UsuarioForm uf,
              BindingResult result, SessionStatus status,ModelMap model){
         if(result.hasErrors()){
           rePasswordCheck(result, uf);
           model.addAttribute(RESULT,"failed");
           model.addAttribute(RESULT_MSG,result.getAllErrors());
           return "usuario.profile.def";
       }else{
           if(uf.getOldpassword()!=null){//si ingreso la contrase?a antihua es para ca<mbiar la contrase?a sino dejo la antigua  
                if(!rePasswordCheck(result, uf)){
                    model.addAttribute(RESULT,"failed");
                     model.addAttribute(RESULT_MSG,result.getAllErrors());
                     return "usuario.profile.def";
                }  

                uf.setMypassword(new Md5PasswordEncoder().encodePassword(uf.getPassword(),"carancho"));
           }
           svce.create(uf.convertToentity());
           status.setComplete();
           return "home.def";
       }
      
        
       
    }
   
       
//---------------------------------------CHEQUEAR CONTRASEÑAS------------------------------
   
    private boolean rePasswordCheck(BindingResult result,UsuarioForm form){
        boolean res=true;
        if(!form.getMypassword().equals(new Md5PasswordEncoder().encodePassword(form.getOldpassword(),"carancho"))){
                result.addError(new ObjectError("","Su contrasena anterior no es correcta"));
                res= false;
           }
           if(!form.getPassword().equals(form.getRepassword())){
                result.addError(new ObjectError("","Reingrese correctamente su nueva contrasena"));
                res=false;
           }
        return res;
    }
   
   private boolean PasswordCheck(BindingResult result,UsuarioForm form){
       if(form.getPassword().isEmpty()){
                result.addError(new ObjectError("","Debe ingresar una Contrasena"));
                return false;
            }else{
                if(form.getPassword().length()<4){
                    result.addError(new ObjectError("","La contrasena debe ser mayor a 3 caracteres"));
                    return false;
                }
            }
       return true;
   }
   private boolean userNameCheck(BindingResult result,UsuarioForm form){           
       if(svce.retrieve(form.getUsername()) != null){
               result.addError(new ObjectError("","El nombre de usuario ya ha sido utilizado"));
               return false;
            }
       return true;
           }
    
    //----------------------------populate Roles--------------------------------------------
              @ModelAttribute("roles")
    public Map<String,String> populateRoles(){
    Map<String,String> roles=new LinkedHashMap<String,String>();
    for(RoleType rt:RoleType.values()){
        roles.put(rt.name(),rt.getRoleName());
    }
    return roles;
}
    
    
    
}
