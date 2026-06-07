<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="sidebar">
    <div class="brand-header">
        <h2 class="serif-font">SHADOW & CUT</h2>
        <span class="admin-badge">Admin Portal</span>
    </div>
    <nav class="nav-menu">
        <div class="nav-label">Core Systems</div>
        <a href="/admin/dashboard" class="nav-item"><i class="fas fa-chart-line"></i> Analytics Overview</a>
        <a href="/admin/orders" class="nav-item"><i class="fas fa-box-open"></i> Order Management</a>
        <a href="/admin/users" class="nav-item"><i class="fas fa-users"></i> Customer Database</a>

        <div class="nav-label">Inventory</div>
        <a href="/admin/products" class="nav-item"><i class="fas fa-gem"></i> All Products</a>
        <a href="/admin/products/add" class="nav-item"><i class="fas fa-plus"></i> Add Product</a>
        <a href="/admin/categories" class="nav-item"><i class="fas fa-tags"></i> Categories</a>

        <div class="nav-label">Storefront Control</div>
        <a href="/admin/media" class="nav-item"><i class="fas fa-images"></i> Media Management</a>
        <a href="/admin/settings" class="nav-item"><i class="fas fa-cog"></i> Global Settings</a>
    </nav>
    <a href="/logout" class="nav-item logout-btn" style="border-top: 1px solid var(--border-light); margin-top: auto; color: #dc3545;">
        <i class="fas fa-sign-out-alt"></i> Terminate Session
    </a>
</aside>