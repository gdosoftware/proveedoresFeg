/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.modelo;

import com.dog.entity.Usuario;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 *
 * @author Administrador
 */
//@Service("userDetailService")//lo declaro en el xml para que se pueda referenciar desde ahi
//@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class DogDetailService implements UserDetailsService {
    @Autowired
    private UsuarioService svce;

      @Override
    public UserDetails loadUserByUsername(String string) throws UsernameNotFoundException {
        Usuario usuario=svce.retrieve(string);
        List<GrantedAuthority> authorities=new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority(usuario.getRol().name()));
	
 
        return new User(usuario.getUsername(), 
			usuario.getPassword(), 
                        usuario.isEnabled(), 
                        true, true,true, authorities);
        
    }

//    public UsuarioService getSvce() {
//        return svce;
//    }
//
    public void setSvce(UsuarioService svce) {
        this.svce = svce;
    }
  
   
    
    
}
