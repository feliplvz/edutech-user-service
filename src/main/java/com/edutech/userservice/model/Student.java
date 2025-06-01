package com.edutech.userservice.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "students")
@PrimaryKeyJoinColumn(name = "user_id")
public class Student extends User {

    @Column(name = "enrollment_date")
    private LocalDate enrollmentDate;

    @Column(name = "education_level")
    private String educationLevel;

    @Column(name = "program")
    private String program;

    // Constructor que inicializa también los campos de User
    public Student(Long id, String firstName, String lastName, String email,
                  String password, boolean active, LocalDate enrollmentDate,
                  String educationLevel, String program) {
        super();
        this.setId(id);
        this.setFirstName(firstName);
        this.setLastName(lastName);
        this.setEmail(email);
        this.setPassword(password);
        this.setActive(active);
        this.setRole(UserRole.STUDENT);
        this.enrollmentDate = enrollmentDate;
        this.educationLevel = educationLevel;
        this.program = program;
    }
}
