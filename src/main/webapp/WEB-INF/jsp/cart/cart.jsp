<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h2>Your Shopping Cart</h2>
        <c:choose>
            <c:when test="${empty cartItems}">
                <p>Your cart is empty. <a href="/products">Go shopping!</a></p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td>${item.product.name}</td>
                                <td>$${item.product.price}</td>
                                <td>${item.quantity}</td>
                                <td>$${item.product.price * item.quantity}</td>
                                <td><a href="/cart/remove/${item.id}" class="btn-danger">Remove</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <h3>Grand Total: $${cartTotal}</h3>
                
                <hr/>
                <h3>Checkout Details</h3>
                <form action="/orders/create" method="POST">
                    <label>Shipping Address:</label>
                    <textarea name="shippingAddress" required placeholder="Enter delivery address..."></textarea>
                    <br/><br/>
                    <button type="submit" class="btn-success">Place Order & Proceed to Payment</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>