package com.ecommerce.controller;

import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    // View all products (Customer Browsing)
    @GetMapping
    public String listProducts(Model model, @RequestParam(defaultValue = "0") int page) {
        Page<Product> productPage = productService.getAllProducts(PageRequest.of(page, 50));
        model.addAttribute("products", productPage.getContent());
        return "products/product-list";
    }

    // View Product Details (Customer Browsing)
    @GetMapping("/{id}")
    public String showProductDetails(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "products/product-details";
    }
}