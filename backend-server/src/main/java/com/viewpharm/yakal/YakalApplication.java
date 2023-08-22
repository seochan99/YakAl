package com.viewpharm.yakal;

import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
//@EnableSchedulerLock(defaultLockAtMostFor = "PT30S")
public class YakalApplication {

    public static void main(String[] args) {
        SpringApplication.run(YakalApplication.class, args);
    }
}
