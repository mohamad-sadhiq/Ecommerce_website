<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .sidebar { width: 260px; background: #2d1136; display: flex; flex-direction: column; height: 100vh; color: #fff; box-shadow: 4px 0 15px rgba(0,0,0,0.05); z-index: 50; }
    .brand-header { padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.05); }
    .brand-header h2 { font-size: 22px; letter-spacing: 3px; color: #fff; text-transform: uppercase; margin-bottom: 8px; font-family: 'Playfair Display', serif;}
    .admin-badge { display: inline-block; font-size: 10px; text-transform: uppercase; letter-spacing: 2px; color: #cda53f; border: 1px solid #cda53f; padding: 4px 12px; border-radius: 20px; font-weight: 600; }

    .nav-menu { flex: 1; display: flex; flex-direction: column; padding: 25px 0; overflow-y: auto; scrollbar-width: none; -ms-overflow-style: none; }
    .nav-menu::-webkit-scrollbar { display: none; }

    .nav-label { font-size: 10px; text-transform: uppercase; letter-spacing: 2px; color: rgba(255,255,255,0.4); margin: 20px 20px 10px; font-weight: 600; }

    /* Reduced Font Size to 12.5px */
    .nav-item { display: flex; align-items: center; gap: 15px; padding: 10px 20px; margin: 4px 15px; color: #e0d0e5; font-size: 12.5px; font-weight: 500; cursor: pointer; transition: all 0.3s ease; text-decoration: none; border-radius: 8px; }
    .nav-item i { font-size: 15px; width: 20px; text-align: center; }

    .nav-item:hover, .nav-item.active { background: #7b1e2e; color: #ffffff; box-shadow: 0 4px 12px rgba(123, 30, 46, 0.4); transform: translateX(4px); }

    .logout-btn { color: #ffbaba; margin-top: auto; margin-bottom: 20px; }
    .logout-btn:hover { background: rgba(220, 53, 69, 0.15); color: #ff6b6b; box-shadow: none; }
</style>

<aside class="sidebar">
    <div class="brand-header">
        <h2 class="serif-font">SHADOW & CUT</h2>
        <span class="admin-badge">Admin Portal</span>
    </div>
    <nav class="nav-menu">
        <div class="nav-label">Core Systems</div>
        <a href="/admin/dashboard" class="nav-item"><i class="fas fa-chart-line"></i> Analytics</a>
        <a href="/admin/orders" class="nav-item"><i class="fas fa-box-open"></i> Orders</a>
        <a href="/admin/users" class="nav-item"><i class="fas fa-users"></i> Customers</a>

        <div class="nav-label">Inventory</div>
        <a href="/admin/products" class="nav-item"><i class="fas fa-gem"></i> All Products</a>
        <a href="/products/add" class="nav-item"><i class="fas fa-plus"></i> Add Product</a>
        <a href="/admin/categories" class="nav-item"><i class="fas fa-tags"></i> Categories</a>

        <div class="nav-label">Storefront</div>
        <a href="/admin/reviews" class="nav-item"><i class="fas fa-comments"></i> Customer Reviews</a>
        <a href="/admin/media" class="nav-item"><i class="fas fa-images"></i> Media</a>
        <a href="/admin/settings" class="nav-item"><i class="fas fa-cog"></i> Settings</a>
    </nav>
    <a href="/logout" class="nav-item logout-btn">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</aside>