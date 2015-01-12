/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.tools.validators;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

/**
 *
 * @author Administrador
 */
@Documented
@Constraint(validatedBy = UpLoadFileValidator.class)
@Target({ ElementType.FIELD, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface UpLoadFile {

    String message() default "No se Pude recibir su Factura";
    long maxSize() default 480000L;
    String mimeType() default "text/xml"; 
    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
