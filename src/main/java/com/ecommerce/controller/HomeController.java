package com.ecommerce.controller;

import com.ecommerce.model.Product;
import com.ecommerce.service.CategoryService;
import com.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/")
    public String showIndexPage(Model model) {

        // Fetch up to 100 products for the storefront grid
        Page<Product> productPage = productService.getAllProducts(PageRequest.of(0, 100));
        model.addAttribute("products", productPage.getContent());

        // Fetch all live categories from the database for the navigation bars
        model.addAttribute("categories", categoryService.getAllCategories());

        return "index";
    }
}