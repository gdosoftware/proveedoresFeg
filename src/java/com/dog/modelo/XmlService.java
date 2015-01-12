/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.modelo;

import com.dog.definiciones.cfdv.Comprobante;
import com.sun.org.apache.xerces.internal.dom.ElementNSImpl;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.util.JAXBSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Service;

import org.xml.sax.SAXException;

/**
 *
 * @author Administrador
 */
@Service
@Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class XmlService  {
   private JAXBContext jaxbContext;
   private  Schema schema;
   private  Validator validator;
    public XmlService(){
         SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
       try {      
           jaxbContext = JAXBContext.newInstance(Comprobante.class);
           schema=sf.newSchema(new URL("http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"));
           validator = (Validator) schema.newValidator();
       } catch (JAXBException ex) {
           Logger.getLogger(XmlService.class.getName()).log(Level.SEVERE, null, ex);
       } catch (MalformedURLException ex) {
           Logger.getLogger(XmlService.class.getName()).log(Level.SEVERE, null, ex);
       } catch (SAXException ex) {
           Logger.getLogger(XmlService.class.getName()).log(Level.SEVERE, null, ex);
       }
       
       
      
    }
    

    
    public Date getFechaFactura(Comprobante comprobante){
       if(comprobante != null){
           return comprobante.getFecha().toGregorianCalendar().getTime();
       }
       
       return null;
    }
    
    public String getUUIDFactura(Comprobante comprobante){
       
       if(comprobante != null){   
          return ((ElementNSImpl)(comprobante.getComplemento().getAny().get(0))).getAttributeNode("UUID").getValue();
       }
       return null;
        
    }
    
    public Comprobante getComprobante(File file){
       try {
           Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
           Comprobante comprobante = (Comprobante) jaxbUnmarshaller.unmarshal(file);
//           JAXBSource source = new JAXBSource(jaxbContext, comprobante);
//           validator.validate(source);
           return comprobante;
       } catch (JAXBException ex) {
           Logger.getLogger(XmlService.class.getName()).log(Level.SEVERE, null, ex);
       } /**catch (SAXException ex) {
           Logger.getLogger(XmlService.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException ex) {
           Logger.getLogger(XmlService.class.getName()).log(Level.SEVERE, null, ex);
       }**/
       return null;
    }

   
}
