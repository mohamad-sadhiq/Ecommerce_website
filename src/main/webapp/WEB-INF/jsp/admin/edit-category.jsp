<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>

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

        input, textarea {
            width: 100%;
            padding: 9px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 15px;
            padding: 9px 14px;
            background-color: #ffc107;
            color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        a {
            margin-top: 15px;
            display: inline-block;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Edit Category</h2>

    <form action="${pageContext.request.contextPath}/categories/update/${category.id}" method="post">

        <label>Category Name</label>
        <input type="text" name="name" value="${category.name}" required>

        <label>Description</label>
        <textarea name="description" rows="3">${category.description}</textarea>

        <button type="submit">Update Category</button>

    </form>

    <a href="${pageContext.request.contextPath}/categories">Back to Categories</a>

</div>

</body>
</html>