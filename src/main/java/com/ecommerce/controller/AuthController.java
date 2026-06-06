package com.ecommerce.controller;

import com.ecommerce.model.User;
import com.ecommerce.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // Show Login Page: GET /login
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    // Handle Login Submission: POST /login
    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session,
                            Model model) {

        User user = userService.loginUser(email, password);

        if (user != null) {
            // Success! Save user to session
            session.setAttribute("loggedInUser", user);

            // ROLE-BASED REDIRECT
            // Ensure your User model has a getRole() method that returns "ADMIN" or "USER"
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                return "redirect:/admin/dashboard"; // Send admins straight to the backend
            } else {
                return "redirect:/"; // Send regular customers to the luxury storefront
            }

        } else {
            // Fail! Reload login page with an error message
            model.addAttribute("error", "Invalid email or password.");
            return "login";
        }
    }

    // Handle Logout: GET /logout
    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        // Destroy the session
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}