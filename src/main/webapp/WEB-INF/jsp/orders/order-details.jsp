<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h2>Order Details #${order.id}</h2>
        <p><strong>Date:</strong> ${order.orderDate}</p>
        <p><strong>Shipping Address:</strong> ${order.shippingAddress}</p>
        <p><strong>Total Amount:</strong> $${order.totalAmount}</p>
        <p><strong>Current Status:</strong> <span class="badge">${order.status}</span></p>

        <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <div class="admin-actions">
                <h3>Admin Control: Update Status</h3>
                <form action="/orders/update-status/${order.id}" method="POST">
                    <select name="status">
                        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        <option value="PAID" ${order.status == 'PAID' ? 'selected' : ''}>PAID</option>
                        <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>SHIPPED</option>
                        <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                    </select>
                    <button type="submit">Update Status</button>
                </form>
            </div>
        </c:if>

        <p><a href="/orders">Back to Order History</a></p>
    </div>
</body>
</html>