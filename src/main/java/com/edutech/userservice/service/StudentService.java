package com.edutech.userservice.service;

import com.edutech.userservice.dto.UserRegistrationDTO;
import com.edutech.userservice.model.Student;

import java.util.List;

public interface StudentService {
    List<Student> getAllStudents();
    Student getStudentById(Long id);
    Student createStudent(UserRegistrationDTO registrationDTO, String program, String educationLevel);
    Student updateStudent(Long id, Student student);
    void deleteStudent(Long id);
    List<Student> getStudentsByProgram(String program);
    List<Student> getStudentsByEducationLevel(String educationLevel);
}
