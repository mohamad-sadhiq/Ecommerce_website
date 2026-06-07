<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Product | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-main: #fcfbf9; --bg-panel: #ffffff; --text-dark: #111111; --text-gray: #777777; --brand-color: #5a1220; --gold-accent: #cda53f; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-dark); display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; transition: 0.3s ease; }

        /* Sidebar CSS */
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
        .topbar { background: var(--bg-panel); height: 70px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; justify-content: flex-end; padding: 0 40px; position: sticky; top: 0; z-index: 5; }
        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 40px; max-width: 800px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: flex-end; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }

        .form-card { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; padding: 40px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 8px; font-weight: 600; }
        input, textarea, select { width: 100%; padding: 12px 15px; border: 1px solid var(--border-light); border-radius: 3px; font-size: 14px; transition: 0.3s; background: #fafafa; }
        input:focus, textarea:focus, select:focus { border-color: var(--gold-accent); outline: none; background: white; }

        .btn-submit { width: 100%; background: var(--brand-color); color: white; padding: 15px; border: none; border-radius: 3px; font-size: 12px; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; cursor: pointer; transition: 0.3s; margin-top: 10px; }
        .btn-submit:hover { background: var(--text-dark); }

        .btn-outline { display: inline-block; background: transparent; color: var(--text-dark); padding: 10px 20px; border-radius: 4px; font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; border: 1px solid var(--border-light); transition: 0.3s; }
        .btn-outline:hover { border-color: var(--brand-color); color: var(--brand-color); }
        .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/jsp/admin/admin-sidebar.jsp" %>

    <main class="main-content">
        <header class="topbar">
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
                    <h1 class="serif-font">Add New Piece</h1>
                </div>
                <a href="/admin/products" class="btn-outline"><i class="fas fa-arrow-left"></i> Cancel</a>
            </div>

            <div class="form-card">
                <form action="/admin/products/add" method="post">

                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" name="name" placeholder="e.g. 22Kt Gold Bridal Necklace" required>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="4" placeholder="Enter detailed product description..." required></textarea>
                    </div>

                    <div class="grid-2">
                        <div class="form-group">
                            <label>Price (₹)</label>
                            <input type="number" step="0.01" name="price" placeholder="0.00" required>
                        </div>

                        <div class="form-group">
                            <label>Stock Quantity</label>
                            <input type="number" name="quantity" placeholder="0" required>
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="form-group">
                            <label>Category</label>
                            <select name="categoryId" required>
                                <option value="">-- Select Category --</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>High-Res Image URL</label>
                            <input type="text" name="imageUrl" placeholder="https://...">
                        </div>
                    </div>

                    <button type="submit" class="btn-submit">Publish Product</button>
                </form>
            </div>
        </div>
    </main>

</body>
</html>