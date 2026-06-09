<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Payment | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-main: #f4f5f7; --brand-color: #7b1e2e; --text-dark: #111; --border-light: #eaeef2; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); display: flex; justify-content: center; align-items: center; height: 100vh; }

        .payment-card { background: white; width: 100%; max-width: 500px; padding: 40px; border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); text-align: center; }
        .logo { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--brand-color); letter-spacing: 3px; margin-bottom: 30px; }

        .amount-display { font-size: 32px; font-weight: 600; color: var(--text-dark); margin-bottom: 10px; font-family: 'Playfair Display', serif; }
        .order-ref { font-size: 13px; color: #777; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 30px; }

        .dummy-card { background: #fdfdfd; border: 1px solid var(--border-light); padding: 20px; border-radius: 8px; text-align: left; margin-bottom: 30px; }
        .dummy-card label { font-size: 11px; text-transform: uppercase; letter-spacing: 1px; color: #777; font-weight: 600; display: block; margin-bottom: 8px; }
        .dummy-card input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-family: monospace; font-size: 16px; margin-bottom: 15px; outline: none; }

        .btn-pay { width: 100%; background: var(--brand-color); color: white; padding: 18px; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; letter-spacing: 1px; cursor: pointer; transition: 0.3s; }
        .btn-pay:hover { background: #5a1220; }
    </style>
</head>
<body>

    <div class="payment-card">
        <div class="logo">SHADOW & CUT</div>

        <div class="amount-display">₹${order.totalAmount}</div>
        <div class="order-ref">Order Reference #${order.id}</div>

        <form action="/payments/process/${order.id}" method="POST">
            <div class="dummy-card">
                <label>Card Number (Mock Gateway)</label>
                <input type="text" value="4444 5555 6666 7777" readonly>

                <div style="display: flex; gap: 15px;">
                    <div style="flex: 1;">
                        <label>Expiry</label>
                        <input type="text" value="12/28" readonly>
                    </div>
                    <div style="flex: 1;">
                        <label>CVV</label>
                        <input type="password" value="***" readonly>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn-pay"><i class="fas fa-lock" style="margin-right: 8px;"></i> AUTHORIZE PAYMENT</button>
        </form>
        <div style="margin-top: 20px; font-size: 11px; color: #aaa; text-transform: uppercase; letter-spacing: 1px;">
            <i class="fas fa-shield-alt"></i> Test Environment
        </div>
    </div>

</body>
</html>