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
        :root { --bg-white: #ffffff; --bg-cream: #faf9f7; --text-dark: #111111; --text-gray: #666666; --brand-color: #7b1e2e; --gold-accent: #cda53f; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-cream); color: var(--text-dark); font-family: 'Jost', sans-serif; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.3s; }

        .utility-bar { background-color: var(--brand-color); color: white; text-align: center; padding: 12px; font-size: 11px; letter-spacing: 2px; text-transform: uppercase; font-weight: 500; }
        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); }
        .brand-logo { font-size: 28px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }
        .back-link { font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-link:hover { color: var(--brand-color); }

        .page-wrapper { max-width: 1000px; margin: 60px auto; padding: 0 40px; animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .page-title { font-size: 32px; margin-bottom: 40px; color: var(--text-dark); border-bottom: 1px solid var(--border-light); padding-bottom: 20px; }

        .table-container { background: var(--bg-white); padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); border-radius: 4px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; border-bottom: 2px solid var(--border-light); color: var(--text-gray); font-size: 11px; text-transform: uppercase; letter-spacing: 1px; }
        td { padding: 20px 15px; border-bottom: 1px solid var(--border-light); vertical-align: middle; font-size: 14px; }
        tr:hover td { background-color: #fafafa; }

        .order-id { font-family: 'Playfair Display', serif; font-weight: 600; color: var(--brand-color); font-size: 16px; }
        .order-price { font-weight: 600; font-family: 'Playfair Display', serif; color: var(--text-dark); }

        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 10px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; display: inline-block; }
        .status-processing { background: #e2e3e5; color: #383d41; }
        .status-paid { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #cce5ff; color: #004085; }
        .status-delivered { background: #d4edda; color: #155724; }

        .btn-view, .btn-items { display: inline-block; padding: 8px 15px; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; transition: 0.3s; cursor: pointer; border-radius: 4px; }
        .btn-items { background: #f8f9fa; border: 1px solid var(--border-light); color: var(--text-dark); }
        .btn-items:hover { background: var(--border-light); }
        .btn-view { background: transparent; border: 1px solid var(--gold-accent); color: var(--text-dark); }
        .btn-view:hover { background: var(--gold-accent); color: white; }

        /* MODAL STYLING */
        .modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.6); backdrop-filter: blur(4px); display: flex; justify-content: center; align-items: center; z-index: 2000; opacity: 0; visibility: hidden; transition: 0.3s; }
        .modal-overlay.active { opacity: 1; visibility: visible; }
        .modal-content { background: white; width: 500px; max-width: 90%; border-radius: 8px; padding: 30px; position: relative; transform: translateY(20px); transition: 0.3s; max-height: 80vh; display: flex; flex-direction: column; }
        .modal-overlay.active .modal-content { transform: translateY(0); }
        .modal-header { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--brand-color); margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid var(--border-light); }
        .close-btn { position: absolute; top: 20px; right: 20px; font-size: 20px; color: var(--text-gray); cursor: pointer; transition: 0.3s; }
        .close-btn:hover { color: var(--brand-color); }

        .modal-body { overflow-y: auto; flex: 1; padding-right: 10px; }
        .modal-item-row { display: flex; align-items: center; gap: 15px; padding: 15px 0; border-bottom: 1px solid var(--border-light); }
        .modal-item-row:last-child { border-bottom: none; }
        .modal-item-img { width: 60px; height: 60px; object-fit: contain; mix-blend-mode: multiply; border: 1px solid var(--border-light); border-radius: 4px; padding: 5px; }
        .modal-item-details { flex: 1; }
        .modal-item-name { font-weight: 600; font-size: 14px; color: var(--text-dark); }
        .modal-item-qty { font-size: 12px; color: var(--text-gray); margin-top: 4px; }
        .modal-item-price { font-weight: 600; color: var(--brand-color); }
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
                <div style="text-align: center; padding: 80px 0; background: var(--bg-white); box-shadow: 0 10px 30px rgba(0,0,0,0.02);">
                    <i class="fas fa-box-open" style="font-size: 50px; color: var(--border-light); margin-bottom: 20px;"></i>
                    <h3 class="serif-font" style="font-size: 22px; color: var(--text-dark); margin-bottom: 15px;">No orders found</h3>
                    <p style="color: var(--text-gray); margin-bottom: 30px;">You haven't placed any completed orders yet.</p>
                    <a href="/" class="btn-view" style="padding: 12px 30px; background: var(--brand-color); color: white; border-color: var(--brand-color);">Discover Collections</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Date Ordered</th>
                                <th>Products</th>
                                <th>Total Amount</th>
                                <th>Status</th>
                                <th style="text-align: right;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="order-id">#${order.id}</td>
                                    <td style="color: var(--text-gray);">${order.orderDate}</td>

                                    <td>
                                        <button class="btn-items" onclick="openItemsModal('order-items-${order.id}', '${order.id}')">
                                            <i class="far fa-eye"></i> View Items (${order.orderItems.size()})
                                        </button>

                                        <div id="order-items-${order.id}" style="display: none;">
                                            <c:forEach var="item" items="${order.orderItems}">
                                                <div class="modal-item-row">
                                                    <img src="${item.product.imageUrl}" class="modal-item-img">
                                                    <div class="modal-item-details">
                                                        <div class="modal-item-name">${item.product.name}</div>
                                                        <div class="modal-item-qty">Qty: ${item.quantity}</div>
                                                    </div>
                                                    <div class="modal-item-price">₹${item.price}</div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </td>

                                    <td class="order-price">₹ ${order.totalAmount}</td>
                                    <td><span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span></td>
                                    <td style="text-align: right;">
                                        <a href="/orders/${order.id}" class="btn-view">Receipt</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="modal-overlay" id="itemsModal">
        <div class="modal-content">
            <i class="fas fa-times close-btn" onclick="closeItemsModal()"></i>
            <h2 class="modal-header" id="modal-title">Order Items</h2>
            <div class="modal-body" id="modal-items-container">
                </div>
        </div>
    </div>

    <script>
        function openItemsModal(dataId, orderNum) {
            document.getElementById('modal-title').innerText = "Items in Order #" + orderNum;
            const content = document.getElementById(dataId).innerHTML;
            document.getElementById('modal-items-container').innerHTML = content;
            document.getElementById('itemsModal').classList.add('active');
        }
        function closeItemsModal() {
            document.getElementById('itemsModal').classList.remove('active');
        }
    </script>
</body>
</html>