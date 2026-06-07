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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // Show Registration Page: GET /register
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register"; // Maps to register.jsp
    }

    // Handle Registration Submission: POST /register
    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, Model model) {
        try {
            userService.registerUser(user);
            return "redirect:/login?registered=true";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }

    // Show Profile Page: GET /profile
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        // Check if user is actually logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // Fetch fresh data from DB in case it was updated
        User freshUserData = userService.getUserProfile(loggedInUser.getId());
        model.addAttribute("user", freshUserData);
        return "users/profile"; // Maps to users/profile.jsp
    }

    // Handle Profile Update: POST /profile/update
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute User updatedUser,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        // Update in database
        User savedUser = userService.updateUserProfile(loggedInUser.getId(), updatedUser);

        // Update the session with the new data
        session.setAttribute("loggedInUser", savedUser);

        // Add a success message that survives the redirect
        redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
        return "redirect:/profile";
    }
}