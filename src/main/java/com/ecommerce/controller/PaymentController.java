package com.ecommerce.controller;

import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payments")
public class PaymentController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/status/{orderId}")
    public String showPaymentGateway(@PathVariable("orderId") Long orderId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderDetails(orderId);

        // Ensure user can only pay for their own orders
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/";
        }

        model.addAttribute("order", order);
        return "cart/payment"; // Routes to the new payment.jsp
    }

    @PostMapping("/process/{orderId}")
    public String processPayment(@PathVariable("orderId") Long orderId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Security check
        Order order = orderService.getOrderDetails(orderId);
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/";
        }

        // The Magic Trigger: Changes status to PAID
        // This makes it visible in the Customer Order History AND the Admin Priority Queue!
        orderService.updateOrderStatus(orderId, "PAID");

        return "redirect:/orders/" + orderId; // Send them to the final digital receipt
    }
}