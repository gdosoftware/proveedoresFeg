/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.modelo;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Administrador
 * clase de servicio generico que debo ectender en mi servicio
 */

public abstract class DaoService<T>  implements IDaoService<T>{
   
    public abstract JpaRepository<T,Long> getRepositrory(); 
    
 
      
    @Override
    public T create(T entity) {
        return getRepositrory().save(entity);
    }

    @Override
    public T update(T entity) {
         return getRepositrory().save(entity);
    }
   
     //es para el,caso en los cuales solo quiero cambiar algunos campos de un  registro dejando los otros
        //intactos y no quiero mandar los datos viejos en el commandname al formulario de update por seguridad como
        //seria el caso de usuarios que le envio la contraseña en un update como hidden, pero por su complejidad es necesario
    //la sobreescritura y luego la llamada super() particularizada
    @Override
    public  T merge(T entity){
        return getRepositrory().save(entity);
    }
   
      
     
    

    @Override
    public T retrieve(Long id) {//en caso de que el objeto contenga otro objeto no eager lo puedo reescribir el metodo teniendo en cuenta la situacion e utilizando unmetodo findeager que creo yo con una namequery
        return getRepositrory().findOne(id);
    }

    @Override
    public void delete(T entity) {
        getRepositrory().delete(entity);
    }

    @Override
    public void delete(Long id) {
        getRepositrory().delete(id);
    }
 
   
    
    @Override
    public List<T> listAll(){
        return getRepositrory().findAll();
    }
    
    @Override
    public Page<T> listAll(Pageable page) {// lo mismo que para el casode retrieve cuando existe un objeto lazy
        return getRepositrory().findAll(page);
    }
    
 
    
  
   
}
//   try {
//            Long id = (Long) entity.getClass().getDeclaredMethod("getId").invoke(entity,(Object[])null);
//            T oldentity=getRepositrory().findOne(id);
//             for(Method newMethod: entity.getClass().getMethods()){
//                 if(newMethod.getName().startsWith("get")){
//                      String getName = newMethod.getName();
//                      String setName = getName.replace("get", "set");
//                       Object newValue=entity.getClass().getDeclaredMethod(getName).invoke(entity,(Object[]) null);
//                       Object oldValue=entity.getClass().getDeclaredMethod(getName).invoke(oldentity,(Object[]) null);
//                       if(newValue == null){
//                           entity.getClass().getDeclaredMethod(setName).invoke(entity,oldValue);
//                       }
//                       if(entity.getClass().getDeclaredMethod(getName).getDeclaringClass().equals(Collection.class)){
//                           ((Collection) newValue).addAll((Collection) oldValue);//concateno la lista vieja y la nueva
//                               
//                           
//                       }
//                 }
//             }
//             getRepositrory().save(entity);
//        } catch (NoSuchMethodException ex) {
//            Logger.getLogger(DogDaoSupport.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (SecurityException ex) {
//            Logger.getLogger(DogDaoSupport.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (IllegalAccessException ex) {
//            Logger.getLogger(DogDaoSupport.class.getName()).log(Level.SEVERE, null, ex);
//        }  catch (InvocationTargetException ex) {
//            Logger.getLogger(DogDaoSupport.class.getName()).log(Level.SEVERE, null, ex);
//        }
//       
//        return entity;//debo implementar con introspeccion