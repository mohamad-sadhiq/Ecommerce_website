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

        .dashboard-container { padding: 40px; max-width: 1400px; margin: 0 auto; width: 100%; }
        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        .controls-wrapper { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .tab-group { display: flex; gap: 10px; }
        .tab-btn { padding: 10px 20px; border: 1px solid var(--border-light); background: var(--bg-panel); border-radius: 4px; cursor: pointer; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); transition: 0.3s; }
        .tab-btn:hover { background: var(--bg-main); color: var(--brand-color); }
        .tab-btn.active { background: var(--brand-color); color: white; border-color: var(--brand-color); }

        .search-group { display: flex; gap: 15px; }
        .search-group input { padding: 10px 15px; border: 1px solid var(--border-light); border-radius: 4px; outline: none; font-size: 13px; font-family: 'Jost', sans-serif; }
        .search-group input:focus { border-color: var(--brand-color); }

        .panel { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #fdfdfd; padding: 18px 25px; text-align: left; font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); border-bottom: 1px solid var(--border-light); }
        td { padding: 15px 25px; border-bottom: 1px solid var(--border-light); font-size: 14px; color: var(--text-dark); vertical-align: middle; }
        tr:hover { background: var(--bg-main); }

        .badge { padding: 5px 12px; border-radius: 20px; font-size: 10px; text-transform: uppercase; font-weight: 600; letter-spacing: 1px; }
        .status-paid { background: #d1ecf1; color: #0c5460; }
        .status-shipped { background: #cce5ff; color: #004085; }
        .status-delivered { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }

        .btn-outline { background: transparent; color: var(--brand-color); padding: 8px 15px; border-radius: 4px; font-size: 11px; text-transform: uppercase; font-weight: 600; border: 1px solid var(--brand-color); cursor: pointer; transition: 0.3s; }
        .btn-outline:hover { background: var(--brand-color); color: white; }

        .btn-items { padding: 6px 12px; background: #f8f9fa; border: 1px solid var(--border-light); border-radius: 4px; font-size: 11px; text-transform: uppercase; font-weight: 600; cursor: pointer; transition: 0.3s; color: var(--text-dark); }
        .btn-items:hover { background: var(--border-light); }

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
                <h1 class="serif-font">Priority Order Queue</h1>
                <p>Manage incoming client orders, filter by status, and track fulfillment.</p>
            </div>

            <div class="controls-wrapper">
                <div class="tab-group">
                    <button class="tab-btn active" data-tab="ALL">All Active</button>
                    <button class="tab-btn" data-tab="PAID">New / Paid</button>
                    <button class="tab-btn" data-tab="SHIPPED">Shipped</button>
                    <button class="tab-btn" data-tab="DELIVERED">Delivered</button>
                </div>
                <div class="search-group">
                    <input type="date" id="dateSearch" title="Filter by Order Date">
                    <input type="text" id="nameSearch" placeholder="Search Customer Name..." style="width: 250px;">
                </div>
            </div>

            <div class="panel">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date & Time</th>
                            <th>Customer</th>
                            <th>Products</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th style="text-align: right;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="orderTableBody">
                        <c:forEach var="order" items="${orders}">
                            <tr class="order-row" data-status="${order.status}" data-name="${order.user.fullName.toLowerCase()}" data-rawdate="${order.orderDate}">
                                <td style="font-weight: 600;">#${order.id}</td>
                                <td style="color: var(--text-gray); font-size: 12px; white-space: nowrap;">${order.orderDate}</td>
                                <td style="font-weight: 500;">${order.user.fullName}</td>

                                <td>
                                    <button class="btn-items" onclick="openItemsModal('order-items-${order.id}', '${order.id}', '${order.user.fullName}')">
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

                                <td class="serif-font" style="color: var(--brand-color); font-weight: 600; white-space: nowrap;">₹${order.totalAmount}</td>
                                <td><span class="badge status-${order.status.toLowerCase()}">${order.status}</span></td>

                               <td style="text-align: right;">
                                   <form action="/admin/orders/update-status/${order.id}" method="POST" style="display: flex; gap: 8px; justify-content: flex-end; align-items: center;">
                                       <select name="status" style="padding: 6px; border: 1px solid var(--border-light); border-radius: 4px; font-size: 11px; text-transform: uppercase; outline: none; cursor: pointer;">
                                           <option value="PAID" <c:if test="${order.status == 'PAID'}">selected</c:if>>Paid / New</option>
                                           <option value="SHIPPED" <c:if test="${order.status == 'SHIPPED'}">selected</c:if>>Shipped</option>
                                           <option value="DELIVERED" <c:if test="${order.status == 'DELIVERED'}">selected</c:if>>Delivered</option>
                                       </select>
                                       <button type="submit" class="btn-outline" style="padding: 6px 12px;">Update</button>
                                   </form>
                               </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr><td colspan="7" style="text-align: center; padding: 40px; color: var(--text-gray);">No orders currently available in the queue.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <div class="modal-overlay" id="itemsModal">
        <div class="modal-content">
            <i class="fas fa-times close-btn" onclick="closeItemsModal()"></i>
            <h2 class="modal-header" id="modal-title">Order Items</h2>
            <div class="modal-body" id="modal-items-container">
                </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const tabs = document.querySelectorAll(".tab-btn");
            const rows = document.querySelectorAll(".order-row");
            const nameSearch = document.getElementById("nameSearch");
            const dateSearch = document.getElementById("dateSearch");

            let currentStatus = "ALL";

            function filterTable() {
                const searchNameVal = nameSearch.value.toLowerCase().trim();
                let searchDateVal = "";
                if (dateSearch.value) {
                    const d = new Date(dateSearch.value);
                    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                    const day = String(d.getDate()).padStart(2, '0');
                    const month = months[d.getMonth()];
                    const year = d.getFullYear();
                    searchDateVal = `\${day} \${month} \${year}`;
                }

                rows.forEach(row => {
                    const rowStatus = row.getAttribute("data-status");
                    const rowName = row.getAttribute("data-name");
                    const rowDate = row.getAttribute("data-rawdate");

                    const matchesStatus = currentStatus === "ALL" || rowStatus === currentStatus;
                    const matchesName = rowName.includes(searchNameVal);
                    const matchesDate = searchDateVal === "" || rowDate.includes(searchDateVal);

                    if (matchesStatus && matchesName && matchesDate) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }

            tabs.forEach(tab => {
                tab.addEventListener("click", () => {
                    tabs.forEach(t => t.classList.remove("active"));
                    tab.classList.add("active");
                    currentStatus = tab.getAttribute("data-tab");
                    filterTable();
                });
            });

            nameSearch.addEventListener("input", filterTable);
            dateSearch.addEventListener("change", filterTable);
        });

        function openItemsModal(dataId, orderNum, customerName) {
            document.getElementById('modal-title').innerText = "Order #" + orderNum + " - " + customerName;
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