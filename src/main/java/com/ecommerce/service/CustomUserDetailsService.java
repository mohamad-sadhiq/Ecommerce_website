package com.ecommerce.service;

import com.ecommerce.model.User;
import com.ecommerce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    // Helper method to fetch the raw User entity for our session
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElse(null);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + email));

        // THE FIX: Spring's .roles() method automatically adds "ROLE_".
        // If our database value already has it, we must strip it off first!
        String cleanRole = user.getRole();
        if (cleanRole != null && cleanRole.startsWith("ROLE_")) {
            cleanRole = cleanRole.substring(5); // Removes the "ROLE_" part
        }

        // Converts our DB User into a Spring Security User
        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPassword())
                .roles(cleanRole) // Now passing just "CUSTOMER" or "ADMIN"
                .build();
    }
}