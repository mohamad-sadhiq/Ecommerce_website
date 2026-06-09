<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Boutiques | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --bg-white: #ffffff; --bg-cream: #faf9f7; --text-dark: #111111; --text-gray: #666666; --brand-color: #7b1e2e; --border-light: #eaeaea; }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-cream); color: var(--text-dark); display: flex; flex-direction: column; min-height: 100vh; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; transition: 0.3s; }

        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); }
        .brand-logo { font-size: 28px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }
        .back-link { font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-link:hover { color: var(--brand-color); }

        .wrapper { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px; animation: fadeIn 0.8s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .empty-state { text-align: center; padding: 80px 60px; background: var(--bg-white); border-radius: 8px; border: 1px solid var(--border-light); max-width: 600px; width: 100%; box-shadow: 0 10px 30px rgba(0,0,0,0.02); }
        .empty-state i { font-size: 50px; color: var(--gold-accent); margin-bottom: 25px; }
        .empty-state h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 15px; }
        .empty-state p { color: var(--text-gray); font-size: 15px; line-height: 1.6; margin-bottom: 35px; }

        .btn-main { display: inline-block; padding: 16px 45px; background: var(--brand-color); color: white; text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 2px; border: 1px solid var(--brand-color); transition: 0.3s; }
        .btn-main:hover { background: transparent; color: var(--brand-color); }
    </style>
</head>
<body>

    <header class="header-main">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>
        <a href="/" class="back-link"><i class="fas fa-arrow-left"></i> Return Home</a>
    </header>

    <div class="wrapper">
        <div class="empty-state">
            <i class="fas fa-map-marked-alt"></i>
            <h1 class="serif-font">Physical Boutiques Coming Soon</h1>
            <p>We are currently operating exclusively as a global online concierge service, delivering our fully insured, certified fine jewellery directly to your door. Stay tuned for updates on our upcoming flagship locations.</p>
            <a href="/" class="btn-main">Continue Shopping Online</a>
        </div>
    </div>

</body>
</html>