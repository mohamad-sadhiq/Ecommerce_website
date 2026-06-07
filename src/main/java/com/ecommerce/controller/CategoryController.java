package com.ecommerce.controller;

import com.ecommerce.model.Category;
import com.ecommerce.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/categories") // This handles the base URL for all methods below
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    // 1. View all categories
    @GetMapping
    public String viewCategories(Model model) {
        model.addAttribute("categories", categoryService.getAllCategories());
        model.addAttribute("category", new Category());

        // FIXED: Point to a dedicated category list page, NOT the dashboard
        return "admin/category-list";
    }

    // 2. Add a category
    @PostMapping("/add")
    public String addCategory(@ModelAttribute Category category) {
        categoryService.addCategory(category);
        return "redirect:/categories";
    }

    // 3. Show edit form
    @GetMapping("/edit/{id}")
    public String showEditCategoryForm(@PathVariable Long id, Model model) {
        Category category = categoryService.getCategoryById(id);
        model.addAttribute("category", category);

        // FIXED: Ensure it explicitly points to the admin folder
        return "admin/edit-category";
    }

    // 4. Update category
    @PostMapping("/update/{id}")
    public String updateCategory(
            @PathVariable Long id,
            @ModelAttribute Category category) {
        categoryService.updateCategory(id, category);
        return "redirect:/categories";
    }

    // 5. Delete category
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable Long id) {
        categoryService.deleteCategory(id);
        return "redirect:/categories";
    }
}