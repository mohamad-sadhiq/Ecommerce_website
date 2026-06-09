package com.ecommerce.controller;

import com.ecommerce.model.User;
import com.ecommerce.model.Cart;
import com.ecommerce.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        List<Cart> cartItems = cartService.getCartDetails(user);

        // Strict BigDecimal Math
        BigDecimal cartTotal = cartItems.stream()
                .map(item -> item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotal", cartTotal.toPlainString()); // toPlainString enforces standard numbers
        return "cart/cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("productId") Long productId,
                            @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
                            HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        cartService.addToCart(user, productId, quantity);
        session.setAttribute("cart", cartService.getCartDetails(user));

        return "redirect:/cart";
    }

    @GetMapping("/remove/{cartId}")
    public String removeFromCart(@PathVariable("cartId") Long cartId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        cartService.removeFromCart(cartId);
        session.setAttribute("cart", cartService.getCartDetails(user));

        return "redirect:/cart";
    }
}