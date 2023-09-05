package com.viewpharm.yakal.service;

import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.domain.Registration;
import com.viewpharm.yakal.dto.PointDto;
import com.viewpharm.yakal.dto.request.UpdateAdminRequestDto;
import com.viewpharm.yakal.dto.response.MedicalDto;
import com.viewpharm.yakal.exception.CommonException;
import com.viewpharm.yakal.exception.ErrorCode;
import com.viewpharm.yakal.repository.MedicalRepository;
import com.viewpharm.yakal.repository.RegistrationRepository;
import com.viewpharm.yakal.type.EMedical;
import com.viewpharm.yakal.type.EPeriod;
import com.viewpharm.yakal.utils.GeometryUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.locationtech.jts.geom.Point;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class MedicalService {

    private final MedicalRepository medicalRepository;
    private final RegistrationRepository registrationRepository;
    private final GeometryUtil geometryUtil;
    private final ImageService imageService;
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

            Point medicalPoint = geometryUtil.getLatLng2Point(latitude,longitude);

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

            Point medicalPoint = geometryUtil.getLatLng2Point(latitude,longitude);

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
    public Boolean updateRegister(Long medicalId, UpdateAdminRequestDto updateAdminRequestDto){
        Medical medical = medicalRepository.findById(medicalId).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_MEDICAL));
        Registration registration = registrationRepository.findById(updateAdminRequestDto.getRegistrationId()).orElseThrow(()-> new CommonException(ErrorCode.NOT_FOUND_REGISTRATION));

        //이미지 삭제
        imageService.removeImage(registration.getImage());
        //등록
        medical.setRegister(updateAdminRequestDto.getIsAllow());

        return Boolean.TRUE;
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

    private List<MedicalDto> convertMedicalListToDtoList(List<Medical> medicalList) {
        List<MedicalDto> result = new ArrayList<>();

        for (Medical medical : medicalList) {
            result.add(
                    MedicalDto.builder()
                            .medicalName(medical.getMedicalName())
                            .medicalAddress(medical.getMedicalAddress())
                            .medicalPoint(new PointDto(medical.getMedicalPoint().getX(),medical.getMedicalPoint().getY()))
                            .medicalTel(medical.getMedicalTel())
                            .eMedical(medical.getEMedical())
                            .build()
            );
        }

        return result;
    }

    public List<MedicalDto> findNearestMedicalsByPoint(Point point) {
        List<Medical> medicals = medicalRepository.findNearestMedicalsByPoint(point);
        return convertMedicalListToDtoList(medicals);
    }

    public List<MedicalDto> findNearestMedicalsByPointAndEMedical(Point point, String eMedical) {
        List<Medical> medicals = medicalRepository.findNearestMedicalsByPointAndEMedical(point, eMedical);
        return convertMedicalListToDtoList(medicals);
    }

    public List<MedicalDto> findNearbyMedicalsByDistance(Point point, double distance) {
        List<Medical> medicals = medicalRepository.findNearbyMedicalsByDistance(point, distance);
        return convertMedicalListToDtoList(medicals);
    }

    public List<MedicalDto> findNearbyMedicalsByDistanceAndEMedical(Point point, double distance, String eMedical) {
        List<Medical> medicals = medicalRepository.findNearbyMedicalsByDistanceAndEMedical(point, distance, eMedical);
        return convertMedicalListToDtoList(medicals);
    }

    public List<MedicalDto> getAllByRegister(Long pageIndex, Long pageSize, EMedical eMedical){
        Pageable pageable = PageRequest.of(pageIndex.intValue(), pageSize.intValue());
        Page<Medical> medicals = medicalRepository.findAllByRegisterTrueAndEMedical(pageable,eMedical);
        List<MedicalDto> medicalDtoList = medicals.stream()
                .map(b -> new MedicalDto(b.getId(),b.getMedicalName(),b.getMedicalAddress()
                ,b.getMedicalTel(),new PointDto(b.getMedicalPoint().getX(),b.getMedicalPoint().getY())
                        ,b.getEMedical(),b.isRegister()))
                .collect(Collectors.toList());


        return medicalDtoList;
    }

    public List<MedicalDto> getByName(final String name){
        List<Medical> medicals = medicalRepository.findByMedicalName(name);
        List<MedicalDto> medicalDtoList = new ArrayList<>();
        for (Medical m: medicals
             ) {
            medicalDtoList.add(
                    MedicalDto.builder()
                            .id(m.getId())
                            .medicalName(m.getMedicalName())
                            .medicalAddress(m.getMedicalAddress())
                            .medicalTel(m.getMedicalTel())
                            .isRegister(m.isRegister())
                            .build()
            );
        }
        return medicalDtoList;
    }




}
