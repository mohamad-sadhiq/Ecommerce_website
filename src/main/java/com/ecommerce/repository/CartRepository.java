package com.ecommerce.repository;

import com.ecommerce.model.Cart;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import jakarta.transaction.Transactional;
import java.util.List;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

    List<Cart> findByUser(User user);

    // Checks if product is already in cart to increase quantity instead of duplicating
    Cart findByUserAndProduct(User user, Product product);

    @Transactional
    void deleteByUser(User user);
}