<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Priority Queue | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Core layout styling */
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

        .dashboard-container { padding: 40px; max-width: 1400px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        /* Table Styling */
        .panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fdfdfd; padding: 18px 25px; text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); border-bottom: 1px solid var(--border-light); }
        td { padding: 15px 25px; border-bottom: 1px solid var(--border-light); font-size: 14px; color: var(--text-dark); vertical-align: middle; }
        tr:hover { background: var(--bg-main); }

        /* Badges */
        .badge { padding: 5px 12px; border-radius: 20px; font-size: 10px; text-transform: uppercase; font-weight: 600; letter-spacing: 1px; }
        .priority-high { background: #ffeeba; color: #856404; }
        .priority-normal { background: #e2e3e5; color: #383d41; }
        .status-pending { background: #cce5ff; color: #004085; }
        .status-shipped { background: #d4edda; color: #155724; }

        .btn-outline { background: transparent; color: var(--brand-color); padding: 8px 15px; border-radius: 4px; font-size: 11px; text-transform: uppercase; font-weight: 600; border: 1px solid var(--brand-color); cursor: pointer; transition: 0.3s; }
        .btn-outline:hover { background: var(--brand-color); color: white; }
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
                <div class="admin-avatar">A</div>
            </div>
        </header>

        <div class="dashboard-container">
            <div class="page-header">
                <h1 class="serif-font">Priority Order Queue</h1>
                <p>Manage and fulfill incoming client orders based on priority and timestamp.</p>
            </div>

            <div class="panel">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date & Time</th>
                            <th>Priority</th>
                            <th>Customer</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th style="text-align: right;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td style="font-weight: 600;">#${order.id}</td>
                                <td style="color: var(--text-gray); font-size: 12px;">${order.orderDate}</td>
                                <td><span class="badge priority-normal">Standard</span></td>
                                <td>${order.user.fullName}</td>
                                <td class="serif-font" style="color: var(--brand-color); font-weight: 600;">₹${order.totalAmount}</td>
                                <td><span class="badge status-pending">${order.status}</span></td>
                                <td style="text-align: right;">
                                    <button class="btn-outline">Process Order</button>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr><td colspan="7" style="text-align: center; padding: 40px; color: var(--text-gray);">Awaiting connection to Order Database (Member 3).</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>