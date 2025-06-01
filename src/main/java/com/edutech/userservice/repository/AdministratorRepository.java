package com.edutech.userservice.repository;

import com.edutech.userservice.model.Administrator;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AdministratorRepository extends JpaRepository<Administrator, Long> {
    List<Administrator> findByDepartment(String department);
    List<Administrator> findByAccessLevelGreaterThanEqual(Integer accessLevel);
}
