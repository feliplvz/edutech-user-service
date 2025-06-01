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
@Table(name = "administrators")
@PrimaryKeyJoinColumn(name = "user_id")
public class Administrator extends User {

    @Column(name = "hire_date")
    private LocalDate hireDate;

    @Column(name = "department")
    private String department;

    @Column(name = "position")
    private String position;

    @Column(name = "access_level")
    private Integer accessLevel;

    // Constructor que inicializa también los campos de User
    public Administrator(Long id, String firstName, String lastName, String email,
                        String password, boolean active, LocalDate hireDate,
                        String department, String position, Integer accessLevel) {
        super();
        this.setId(id);
        this.setFirstName(firstName);
        this.setLastName(lastName);
        this.setEmail(email);
        this.setPassword(password);
        this.setActive(active);
        this.setRole(UserRole.ADMIN);
        this.hireDate = hireDate;
        this.department = department;
        this.position = position;
        this.accessLevel = accessLevel;
    }
}
