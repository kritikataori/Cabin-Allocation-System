package com.yash.cabinallotment.util;

import com.yash.cabinallotment.domain.Allocations;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class ExcelGenerator {

    public static ByteArrayOutputStream generateCurrentAllocationsExcel(List<Allocations> allocations) throws IOException {
        System.out.println("Excel generator reached");

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Current Allocations");

        // Create Header Row
        Row headerRow = sheet.createRow(0);
        String[] headers = {"Allocation ID", "Request ID", "Employee Name", "Cabin Name", "Date", "Start Time", "End Time"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // Create Data Rows
        int rowNum = 1;
        for (Allocations allocation : allocations) {
            try {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(allocation.getId());
                row.createCell(1).setCellValue(allocation.getRequestId());
                row.createCell(2).setCellValue(allocation.getEmployeeName());
                row.createCell(3).setCellValue(allocation.getCabinName());
                row.createCell(4).setCellValue(allocation.getRequestDate().toString());
                row.createCell(5).setCellValue(allocation.getStartTime().toString());
                row.createCell(6).setCellValue(allocation.getEndTime().toString());
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception
            }
        }

        // Write to ByteArrayOutputStream
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream;
    }

    public static ByteArrayOutputStream generateAllocationHistoryExcel(List<Allocations> allocations) throws IOException {
        System.out.println("Excel generator reached");
        System.out.println(allocations.size());
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Allocation History");

        // Create Header Row
        Row headerRow = sheet.createRow(0);
        String[] headers = {"Allocation ID", "Request ID", "Employee Name", "Cabin Name", "Assigned Cabin Name", "Date", "Start Time", "End Time"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        // Create Data Rows
        int rowNum = 1;
        for (Allocations allocation : allocations) {
            try {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(allocation.getId());
                row.createCell(1).setCellValue(allocation.getRequestId());
                row.createCell(2).setCellValue(allocation.getEmployeeName());
                row.createCell(3).setCellValue(allocation.getCabinName());
                row.createCell(4).setCellValue(allocation.getAssignedCabinName() != null ? allocation.getAssignedCabinName() : "");
                row.createCell(5).setCellValue(allocation.getRequestDate() != null ? allocation.getRequestDate().toString() : "");
                row.createCell(6).setCellValue(allocation.getStartTime() != null ? allocation.getStartTime().toString() : "");
                row.createCell(7).setCellValue(allocation.getEndTime() != null ? allocation.getEndTime().toString() : "");
            } catch (Exception e) {
                e.printStackTrace(); // Log the exception
            }
        }

        // Write to ByteArrayOutputStream
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        return outputStream;
    }
}