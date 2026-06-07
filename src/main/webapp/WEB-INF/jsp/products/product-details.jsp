<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-main: #f8f9fa; --bg-panel: #ffffff; --text-dark: #111111; --text-gray: #6c757d; --brand-color: #7b1e2e; --gold-accent: #cda53f; --border-light: #e9ecef; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-dark); display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; transition: 0.3s ease; }

        .sidebar { width: 260px; background: var(--bg-panel); border-right: 1px solid var(--border-light); display: flex; flex-direction: column; z-index: 10; }
        .brand-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid var(--border-light); }
        .brand-header h2 { font-size: 20px; letter-spacing: 3px; color: var(--brand-color); text-transform: uppercase; }
        .admin-badge { display: inline-block; margin-top: 10px; font-size: 10px; text-transform: uppercase; letter-spacing: 2px; color: var(--gold-accent); border: 1px solid var(--gold-accent); padding: 3px 10px; border-radius: 20px; }
        .nav-menu { flex: 1; padding: 20px 0; overflow-y: auto; }
        .nav-label { font-size: 11px; text-transform: uppercase; letter-spacing: 2px; color: #adb5bd; margin: 20px 20px 10px; font-weight: 600; }
        .nav-item { display: flex; align-items: center; gap: 15px; padding: 12px 25px; color: var(--text-gray); font-size: 14px; font-weight: 500; border-left: 3px solid transparent; cursor: pointer; }
        .nav-item i { font-size: 16px; width: 20px; text-align: center; }
        .nav-item:hover, .nav-item.active { background: var(--bg-main); color: var(--brand-color); border-left-color: var(--brand-color); }

        .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
        .topbar { background: var(--bg-panel); height: 70px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; justify-content: space-between; padding: 0 40px; position: sticky; top: 0; z-index: 5; }
        .refresh-btn { background: transparent; border: 1px solid var(--border-light); color: var(--text-dark); padding: 8px 15px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .refresh-btn:hover { color: var(--brand-color); border-color: var(--brand-color); background: var(--bg-main); }
        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 40px; max-width: 1000px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: flex-end; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        .header-actions { display: flex; gap: 15px; }
        .btn-primary { background: var(--brand-color); color: white; padding: 10px 20px; border-radius: 4px; font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; border: 1px solid var(--brand-color); display: flex; align-items: center; gap: 8px; }
        .btn-primary:hover { background: #5a1220; }

        .details-card { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; display: flex; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .img-section { flex: 1; background: var(--bg-main); display: flex; align-items: center; justify-content: center; min-height: 400px; padding: 20px; border-right: 1px solid var(--border-light); }
        .img-section img { max-width: 100%; max-height: 350px; object-fit: contain; border-radius: 4px; }
        .no-img { color: var(--text-gray); font-size: 14px; text-transform: uppercase; letter-spacing: 2px; }

        .info-section { flex: 1.5; padding: 40px; display: flex; flex-direction: column; }
        .info-tag { display: inline-block; background: var(--bg-main); color: var(--text-gray); font-size: 10px; text-transform: uppercase; letter-spacing: 2px; padding: 4px 10px; border-radius: 20px; margin-bottom: 15px; border: 1px solid var(--border-light); }
        .info-title { font-size: 28px; color: var(--text-dark); margin-bottom: 15px; }
        .info-price { font-size: 24px; color: var(--brand-color); margin-bottom: 25px; font-weight: 600; }
        .info-desc { font-size: 14px; line-height: 1.7; color: var(--text-gray); margin-bottom: 30px; }

        .stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .stat-box { background: var(--bg-main); padding: 15px; border-radius: 4px; border: 1px solid var(--border-light); }
        .stat-label { font-size: 10px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 5px; }
        .stat-value { font-size: 16px; font-weight: 500; color: var(--text-dark); }

        .action-row { display: flex; gap: 15px; margin-top: auto; }
        .btn-outline { flex: 1; text-align: center; background: transparent; color: var(--text-dark); padding: 12px; border-radius: 4px; font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; border: 1px solid var(--border-light); transition: 0.3s; }
        .btn-outline:hover { border-color: var(--brand-color); color: var(--brand-color); }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/jsp/admin/admin-sidebar.jsp" %>

    <main class="main-content">
        <header class="topbar">
            <button onclick="window.location.reload();" class="refresh-btn">
                <i class="fas fa-sync-alt"></i> Live Sync
            </button>
            <div class="admin-profile">
                <span>${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName : 'Administrator'}</span>
                <div class="admin-avatar">
                    ${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName.substring(0,1).toUpperCase() : 'A'}
                </div>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="page-header">
                <div>
                    <h1 class="serif-font">Product Inspect</h1>
                    <p>Detailed view of inventory item #${product.id}</p>
                </div>
                <div class="header-actions">
                    <a href="/admin/products" class="btn-outline"><i class="fas fa-arrow-left"></i> Back to Inventory</a>
                    <a href="/admin/products/edit/${product.id}" class="btn-primary"><i class="fas fa-pen"></i> Edit Piece</a>
                </div>
            </div>

            <div class="details-card">
                <div class="img-section">
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <img src="${product.imageUrl}" alt="Product Image">
                        </c:when>
                        <c:otherwise><span class="no-img">No Image Available</span></c:otherwise>
                    </c:choose>
                </div>

                <div class="info-section">
                    <div>
                        <span class="info-tag">
                            <c:choose>
                                <c:when test="${not empty product.category}">${product.category.name}</c:when>
                                <c:otherwise>Uncategorized</c:otherwise>
                            </c:choose>
                        </span>
                        <h2 class="info-title serif-font">${product.name}</h2>
                        <div class="info-price serif-font">₹${product.price}</div>
                        <p class="info-desc">${product.description}</p>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-box">
                            <div class="stat-label">Stock Status</div>
                            <div class="stat-value" style="color: ${product.quantity > 0 ? '#28a745' : '#dc3545'};">
                                ${product.quantity > 0 ? product.quantity += ' Units Available' : 'Out of Stock'}
                            </div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-label">Product ID Number</div>
                            <div class="stat-value">#${product.id}</div>
                        </div>
                    </div>

                    <div class="action-row">
                        <a href="/admin/products/delete/${product.id}" onclick="return confirm('Permanently delete this product?');" class="btn-outline" style="color: #dc3545; border-color: #dc3545;">Delete Product</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

</body>
</html>