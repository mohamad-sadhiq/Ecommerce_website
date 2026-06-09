package com.ecommerce.controller;

import com.ecommerce.model.User;
import com.ecommerce.service.WishlistService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class WishlistController {

    @Autowired
    private WishlistService wishlistService;

    // 1. Load the actual Wishlist Page
    @GetMapping("/wishlist")
    public String viewWishlist(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // This fixes the 500 error! It passes real Wishlist database entities to the JSP.
        model.addAttribute("wishlistItems", wishlistService.getUserWishlist(user));
        return "wishlist";
    }

    // 2. Silent AJAX Add to Database
    @PostMapping("/wishlist/add")
    @ResponseBody
    public String addToWishlist(@RequestParam("productId") Long productId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "UNAUTHORIZED";

        wishlistService.addProductToWishlist(user, productId);
        return "SUCCESS";
    }

    // 3. Remove Item from the Wishlist Page
    @GetMapping("/wishlist/remove/{id}")
    public String removeFromWishlist(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        wishlistService.removeWishlistItem(id);
        return "redirect:/wishlist";
    }
}