/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.tools.formatters;


import com.dog.entity.FacturaState;
import com.dog.entity.RoleType;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import org.springframework.format.Formatter;
import org.springframework.format.FormatterRegistrar;
import org.springframework.format.FormatterRegistry;
import org.springframework.stereotype.Component;

/**
 *
 * @author Administrador
 */
@Component
public class DogFormatterRegistrar implements FormatterRegistrar {

    
  

    //se utiliza en los casos en ñlos que selecciono un entity creado; por  su id y necesito que se interprete por  su objeto
    @Override
    public void registerFormatters(FormatterRegistry fr) {
   
         fr.addFormatterForFieldType(RoleType.class,new Formatter<RoleType>() {

             @Override
             public String print(RoleType t, Locale locale) {
                 return t.name();
             }

             @Override
             public RoleType parse(String string, Locale locale) throws ParseException {
                 return RoleType.valueOf(string);
             }
         });
          
         fr.addFormatterForFieldType(FacturaState.class,new Formatter<FacturaState>() {

             @Override
             public String print(FacturaState t, Locale locale) {
                 return t.name();
             }

             @Override
             public FacturaState parse(String string, Locale locale) throws ParseException {
                 return FacturaState.valueOf(string);
             }
         }); 
        
          fr.addFormatterForFieldType(Date.class,new Formatter<Date>() {
              private SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yy");
             @Override
             public String print(Date t, Locale locale) {
                 return String.format(" %td/%tm/%ty", t,t,t);
             }

             @Override
             public Date parse(String string, Locale locale) throws ParseException {
                 return sdf.parse(string);
             }
         });
    }
   

    
}
