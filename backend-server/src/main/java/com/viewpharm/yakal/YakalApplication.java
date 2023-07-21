package com.viewpharm.yakal;

import jakarta.annotation.PostConstruct;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.TimeZone;

@SpringBootApplication
public class YakalApplication {

    public static void main(String[] args) {
        SpringApplication.run(YakalApplication.class, args);
    }

    @PostConstruct
    public void started() {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
    }
}
