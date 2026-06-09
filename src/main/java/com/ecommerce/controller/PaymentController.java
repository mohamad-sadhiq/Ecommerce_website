package com.ecommerce.controller;

import com.ecommerce.model.Order;
import com.ecommerce.model.Payment;
import com.ecommerce.model.User;
import com.ecommerce.service.OrderService;
import com.ecommerce.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/payments")
public class PaymentController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/status/{orderId}")
    public String showPaymentGateway(@PathVariable("orderId") Long orderId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderDetails(orderId);
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/";
        }

        model.addAttribute("order", order);
        return "cart/payment";
    }

    @PostMapping("/process/{orderId}")
    public String processPayment(@PathVariable("orderId") Long orderId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderDetails(orderId);
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/";
        }

        // 1. Save the Mock Payment to the Database
        Payment mockPayment = new Payment(order, order.getTotalAmount(), "COMPLETED", LocalDate.now());
        paymentService.savePayment(mockPayment);

        // 2. Update the Order Status
        orderService.updateOrderStatus(orderId, "PAID");

        return "redirect:/orders/" + orderId;
    }
}