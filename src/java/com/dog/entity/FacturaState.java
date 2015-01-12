/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.entity;

/**
 *
 * @author Administrador
 */
public enum FacturaState {PEND("Pendiente"),
                          REJECT("Rechazada"),
                          CONFIRM("conforme"),
                          VALID("Aprobada"),
                          TOPAY("a Pagar"),
                          PAID("Pagada");
private String estado;
private FacturaState(String estado){
    this.estado=estado;
}
public String getEstado(){
    return this.estado;
}
    
}
