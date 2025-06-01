package com.edutech.userservice.controller;

import com.edutech.userservice.dto.UserRegistrationDTO;
import com.edutech.userservice.model.Student;
import com.edutech.userservice.service.StudentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {

    private final StudentService studentService;

    @Autowired
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping
    public ResponseEntity<List<Student>> getAllStudents() {
        return ResponseEntity.ok(studentService.getAllStudents());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Student> getStudentById(@PathVariable Long id) {
        return ResponseEntity.ok(studentService.getStudentById(id));
    }

    @PostMapping
    public ResponseEntity<Student> createStudent(
            @Valid @RequestBody UserRegistrationDTO registrationDTO,
            @RequestParam String program,
            @RequestParam String educationLevel) {

        Student createdStudent = studentService.createStudent(registrationDTO, program, educationLevel);
        return new ResponseEntity<>(createdStudent, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Student> updateStudent(
            @PathVariable Long id,
            @Valid @RequestBody Student student) {

        return ResponseEntity.ok(studentService.updateStudent(id, student));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStudent(@PathVariable Long id) {
        studentService.deleteStudent(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/program/{program}")
    public ResponseEntity<List<Student>> getStudentsByProgram(@PathVariable String program) {
        return ResponseEntity.ok(studentService.getStudentsByProgram(program));
    }

    @GetMapping("/level/{educationLevel}")
    public ResponseEntity<List<Student>> getStudentsByEducationLevel(@PathVariable String educationLevel) {
        return ResponseEntity.ok(studentService.getStudentsByEducationLevel(educationLevel));
    }
}
