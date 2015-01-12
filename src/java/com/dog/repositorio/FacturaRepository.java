/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.repositorio;

import com.dog.entity.Factura;
import com.dog.entity.FacturaState;
import com.dog.entity.Usuario;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Administrador
 */
public interface FacturaRepository extends JpaRepository<Factura, Long>{
         @Query("SELECT f.idFactura FROM Factura f ORDER BY f.idFactura ASC")
    public List<Long> findLastIDFactura();
       
    @Query("SELECT f FROM Factura f WHERE f.estado=:estado1 OR f.estado=:estado2 OR f.estado=:estado3")
    public List<Factura> findAllunPaid(@Param("estado1") FacturaState estado1,
                                        @Param("estado2") FacturaState estado2,
                                        @Param("estado3") FacturaState estado3);
    
       
        @Query("SELECT f FROM Factura f WHERE f.estado=:estado ORDER BY f.idFactura DESC")                               
     public Page<Factura> findAllByState(@Param("estado") FacturaState estado,Pageable page);
     
      @Query("SELECT f FROM Factura f WHERE f.estado=:estado ORDER BY f.idFactura DESC")                               
     public List<Factura> findAllByState(@Param("estado") FacturaState estado);
      
    
     @Query("SELECT f FROM Factura f WHERE f.proveedor=:prov AND f.estado=:estado ORDER BY f.idFactura DESC")                               
     public Page<Factura> findAllByProveedorByState(@Param("prov") Usuario prov,@Param("estado") FacturaState estado,Pageable page);
      
     @Query("SELECT f FROM Factura f WHERE f.proveedor=:prov AND f.estado!=:estado ORDER BY f.idFactura DESC")                               
     public Page<Factura> findAllByProveedorByNotState(@Param("prov") Usuario prov,@Param("estado") FacturaState estado,Pageable page);
     
        @Query("SELECT f FROM Factura f WHERE f.idFactura=:id")                               
     public Factura findOneByFacturaId(@Param("id") Long id);
        
        @Query("SELECT f FROM Factura f WHERE f.idFactura=:id AND f.proveedor=:prov")                               
     public Factura findOneByFacturaIdAndProveedor(@Param("id") Long id,@Param("prov") Usuario prov);
       
     @Query("SELECT f FROM Factura f WHERE f.proveedor=:prov")  
     public List<Factura> findAllFacturaByProveedor(@Param("prov") Usuario prov);
}