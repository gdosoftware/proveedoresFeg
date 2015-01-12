/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.tools.validators;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 *
 * @author Administrador
 */
public class EqualToValidator implements ConstraintValidator<EqualTo, String> {
    String field;
    Class clazz;
    @Override
    public void initialize(EqualTo constraintAnnotation) {
        String toupper=constraintAnnotation.field().substring(0,1).toUpperCase();
        field="get"+toupper+constraintAnnotation.field().substring(1);
        try {
            clazz=Class.forName(constraintAnnotation.clazz());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
        }
        
                
    }
    
    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        boolean result=false;
//        if(value==null){
//            result= false;
//        }else{
//           
//            try {
//                  Method mthd=clazz.getMethod(field);
//                  String target=(String) mthd.invoke(clazz.newInstance());
//                if(target.equals(value)){
//                    result= true;
//                }else{
//                    result= false;
//                }
//            } catch (NoSuchMethodException ex) {
//                Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
//            } catch (SecurityException ex) {
//                Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
//            } catch (IllegalAccessException ex) {
//                Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
//            } catch (IllegalArgumentException ex) {
//                Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
//            } catch (InvocationTargetException ex) {
//                Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
//            } catch (InstantiationException ex) {
//                Logger.getLogger(EqualToValidator.class.getName()).log(Level.SEVERE, null, ex);
//            } 
//        }
        return true;
    }
}
