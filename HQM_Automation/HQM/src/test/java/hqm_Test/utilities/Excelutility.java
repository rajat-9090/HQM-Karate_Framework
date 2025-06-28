package hqm_Test.utilities;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

public class Excelutility {

    public FileInputStream fip;
    public FileOutputStream fop;
    public XSSFWorkbook workbook;
    public XSSFSheet sheet;
    public XSSFRow row;
    public XSSFCell cell;
    String path;

    public Excelutility(String path) {

        this.path=path;
    }


    public int getRowCount(String sheetName) throws Exception {

        fip= new FileInputStream(path);
        workbook= new XSSFWorkbook(fip);
        sheet= workbook.getSheet(sheetName);
        int rowcount= sheet.getLastRowNum();
        workbook.close();
        fip.close();
        return rowcount;

    }


    public int getCellCount(String sheetName, int rownum) throws Exception {

        fip= new FileInputStream(path);
        workbook= new XSSFWorkbook(fip);
        sheet= workbook.getSheet(sheetName);
        row= sheet.getRow(rownum);
        int cellcount= row.getLastCellNum();
        workbook.close();
        fip.close();
        return cellcount;
    }


    public String getCellData(String sheetName, int rownum, int column) throws Exception {

        fip= new FileInputStream(path);
        workbook= new XSSFWorkbook(fip);
        sheet= workbook.getSheet(sheetName);
        row= sheet.getRow(rownum);
        cell=row.getCell(column);

        DataFormatter formatter= new DataFormatter();
        String data;
        try {

            data=formatter.formatCellValue(cell);

        }catch (Exception e) {

            data="";
        }

        workbook.close();
        fip.close();
        return data;
    }



    public void setCellData(String sheetName, int rownum, String columnName, String data) throws Exception {

        File xlfile = new File(path);

        // Check if the file exists, if not create a new workbook and file
        if (!xlfile.exists()) {
            workbook = new XSSFWorkbook();
            fop = new FileOutputStream(path);
            workbook.write(fop);
            fop.close();  // Always close the output stream after writing
        }

        // Open the existing Excel file
        fip = new FileInputStream(path);
        workbook = new XSSFWorkbook(fip);

        // If the sheet doesn't exist, create it
        if (workbook.getSheetIndex(sheetName) == -1) {
            workbook.createSheet(sheetName);
        }

        sheet = workbook.getSheet(sheetName);

        // Get the header row (first row) or create it if it doesn't exist
        Row headerRow = sheet.getRow(0);
        if (headerRow == null) {
            headerRow = sheet.createRow(0);
        }

        // Find the column index for the given column name
        int colIndex = -1;
        for (int i = 0; i < headerRow.getLastCellNum(); i++) {
            Cell cell = headerRow.getCell(i);
            if (cell != null && cell.getStringCellValue().trim().equalsIgnoreCase(columnName.trim())) {
                colIndex = i;  // Found the column index
                break;
            }
        }

        // If the column name doesn't exist, create a new column for it
        if (colIndex == -1) {
            colIndex = headerRow.getLastCellNum();

            if (colIndex == -1) {  // If no cells exist in the row, start with column 0
                colIndex = 0;
            }
            headerRow.createCell(colIndex).setCellValue(columnName);
        }

        // Check if the row exists, if not create it
        row = sheet.getRow(rownum);
        if (row == null) {
            row = sheet.createRow(rownum);
        }

        // Create the cell and set its value
        cell = row.createCell(colIndex);
        cell.setCellValue(data);

        // Write the data back to the Excel file
        fop = new FileOutputStream(path);
        workbook.write(fop);

        // Close resources
        workbook.close();
        fip.close();
        fop.close();
    }

}
