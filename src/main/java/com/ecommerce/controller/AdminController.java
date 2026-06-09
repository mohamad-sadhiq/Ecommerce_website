package com.ecommerce.controller;

import com.ecommerce.model.Order;
import com.ecommerce.model.Product;
import com.ecommerce.model.StoreSettings;
import com.ecommerce.model.User;
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.OrderService;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.SettingsService;
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

import java.util.List;
import java.util.stream.Collectors;

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
    @Autowired
    private SettingsService settingsService;

    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        return user != null && "ADMIN".equalsIgnoreCase(user.getRole());
    }

    // ==========================================
    // DEFAULT ROUTE & DASHBOARD
    // ==========================================

    // NEW: If they go to /admin, send them to the dashboard!
    @GetMapping({"/admin", "/admin/"})
    public String adminDefault(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/admin/dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalProducts", productRepository.count());
        model.addAttribute("totalCategories", categoryService.getAllCategories().size());

        long lowStockCount = productService.getAllProducts(PageRequest.of(0, 1000))
                .getContent().stream()
                .filter(p -> p.getQuantity() <= 5)
                .count();
        model.addAttribute("pendingProducts", lowStockCount);

        List<Order> allOrders = orderService.getAllOrders();
        long pendingFulfillment = 0;
        double grossRevenue = 0.0;

        for (Order order : allOrders) {
            if (!"PENDING".equalsIgnoreCase(order.getStatus()) && !"CANCELLED".equalsIgnoreCase(order.getStatus())) {
                if (order.getTotalAmount() != null) {
                    grossRevenue += order.getTotalAmount().doubleValue();
                }
                if ("PAID".equalsIgnoreCase(order.getStatus()) || "PROCESSING".equalsIgnoreCase(order.getStatus())) {
                    pendingFulfillment++;
                }
            }
        }

        model.addAttribute("totalOrders", pendingFulfillment);
        model.addAttribute("totalRevenue", String.format("%,.2f", grossRevenue));

        return "admin/dashboard";
    }

    // ==========================================
    // USERS
    // ==========================================

    @GetMapping("/admin/users")
    public String showAdminUsers(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }

    @GetMapping("/admin/users/view/{id}")
    public String viewUserDetailsAdmin(@PathVariable Long id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        User userProfile = userService.getUserProfile(id);
        if (userProfile == null) {
            return "redirect:/admin/users";
        }

        model.addAttribute("clientProfile", userProfile);
        return "admin/user-details";
    }

    // ==========================================
    // ORDER MANAGEMENT
    // ==========================================

    @GetMapping("/admin/orders")
    public String showAdminOrders(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";

        List<Order> allOrders = orderService.getAllOrders();
        List<Order> activeOrders = allOrders.stream()
                .filter(o -> !"PENDING".equalsIgnoreCase(o.getStatus()))
                .collect(Collectors.toList());

        model.addAttribute("orders", activeOrders);
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
        return "products/product-list";
    }

    @GetMapping("/admin/products/view/{id}")
    public String viewProductAdminDetails(@PathVariable Long id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("product", productService.getProductById(id));
        return "products/product-details";
    }

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

        StoreSettings settings = settingsService.getSettings();
        settings.setShowAnnouncement(showAnnouncement != null);
        settings.setAnnouncementText(announcementText);
        settings.setEmergencyClose(emergencyClose != null);
        settingsService.saveSettings(settings, request.getServletContext());

        redirectAttributes.addFlashAttribute("successMsg", "Store settings saved to database successfully!");
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

        StoreSettings settings = settingsService.getSettings();
        settings.setSlide1Media(slide1Media);
        settings.setSlide1Heading(slide1Heading);
        settings.setSlide1Desc(slide1Desc);
        settings.setSlide2Media(slide2Media);
        settings.setSlide2Heading(slide2Heading);
        settings.setSlide2Desc(slide2Desc);

        settingsService.saveSettings(settings, request.getServletContext());

        redirectAttributes.addFlashAttribute("successMsg", "Hero sliders saved to database successfully!");
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

        StoreSettings settings = settingsService.getSettings();
        settings.setVideo1Url(video1Url);
        settings.setVideo1Heading(video1Heading);
        settings.setVideo2Url(video2Url);
        settings.setVideo2Heading(video2Heading);
        settings.setVideo3Url(video3Url);
        settings.setVideo3Heading(video3Heading);

        settingsService.saveSettings(settings, request.getServletContext());

        redirectAttributes.addFlashAttribute("successMsg", "Showcase videos saved to database successfully!");
        return "redirect:/admin/media";
    }
}