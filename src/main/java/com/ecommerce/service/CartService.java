package com.ecommerce.service;

import com.ecommerce.model.Cart;
import com.ecommerce.model.User;
import com.ecommerce.model.Product;
import com.ecommerce.repository.CartRepository;
import com.ecommerce.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<Cart> getCartDetails(User user) {
        return cartRepository.findByUser(user);
    }

    public void addToCart(User user, Long productId, Integer quantity) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Product not found"));

        // Bulletproof check: Manually scan the user's cart to find a match
        List<Cart> userCart = cartRepository.findByUser(user);
        Cart existingCartItem = null;

        for (Cart item : userCart) {
            if (item.getProduct().getId().equals(productId)) {
                existingCartItem = item;
                break;
            }
        }

        if (existingCartItem != null) {
            // Item exists, just increase quantity
            existingCartItem.setQuantity(existingCartItem.getQuantity() + quantity);
            cartRepository.save(existingCartItem);
        } else {
            // Brand new item, use default constructor and setters to avoid errors
            Cart newCartItem = new Cart();
            newCartItem.setUser(user);
            newCartItem.setProduct(product);
            newCartItem.setQuantity(quantity);
            cartRepository.save(newCartItem);
        }
    }

    public void removeFromCart(Long cartId) {
        cartRepository.deleteById(cartId);
    }

    public void clearCart(User user) {
        // Bulletproof clear: Fetch all and delete, avoiding custom SQL queries
        List<Cart> userCart = cartRepository.findByUser(user);
        if (!userCart.isEmpty()) {
            cartRepository.deleteAll(userCart);
        }
    }
}