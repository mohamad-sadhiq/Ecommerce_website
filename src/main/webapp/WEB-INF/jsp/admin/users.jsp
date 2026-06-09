<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Database | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --bg-main: #f8f9fa; --bg-panel: #ffffff; --text-dark: #111111; --text-gray: #6c757d; --brand-color: #4A235A; --gold-accent: #cda53f; --border-light: #e9ecef; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-dark); display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; transition: 0.3s ease; }

        .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
        .topbar { background: var(--bg-panel); height: 70px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; justify-content: space-between; padding: 0 40px; position: sticky; top: 0; z-index: 5; }

        .topbar-actions { display: flex; gap: 15px; }
        .refresh-btn { background: transparent; border: 1px solid var(--border-light); color: var(--text-dark); padding: 8px 15px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .refresh-btn:hover { color: var(--brand-color); border-color: var(--brand-color); background: var(--bg-main); }

        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 40px; max-width: 1200px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        .panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fdfdfd; padding: 18px 25px; text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); border-bottom: 1px solid var(--border-light); }
        td { padding: 15px 25px; border-bottom: 1px solid var(--border-light); font-size: 14px; color: var(--text-dark); vertical-align: middle; }
        tr:hover { background: var(--bg-main); }

        .role-badge { padding: 4px 10px; border-radius: 20px; font-size: 10px; text-transform: uppercase; font-weight: 600; letter-spacing: 1px; border: 1px solid var(--border-light); }
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
                <h1 class="serif-font">Client Database</h1>
                <p>View registered accounts and manage administrative access.</p>
            </div>

            <div class="panel">
                <table>
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Email Address</th>
                            <th>Role</th>
                            <th style="text-align: right;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td style="color: var(--text-gray);">#${user.id}</td>
                                <td style="font-weight: 500;">${user.fullName}</td>
                                <td>${user.email}</td>
                                <td><span class="role-badge">${user.role}</span></td>
                                <td style="text-align: right;">
                                    <a href="/admin/users/view/${user.id}" class="role-badge" style="cursor: pointer; background: #fdfaf6; color: var(--text-dark); text-decoration: none; transition: 0.3s; display: inline-block;">
                                        View Profile <i class="fas fa-arrow-right" style="margin-left: 5px; font-size: 9px;"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty users}">
                            <tr><td colspan="5" style="text-align: center; padding: 40px; color: var(--text-gray);">Awaiting connection to User Database (Member 1).</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>