package com.ecommerce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // This opens index.jsp
    @GetMapping("/")
    public String index() {
        return "index";
    }

    // This opens login.jsp
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // This opens register.jsp
    @GetMapping("/register")
    public String register() {
        return "register";
    }

    // This opens home.jsp
    @GetMapping("/home")
    public String home() {
        return "home";
    }
}