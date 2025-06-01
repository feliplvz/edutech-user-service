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
@Table(name = "instructors")
@PrimaryKeyJoinColumn(name = "user_id")
public class Instructor extends User {

    @Column(name = "hire_date")
    private LocalDate hireDate;

    @Column(name = "specialization")
    private String specialization;

    @Column(name = "biography", columnDefinition = "TEXT")
    private String biography;

    @Column(name = "years_experience")
    private Integer yearsExperience;

    // Constructor que inicializa también los campos de User
    public Instructor(Long id, String firstName, String lastName, String email,
                     String password, boolean active, LocalDate hireDate,
                     String specialization, String biography, Integer yearsExperience) {
        super();
        this.setId(id);
        this.setFirstName(firstName);
        this.setLastName(lastName);
        this.setEmail(email);
        this.setPassword(password);
        this.setActive(active);
        this.setRole(UserRole.INSTRUCTOR);
        this.hireDate = hireDate;
        this.specialization = specialization;
        this.biography = biography;
        this.yearsExperience = yearsExperience;
    }
}
