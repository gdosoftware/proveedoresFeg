/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.tools.validators;

import java.util.Arrays;
import java.util.List;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Administrador
 */

public class UpLoadFileValidator implements ConstraintValidator<UpLoadFile,MultipartFile> {
   
    private long maxSize;
    private List<String> mimeType;
    private static final  Resource res = new ClassPathResource("resources/image");
        
    @Override
    public void initialize(UpLoadFile constraintAnnotation) {
        this.maxSize=constraintAnnotation.maxSize();
        this.mimeType=Arrays.asList(constraintAnnotation.mimeType().split(","));
       
        
    }
   
  

    @Override
    public boolean isValid(MultipartFile t, ConstraintValidatorContext cvc) {
        //mimeType.contains(value.getFile().getContentType())
        if((t.getSize()<this.maxSize)&&(mimeType.contains(t.getContentType()))){
            return true;
        }else{
            return false;
        }
        
    }
 
   
}
