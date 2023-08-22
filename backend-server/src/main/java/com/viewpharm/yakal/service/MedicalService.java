package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.repository.MedicalRepository;
import com.viewpharm.yakal.type.EMedical;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class MedicalService {

    private final MedicalRepository medicalRepository;
    private static final GeometryFactory geometryFactory = new GeometryFactory();

    public Boolean updateMedical() throws IOException {
        // 엑셀 파일을 읽어들입니다.
        FileInputStream fileInputStream;

        {
            try {
                fileInputStream = new FileInputStream(new File("C:\\workspace\\YakAl\\backend-server\\medical.xlsx"));
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            }
        }

        Workbook workbook;

        {
            try {
                workbook = new XSSFWorkbook(fileInputStream);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        // 병원 삽입
        List<Medical> dataList = new ArrayList<>();
        Sheet sheet1 = workbook.getSheetAt(0);
        for (int i = 1; i <= sheet1.getLastRowNum(); i++) {
            Row row = sheet1.getRow(i);

            String medicalName = getStringCellValue(row, 0, "");
            String medicalAddress = getStringCellValue(row, 1, "");
            String medicalTel = getStringCellValue(row, 2, "");

            double latitude = getNumericCellValue(row, 3, 0.0);
            double longitude = getNumericCellValue(row, 4, 0.0);

            Point medicalPoint = geometryFactory.createPoint(new Coordinate(latitude, longitude));

            Medical data = Medical.builder()
                    .medicalName(medicalName)
                    .medicalAddress(medicalAddress)
                    .medicalTel(medicalTel)
                    .medicalPoint(medicalPoint)
                    .eMedical(EMedical.HOSPITAL)
                    .build();

            dataList.add(data);
        }

// 약국 삽입
        Sheet sheet2 = workbook.getSheetAt(1);
        for (int i = 1; i <= sheet2.getLastRowNum(); i++) {
            Row row = sheet2.getRow(i);

            String medicalName = getStringCellValue(row, 0, "");
            String medicalAddress = getStringCellValue(row, 1, "");
            String medicalTel = getStringCellValue(row, 2, "");

            double latitude = getNumericCellValue(row, 3, 0.0);
            double longitude = getNumericCellValue(row, 4, 0.0);

            Point medicalPoint = geometryFactory.createPoint(new Coordinate(latitude, longitude));

            Medical data = Medical.builder()
                    .medicalName(medicalName)
                    .medicalAddress(medicalAddress)
                    .medicalTel(medicalTel)
                    .medicalPoint(medicalPoint)
                    .eMedical(EMedical.PHARMACY)
                    .build();

            dataList.add(data);
        }

        //db에 저장
        medicalRepository.saveAll(dataList);

        workbook.close();
        return true;
    }

    private String getStringCellValue(Row row, int cellIndex, String defaultValue) {
        Cell cell = row.getCell(cellIndex);
        if (cell != null && cell.getCellType() == CellType.STRING) {
            return cell.getStringCellValue();
        }
        return defaultValue;
    }

    private double getNumericCellValue(Row row, int cellIndex, double defaultValue) {
        Cell cell = row.getCell(cellIndex);
        if (cell != null && cell.getCellType() == CellType.NUMERIC) {
            return cell.getNumericCellValue();
        }
        return defaultValue;
    }


}
