/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.repositorio;

import com.dog.entity.Usuario;
import java.io.Serializable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Administrador
 */
public interface UsuarioRepository extends JpaRepository<Usuario,Long>{
    @Query("SELECT  u FROM Usuario u  WHERE u.username= :name")
    public Usuario findOneByUserName(@Param("name") String name);
}
