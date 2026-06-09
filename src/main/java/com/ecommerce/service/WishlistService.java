package com.ecommerce.service;

import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import com.ecommerce.model.Wishlist;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.WishlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WishlistService {

    @Autowired
    private WishlistRepository wishlistRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<Wishlist> getUserWishlist(User user) {
        return wishlistRepository.findByUser(user);
    }

    public void addProductToWishlist(User user, Long productId) {
        Product product = productRepository.findById(productId).orElse(null);
        if (product != null) {
            // Check if it already exists to prevent duplicates
            Optional<Wishlist> existing = wishlistRepository.findByUserAndProduct(user, product);
            if (existing.isEmpty()) {
                Wishlist wishlist = new Wishlist();
                wishlist.setUser(user);
                wishlist.setProduct(product);
                wishlistRepository.save(wishlist);
            }
        }
    }

    public void removeWishlistItem(Long wishlistId) {
        wishlistRepository.deleteById(wishlistId);
    }
}