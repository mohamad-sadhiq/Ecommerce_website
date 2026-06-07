package com.ecommerce.controller;

import com.ecommerce.model.Product;
import com.ecommerce.service.CategoryService;
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

    @Autowired
    private CategoryService categoryService;

    // 1. View all products (Now handles the Pageable requirement!)
    @GetMapping
    public String listProducts(Model model, @RequestParam(defaultValue = "0") int page) {
        // Fetch up to 50 items per page
        Page<Product> productPage = productService.getAllProducts(PageRequest.of(page, 50));

        // Pass .getContent() so your JSP can simply loop through ${products}
        model.addAttribute("products", productPage.getContent());
        return "products/product-list";
    }

    // 2. Show the Add Product form
    @GetMapping("/add")
    public String showAddProductForm(Model model) {
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categoryService.getAllCategories());
        return "products/add-product";
    }

    // 3. Process the Add Product form
    @PostMapping("/add")
    public String addProduct(@ModelAttribute Product product, @RequestParam("categoryId") Long categoryId) {
        // Now passing the categoryId directly to your service as it expects!
        productService.addProduct(product, categoryId);
        return "redirect:/products";
    }

    // 4. Show the Edit Product form
    @GetMapping("/edit/{id}")
    public String showEditProductForm(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.getAllCategories());
        return "products/edit-product";
    }

    // 5. Process the Update Product form
    @PostMapping("/update/{id}")
    public String updateProduct(@PathVariable Long id, @ModelAttribute Product product, @RequestParam("categoryId") Long categoryId) {
        // Now passing the categoryId directly to your service!
        productService.updateProduct(id, product, categoryId);
        return "redirect:/products";
    }

    // 6. View Product Details
    @GetMapping("/{id}")
    public String showProductDetails(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "products/product-details";
    }

    // 7. Delete Product
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }
}