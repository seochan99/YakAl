package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.domain.Notification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    Optional<Notification> findByIdAndUserId(Long notificationId, Long userId);

    Page<Notification> findByUserAndStatus(User user, Pageable pageable, Boolean status);

    @Query(value = "SELECT DATE_FORMAT(create_date,'%H:00') as CDate, COUNT(create_date) as Count " +
            "FROM notifications " +
            "WHERE DATE_FORMAT(create_date,'%Y-%m-%d') = :date " +
            "GROUP BY CDate ORDER BY CDate DESC", nativeQuery = true)
    List<timeInformation> getDateAndCountForHour(@Param("date") LocalDate date);

    interface timeInformation {
        String getCDate();

        Long getCount();

    }
}
