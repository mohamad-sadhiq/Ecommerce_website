package com.ecommerce.controller;

import com.ecommerce.model.User;
import com.ecommerce.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    // --- LOGIN ---
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "redirect", required = false) String redirect, Model model) {
        if (redirect != null && !redirect.isEmpty()) {
            model.addAttribute("redirect", redirect);
        }
        return "login";
    }

    // NOTE: We DO NOT write a @PostMapping("/login") anymore!
    // Spring Security intercepts the form submission automatically via SecurityConfig.

    // --- REGISTRATION ---
    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, RedirectAttributes redirectAttributes, Model model) {
        try {
            userService.registerUser(user);
            // Send them back to login page with a success flag
            redirectAttributes.addAttribute("registered", "true");
            return "redirect:/login";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }

    // --- LOGOUT ---
    // (Spring Security also handles POST /logout automatically, but this helps catch GET requests gracefully)
    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}