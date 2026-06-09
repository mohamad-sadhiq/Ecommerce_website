package com.ecommerce.controller;

import com.ecommerce.model.Review;
import com.ecommerce.model.User;
import com.ecommerce.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/new")
    public String showReviewForm(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            // Send to login, but pass the redirect parameter so they come back here!
            return "redirect:/login?redirect=/review/new";
        }
        model.addAttribute("review", new Review());
        return "write-review";
    }

    @PostMapping("/submit")
    public String submitReview(@ModelAttribute Review review, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        review.setUser(loggedInUser);
        reviewService.saveReview(review);

        // Return to homepage after submission
        return "redirect:/?reviewSuccess=true";
    }
}