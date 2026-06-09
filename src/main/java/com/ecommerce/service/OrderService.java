package com.ecommerce.service;

import com.ecommerce.model.Order;
import com.ecommerce.model.User;
import com.ecommerce.model.Cart;
import com.ecommerce.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private CartService cartService;

    public Order createOrder(User user, String shippingAddress) {
        List<Cart> cartItems = cartService.getCartDetails(user);
        if (cartItems.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }

        // Precise financial math using BigDecimal
        BigDecimal total = cartItems.stream()
                .map(item -> item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(total);
        order.setShippingAddress(shippingAddress);
        order.setStatus("PENDING");

        // Save order and clear cart
        Order savedOrder = orderRepository.save(order);
        cartService.clearCart(user);

        return savedOrder;
    }

    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUser(user);
    }

    public Order getOrderDetails(Long orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
    }

    public void updateOrderStatus(Long orderId, String status) {
        Order order = getOrderDetails(orderId);
        order.setStatus(status);
        orderRepository.save(order);
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }
}