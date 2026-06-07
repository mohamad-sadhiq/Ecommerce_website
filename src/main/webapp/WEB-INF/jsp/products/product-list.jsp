<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Inventory | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-main: #f8f9fa; --bg-panel: #ffffff; --text-dark: #111111; --text-gray: #6c757d; --brand-color: #7b1e2e; --gold-accent: #cda53f; --border-light: #e9ecef; --danger: #dc3545; }
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

        .dashboard-container { padding: 40px; max-width: 1400px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: flex-end; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        .btn-primary { background: var(--brand-color); color: white; padding: 12px 25px; border-radius: 4px; font-size: 12px; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; border: 1px solid var(--brand-color); display: flex; align-items: center; gap: 8px; }
        .btn-primary:hover { background: #5a1220; }

        .panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fdfdfd; padding: 18px 25px; text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); border-bottom: 1px solid var(--border-light); }
        td { padding: 15px 25px; border-bottom: 1px solid var(--border-light); font-size: 14px; color: var(--text-dark); vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: var(--bg-main); }

        .prod-img-wrapper { width: 50px; height: 50px; border-radius: 4px; overflow: hidden; background: var(--bg-main); border: 1px solid var(--border-light); display: flex; align-items: center; justify-content: center; }
        .prod-img-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .no-img-text { font-size: 10px; color: var(--text-gray); text-transform: uppercase; }

        .action-cell { display: flex; gap: 10px; align-items: center; justify-content: flex-end; }
        .btn-icon { width: 32px; height: 32px; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 13px; border: 1px solid var(--border-light); color: var(--text-gray); transition: 0.3s; }
        .btn-icon.view:hover { background: #28a745; color: white; border-color: #28a745; }
        .btn-icon.edit:hover { background: var(--gold-accent); color: white; border-color: var(--gold-accent); }
        .btn-icon.delete:hover { background: var(--danger); color: white; border-color: var(--danger); }
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
                    <h1 class="serif-font">Product Inventory</h1>
                    <p>Manage your luxury collections, pricing, and stock levels.</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/admin/products/add" class="btn-primary"><i class="fas fa-plus"></i> Add Product</a>
                </div>
            </div>

            <div class="panel">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 80px;">ID</th>
                            <th style="width: 80px;">Image</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th style="text-align: right;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>#${product.id}</td>
                                <td>
                                    <div class="prod-img-wrapper">
                                        <c:choose>
                                            <c:when test="${not empty product.imageUrl}">
                                                <img src="${product.imageUrl}" alt="${product.name}">
                                            </c:when>
                                            <c:otherwise><span class="no-img-text">N/A</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td style="font-weight: 500;">${product.name}</td>
                                <td>${not empty product.category ? product.category.name : '<em style="color: #ccc;">Uncategorized</em>'}</td>
                                <td class="serif-font" style="color: var(--brand-color); font-weight: 600;">₹${product.price}</td>
                                <td>${product.quantity}</td>
                                <td>
                                    <div class="action-cell">
                                        <a href="${pageContext.request.contextPath}/admin/products/view/${product.id}" class="btn-icon view" title="View Details"><i class="far fa-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/admin/products/edit/${product.id}" class="btn-icon edit" title="Edit Product"><i class="fas fa-pen"></i></a>
                                        <a href="${pageContext.request.contextPath}/admin/products/delete/${product.id}" class="btn-icon delete" title="Delete Product" onclick="return confirm('Permanently delete this product?');"><i class="fas fa-trash"></i></a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty products}">
                            <tr><td colspan="7" style="text-align: center; padding: 50px; color: var(--text-gray);">No products found in the inventory.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

</body>
</html>