<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 30px;
        }

        .container {
            width: 90%;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .top-actions {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        a.button {
            background-color: #007bff;
            color: white;
            padding: 9px 14px;
            text-decoration: none;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th {
            background-color: #343a40;
            color: white;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .view {
            background-color: #28a745;
            color: white;
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 4px;
        }

        .edit {
            background-color: #ffc107;
            color: black;
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 4px;
        }

        .delete {
            background-color: #dc3545;
            color: white;
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 4px;
        }

        .pagination {
            margin-top: 25px;
            text-align: center;
        }

        .pagination a {
            padding: 8px 12px;
            border: 1px solid #007bff;
            margin: 3px;
            text-decoration: none;
            color: #007bff;
            border-radius: 4px;
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
        }

        .pagination a.disabled {
            pointer-events: none;
            color: gray;
            border-color: gray;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Product Management</h2>

    <div class="top-actions">
        <div>
            <a href="${pageContext.request.contextPath}/products/add" class="button">Add Product</a>
            <a href="${pageContext.request.contextPath}/categories" class="button">Manage Categories</a>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/products" class="button">Refresh</a>
        </div>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Product Image</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="product" items="${productPage.content}">
            <tr>
                <td>${product.id}</td>

                <td>
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <img src="${product.imageUrl}" width="70" height="70" alt="Product Image"/>
                        </c:when>
                        <c:otherwise>
                            No Image
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>${product.name}</td>

                <td>
                    <c:choose>
                        <c:when test="${not empty product.category}">
                            ${product.category.name}
                        </c:when>
                        <c:otherwise>
                            No Category
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>₹${product.price}</td>
                <td>${product.quantity}</td>

                <td>
                    <a href="${pageContext.request.contextPath}/products/${product.id}" class="view">View</a>
                    <a href="${pageContext.request.contextPath}/products/edit/${product.id}" class="edit">Edit</a>
                    <a href="${pageContext.request.contextPath}/products/delete/${product.id}"
                       class="delete"
                       onclick="return confirm('Are you sure you want to delete this product?');">
                        Delete
                    </a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty productPage.content}">
            <tr>
                <td colspan="7">No products available</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="pagination">

        <c:if test="${totalPages > 0}">

            <c:choose>
                <c:when test="${currentPage > 0}">
                    <a href="${pageContext.request.contextPath}/products?page=${currentPage - 1}&size=5">Previous</a>
                </c:when>
                <c:otherwise>
                    <a class="disabled">Previous</a>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                <a href="${pageContext.request.contextPath}/products?page=${i}&size=5"
                   class="${i == currentPage ? 'active' : ''}">
                    ${i + 1}
                </a>
            </c:forEach>

            <c:choose>
                <c:when test="${currentPage + 1 < totalPages}">
                    <a href="${pageContext.request.contextPath}/products?page=${currentPage + 1}&size=5">Next</a>
                </c:when>
                <c:otherwise>
                    <a class="disabled">Next</a>
                </c:otherwise>
            </c:choose>

        </c:if>

    </div>

</div>

</body>
</html>