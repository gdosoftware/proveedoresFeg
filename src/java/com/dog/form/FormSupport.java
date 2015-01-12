/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.form;

/**
 *
 * @author Administrador
 */
public abstract class FormSupport<T> {
    public abstract T convertToentity();
    public abstract void convertFromEntity(T entity);
    
}
