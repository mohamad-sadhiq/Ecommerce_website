<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reviews | Admin Console</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-white: #ffffff; --bg-cream: #faf9f7; --text-dark: #111111; --text-gray: #666666; --brand-color: #7b1e2e; --gold-accent: #cda53f; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-cream); color: var(--text-dark); font-family: 'Jost', sans-serif; display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; }

        .main-content { flex: 1; display: flex; flex-direction: column; height: 100vh; overflow: hidden; }
        .top-header { background: var(--bg-white); padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 15px rgba(0,0,0,0.02); z-index: 10; }
        .page-title { font-size: 24px; color: var(--brand-color); margin: 0; }

        .dashboard-content { flex: 1; padding: 40px; overflow-y: auto; background: var(--bg-cream); }
        .table-container { background: var(--bg-white); padding: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); border-radius: 6px; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 800px; }
        th { text-align: left; padding: 15px; border-bottom: 2px solid var(--border-light); color: var(--text-gray); font-size: 11px; text-transform: uppercase; letter-spacing: 1px; font-weight: 600; }
        td { padding: 18px 15px; border-bottom: 1px solid var(--border-light); vertical-align: middle; font-size: 14px; color: var(--text-dark); }
        tr:hover td { background-color: var(--bg-cream); }

        .rating-stars { color: var(--gold-accent); font-size: 12px; }
        .review-text { font-style: italic; color: #555; max-width: 300px; }

        .btn-delete { color: #d9534f; background: rgba(217, 83, 79, 0.1); padding: 8px 12px; border-radius: 4px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; transition: 0.3s; border: 1px solid transparent; }
        .btn-delete:hover { background: #d9534f; color: white; }

        .alert { padding: 15px; margin-bottom: 20px; border-radius: 4px; font-size: 13px; font-weight: 500; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    </style>
</head>
<body>

    <jsp:include page="admin-sidebar.jsp" />

    <main class="main-content">
        <header class="top-header">
            <h1 class="page-title serif-font">Customer Reviews</h1>
            <div style="font-size: 14px; font-weight: 500; color: var(--text-gray);">
                <i class="fas fa-user-shield" style="margin-right: 5px;"></i> Admin Area
            </div>
        </header>

        <div class="dashboard-content">

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success"><i class="fas fa-check-circle" style="margin-right: 5px;"></i> ${successMessage}</div>
            </c:if>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Rating</th>
                            <th>Review Content</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty reviews}">
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 40px; color: var(--text-gray);">
                                        <i class="fas fa-comment-slash" style="font-size: 30px; color: var(--border-light); margin-bottom: 15px; display: block;"></i>
                                        No reviews have been submitted yet.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="review" items="${reviews}">
                                    <tr>
                                        <td style="font-weight: 600;">#${review.id}</td>
                                        <td>${review.user.fullName}</td>
                                        <td class="rating-stars">
                                            <c:forEach begin="1" end="${review.rating}"><i class="fas fa-star"></i></c:forEach>
                                            <c:forEach begin="${review.rating + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                                        </td>
                                        <td class="review-text">"${review.content}"</td>
                                        <td style="font-size: 12px; color: var(--text-gray);">${review.createdAt.toLocalDate()}</td>
                                        <td>
                                            <a href="/admin/reviews/delete/${review.id}" class="btn-delete" onclick="return confirm('Are you sure you want to delete this review? This action cannot be undone.');">
                                                <i class="fas fa-trash-alt" style="margin-right: 5px;"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>