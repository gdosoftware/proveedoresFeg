/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.form;

import com.dog.entity.RoleType;
import com.dog.entity.Usuario;
import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrador
 */
@Component
@Scope("request")
public class UsuarioForm extends FormSupport<Usuario> {
  
    private Long id;
        @Size(min = 6,message = "Debe ingresar un nombre mayor a 6 caracteres")
        @NotEmpty(message = "Debe ingresar su nombre")
    private String nombre;
        @Size(min = 6,message = "Debe ingresar un usuario mayor a 6 caracteres")
        @NotEmpty(message = "Debe ingresar su nombre de usuario")
   private String username;
//        @Size(min = 4,message = "Debe ingresar una contraseña mayor a 6 caracteres")
//        @NotEmpty(message = "Debe ingresar una Contraseña")
    private String password;
//         @Size(min = 4,message = "Debe ingresar una contraseña mayor a 6 caracteres")
//         @NotEmpty(message = "Debe ingresar una Contraseña")
    private String repassword;
//          @Size(min = 4,message = "Debe ingresar una contraseña mayor a 6 caracteres")
//          @NotEmpty(message = "Debe ingresar una Contraseña")
    private String oldpassword;        
    private RoleType rol;
        @Email(message = "Debe ingresar una direccion de mail valida")
    private String email;
    private Boolean enabled;
    private String rfc;
    private int diasCredito;
    private String mypassword;//esta la uso para guardar el password de mi cuenta 
    public UsuarioForm() {
      
    }
    
    
    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRepassword() {
        return repassword;
    }

    public void setRepassword(String repassword) {
        this.repassword = repassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getOldpassword() {
        return oldpassword;
    }

    public void setOldpassword(String oldpassword) {
        this.oldpassword = oldpassword;
    }

    public int getDiasCredito() {
        return diasCredito;
    }

    public void setDiasCredito(int diasCredito) {
        this.diasCredito = diasCredito;
    }

   

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public RoleType getRol() {
        return rol;
    }

    public void setRol(RoleType rol) {
        this.rol = rol;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getMypassword() {
        return mypassword;
    }

    public void setMypassword(String mypassword) {
        this.mypassword = mypassword;
    }
    
    
    
    @Override
    public Usuario convertToentity() {
       Usuario usuario=new Usuario();
       usuario.setId(id);
       usuario.setNombre(nombre);
       usuario.setPassword(mypassword);
       usuario.setRol(rol);
       usuario.setUsername(username);
       usuario.setEnabled(enabled);
       usuario.setEmail(email);
       usuario.setRfc(rfc);
       usuario.setDiasCredito(diasCredito);
       return usuario;
    }

    @Override
    public void convertFromEntity(Usuario entity) {
        this.id=entity.getId();
        this.nombre=entity.getNombre();
        this.rol=entity.getRol();
        this.username=entity.getUsername();
        this.enabled=entity.isEnabled();
        this.email=entity.getEmail();
        this.rfc=entity.getRfc();
        this.diasCredito=entity.getDiasCredito();
        this.mypassword=entity.getPassword();
    }
    
}
