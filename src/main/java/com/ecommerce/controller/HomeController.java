package com.ecommerce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // Handles the root URL: GET /
    @GetMapping("/")
    public String showIndexPage() {
        return "index"; // Maps to index.jsp (Your beautiful luxury storefront)
    }

}