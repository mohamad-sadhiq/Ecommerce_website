<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Profile | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-main: #f8f9fa; --bg-panel: #ffffff; --text-dark: #111111; --text-gray: #6c757d; --brand-color: #4A235A; --gold-accent: #cda53f; --border-light: #e9ecef; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-dark); display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; font-weight: 400; }
        a { text-decoration: none; transition: 0.3s; }

        .main-content { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
        .topbar { background: var(--bg-panel); height: 70px; display: flex; align-items: center; justify-content: space-between; padding: 0 40px; border-bottom: 1px solid var(--border-light); z-index: 5; }
        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 40px; max-width: 900px; width: 100%; margin: 0 auto; display: flex; flex-direction: column; height: calc(100vh - 70px); overflow-y: auto; animation: fadeIn 0.4s ease-out; scroll-behavior: smooth; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        .back-link { font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 25px; display: inline-flex; align-items: center; gap: 8px; font-weight: 600; }
        .back-link:hover { color: var(--brand-color); }

        .profile-card { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 6px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); overflow: hidden; }
        .profile-header { background: #fdfdfd; padding: 40px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; gap: 30px; }

        .client-avatar { width: 80px; height: 80px; background: var(--gold-accent); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 36px; }
        .client-title h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .client-title p { color: var(--text-gray); font-size: 14px; letter-spacing: 1px; }

        .role-badge { display: inline-block; padding: 5px 15px; font-size: 10px; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; border-radius: 20px; margin-top: 10px; border: 1px solid var(--border-light); background: var(--bg-main); color: var(--text-dark); }
        .role-admin { background: #fbe5e9; color: var(--brand-color); border-color: #f5c6cb; }

        .profile-body { padding: 40px; display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }

        .info-group { margin-bottom: 25px; }
        .info-label { font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-gray); margin-bottom: 8px; font-weight: 600; display: flex; align-items: center; gap: 8px; }
        .info-value { font-size: 15px; color: var(--text-dark); background: #f8fafc; padding: 14px 18px; border-radius: 4px; border: 1px solid var(--border-light); line-height: 1.5; }

        .empty-val { color: #adb5bd; font-style: italic; font-size: 14px; }

        .wishlist-item-card { width: 120px; text-align: center; border: 1px solid var(--border-light); border-radius: 6px; padding: 10px; background: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.02); }
        .wishlist-item-card img { width: 100%; height: 90px; object-fit: contain; margin-bottom: 8px; mix-blend-mode: multiply; }
        .wishlist-item-card .name { font-size: 11px; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: var(--text-dark); }
        .wishlist-item-card .price { font-size: 11px; color: var(--brand-color); margin-top: 4px; font-weight: bold; }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/jsp/admin/admin-sidebar.jsp" %>

    <main class="main-content">
        <header class="topbar">
            <div></div>
            <div class="admin-profile">
                <span>${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName : 'Administrator'}</span>
                <div class="admin-avatar">
                    ${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName.substring(0,1).toUpperCase() : 'A'}
                </div>
            </div>
        </header>

        <div class="dashboard-container">
            <a href="/admin/users" class="back-link"><i class="fas fa-arrow-left"></i> Return to Database</a>

            <div class="profile-card">
                <div class="profile-header">
                    <div class="client-avatar">
                        ${clientProfile.fullName.substring(0,1).toUpperCase()}
                    </div>
                    <div class="client-title">
                        <h1 class="serif-font">${clientProfile.fullName}</h1>
                        <p><i class="far fa-id-badge"></i> Client ID: #${clientProfile.id}</p>
                        <span class="role-badge ${clientProfile.role == 'ADMIN' ? 'role-admin' : ''}">
                            ${clientProfile.role}
                        </span>
                    </div>
                </div>

                <div class="profile-body">
                    <div>
                        <h3 class="serif-font" style="font-size: 20px; border-bottom: 1px solid var(--border-light); padding-bottom: 10px; margin-bottom: 25px;">Contact Information</h3>

                        <div class="info-group">
                            <div class="info-label"><i class="far fa-envelope"></i> Email Address</div>
                            <div class="info-value">${clientProfile.email}</div>
                        </div>

                        <div class="info-group">
                            <div class="info-label"><i class="fas fa-phone-alt"></i> Phone Number</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty clientProfile.phoneNumber}">${clientProfile.phoneNumber}</c:when>
                                    <c:otherwise><span class="empty-val">Not provided</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div>
                        <h3 class="serif-font" style="font-size: 20px; border-bottom: 1px solid var(--border-light); padding-bottom: 10px; margin-bottom: 25px;">Shipping Details</h3>

                        <div class="info-group">
                            <div class="info-label"><i class="fas fa-map-marker-alt"></i> Primary Address</div>
                            <div class="info-value" style="min-height: 110px;">
                                <c:choose>
                                    <c:when test="${not empty clientProfile.address}">${clientProfile.address}</c:when>
                                    <c:otherwise><span class="empty-val">No shipping address on file</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div id="client-wishlist" style="grid-column: 1 / -1; margin-top: 10px; padding-top: 20px;">
                        <h3 class="serif-font" style="font-size: 20px; border-bottom: 1px solid var(--border-light); padding-bottom: 10px; margin-bottom: 20px;">
                            <i class="fas fa-heart" style="color: #d9534f; margin-right: 8px;"></i> Client's Current Wishlist
                        </h3>

                        <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                            <c:choose>
                                <c:when test="${not empty clientWishlist}">
                                    <c:forEach var="wItem" items="${clientWishlist}">
                                        <div class="wishlist-item-card">
                                            <img src="${wItem.product.imageUrl}" alt="${wItem.product.name}">
                                            <div class="name" title="${wItem.product.name}">${wItem.product.name}</div>
                                            <div class="price">₹${wItem.product.price}</div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span class="empty-val">This client currently has no items saved to their wishlist.</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

</body>
</html>