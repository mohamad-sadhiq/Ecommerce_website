<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management | Admin Portal</title>
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

        .dashboard-container { padding: 40px; max-width: 1200px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        .layout-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; align-items: start; }

        .form-panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; padding: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .form-panel h3 { font-size: 18px; color: var(--text-dark); margin-bottom: 20px; }
        .form-group { display: flex; flex-direction: column; margin-bottom: 20px; }
        .form-group label { font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 8px; font-weight: 600; }
        .form-group input, .form-group textarea { padding: 12px 15px; border: 1px solid var(--border-light); border-radius: 4px; font-size: 13px; outline: none; transition: 0.3s; background: var(--bg-main); color: var(--text-dark); }
        .form-group input:focus, .form-group textarea:focus { border-color: var(--gold-accent); background: white; box-shadow: 0 0 10px rgba(205, 165, 63, 0.1); }
        .btn-submit { background: var(--brand-color); color: white; padding: 12px; border: none; border-radius: 4px; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; font-weight: 600; cursor: pointer; width: 100%; transition: 0.3s; }
        .btn-submit:hover { background: #5a1220; }

        .table-panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fdfdfd; padding: 18px 25px; text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); border-bottom: 1px solid var(--border-light); }
        td { padding: 15px 25px; border-bottom: 1px solid var(--border-light); font-size: 14px; color: var(--text-dark); vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: var(--bg-main); }

        .action-cell { display: flex; gap: 10px; align-items: center; justify-content: flex-end; }
        .btn-icon { width: 32px; height: 32px; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 13px; border: 1px solid var(--border-light); color: var(--text-gray); transition: 0.3s; }
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
                <h1 class="serif-font">Category Management</h1>
                <p>Organize your inventory into elegant collections.</p>
            </div>

            <div class="layout-grid">
                <div class="form-panel">
                    <h3 class="serif-font">Create Collection</h3>
                    <form action="/categories/add" method="post">
                        <div class="form-group">
                            <label>Category Name</label>
                            <input type="text" name="name" placeholder="e.g., Bridal Sets" required>
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <textarea name="description" rows="3" placeholder="Brief details about this collection..." required></textarea>
                        </div>
                        <button type="submit" class="btn-submit">Add Category</button>
                    </form>
                </div>

                <div class="table-panel">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 60px;">ID</th>
                                <th>Collection Name</th>
                                <th>Description</th>
                                <th style="text-align: right;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td>#${cat.id}</td>
                                    <td style="font-weight: 500;">${cat.name}</td>
                                    <td style="color: var(--text-gray); font-size: 13px;">${cat.description}</td>
                                    <td>
                                        <div class="action-cell">
                                            <a href="/categories/edit/${cat.id}" class="btn-icon edit" title="Edit Category"><i class="fas fa-pen"></i></a>
                                            <a href="/categories/delete/${cat.id}" class="btn-icon delete" title="Delete Category" onclick="return confirm('Permanently delete the category?');"><i class="fas fa-trash"></i></a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty categories}">
                                <tr><td colspan="4" style="text-align: center; padding: 40px; color: var(--text-gray);">No collections have been created yet.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

</body>
</html>