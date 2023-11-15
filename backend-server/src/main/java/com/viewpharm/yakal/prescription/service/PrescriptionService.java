package com.viewpharm.yakal.prescription.service;

import com.viewpharm.yakal.prescription.domain.Dose;
import com.viewpharm.yakal.prescription.domain.DoseName;
import com.viewpharm.yakal.prescription.domain.Prescription;
import com.viewpharm.yakal.prescription.domain.Risk;
import com.viewpharm.yakal.prescription.dto.request.CreateScheduleDto;
import com.viewpharm.yakal.prescription.dto.request.OneMedicineScheduleDto;
import com.viewpharm.yakal.prescription.dto.request.OneScheduleDto;
import com.viewpharm.yakal.prescription.repository.DoseNameRepository;
import com.viewpharm.yakal.prescription.repository.DoseRepository;
import com.viewpharm.yakal.prescription.repository.RiskRepository;
import com.viewpharm.yakal.user.domain.User;
import com.viewpharm.yakal.prescription.dto.request.CreatePrescriptionDto;
import com.viewpharm.yakal.prescription.dto.response.PrescriptionDto;
import com.viewpharm.yakal.base.exception.CommonException;
import com.viewpharm.yakal.base.exception.ErrorCode;
import com.viewpharm.yakal.prescription.repository.PrescriptionRepository;
import com.viewpharm.yakal.user.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class PrescriptionService {

    private final UserRepository userRepository;
    private final PrescriptionRepository prescriptionRepository;
    private final DoseRepository doseRepository;
    private final DoseNameRepository doseNameRepository;
    private final RiskRepository riskRepository;

    public List<PrescriptionDto> getPrescriptions(Long userId){
        userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Prescription> prescriptionList = prescriptionRepository.findByUserId(userId);
        List<PrescriptionDto> prescriptionDtoList =  prescriptionList.stream()
                .map(b-> new PrescriptionDto(b.getId(),b.getPharmacyName(),b.getPrescribedDate().toString(),b.getCreatedDate().toString()))
                .collect(Collectors.toList());

        return prescriptionDtoList;
    }

    public Boolean createPrescription(Long userId, CreatePrescriptionDto prescription){
        User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        prescriptionRepository.save(
                Prescription.builder()
                        .user(user)
                        .pharmacyName(prescription.getPharmacyName())
                        .prescribedDate(prescription.getPrescribedDate())
                        .isAllow(prescription.getIsAllow())
                        .build()
        );

        return true;
    }

    public List<Boolean> createSchedules(final Long userId, final CreateScheduleDto createScheduleDto) {
        final User user = userRepository.findById(userId).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));
        final Prescription prescription = new Prescription(user,"약국이름 입력",LocalDate.now(),true);
        prescriptionRepository.saveAndFlush(prescription);

        final List<Boolean> isInserted = new ArrayList<>();
        final List<Dose> willSave = new ArrayList<>();

        for (final OneMedicineScheduleDto oneMedicineScheduleDto : createScheduleDto.getMedicines()) {
            final String KDCode = oneMedicineScheduleDto.getKDCode();
            final String ATCCode = oneMedicineScheduleDto.getATCCode();

            DoseName doseName = doseNameRepository.findById(KDCode).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_DOSENAME));
            Risk risk = riskRepository.findById(ATCCode).orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_RISK));

            for (final OneScheduleDto oneScheduleDto : oneMedicineScheduleDto.getSchedules()) {

                Boolean isOverlapped = false;
                if (oneScheduleDto.getTime().get(0)) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistMorningTrue(userId, doseName, oneScheduleDto.getDate());
                }
                if (oneScheduleDto.getTime().get(1) && !isOverlapped) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistAfternoonTrue(userId, doseName, oneScheduleDto.getDate());
                }
                if (oneScheduleDto.getTime().get(2) && !isOverlapped) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistEveningTrue(userId, doseName, oneScheduleDto.getDate());
                }
                if (oneScheduleDto.getTime().get(3) && !isOverlapped) {
                    isOverlapped = doseRepository.existsByUserIdAndKDCodeAndDateAndExistDefaultTrue(userId, doseName, oneScheduleDto.getDate());
                }
                isInserted.add(!isOverlapped);

                if (!isOverlapped) {

                    final Dose dose = Dose.builder()
                            .KDCode(doseName)
                            .ATCCode(risk)
                            .date(oneScheduleDto.getDate())
                            .pillCnt(oneScheduleDto.getCount().longValue())
                            .isHalf(oneScheduleDto.getCount().toString().endsWith(".5"))
                            .prescription(prescription)
                            .user(user)
                            .existMorning(oneScheduleDto.getTime().get(0))
                            .existAfternoon(oneScheduleDto.getTime().get(1))
                            .existEvening(oneScheduleDto.getTime().get(2))
                            .existDefault(oneScheduleDto.getTime().get(3))
                            .build();

                    willSave.add(dose);
                }

            }
        }

        doseRepository.saveAll(willSave);

        return isInserted;
    }
}
