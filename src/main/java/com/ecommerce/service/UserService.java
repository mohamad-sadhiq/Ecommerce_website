package com.ecommerce.service;

import com.ecommerce.model.User;
import com.ecommerce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // 1. Register a new user
    public User registerUser(User user) {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new RuntimeException("An account with this email already exists.");
        }

        // Default new users to Customer role if not specified
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("ROLE_CUSTOMER");
        }

        return userRepository.save(user);
    }

    // 2. Login a user
    public User loginUser(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    // 3. Get User Profile
    public User getUserProfile(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    // 4. Update User Profile
    public User updateUserProfile(Long id, User updatedDetails) {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));

        existingUser.setFullName(updatedDetails.getFullName());
        existingUser.setAddress(updatedDetails.getAddress());
        existingUser.setPhoneNumber(updatedDetails.getPhoneNumber());

        return userRepository.save(existingUser);
    }

    // 5. Get all users for admin page
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}