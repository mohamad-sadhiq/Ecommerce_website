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
            --bg-main: #f4f5f7;
            --bg-white: #ffffff;
            --text-dark: #111111;
            --text-gray: #757575;
            --brand-color: #7b1e2e;
            --gold-accent: #cda53f;
            --border-light: #eaeef2;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-main); color: var(--text-dark); font-family: 'Jost', sans-serif; overflow-x: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.3s; }

        .header-main { background: var(--bg-white); height: 70px; display: flex; justify-content: center; align-items: center; padding: 0 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.02); position: sticky; top: 0; z-index: 100; }
        .back-btn { position: absolute; left: 40px; font-size: 18px; color: var(--text-dark); }
        .brand-logo { font-size: 24px; font-weight: 600; color: var(--brand-color); letter-spacing: 3px; }

        .cart-wrapper { max-width: 1200px; margin: 40px auto; padding: 0 20px; display: grid; grid-template-columns: 1.6fr 1fr; gap: 30px; align-items: flex-start; }

        .left-col { display: flex; flex-direction: column; gap: 15px; }

        .cart-item-card { background: var(--bg-white); border-radius: 12px; padding: 20px; display: flex; gap: 20px; position: relative; box-shadow: 0 2px 8px rgba(0,0,0,0.02); }
        .item-img-wrap { width: 130px; height: 130px; background: #fdfdfd; border: 1px solid var(--border-light); border-radius: 8px; display: flex; align-items: center; justify-content: center; padding: 10px; }
        .item-img-wrap img { width: 100%; height: 100%; object-fit: contain; mix-blend-mode: multiply; }

        .item-details { flex: 1; padding-top: 5px; }
        .item-title { font-size: 15px; font-weight: 500; color: var(--text-dark); margin-bottom: 8px; padding-right: 30px; }
        .item-price-row { display: flex; align-items: baseline; gap: 10px; margin-bottom: 12px; }
        .item-price { font-size: 18px; font-weight: 600; color: var(--brand-color); font-family: 'Playfair Display', serif; }

        .item-meta { font-size: 12px; color: var(--text-gray); margin-bottom: 15px; display: flex; gap: 20px; }
        .item-meta span { font-weight: 500; color: var(--text-dark); }

        .remove-btn { position: absolute; top: 20px; right: 20px; width: 25px; height: 25px; background: #f4f5f7; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--text-gray); font-size: 10px; transition: 0.3s; }
        .remove-btn:hover { background: #ffebee; color: #d32f2f; }

        .right-col { position: sticky; top: 100px; display: flex; flex-direction: column; gap: 15px; }
        .summary-card { background: var(--bg-white); border-radius: 12px; padding: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.02); }

        .cost-row { display: flex; justify-content: space-between; font-size: 13px; color: var(--text-gray); margin-bottom: 12px; }
        .cost-row.discount { color: #2e7d32; }
        .cost-row.total { font-size: 18px; font-weight: 600; color: var(--text-dark); margin-top: 15px; padding-top: 15px; border-top: 1px solid var(--border-light); }

        .checkout-form { margin-top: 25px; }
        .address-input { width: 100%; background: #f9f9f9; border: 1px solid var(--border-light); border-radius: 8px; padding: 15px; font-size: 13px; font-family: 'Jost', sans-serif; resize: vertical; min-height: 80px; margin-bottom: 15px; outline: none; transition: 0.3s; }
        .address-input:focus { border-color: var(--brand-color); background: white; }

        .btn-place-order { width: 100%; background: var(--brand-color); color: white; padding: 16px; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; letter-spacing: 1px; cursor: pointer; transition: 0.3s; }
        .btn-place-order:hover { background: #5a1220; transform: translateY(-2px); }

        .empty-cart { text-align: center; padding: 80px 20px; background: white; border-radius: 12px; grid-column: 1 / -1; box-shadow: 0 2px 8px rgba(0,0,0,0.02); }
        .empty-cart img { width: 150px; margin-bottom: 20px; opacity: 0.5; }
        .empty-cart h2 { font-size: 24px; color: var(--text-dark); margin-bottom: 10px; }
        .empty-cart p { color: var(--text-gray); margin-bottom: 30px; font-size: 14px; }
        .btn-shop { display: inline-block; padding: 12px 35px; background: var(--brand-color); color: white; border-radius: 25px; font-size: 13px; font-weight: 600; letter-spacing: 1px; }

        @media (max-width: 900px) {
            .cart-wrapper { grid-template-columns: 1fr; }
            .right-col { position: static; }
            .back-btn { display: none; }
        }
    </style>
</head>
<body>

    <header class="header-main">
        <a href="/" class="back-btn"><i class="fas fa-arrow-left"></i></a>
        <div class="brand-logo serif-font">SHADOW & CUT</div>
    </header>

    <div class="cart-wrapper">
        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-cart">
                    <img src="https://cdn-icons-png.flaticon.com/512/102/102665.png" alt="Empty Bag">
                    <h2 class="serif-font">Your Shopping Bag is Empty</h2>
                    <p>Looks like you haven't added anything to your bag yet.</p>
                    <a href="/" class="btn-shop">CONTINUE SHOPPING</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="left-col">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item-card">
                            <div class="item-img-wrap">
                                <img src="${item.product.imageUrl}" alt="${item.product.name}">
                            </div>
                            <div class="item-details">
                                <h3 class="item-title">${item.product.name}</h3>
                                <div class="item-price-row">
                                    <span class="item-price">₹${item.product.price}</span>
                                </div>
                                <div class="item-meta">
                                    <div>Quantity: <span>${item.quantity}</span></div>
                                </div>
                            </div>
                            <a href="/cart/remove/${item.id}" class="remove-btn" title="Remove"><i class="fas fa-times"></i></a>
                        </div>
                    </c:forEach>
                </div>

                <div class="right-col">
                    <div class="summary-card">
                        <div class="cost-breakdown">
                            <div class="cost-row">
                                <span>Subtotal</span>
                                <span>₹${cartTotal}</span>
                            </div>
                            <div class="cost-row discount">
                                <span>Shipping (Insured)</span>
                                <span>Free</span>
                            </div>
                            <div class="cost-row total">
                                <span>Total Cost</span>
                                <span>₹${cartTotal}</span>
                            </div>
                        </div>

                        <form action="/orders/create" method="POST" class="checkout-form">
                            <textarea name="shippingAddress" class="address-input" required placeholder="Enter Complete Delivery Address (Street, City, State, Pincode)"></textarea>
                            <button type="submit" class="btn-place-order">SECURE CHECKOUT</button>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>