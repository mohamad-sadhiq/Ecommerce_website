package com.ecommerce.controller;

import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.OrderService;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.UserService;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminController {

    @Autowired
    private UserService userService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ProductRepository productRepository;

    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        return user != null && "ADMIN".equalsIgnoreCase(user.getRole());
    }

    // ==========================================
    // DASHBOARD & USERS
    // ==========================================

    @GetMapping("/admin/dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalProducts", productRepository.count());
        model.addAttribute("totalOrders", 34); // Mock data for now
        model.addAttribute("totalRevenue", "14,25,000"); // Mock data for now

        return "admin/dashboard";
    }

    @GetMapping("/admin/users")
    public String showAdminUsers(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }

    // ==========================================
    // ORDER MANAGEMENT
    // ==========================================

    @GetMapping("/admin/orders")
    public String showAdminOrders(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin/orders";
    }

    @PostMapping("/admin/orders/update-status/{orderId}")
    public String updateOrderStatusAdmin(@PathVariable("orderId") Long orderId, @RequestParam("status") String status, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        orderService.updateOrderStatus(orderId, status);
        return "redirect:/admin/orders";
    }

    // ==========================================
    // INVENTORY MANAGEMENT (Products & Categories)
    // ==========================================

    @GetMapping("/admin/products")
    public String showAdminProducts(HttpSession session, Model model, @RequestParam(defaultValue = "0") int page) {
        if (!isAdmin(session)) return "redirect:/login";
        Page<Product> productPage = productService.getAllProducts(PageRequest.of(page, 50));
        model.addAttribute("products", productPage.getContent());
        return "products/product-list"; // Routes to the products folder
    }

    @GetMapping("/admin/products/view/{id}")
    public String viewProductAdminDetails(@PathVariable Long id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("product", productService.getProductById(id));
        return "products/product-details";
    }

    // THIS IS THE METHOD THAT WAS MISSING!
    @GetMapping("/admin/products/add")
    public String showAddProductForm(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.getAllCategories());
        return "products/add-product";
    }

    @PostMapping("/admin/products/add")
    public String addProductAdmin(@ModelAttribute Product product, @RequestParam("categoryId") Long categoryId, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        productService.addProduct(product, categoryId);
        return "redirect:/admin/products";
    }

    @GetMapping("/admin/products/edit/{id}")
    public String showEditProductForm(@PathVariable Long id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("product", productService.getProductById(id));
        model.addAttribute("categories", categoryService.getAllCategories());
        return "products/edit-product";
    }

    @PostMapping("/admin/products/update/{id}")
    public String updateProductAdmin(@PathVariable Long id, @ModelAttribute Product product, @RequestParam("categoryId") Long categoryId, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        productService.updateProduct(id, product, categoryId);
        return "redirect:/admin/products";
    }

    @GetMapping("/admin/products/delete/{id}")
    public String deleteProductAdmin(@PathVariable Long id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        productService.deleteProduct(id);
        return "redirect:/admin/products";
    }

    @GetMapping("/admin/categories")
    public String showAdminCategories(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "redirect:/categories";
    }

    // ==========================================
    // MEDIA & SETTINGS CONTROL
    // ==========================================

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

    @PostMapping("/admin/settings/update")
    public String updateSettings(
            @RequestParam(value = "showAnnouncement", required = false) String showAnnouncement,
            @RequestParam("announcementText") String announcementText,
            @RequestParam(value = "emergencyClose", required = false) String emergencyClose,
            HttpServletRequest request, HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) return "redirect:/login";

        jakarta.servlet.ServletContext context = request.getServletContext();

        // Save states! (If checkbox is checked, it sends a value, otherwise null)
        context.setAttribute("showAnnouncement", showAnnouncement != null);
        context.setAttribute("announcementText", announcementText);
        context.setAttribute("emergencyClose", emergencyClose != null);

        redirectAttributes.addFlashAttribute("successMsg", "Store settings updated successfully!");
        return "redirect:/admin/settings";
    }

    @PostMapping("/admin/media/hero")
    public String updateHeroMedia(
            @RequestParam("slide1_media") String slide1Media,
            @RequestParam("slide1_heading") String slide1Heading,
            @RequestParam("slide1_desc") String slide1Desc,
            @RequestParam("slide2_media") String slide2Media,
            @RequestParam("slide2_heading") String slide2Heading,
            @RequestParam("slide2_desc") String slide2Desc,
            HttpServletRequest request, HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) return "redirect:/login";

        jakarta.servlet.ServletContext context = request.getServletContext();
        context.setAttribute("slide1_media", slide1Media);
        context.setAttribute("slide1_heading", slide1Heading);
        context.setAttribute("slide1_desc", slide1Desc);
        context.setAttribute("slide2_media", slide2Media);
        context.setAttribute("slide2_heading", slide2Heading);
        context.setAttribute("slide2_desc", slide2Desc);

        redirectAttributes.addFlashAttribute("successMsg", "Hero sliders updated successfully!");
        return "redirect:/admin/media";
    }

    @PostMapping("/admin/media/videos")
    public String updateVideos(
            @RequestParam("video1_url") String video1Url,
            @RequestParam("video1_heading") String video1Heading,
            @RequestParam("video2_url") String video2Url,
            @RequestParam("video2_heading") String video2Heading,
            @RequestParam("video3_url") String video3Url,
            @RequestParam("video3_heading") String video3Heading,
            HttpServletRequest request, HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (!isAdmin(session)) return "redirect:/login";

        jakarta.servlet.ServletContext context = request.getServletContext();
        context.setAttribute("video1_url", video1Url);
        context.setAttribute("video1_heading", video1Heading);
        context.setAttribute("video2_url", video2Url);
        context.setAttribute("video2_heading", video2Heading);
        context.setAttribute("video3_url", video3Url);
        context.setAttribute("video3_heading", video3Heading);

        redirectAttributes.addFlashAttribute("successMsg", "Showcase videos updated successfully!");
        return "redirect:/admin/media";
    }
}