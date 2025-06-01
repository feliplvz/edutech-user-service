package com.edutech.userservice.repository;

import com.edutech.userservice.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InstructorRepository extends JpaRepository<Instructor, Long> {
    List<Instructor> findBySpecialization(String specialization);
    List<Instructor> findByYearsExperienceGreaterThanEqual(Integer years);
}
