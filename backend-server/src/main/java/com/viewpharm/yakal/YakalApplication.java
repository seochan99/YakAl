package com.viewpharm.yakal;

import jakarta.annotation.PostConstruct;
import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.util.TimeZone;
@EnableScheduling
@SpringBootApplication
//@EnableSchedulerLock(defaultLockAtMostFor = "PT30S")
public class YakalApplication {

    public static void main(String[] args) {
        SpringApplication.run(YakalApplication.class, args);
    }
}
