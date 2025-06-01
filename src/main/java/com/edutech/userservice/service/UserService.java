package com.edutech.userservice.service;

import com.edutech.userservice.dto.UserDTO;
import com.edutech.userservice.dto.UserRegistrationDTO;
import com.edutech.userservice.model.User;
import com.edutech.userservice.model.UserRole;

import java.util.List;

public interface UserService {
    List<UserDTO> getAllUsers();
    UserDTO getUserById(Long id);
    UserDTO getUserByEmail(String email);
    UserDTO createUser(UserRegistrationDTO registrationDTO, UserRole role);
    UserDTO updateUser(Long id, UserDTO userDTO);
    void deleteUser(Long id);
    boolean existsByEmail(String email);
}
