<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-white: #ffffff;
            --bg-cream: #faf9f7;
            --text-dark: #111111;
            --text-gray: #666666;
            --brand-color: #7b1e2e;
            --gold-accent: #cda53f;
            --border-light: #eaeaea;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-cream); color: var(--text-dark); font-family: 'Jost', sans-serif; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.3s; }

        /* === HEADER === */
        .utility-bar { background-color: var(--brand-color); color: white; text-align: center; padding: 12px; font-size: 11px; letter-spacing: 2px; text-transform: uppercase; font-weight: 500; }
        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); }
        .brand-logo { font-size: 28px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }
        .back-link { font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-link:hover { color: var(--brand-color); }

        /* === MAIN CONTAINER === */
        .page-wrapper { max-width: 1000px; margin: 60px auto; padding: 0 40px; animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .page-title { font-size: 32px; margin-bottom: 40px; color: var(--text-dark); border-bottom: 1px solid var(--border-light); padding-bottom: 20px; }

        /* === EMPTY STATE === */
        .empty-state { text-align: center; padding: 80px 0; background: var(--bg-white); box-shadow: 0 10px 30px rgba(0,0,0,0.02); }
        .empty-state i { font-size: 50px; color: var(--border-light); margin-bottom: 20px; }
        .empty-state h3 { font-size: 22px; color: var(--text-dark); margin-bottom: 15px; }

        /* === TABLE STYLING === */
        .table-container { background: var(--bg-white); padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); border-radius: 4px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; border-bottom: 2px solid var(--border-light); color: var(--text-gray); font-size: 12px; text-transform: uppercase; letter-spacing: 1px; }
        td { padding: 20px 15px; border-bottom: 1px solid var(--border-light); vertical-align: middle; font-size: 15px; }
        tr:hover td { background-color: #fafafa; }

        .order-id { font-family: 'Playfair Display', serif; font-weight: 600; color: var(--brand-color); }
        .order-price { font-weight: 500; }

        /* === STATUS BADGES === */
        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; display: inline-block; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-paid { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #cce5ff; color: #004085; }
        .status-delivered { background: #d4edda; color: #155724; }

        .btn-view { display: inline-block; padding: 8px 16px; border: 1px solid var(--gold-accent); color: var(--text-dark); font-size: 11px; text-transform: uppercase; letter-spacing: 1px; transition: 0.3s; }
        .btn-view:hover { background: var(--gold-accent); color: white; }
    </style>
</head>
<body>

    <div class="utility-bar">Secure Order Tracking</div>

    <header class="header-main">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>
        <a href="/profile" class="back-link"><i class="fas fa-arrow-left"></i> Back to Profile</a>
    </header>

    <div class="page-wrapper">
        <h1 class="page-title serif-font">Your Order History</h1>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-state">
                    <i class="fas fa-box-open"></i>
                    <h3 class="serif-font">No orders found</h3>
                    <p style="color: var(--text-gray); margin-bottom: 30px;">You haven't placed any orders yet.</p>
                    <a href="/products" class="btn-view" style="padding: 12px 30px; background: var(--brand-color); color: white; border-color: var(--brand-color);">Discover Collections</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Date</th>
                                <th>Total Amount</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="order-id">#${order.id}</td>
                                    <td>${order.orderDate}</td>
                                    <td class="order-price">₹ ${order.totalAmount}</td>
                                    <td>
                                        <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                                    </td>
                                    <td>
                                        <a href="/orders/${order.id}" class="btn-view">View Details</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>