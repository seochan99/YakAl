package com.viewpharm.yakal.service;

import com.viewpharm.yakal.dto.response.LoginLogListDto;
import com.viewpharm.yakal.dto.response.LoginLogListForMonthDto;
import com.viewpharm.yakal.repository.LoginLogRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class LoginLogService {
    private final LoginLogRepository loginLogRepository;

    //하루 이용자 수
    public List<LoginLogListDto> getUserOneDayForWeek(LocalDate date) {
        LocalDate startOfWeek = date.minusDays(6);
        LocalDate endOfWeek = date;

        log.info(startOfWeek.toString());
        log.info(endOfWeek.toString());

        List<LoginLogRepository.oneDayInformation> listDtos = loginLogRepository.getLoginTimeAndCountForDay(startOfWeek, endOfWeek);

        List<LoginLogListDto> list = listDtos.stream()
                .map(l -> new LoginLogListDto(l.getLoginTime(), l.getCount()))
                .collect(Collectors.toList());

        return list;
    }

    public List<LoginLogListDto> getUserOneDayForMonth(YearMonth yearMonth) {

        LocalDate startOfMonth = yearMonth.atDay(1);
        LocalDate endOfMonth = yearMonth.atEndOfMonth();

        List<LoginLogRepository.oneDayInformation> listDtos = loginLogRepository.getLoginTimeAndCountForDay(startOfMonth, endOfMonth);

        List<LoginLogListDto> list = listDtos.stream()
                .map(l -> new LoginLogListDto(l.getLoginTime(), l.getCount()))
                .collect(Collectors.toList());

        return list;
    }

    public List<LoginLogListForMonthDto> getUserOneMonthForSixMonth(YearMonth yearMonth) {
        YearMonth startOfMonth = yearMonth.minusMonths(5);
        YearMonth endOfMonth = yearMonth;

        LocalDate startDay = startOfMonth.atDay(1);
        LocalDate endDay = endOfMonth.atEndOfMonth();

        List<LoginLogRepository.oneMonthInformation> listDtos = loginLogRepository.getLoginTimeAndCountForMonth(startDay, endDay);

        List<LoginLogListForMonthDto> list = listDtos.stream()
                .map(l -> new LoginLogListForMonthDto(l.getLoginTime(), l.getCount()))
                .collect(Collectors.toList());
        return list;
    }

    public List<LoginLogListForMonthDto> getUserOneMonthForYear(YearMonth yearMonth) {
        YearMonth startOfMonth = yearMonth.minusMonths(11);
        YearMonth endOfMonth = yearMonth;

        LocalDate startDay = startOfMonth.atDay(1);
        LocalDate endDay = endOfMonth.atEndOfMonth();

        List<LoginLogRepository.oneMonthInformation> listDtos = loginLogRepository.getLoginTimeAndCountForMonth(startDay, endDay);

        List<LoginLogListForMonthDto> list = listDtos.stream()
                .map(l -> new LoginLogListForMonthDto(l.getLoginTime(), l.getCount()))
                .collect(Collectors.toList());
        return list;
    }
}
