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
public enum RoleType {ADMIN("Administrador"),
                     COMPRADOR("Comprador"),
                     CONTABLE("Contable"),
                     PROV_LOCAL("Prov Local"),
                     PROV_EXT("Prov Exterior");
private String roleName;
private RoleType(String name){
    this.roleName=name;
}
public String getRoleName(){
    return this.roleName;
}
};
