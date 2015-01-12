/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author Administrador
 */
@Entity
public class Factura implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private Long idFactura;
        @Temporal(javax.persistence.TemporalType.DATE)
        @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date fechaFactura;
    @ManyToOne
    private Usuario proveedor;
    private String ordenCompra;
    private String ordenEntrada;
    private String uuid;
        @Enumerated(EnumType.STRING)
    private FacturaState estado;
    private String motivo;
         @Temporal(javax.persistence.TemporalType.DATE)
         @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date fechaValidacion;
         @Temporal(javax.persistence.TemporalType.DATE)
         @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date fechaPago;
    private String fileName;
    private String username;
    private String comentario;

    public Factura() {
    }

    public Long getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(Long idFactura) {
        this.idFactura = idFactura;
    }

    public Date getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(Date fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public Usuario getProveedor() {
        return proveedor;
    }

    public void setProveedor(Usuario proveedor) {
        this.proveedor = proveedor;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public FacturaState getEstado() {
        return estado;
    }

    public void setEstado(FacturaState estado) {
        this.estado = estado;
    }

    public String getOrdenCompra() {
        return ordenCompra;
    }

    public void setOrdenCompra(String ordenCompra) {
        this.ordenCompra = ordenCompra;
    }

    public String getOrdenEntrada() {
        return ordenEntrada;
    }

    public void setOrdenEntrada(String ordenEntrada) {
        this.ordenEntrada = ordenEntrada;
    }

   

   

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Date getFechaValidacion() {
        return fechaValidacion;
    }

    public void setFechaValidacion(Date fechaValidacion) {
        this.fechaValidacion = fechaValidacion;
    }

    public Date getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }

    

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }
    
    
    
    
    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Factura)) {
            return false;
        }
        Factura other = (Factura) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.dog.entity.Factura[ id=" + id + " ]";
    }
    
}
