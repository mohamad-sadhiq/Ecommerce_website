package com.ecommerce.controller;

import com.ecommerce.model.User;
import com.ecommerce.service.UserService;
import com.ecommerce.service.CartService;
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

    @Autowired
    private CartService cartService;

    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "redirect", required = false) String redirect, Model model) {
        if (redirect != null && !redirect.isEmpty()) {
            model.addAttribute("redirect", redirect);
        }
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            @RequestParam(value = "redirect", required = false) String redirect,
                            HttpSession session,
                            Model model) {

        User user = userService.loginUser(email, password);

        if (user != null) {
            session.setAttribute("loggedInUser", user);
            session.setAttribute("cart", cartService.getCartDetails(user));

            // If a redirect URL was passed, send them there
            if (redirect != null && !redirect.isEmpty()) {
                return "redirect:" + redirect;
            }

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/";
            }

        } else {
            model.addAttribute("error", "Invalid email or password.");
            if (redirect != null && !redirect.isEmpty()) {
                model.addAttribute("redirect", redirect);
            }
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logoutUser(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}