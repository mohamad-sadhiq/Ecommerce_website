<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Receipt | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-white: #ffffff; --bg-cream: #faf9f7; --text-dark: #111111; --text-gray: #666666; --brand-color: #7b1e2e; --gold-accent: #cda53f; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-cream); color: var(--text-dark); font-family: 'Jost', sans-serif; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.3s; }

        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); }
        .brand-logo { font-size: 28px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }
        .back-link { font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-link:hover { color: var(--brand-color); }

        .receipt-container { max-width: 700px; margin: 60px auto; background: var(--bg-white); box-shadow: 0 15px 40px rgba(0,0,0,0.05); padding: 50px; border-top: 4px solid var(--brand-color); animation: fadeIn 0.6s ease-out; position: relative; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .receipt-header { display: flex; justify-content: space-between; align-items: flex-end; border-bottom: 1px solid var(--border-light); padding-bottom: 20px; margin-bottom: 30px; }
        .order-title { font-size: 28px; color: var(--text-dark); }
        .order-date { font-size: 13px; color: var(--text-gray); text-transform: uppercase; letter-spacing: 1px; }

        .info-group { margin-bottom: 25px; }
        .info-label { font-size: 11px; text-transform: uppercase; color: var(--text-gray); letter-spacing: 1px; margin-bottom: 5px; }
        .info-value { font-size: 16px; color: var(--text-dark); line-height: 1.5; }

        .total-amount { font-family: 'Playfair Display', serif; font-size: 28px; color: var(--brand-color); font-weight: 600; }

        .status-badge { padding: 6px 15px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; display: inline-block; margin-top: 5px; }
        .status-processing { background: #e2e3e5; color: #383d41; }
        .status-paid { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #cce5ff; color: #004085; }
        .status-delivered { background: #d4edda; color: #155724; }

    </style>
</head>
<body>

    <header class="header-main">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>
        <a href="/orders" class="back-link"><i class="fas fa-arrow-left"></i> Back to Orders</a>
    </header>

    <div class="receipt-container">
        <div class="receipt-header">
            <div>
                <h1 class="order-title serif-font">Order #${order.id}</h1>
                <div class="status-badge status-${order.status.toLowerCase()}">${order.status}</div>
            </div>
            <div class="order-date">${order.orderDate}</div>
        </div>

        <div class="info-group">
            <div class="info-label">Shipping Destination</div>
            <div class="info-value">${order.shippingAddress}</div>
        </div>

        <div class="info-group" style="margin-top: 40px; padding-top: 20px; border-top: 1px solid var(--border-light);">
            <div class="info-label">Total Investment</div>
            <div class="total-amount">₹ ${order.totalAmount}</div>
        </div>

        </div>

</body>
</html>