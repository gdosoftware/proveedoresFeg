/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.controller;

import org.springframework.data.domain.Page;
import org.springframework.ui.ModelMap;

/**
 *
 * @author Administrador
 */
public class PaginatorHelper {
    private static final String PAGINATION_BEGIN_INDEX="begin";
    private static final String PAGINATION_END_INDEX="end";
    private static final String PAGINATION_CURRENT_INDEX="current";
    private static final String PAGINATION_TOTAL_PAGES="total";
    
     public void paginator(Page page,ModelMap modelo){//envia en el mmodelo los paremetros de pagina actual/cantidad maxima de paginas/comienzo y fin de paginacion
        int current = page.getNumber()+1;
        int begin = Math.max(1, current - 10);
        int end = Math.min(begin + 10, page.getTotalPages());
        modelo.addAttribute(PAGINATION_BEGIN_INDEX,begin);
        modelo.addAttribute(PAGINATION_END_INDEX, end);
        modelo.addAttribute(PAGINATION_CURRENT_INDEX, current); 
        modelo.addAttribute(PAGINATION_TOTAL_PAGES, page.getTotalPages()); 
    }
}
