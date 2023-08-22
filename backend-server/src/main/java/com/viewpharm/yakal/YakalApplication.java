package com.viewpharm.yakal;

import net.javacrumbs.shedlock.spring.annotation.EnableSchedulerLock;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
<<<<<<< HEAD
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
=======
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
>>>>>>> 2af2daa8c226f82663e9fe0407a23112d935821a
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
<<<<<<< HEAD
@EnableJpaAuditing
@SpringBootApplication
=======
@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
>>>>>>> 2af2daa8c226f82663e9fe0407a23112d935821a
//@EnableSchedulerLock(defaultLockAtMostFor = "PT30S")
public class YakalApplication {

    public static void main(String[] args) {
        SpringApplication.run(YakalApplication.class, args);
    }
}
