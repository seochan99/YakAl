package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Medical;
import com.viewpharm.yakal.type.EMedical;
import org.locationtech.jts.geom.Point;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MedicalRepository extends JpaRepository<Medical ,Long> {

    // 내 좌표를 기준으로 가장 가까운 10개의 의료기관을 뽑는다.
    @Query(value = "SELECT *, ST_Distance_Sphere(m.medical_point, :point) AS distance " +
            "FROM medicals m " +
            "ORDER BY distance " +
            "LIMIT 10", nativeQuery = true)
    List<Medical> findNearestMedicalsByPoint(Point point);

    // 내 좌표를 기준으로 가장 가까운 10개의 병원 혹은 약국을 뽑는다.
    @Query(value = "SELECT *, ST_Distance_Sphere(m.medical_point, :point) AS distance " +
            "FROM medicals m " +
            "WHERE m.e_medical = :eMedical " +
            "ORDER BY distance " +
            "LIMIT 10", nativeQuery = true)
    List<Medical> findNearestMedicalsByPointAndEMedical(Point point, String eMedical);

    // 일정 거리 안에 있는 의료기관을 뽑는다.

    @Query(value = "SELECT *, " +
            "ST_Distance_Sphere(m.medical_point, :point) AS distance " +
            "FROM ( " +
            "    SELECT * " +
            "    FROM medicals " +
            "    WHERE ST_Distance_Sphere(medical_point, :point) <= :distance " +
            ") AS m " +
            "ORDER BY distance", nativeQuery = true)
    List<Medical> findNearbyMedicalsByDistance(Point point,double distance);

    // // 일정 거리 안에 있는 병원 혹은 약국을 뽑는다.

    @Query(value = "SELECT *, " +
            "ST_Distance_Sphere(m.medical_point, :point) AS distance " +
            "FROM ( " +
            "    SELECT * " +
            "    FROM medicals " +
            "    WHERE ST_Distance_Sphere(medical_point, :point) <= :distance" +
            ") AS m " +
            "WHERE m.e_medical = :eMedical " +
            "ORDER BY distance", nativeQuery = true)
    List<Medical> findNearbyMedicalsByDistanceAndEMedical(Point point,double distance,String eMedical);


}
