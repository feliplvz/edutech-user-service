package com.edutech.userservice.repository;

import com.edutech.userservice.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    List<Student> findByProgram(String program);
    List<Student> findByEducationLevel(String educationLevel);
}
