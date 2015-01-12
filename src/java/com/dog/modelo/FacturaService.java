/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.modelo;

import com.dog.entity.Factura;
import com.dog.entity.FacturaState;
import com.dog.entity.Usuario;
import com.dog.repositorio.FacturaRepository;
import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrador
 */
@Service
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class FacturaService extends DaoService<Factura>{
    @Autowired
    private FacturaRepository repo;

    @Override
    public JpaRepository<Factura, Long> getRepositrory() {
        return repo;
    }

   public Long nextAvailableNumber(){
     List<Long> lista= repo.findLastIDFactura();
      if(lista.isEmpty()){
           return 0L;
      }else{
          return Collections.max(lista);
      }
      
   }
   
   public List<Factura> listAllPend(){
       return repo.findAllByState(FacturaState.PEND);
   }
   
   public List<Factura> ListAllunPaid(){
       return repo.findAllunPaid(FacturaState.CONFIRM,FacturaState.VALID,FacturaState.TOPAY);
   }

   
    public Page<Factura> ListAllReject(Pageable page){
       return repo.findAllByState(FacturaState.REJECT,page);
   }
   
    public Page<Factura> ListAllPaid(Pageable page){
       return repo.findAllByState(FacturaState.PAID,page);
   }
     
   public Page<Factura> ListAllByProveedorUnPaid(Usuario user,Pageable page){//facturas cuyo estdo sea distintoa paid
    
       return repo.findAllByProveedorByNotState(user,FacturaState.PAID,page);
   }
   
    public Page<Factura> ListAllByProveedorPaid(Usuario user,Pageable page){//facturas cuyo estado sea  paid
       return repo.findAllByProveedorByState(user,FacturaState.PAID,page);
   }
    
  public Factura findFacturaById(Long id){
      return repo.findOneByFacturaId(id);
  }
  public Factura findFacturaById(Long id,Usuario user){
      return repo.findOneByFacturaIdAndProveedor(id,user);
  }
  
  public void deleteFacturasByProveedor(Usuario user){
      for(Factura f:repo.findAllFacturaByProveedor(user)){
          repo.delete(f);
      }
    
  }
    
}
