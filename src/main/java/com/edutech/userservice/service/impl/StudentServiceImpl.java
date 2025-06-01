package com.edutech.userservice.service.impl;

import com.edutech.userservice.dto.UserRegistrationDTO;
import com.edutech.userservice.exception.ResourceNotFoundException;
import com.edutech.userservice.model.Student;
import com.edutech.userservice.model.UserRole;
import com.edutech.userservice.repository.StudentRepository;
import com.edutech.userservice.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    private final StudentRepository studentRepository;

    @Autowired
    public StudentServiceImpl(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    @Override
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    @Override
    public Student getStudentById(Long id) {
        return studentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Estudiante", "id", id));
    }

    @Override
    public Student createStudent(UserRegistrationDTO registrationDTO, String program, String educationLevel) {
        Student student = new Student();
        student.setFirstName(registrationDTO.getFirstName());
        student.setLastName(registrationDTO.getLastName());
        student.setEmail(registrationDTO.getEmail());
        student.setPassword(registrationDTO.getPassword()); // En un caso real, hashearíamos la contraseña
        student.setRole(UserRole.STUDENT);
        student.setActive(true);
        student.setEnrollmentDate(LocalDate.now());
        student.setProgram(program);
        student.setEducationLevel(educationLevel);

        return studentRepository.save(student);
    }

    @Override
    public Student updateStudent(Long id, Student studentDetails) {
        Student student = getStudentById(id);

        student.setFirstName(studentDetails.getFirstName());
        student.setLastName(studentDetails.getLastName());
        student.setEmail(studentDetails.getEmail());
        student.setActive(studentDetails.isActive());
        student.setProgram(studentDetails.getProgram());
        student.setEducationLevel(studentDetails.getEducationLevel());

        return studentRepository.save(student);
    }

    @Override
    public void deleteStudent(Long id) {
        Student student = getStudentById(id);

        // Soft delete
        student.setActive(false);
        studentRepository.save(student);

        // Hard delete
        // studentRepository.delete(student);
    }

    @Override
    public List<Student> getStudentsByProgram(String program) {
        return studentRepository.findByProgram(program);
    }

    @Override
    public List<Student> getStudentsByEducationLevel(String educationLevel) {
        return studentRepository.findByEducationLevel(educationLevel);
    }
}
