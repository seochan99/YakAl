package com.viewpharm.yakal.validator;

import com.viewpharm.yakal.annotation.Date;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class DateValidator implements ConstraintValidator<Date, String> {

    @Override
    public void initialize(Date constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null || value.length() == 0) {
            return false;
        }

        try {
            LocalDate.parse(value, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch(DateTimeParseException e) {
            return false;
        }

        return true;
    }
}
