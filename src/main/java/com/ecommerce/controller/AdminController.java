package com.ecommerce.controller;

import com.ecommerce.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    // Helper method to verify admin access
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        return user != null && "ADMIN".equalsIgnoreCase(user.getRole());
    }

    // === YOUR TERRITORY (MEMBER 2) ===

    @GetMapping("/admin/dashboard")
    public String showAdminDashboard(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/dashboard"; // Serves your main dashboard file
    }

    @GetMapping("/admin/products")
    public String showAdminProducts(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "redirect:/products"; // Sends traffic to your ProductController
    }

    @GetMapping("/admin/categories")
    public String showAdminCategories(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "redirect:/categories"; // Sends traffic to your CategoryController
    }

    // === PLACEHOLDERS FOR TEAMMATES (Prevents 404s) ===

    // ... (Keep the top half with products and categories exactly the same) ...

    // === ADMIN UI VIEWS FOR TEAMMATES ===

    @GetMapping("/admin/orders")
    public String showAdminOrders(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/orders"; // Serves your new Order UI
    }

    @GetMapping("/admin/users")
    public String showAdminUsers(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/users"; // Serves your new Customer UI
    }

    @GetMapping("/admin/media")
    public String showAdminMedia(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/media";
    }

    @GetMapping("/admin/settings")
    public String showAdminSettings(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/settings";
    }
}
