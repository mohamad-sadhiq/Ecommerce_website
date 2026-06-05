<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            padding: 30px;
        }

        .container {
            width: 700px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
        }

        .image-box {
            text-align: center;
            margin-bottom: 20px;
        }

        .image-box img {
            max-width: 250px;
            max-height: 250px;
            object-fit: cover;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .no-image {
            color: gray;
            border: 1px solid #ddd;
            display: inline-block;
            padding: 30px;
            border-radius: 6px;
        }

        p {
            font-size: 16px;
            line-height: 1.6;
        }

        .actions {
            text-align: center;
            margin-top: 20px;
        }

        .btn {
            padding: 8px 14px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
            margin: 5px;
            display: inline-block;
        }

        .btn-blue {
            background-color: #007bff;
        }

        .btn-warning {
            background-color: #ffc107;
            color: black;
        }

        .btn-gray {
            background-color: #6c757d;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Product Details</h2>

    <div class="image-box">
        <c:choose>
            <c:when test="${not empty product.imageUrl}">
                <img src="${product.imageUrl}" alt="Product Image">
            </c:when>
            <c:otherwise>
                <div class="no-image">No Image Available</div>
            </c:otherwise>
        </c:choose>
    </div>

    <p><strong>ID:</strong> ${product.id}</p>
    <p><strong>Name:</strong> ${product.name}</p>
    <p><strong>Description:</strong> ${product.description}</p>
    <p><strong>Price:</strong> ₹${product.price}</p>
    <p><strong>Quantity:</strong> ${product.quantity}</p>

    <p>
        <strong>Category:</strong>
        <c:choose>
            <c:when test="${not empty product.category}">
                ${product.category.name}
            </c:when>
            <c:otherwise>
                No Category
            </c:otherwise>
        </c:choose>
    </p>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-gray">Back</a>
        <a href="${pageContext.request.contextPath}/products/edit/${product.id}" class="btn btn-warning">Edit</a>
        <a href="${pageContext.request.contextPath}/products/${product.id}" class="btn btn-blue">Refresh</a>
    </div>

</div>

</body>
</html>