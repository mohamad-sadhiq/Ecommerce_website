<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-main: #fcfbf9; --bg-panel: #ffffff; --text-dark: #111111; --text-gray: #777777; --brand-color: #4A235A; --gold-accent: #cda53f; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-dark); display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; font-weight: 400; }
        a { text-decoration: none; transition: 0.3s; }

        .main-content { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
        .topbar { background: var(--bg-panel); height: 70px; display: flex; align-items: center; justify-content: space-between; padding: 0 40px; border-bottom: 1px solid var(--border-light); z-index: 5; }

        .topbar-actions { display: flex; gap: 15px; }
        .refresh-btn { background: transparent; border: 1px solid var(--border-light); color: var(--text-dark); padding: 8px 15px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .refresh-btn:hover { color: var(--brand-color); border-color: var(--brand-color); background: var(--bg-main); }

        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 30px 40px; max-width: 1400px; width: 100%; margin: 0 auto; display: flex; flex-direction: column; height: calc(100vh - 70px); overflow-y: auto; }

        .page-header { margin-bottom: 25px; flex-shrink: 0; }
        .page-header h1 { font-size: 28px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 13px; }

        .metrics-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; margin-bottom: 35px; flex-shrink: 0; }
        .metric-card { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; padding: 18px 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.01); display: flex; flex-direction: column; justify-content: center; position: relative; transition: 0.3s; overflow: hidden; }
        .metric-card:hover { border-color: var(--gold-accent); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(0,0,0,0.04); }
        .metric-icon { position: absolute; top: 18px; right: 20px; font-size: 20px; color: var(--border-light); opacity: 0.7; transition: 0.3s; }
        .metric-card:hover .metric-icon { color: var(--gold-accent); opacity: 1; transform: scale(1.1); }
        .metric-label { font-size: 10px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 6px; font-weight: 600; display: block; }
        .metric-value { font-size: 26px; color: var(--brand-color); line-height: 1; margin-bottom: 5px; font-weight: 500; }
        .metric-sub { font-size: 11px; color: #888; display: flex; align-items: center; gap: 5px; }
        .trend-up { color: #5a8a63; font-weight: 500; }
        .trend-warn { color: #dc3545; font-weight: 500; }

        .section-title { font-size: 18px; color: var(--text-dark); margin-bottom: 15px; flex-shrink: 0; }
        .control-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; flex-grow: 1; min-height: 0; }
        .control-card { background: var(--bg-panel); border: 1px solid var(--border-light); padding: 20px; display: flex; align-items: flex-start; gap: 15px; transition: 0.3s; border-radius: 4px; box-shadow: 0 2px 10px rgba(0,0,0,0.01); }
        .control-card:hover { border-color: var(--gold-accent); transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.04); }
        .control-icon { font-size: 20px; color: var(--gold-accent); margin-top: 2px; }
        .control-info { flex: 1; display: flex; flex-direction: column; height: 100%; }
        .control-info h3 { font-size: 16px; margin-bottom: 6px; color: var(--text-dark); }
        .control-info p { font-size: 12px; color: var(--text-gray); line-height: 1.5; margin-bottom: 10px; flex-grow: 1; }
        .action-link { font-size: 10px; text-transform: uppercase; letter-spacing: 1px; color: var(--brand-color); font-weight: 600; display: inline-flex; align-items: center; gap: 5px; margin-top: auto; }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/jsp/admin/admin-sidebar.jsp" %>

    <main class="main-content">
        <header class="topbar">
            <div class="topbar-actions">
                <button onclick="history.back()" class="refresh-btn">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
                <button onclick="window.location.reload();" class="refresh-btn">
                    <i class="fas fa-sync-alt"></i> Live Sync
                </button>
            </div>

            <div class="admin-profile">
                <span>${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName : 'Administrator'}</span>
                <div class="admin-avatar">
                    ${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName.substring(0,1).toUpperCase() : 'A'}
                </div>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="page-header">
                <h1 class="serif-font">Dashboard</h1>
                <p>Real-time overview of store performance and inventory.</p>
            </div>

            <div class="metrics-grid">
                <div class="metric-card">
                    <i class="fas fa-users metric-icon"></i>
                    <span class="metric-label">Registered Clients</span>
                    <div class="metric-value serif-font">${not empty totalUsers ? totalUsers : 0}</div>
                    <div class="metric-sub"><i class="fas fa-circle" style="font-size: 5px; color: var(--gold-accent);"></i> Database Accounts</div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-gem metric-icon"></i>
                    <span class="metric-label">Active Inventory</span>
                    <div class="metric-value serif-font">${not empty totalProducts ? totalProducts : 0}</div>
                    <div class="metric-sub"><i class="fas fa-circle" style="font-size: 5px; color: var(--gold-accent);"></i> Products Online</div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-tags metric-icon"></i>
                    <span class="metric-label">Product Categories</span>
                    <div class="metric-value serif-font">${not empty totalCategories ? totalCategories : 0}</div>
                    <div class="metric-sub"><i class="fas fa-circle" style="font-size: 5px; color: var(--gold-accent);"></i> Active Filters</div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-box-open metric-icon"></i>
                    <span class="metric-label">Pending Fulfillment</span>
                    <div class="metric-value serif-font">${not empty totalOrders ? totalOrders : 0}</div>
                    <div class="metric-sub">Orders awaiting dispatch</div>
                </div>
                <div class="metric-card">
                    <i class="fas fa-exclamation-circle metric-icon"></i>
                    <span class="metric-label">Pending Restock</span>
                    <div class="metric-value serif-font" style="color: ${pendingProducts > 0 ? '#dc3545' : 'var(--text-dark)'}">${not empty pendingProducts ? pendingProducts : 0}</div>
                    <div class="metric-sub ${pendingProducts > 0 ? 'trend-warn' : ''}">Low stock items (Qty < 5)</div>
                </div>
                <div class="metric-card" style="border-left: 3px solid var(--gold-accent);">
                    <i class="fas fa-chart-line metric-icon"></i>
                    <span class="metric-label">Gross Revenue</span>
                    <div class="metric-value serif-font">₹${not empty totalRevenue ? totalRevenue : '0.00'}</div>
                    <div class="metric-sub trend-up"><i class="fas fa-arrow-up"></i> Live calculation</div>
                </div>
            </div>

            <h2 class="section-title serif-font">Management Hub</h2>

            <div class="control-grid">
                <a href="/admin/products" class="control-card">
                    <div class="control-icon"><i class="fas fa-gem"></i></div>
                    <div class="control-info">
                        <h3 class="serif-font">Inventory & Pricing</h3>
                        <p>Curate collections, adjust pricing, and monitor stock.</p>
                        <span class="action-link">Manage Inventory <i class="fas fa-arrow-right"></i></span>
                    </div>
                </a>
                <a href="/admin/categories" class="control-card">
                    <div class="control-icon"><i class="fas fa-tags"></i></div>
                    <div class="control-info">
                        <h3 class="serif-font">Product Collections</h3>
                        <p>Organize inventory into bridal, diamond, and gold categories.</p>
                        <span class="action-link">Manage Categories <i class="fas fa-arrow-right"></i></span>
                    </div>
                </a>
            </div>
        </div>
    </main>

</body>
</html>