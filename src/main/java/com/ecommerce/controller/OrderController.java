package com.ecommerce.controller;

import com.ecommerce.model.User;
import com.ecommerce.model.Order;
import com.ecommerce.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/create")
    public String createOrder(@RequestParam("shippingAddress") String shippingAddress, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Creates the order as PENDING and clears the cart
        Order order = orderService.createOrder(user, shippingAddress);

        // Redirects to Member 4's Payment Gateway
        return "redirect:/payments/status/" + order.getId();
    }

    @GetMapping
    public String viewOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // Fetch user orders, but hide PENDING (unpaid/abandoned) checkouts from their history
        List<Order> allUserOrders = orderService.getOrdersByUser(user);
        List<Order> activeOrders = allUserOrders.stream()
                .filter(o -> !"PENDING".equalsIgnoreCase(o.getStatus()))
                .collect(Collectors.toList());

        model.addAttribute("orders", activeOrders);
        return "orders/order-list";
    }

    @GetMapping("/{orderId}")
    public String orderDetails(@PathVariable("orderId") Long orderId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Order order = orderService.getOrderDetails(orderId);
        model.addAttribute("order", order);
        return "orders/order-details";
    }
}