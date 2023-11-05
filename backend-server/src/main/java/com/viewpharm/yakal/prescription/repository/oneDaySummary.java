package com.viewpharm.yakal.prescription.repository;

import java.time.LocalDate;

public interface oneDaySummary {

    Long getTotal();

    Long getTake();

    LocalDate getDate();
}
