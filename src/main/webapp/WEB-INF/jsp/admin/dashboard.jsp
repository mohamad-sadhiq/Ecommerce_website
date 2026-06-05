<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Category Management</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            padding: 30px;
        }

        .container {
            width: 850px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
        }

        h2, h3 {
            text-align: center;
        }

        label {
            display: block;
            margin-top: 12px;
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            padding: 9px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 15px;
            padding: 9px 14px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .top-actions {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 8px 13px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
            margin: 2px;
            display: inline-block;
        }

        .btn-blue {
            background-color: #007bff;
        }

        .btn-green {
            background-color: #28a745;
        }

        .btn-warning {
            background-color: #ffc107;
            color: black;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-gray {
            background-color: #6c757d;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th {
            background-color: #343a40;
            color: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 11px;
            text-align: center;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Category Management</h2>

    <div class="top-actions">
        <div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-green">View Products</a>
            <a href="${pageContext.request.contextPath}/products/add" class="btn btn-blue">Add Product</a>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/categories" class="btn btn-gray">Refresh</a>
        </div>
    </div>

    <h3>Add Category</h3>

    <form action="${pageContext.request.contextPath}/categories/add" method="post">
        <label>Category Name</label>
        <input type="text" name="name" placeholder="Example: Gold, Rings, Chains" required>

        <label>Description</label>
        <textarea name="description" rows="3" placeholder="Enter category description"></textarea>

        <button type="submit">Add Category</button>
    </form>

    <h3>Existing Categories</h3>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Category Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="category" items="${categories}">
            <tr>
                <td>${category.id}</td>
                <td>${category.name}</td>
                <td>${category.description}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/categories/edit/${category.id}" class="btn btn-warning">Edit</a>

                    <a href="${pageContext.request.contextPath}/categories/delete/${category.id}"
                       class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to delete this category?');">
                        Delete
                    </a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty categories}">
            <tr>
                <td colspan="4">No categories available.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

</div>

</body>
</html>