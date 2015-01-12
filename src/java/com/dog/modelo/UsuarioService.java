/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.modelo;

import com.dog.entity.Usuario;
import com.dog.repositorio.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrador
 */
@Service
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class UsuarioService extends DaoService<Usuario>{
@Autowired
private UsuarioRepository repo;
    @Override
    public JpaRepository<Usuario, Long> getRepositrory() {
        return repo;
        
    }

   
    
     
   public Usuario retrieve (String username){
       return repo.findOneByUserName(username);
   }
    
}
