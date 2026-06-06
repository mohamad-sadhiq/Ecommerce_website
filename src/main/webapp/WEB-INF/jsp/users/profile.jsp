<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile - E-Commerce</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        body { font-family: Arial, sans-serif; max-width: 500px; margin: 50px auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"] { width: 100%; padding: 8px; box-sizing: border-box; }
        button { padding: 10px 15px; background-color: #17a2b8; color: white; border: none; cursor: pointer; }
        .success { color: green; margin-bottom: 15px; padding: 10px; background-color: #d4edda; border-radius: 4px; }
        .readonly-field { background-color: #e9ecef; color: #495057; border: 1px solid #ced4da; }
    </style>
</head>
<body>
    <h2>Update Profile</h2>

    <c:if test="${not empty successMessage}">
        <div class="success">${successMessage}</div>
    </c:if>

    <form action="/profile/update" method="post">
        <div class="form-group">
            <label>Email Address (Cannot be changed):</label>
            <input type="text" value="${user.email}" class="readonly-field" readonly>
        </div>

        <div class="form-group">
            <label for="fullName">Full Name:</label>
            <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
        </div>

        <div class="form-group">
            <label for="phoneNumber">Phone Number:</label>
            <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">
        </div>

        <div class="form-group">
            <label for="address">Shipping Address:</label>
            <input type="text" id="address" name="address" value="${user.address}">
        </div>

        <button type="submit">Save Changes</button>
    </form>

    <p style="margin-top: 20px;">
        <a href="/home">&larr; Back to Dashboard</a>
    </p>
</body>
</html>