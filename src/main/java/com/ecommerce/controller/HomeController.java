package com.ecommerce.controller;

import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import com.ecommerce.model.Review; // ADDED
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.WishlistService;
import com.ecommerce.service.ReviewService; // ADDED
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class HomeController {

    @Autowired private ProductService productService;
    @Autowired private CategoryService categoryService;
    @Autowired private WishlistService wishlistService;
    @Autowired private ReviewService reviewService; // ADDED

    @GetMapping("/")
    public String showIndexPage(Model model, HttpSession session) {
        Page<Product> productPage = productService.getAllProducts(PageRequest.of(0, 100));
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("categories", categoryService.getAllCategories());

        // THE FIX: Fetch real reviews from the database
        List<Review> reviews = reviewService.getAllReviews();
        model.addAttribute("reviews", reviews);

        // Check the database for this specific user's wishlist!
        List<Long> userWishlistIds = new ArrayList<>();
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            userWishlistIds = wishlistService.getUserWishlist(user).stream()
                    .map(w -> w.getProduct().getId())
                    .collect(Collectors.toList());
        }
        model.addAttribute("userWishlistIds", userWishlistIds);

        return "index";
    }

    @GetMapping("/stores")
    public String showStoresPage() {
        return "stores";
    }
}