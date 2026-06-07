<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category | Admin Portal</title>
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

        .dashboard-container { padding: 40px; max-width: 700px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        .form-panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; padding: 40px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .form-group { display: flex; flex-direction: column; margin-bottom: 20px; }
        .form-group label { font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 8px; font-weight: 600; }
        .form-group input, .form-group textarea { padding: 14px 15px; border: 1px solid var(--border-light); border-radius: 4px; font-size: 14px; outline: none; transition: 0.3s; background: var(--bg-main); color: var(--text-dark); }
        .form-group input:focus, .form-group textarea:focus { border-color: var(--gold-accent); background: white; box-shadow: 0 0 10px rgba(205, 165, 63, 0.1); }
        .btn-warning { background: var(--gold-accent); color: white; padding: 15px; border: none; border-radius: 4px; font-size: 13px; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; cursor: pointer; width: 100%; margin-top: 10px; transition: 0.3s; }
        .btn-warning:hover { background: #b59032; }
        .back-link { display: inline-block; margin-top: 20px; font-size: 12px; color: var(--text-gray); text-transform: uppercase; letter-spacing: 1px; text-align: center; width: 100%; transition: 0.3s; }
        .back-link:hover { color: var(--brand-color); }
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
                <h1 class="serif-font">Edit Category</h1>
                <p>Modify the name and description of this product collection.</p>
            </div>

            <div class="form-panel">
                <form action="${pageContext.request.contextPath}/categories/update/${category.id}" method="post">
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" name="name" value="${category.name}" required>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="3">${category.description}</textarea>
                    </div>

                    <button type="submit" class="btn-warning">Update Category</button>
                </form>

                <a href="${pageContext.request.contextPath}/categories" class="back-link"><i class="fas fa-arrow-left"></i> Back to Categories</a>
            </div>
        </div>
    </main>

</body>
</html>