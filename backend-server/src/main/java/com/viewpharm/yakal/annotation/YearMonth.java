package com.viewpharm.yakal.annotation;

import com.viewpharm.yakal.validator.YearMonthValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.PARAMETER, ElementType.FIELD})
@Constraint(validatedBy = {YearMonthValidator.class})
public @interface YearMonth {
    String message() default "Invalid YearMonth Format. (yyyy-MM)";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
