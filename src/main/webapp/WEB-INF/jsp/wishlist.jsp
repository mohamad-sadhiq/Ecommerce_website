<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-white: #ffffff; --bg-cream: #faf9f7; --text-dark: #111111; --text-gray: #666666; --brand-color: #7b1e2e; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-cream); color: var(--text-dark); }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; transition: 0.3s; }

        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); }
        .brand-logo { font-size: 28px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }
        .back-link { font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-link:hover { color: var(--brand-color); }

        .wrapper { max-width: 1200px; margin: 60px auto; padding: 0 40px; animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .page-title { font-size: 36px; margin-bottom: 40px; color: var(--text-dark); border-bottom: 1px solid var(--border-light); padding-bottom: 20px; }

        .empty-state { text-align: center; padding: 80px 0; background: var(--bg-white); border-radius: 8px; border: 1px solid var(--border-light); }
        .empty-state i { font-size: 60px; color: #ffebf0; margin-bottom: 20px; }
        .empty-state h3 { font-size: 24px; color: var(--text-dark); margin-bottom: 15px; }
        .btn-main { display: inline-block; padding: 15px 40px; background: var(--brand-color); color: white; text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 2px; border-radius: 4px; border: 1px solid var(--brand-color); transition: 0.3s; }
        .btn-main:hover { background: transparent; color: var(--brand-color); }

        .wishlist-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 30px; }
        .product-card { background: white; border: 1px solid var(--border-light); border-radius: 8px; overflow: hidden; transition: 0.3s; position: relative; }
        .product-card:hover { box-shadow: 0 15px 30px rgba(0,0,0,0.05); transform: translateY(-5px); border-color: var(--brand-color); }

        .remove-btn { position: absolute; top: 10px; right: 10px; background: white; border: 1px solid var(--border-light); border-radius: 50%; width: 30px; height: 30px; display: flex; justify-content: center; align-items: center; color: #d9534f; z-index: 10; cursor: pointer; transition: 0.3s; }
        .remove-btn:hover { background: #d9534f; color: white; }

        .img-wrap { height: 250px; background: #fdfdfd; padding: 20px; }
        .img-wrap img { width: 100%; height: 100%; object-fit: contain; }

        .info { padding: 20px; text-align: center; border-top: 1px solid var(--border-light); }
        .price { font-size: 18px; font-weight: 600; color: var(--brand-color); margin-bottom: 5px; font-family: 'Playfair Display', serif; }
        .name { font-size: 12px; color: #555; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; }
        .add-cart-btn { width: 100%; padding: 10px; background: transparent; color: var(--text-dark); border: 1px solid var(--border-light); text-transform: uppercase; font-size: 10px; font-weight: 600; letter-spacing: 1px; cursor: pointer; border-radius: 4px; transition: 0.3s; }
        .add-cart-btn:hover { background: var(--brand-color); color: white; border-color: var(--brand-color); }
    </style>
</head>
<body>

    <header class="header-main">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>
        <a href="/" class="back-link"><i class="fas fa-arrow-left"></i> Continue Shopping</a>
    </header>

    <div class="wrapper">
        <h1 class="page-title serif-font">My Wishlist</h1>

        <c:choose>
            <c:when test="${empty wishlistItems}">
                <div class="empty-state">
                    <i class="fas fa-heart" style="color: var(--brand-color);"></i>
                    <h3 class="serif-font">Your wishlist is currently empty</h3>
                    <p style="color: var(--text-gray); margin-bottom: 30px;">Save your favorite pieces here to review them later.</p>
                    <a href="/" class="btn-main">Discover Collections</a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="wishlist-grid">
                    <c:forEach var="item" items="${wishlistItems}">
                        <div class="product-card">
                            <a href="/wishlist/remove/${item.id}" class="remove-btn"><i class="fas fa-times"></i></a>
                            <div class="img-wrap">
                                <img src="${item.product.imageUrl}" alt="${item.product.name}">
                            </div>
                            <div class="info">
                                <div class="price">₹ ${item.product.price}</div>
                                <div class="name">${item.product.name}</div>
                                <form action="/cart/add" method="POST">
                                    <input type="hidden" name="productId" value="${item.product.id}">
                                    <button type="submit" class="add-cart-btn">Move to Cart</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>