/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.modelo;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 *
 * @author Administrador
 */
public interface IDaoService<T> {
  
   
    public T create(T entity);
    public T update(T entity);// se actualiza todo el registro con la nueva version
    public T merge(T entity);//solo se actaulizan los campos con valores sitiontos de null
    public T retrieve(Long id);
    public void delete(T entity);
    public void delete (Long id);
    public List<T> listAll();
    public Page<T> listAll(Pageable page); 
}
