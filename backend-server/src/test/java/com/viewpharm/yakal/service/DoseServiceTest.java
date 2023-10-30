package com.viewpharm.yakal.service;

import com.viewpharm.yakal.dto.request.OneMedicineScheduleDto;
import com.viewpharm.yakal.dto.request.OneScheduleDto;
import com.viewpharm.yakal.repository.DoseRepository;
import com.viewpharm.yakal.base.type.EDosingTime;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@ExtendWith(MockitoExtension.class)
class DoseServiceTest {

    @InjectMocks
    private DoseService doseService;

    @Mock
    DoseRepository doseRepository;

    @Test
    void getOneDaySchedule() {
        Long userId = 1L;
        LocalDate date = LocalDate.now();

        List<OneScheduleDto> aSchedules = new ArrayList<>();
        OneScheduleDto aMorning = new OneScheduleDto(LocalDate.of(2023,07,12), EDosingTime.MORNING,1.0);
        OneScheduleDto aAfternoon= new OneScheduleDto(LocalDate.of(2023,07,12), EDosingTime.MORNING,1.0);
        OneScheduleDto aEvening = new OneScheduleDto(LocalDate.of(2023,07,12), EDosingTime.EVENING,1.0);
        OneScheduleDto aDefault = new OneScheduleDto(LocalDate.of(2023,07,12), EDosingTime.DEFAULT,1.0);
        aSchedules.add(aMorning);
        aSchedules.add(aAfternoon);
        aSchedules.add(aEvening);
        aSchedules.add(aDefault);

        OneMedicineScheduleDto A = new OneMedicineScheduleDto("KD1","ATC1",aSchedules);










    }

    @Test
    void getOneDayProgressOrNull() {
    }

    @Test
    void getOneWeekSummary() {
    }

    @Test
    void getOneMonthSummary() {
    }

    @Test
    void updateDoseCount() {
    }

    @Test
    void updateIsTakenByTime() {
    }

    @Test
    void updateIsTakenById() {
    }

    @Test
    void createSchedule() {
        //given

    }

    @Test
    void deleteSchedule() {
    }
}