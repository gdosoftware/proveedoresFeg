/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.form;

import com.dog.entity.Factura;
import com.dog.entity.FacturaState;
import com.dog.entity.Usuario;
import com.dog.tools.validators.UpLoadFile;
import java.util.Date;
import org.springframework.context.annotation.Scope;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Administrador
 */
@Component
@Scope("request")
public class FacturaForm extends FormSupport<Factura>{
    private Long id;
    private String comentario;
        @UpLoadFile(mimeType = "text/xml,application/pdf")
    private MultipartFile fileupload;
        @DateTimeFormat(pattern = "dd/mm/yyyy")
    private Date fechaFactura;
    private String uuid;
    private Usuario proveedor;
    private Long idFactura;
    private String fileName;
    private FacturaState estado;
    private String ordenCompra;
    private String ordenEntrada;
    private boolean pagada;
    private String motivo;
    private Date fechaValidacion;
    private Date fechaPago;
    private Date fechaLimite;
    private String username;
  

    public FacturaForm() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public MultipartFile getFileupload() {
        return fileupload;
    }

    public void setFileupload(MultipartFile fileupload) {
        this.fileupload = fileupload;
    }

    public Date getFechaFactura() {
        return fechaFactura;
    }

    public void setFechaFactura(Date fechaFactura) {
        this.fechaFactura = fechaFactura;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Usuario getProveedor() {
        return proveedor;
    }

    public void setProveedor(Usuario proveedor) {
        this.proveedor = proveedor;
    }

    public Long getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(Long idFactura) {
        this.idFactura = idFactura;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
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

    public Date getFechaLimite() {
        
        return fechaLimite;
    }

    public void setFechaLimite(Date fechaLimite) {
        this.fechaLimite = fechaLimite;
    }

   

   
    

    public boolean getPagada() {
        return pagada;
    }

    public void setPagada(boolean pagada) {
        this.pagada = pagada;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    
    
    
    @Override
    public Factura convertToentity() {
        Factura fact= new Factura();
        fact.setId(id);
        fact.setComentario(comentario);
        fact.setFechaFactura(fechaFactura);
        fact.setFileName(fileName);
        fact.setIdFactura(idFactura);
        fact.setEstado(estado);
       if(pagada) {
            fact.setEstado(FacturaState.PAID);
        }
        fact.setProveedor(proveedor);
        fact.setUuid(uuid);
        fact.setMotivo(motivo);
        fact.setFechaValidacion(fechaValidacion);
        fact.setFechaPago(fechaPago);
        fact.setUsername(username);
        fact.setOrdenCompra(ordenCompra);
        fact.setOrdenEntrada(ordenEntrada);
        
        return fact;
    }

    @Override
    public void convertFromEntity(Factura entity) {
        this.comentario=entity.getComentario();
        this.fechaFactura=entity.getFechaFactura();
        this.id=entity.getId();
        this.idFactura=entity.getIdFactura();
         this.proveedor=entity.getProveedor();
        this.uuid=entity.getUuid();
        this.estado=entity.getEstado();
        this.comentario=entity.getComentario();
        this.fechaValidacion=entity.getFechaValidacion();
        this.fechaPago=entity.getFechaPago();
        this.username=entity.getUsername();
        this.motivo=entity.getMotivo();
        this.fileName=entity.getFileName();
        this.ordenCompra=entity.getOrdenCompra();
        this.ordenEntrada=entity.getOrdenEntrada();
        
    }
    
    
    
    
}
