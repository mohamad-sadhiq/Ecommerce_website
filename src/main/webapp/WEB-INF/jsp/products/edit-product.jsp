<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            padding: 30px;
        }

        .container {
            width: 500px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            margin-top: 12px;
            font-weight: bold;
        }

        input, textarea, select {
            width: 100%;
            padding: 9px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 18px;
            width: 100%;
            padding: 10px;
            background-color: #ffc107;
            border: none;
            color: black;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #e0a800;
        }

        .back {
            display: block;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">

    <h2>Edit Product</h2>

    <form action="/products/update/${product.id}" method="post">

        <label>Product Name</label>
        <input type="text" name="name" value="${product.name}" required>

        <label>Description</label>
        <textarea name="description" rows="4" required>${product.description}</textarea>

        <label>Price</label>
        <input type="number" step="0.01" name="price" value="${product.price}" required>

        <label>Quantity</label>
        <input type="number" name="quantity" value="${product.quantity}" required>

        <label>Image URL</label>
        <input type="text" name="imageUrl" value="${product.imageUrl}">

        <label>Category</label>
        <select name="categoryId" required>
            <option value="">-- Select Category --</option>

            <c:forEach var="category" items="${categories}">
                <option value="${category.id}"
                    <c:if test="${product.category.id == category.id}">selected</c:if>>
                    ${category.name}
                </option>
            </c:forEach>
        </select>

        <button type="submit">Update Product</button>
    </form>

    <a href="/products" class="back">Back to Products</a>

</div>

</body>
</html>