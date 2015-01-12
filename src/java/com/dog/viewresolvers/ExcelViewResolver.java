/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.dog.viewresolvers;

import com.dog.entity.Factura;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.web.servlet.view.document.AbstractExcelView;

/**
 *
 * @author Administrador
 * Esta es la clase que se llamara cuando desde el controlador
 *     ModelAndView modelo=new ModelAndView("excelView","listfacturas",svce.ListAllunPaid());
 * excelView esta definido en un archivo views.xml de vistas en donde hay una entrada
 *  <bean id="excelView" class="com.dog.viewresolvers.ExcelViewResolver" />
 * para que todo esto funciones hay que definir en el archivo de configuracion dispatcher-servlet
 * <bean id="viewResolver1" class="org.springframework.web.servlet.view.XmlViewResolver">
        <property name="order" value="1"/> colocar en el primer orden y el de tiles en el segundo
        <property name="location" value="/WEB-INF/views.xml"/>
    </bean>  
 * 
 */
public class ExcelViewResolver extends AbstractExcelView{

    @Override
    protected void buildExcelDocument(Map<String, Object> map, HSSFWorkbook hssfw, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        // get data model which is passed by the Spring container
        List<Factura> listFactura = (List<Factura>) map.get("listfacturas");
         
        // create a new Excel sheet
        HSSFSheet sheet = hssfw.createSheet("Java Books");
        sheet.setDefaultColumnWidth(30);
         
        // create style for header cells
        CellStyle style = hssfw.createCellStyle();
        Font font = hssfw.createFont();
        font.setFontName("Arial");
        style.setFillForegroundColor(HSSFColor.BLUE.index);
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font.setColor(HSSFColor.WHITE.index);
        style.setFont(font);
         
        // create header row
        HSSFRow header = sheet.createRow(0);
         
        header.createCell(0).setCellValue("Book Title");
        header.getCell(0).setCellStyle(style);
         
        header.createCell(1).setCellValue("Author");
        header.getCell(1).setCellStyle(style);
         
        header.createCell(2).setCellValue("ISBN");
        header.getCell(2).setCellStyle(style);
         
        header.createCell(3).setCellValue("Published Date");
        header.getCell(3).setCellStyle(style);
         
        header.createCell(4).setCellValue("Price");
        header.getCell(4).setCellStyle(style);
         
        // create data rows
        int rowCount = 1;
         
//        for (Factura fact : listFactura) {
//            HSSFRow aRow = sheet.createRow(rowCount++);
//            aRow.createCell(0).setCellValue(fact.getIdFactura());
//            aRow.createCell(1).setCellValue(fact.getFechaFactura());
//            aRow.createCell(2).setCellValue(fact.getProveedor().getNombre());
//            aRow.createCell(3).setCellValue(fact.getUuid());
//            aRow.createCell(4).setCellValue(fact.getFechaPago());
//        }
    }
    
}
