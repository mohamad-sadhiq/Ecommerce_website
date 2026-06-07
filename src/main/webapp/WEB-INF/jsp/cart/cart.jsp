<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Bag | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-white: #ffffff;
            --bg-cream: #faf9f7;
            --text-dark: #111111;
            --text-gray: #666666;
            --brand-color: #7b1e2e;
            --gold-accent: #cda53f;
            --border-light: #eaeaea;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-cream); color: var(--text-dark); font-family: 'Jost', sans-serif; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.3s; }

        /* === HEADER === */
        .utility-bar { background-color: var(--brand-color); color: white; text-align: center; padding: 12px; font-size: 11px; letter-spacing: 2px; text-transform: uppercase; font-weight: 500; }
        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); }
        .brand-logo { font-size: 28px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }
        .header-actions { display: flex; gap: 30px; align-items: flex-end; }
        .action-item { position: relative; display: flex; flex-direction: column; align-items: center; font-size: 14px; color: #333; transition: 0.3s; font-weight: 500; padding-bottom: 10px; margin-bottom: -10px; }
        .action-item i { font-size: 24px; margin-bottom: 5px; color: var(--text-gray); transition: 0.3s; font-weight: 900; }
        .action-item:hover, .action-item:hover i { color: var(--brand-color); }

        /* === CART CONTAINER === */
        .cart-wrapper { max-width: 1400px; margin: 60px auto; padding: 0 40px; animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .page-title { font-size: 36px; margin-bottom: 40px; color: var(--text-dark); border-bottom: 1px solid var(--border-light); padding-bottom: 20px; }

        /* === EMPTY CART === */
        .empty-cart { text-align: center; padding: 80px 0; background: var(--bg-white); border-radius: 8px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); }
        .empty-cart i { font-size: 60px; color: var(--border-light); margin-bottom: 20px; }
        .empty-cart h3 { font-size: 24px; color: var(--text-dark); margin-bottom: 15px; }
        .empty-cart p { color: var(--text-gray); margin-bottom: 30px; }

        /* === CART LAYOUT === */
        .cart-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 60px; align-items: start; }

        .cart-items-section { background: var(--bg-white); padding: 50px; box-shadow: 0 15px 40px rgba(0,0,0,0.03); border-radius: 8px; border: 1px solid var(--border-light); }
        .cart-table { width: 100%; border-collapse: collapse; }
        .cart-table th { text-align: left; padding-bottom: 20px; border-bottom: 2px solid var(--border-light); color: var(--text-gray); font-size: 11px; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; }
        .cart-table td { padding: 35px 0; border-bottom: 1px solid var(--border-light); vertical-align: middle; }
        .cart-table tr:last-child td { border-bottom: none; padding-bottom: 0; }

        .product-cell { display: flex; align-items: center; gap: 25px; }
        .product-img-wrap { width: 110px; height: 110px; background: var(--bg-cream); display: flex; align-items: center; justify-content: center; border-radius: 6px; border: 1px solid var(--border-light); padding: 10px; }
        .product-img { width: 100%; height: 100%; object-fit: contain; mix-blend-mode: multiply; }

        .product-name { font-size: 15px; font-weight: 500; color: var(--text-dark); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .product-price-sub { color: var(--text-gray); font-size: 13px; }

        .price-text { font-family: 'Playfair Display', serif; font-size: 22px; color: var(--brand-color); font-weight: 600; }

        .btn-remove { color: #a1a1a1; transition: 0.3s; font-size: 18px; display: inline-block; padding: 10px; border-radius: 50%; border: 1px solid transparent; }
        .btn-remove:hover { color: #d9534f; border-color: #d9534f; transform: scale(1.05); }

        /* === CHECKOUT SECTION === */
        .checkout-section { background: var(--brand-color); color: white; padding: 50px; border-radius: 8px; position: sticky; top: 40px; box-shadow: 0 20px 50px rgba(123, 30, 46, 0.15); }
        .checkout-title { font-size: 28px; border-bottom: 1px solid rgba(255,255,255,0.15); padding-bottom: 20px; margin-bottom: 35px; color: var(--gold-accent); }

        .summary-row { display: flex; justify-content: space-between; margin-bottom: 20px; font-size: 15px; color: rgba(255,255,255,0.85); letter-spacing: 0.5px; }
        .total-row { display: flex; justify-content: space-between; margin-top: 30px; padding-top: 25px; border-top: 1px solid rgba(255,255,255,0.2); font-size: 26px; font-weight: 600; color: white; }

        .checkout-form { margin-top: 45px; }
        .input-group { position: relative; margin-bottom: 35px; }
        .input-group label { display: block; font-size: 11px; text-transform: uppercase; letter-spacing: 2px; color: var(--gold-accent); margin-bottom: 12px; font-weight: 500; }
        .input-group textarea { width: 100%; padding: 18px; background: rgba(0,0,0,0.15); border: 1px solid rgba(255,255,255,0.2); color: white; font-family: 'Jost', sans-serif; outline: none; transition: 0.3s; resize: vertical; min-height: 120px; border-radius: 4px; font-size: 14px; }
        .input-group textarea:focus { border-color: var(--gold-accent); background: rgba(0,0,0,0.25); }
        .input-group textarea::placeholder { color: rgba(255,255,255,0.4); }

        .btn-main { width: 100%; padding: 20px; background: var(--gold-accent); color: white; text-transform: uppercase; font-size: 12px; font-weight: 600; letter-spacing: 3px; border: 1px solid var(--gold-accent); border-radius: 4px; transition: 0.4s; text-align: center; cursor: pointer; }
        .btn-main:hover { background: transparent; color: var(--gold-accent); }

        .security-badge { text-align: center; margin-top: 25px; font-size: 11px; color: rgba(255,255,255,0.5); text-transform: uppercase; letter-spacing: 1px; }

        @media (max-width: 1024px) {
            .cart-grid { grid-template-columns: 1fr; }
            .header-main { padding: 20px 30px; }
            .cart-wrapper { padding: 0 30px; }
        }
    </style>
</head>
<body>

    <div class="utility-bar">
        Secure Checkout | Complimentary Insured Shipping
    </div>

    <header class="header-main">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>

        <div class="header-actions">
            <a href="/stores" class="action-item"><i class="fas fa-location-dot"></i><span>Stores</span></a>
            <a href="/wishlist" class="action-item"><i class="fas fa-heart"></i><span>Wishlist</span></a>
            <a href="/" class="action-item"><i class="fas fa-arrow-left"></i><span>Shop</span></a>
        </div>
    </header>

    <div class="cart-wrapper">
        <h1 class="page-title serif-font">Your Shopping Bag</h1>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-cart">
                    <i class="fas fa-shopping-bag"></i>
                    <h3 class="serif-font">Your bag is beautifully empty</h3>
                    <p>Discover our latest collections of fine jewelry and find your perfect piece.</p>
                    <a href="/" class="btn-main" style="display: inline-block; width: auto; padding: 15px 40px;">Explore Collections</a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="cart-grid">

                    <div class="cart-items-section">
                        <table class="cart-table">
                            <thead>
                                <tr>
                                    <th>Item Details</th>
                                    <th style="text-align: center;">Quantity</th>
                                    <th style="text-align: right;">Total</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartItems}">
                                    <tr>
                                        <td>
                                            <div class="product-cell">
                                                <div class="product-img-wrap">
                                                    <img src="${not empty item.product.imageUrl ? item.product.imageUrl : 'https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=80&w=200&auto=format&fit=crop'}" class="product-img" alt="Jewelry">
                                                </div>
                                                <div>
                                                    <div class="product-name">${item.product.name}</div>
                                                    <div class="product-price-sub">Unit Price: ₹ ${item.product.price}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="font-size: 15px; font-weight: 500; text-align: center;">${item.quantity}</td>
                                        <td class="price-text" style="text-align: right;">₹ ${item.product.price * item.quantity}</td>
                                        <td style="text-align: right; padding-left: 20px;">
                                            <a href="/cart/remove/${item.id}" class="btn-remove" title="Remove Item"><i class="fas fa-trash-alt"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="checkout-section">
                        <h2 class="checkout-title serif-font">Order Summary</h2>

                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>₹ ${cartTotal}</span>
                        </div>
                        <div class="summary-row">
                            <span>Insured Shipping</span>
                            <span>Complimentary</span>
                        </div>

                        <div class="total-row serif-font">
                            <span>Total</span>
                            <span>₹ ${cartTotal}</span>
                        </div>

                        <form action="/orders/create" method="POST" class="checkout-form">
                            <div class="input-group">
                                <label for="shippingAddress">Secure Shipping Address</label>
                                <textarea name="shippingAddress" id="shippingAddress" required placeholder="Enter your full name, street address, city, state, and pincode..."></textarea>
                            </div>

                            <button type="submit" class="btn-main">Proceed to Secure Payment</button>
                        </form>

                        <div class="security-badge">
                            <i class="fas fa-lock" style="margin-right: 5px;"></i> 256-bit Encrypted Checkout
                        </div>
                    </div>

                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>