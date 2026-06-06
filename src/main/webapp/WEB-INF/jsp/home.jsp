<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SHADOW & CUT | Luxury Fine Jewelry</title>
    <!-- Google Fonts for High-End Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">

    <style>
        /* Core Aesthetics - Deep Midnight Sapphire Theme */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Playfair Display', serif; }
        body {
            background: radial-gradient(circle at 50% 0%, #0f172a 0%, #020617 100%);
            color: #f8fafc;
            line-height: 1.6;
            min-height: 100vh;
        }
        a { text-decoration: none; color: inherit; transition: all 0.4s ease; }

        /* Header & Navigation */
        .luxury-header { background-color: rgba(2, 6, 23, 0.85); backdrop-filter: blur(10px); border-bottom: 1px solid #1e293b; position: sticky; top: 0; z-index: 1000; padding: 20px; }
        .nav-container { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .brand-logo { font-size: 24px; letter-spacing: 4px; text-transform: uppercase; color: #facc15; font-weight: bold; text-shadow: 0 0 15px rgba(250, 204, 21, 0.2); }
        .nav-links { display: flex; list-style: none; gap: 30px; font-family: 'Montserrat', sans-serif; font-size: 13px; text-transform: uppercase; letter-spacing: 2px; }
        .nav-links a:hover { color: #facc15; }
        .user-actions { display: flex; gap: 20px; align-items: center; font-family: 'Montserrat', sans-serif; font-size: 12px; }
        .user-greeting { color: #94a3b8; }
        .cart-count { background: linear-gradient(135deg, #facc15, #d97706); color: #000; border-radius: 50%; padding: 2px 7px; font-weight: bold; }
        .logout-link { color: #f87171; }

        /* High-Fidelity Hero Banner */
        .hero-banner { height: 85vh; background: linear-gradient(rgba(15, 23, 42, 0.4), rgba(2, 6, 23, 1)), url('https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=100&w=3840&auto=format&fit=crop') center/cover; display: flex; align-items: center; justify-content: center; text-align: center; }
        .hero-title { font-size: 52px; letter-spacing: 6px; text-transform: uppercase; margin-bottom: 15px; text-shadow: 0 4px 20px rgba(0,0,0,0.9); color: #ffffff; }
        .hero-subtitle { font-size: 18px; color: #cbd5e1; font-style: italic; margin-bottom: 30px; }

        /* Champagne Gold Buttons */
        .btn-primary { display: inline-block; padding: 15px 40px; background: linear-gradient(135deg, #fef08a, #d97706); color: #020617; text-transform: uppercase; letter-spacing: 2px; font-size: 13px; font-weight: 600; border-radius: 2px; border: none; transition: 0.4s; box-shadow: 0 10px 20px rgba(217, 119, 6, 0.2); }
        .btn-primary:hover { transform: translateY(-3px); box-shadow: 0 15px 25px rgba(217, 119, 6, 0.4); color: #000; }

        /* Sections & Typography */
        .section-header { text-align: center; margin-bottom: 50px; }
        .section-header h2 { font-size: 32px; letter-spacing: 4px; text-transform: uppercase; color: #f8fafc; }
        .divider-line { width: 50px; height: 2px; background: linear-gradient(90deg, transparent, #facc15, transparent); margin: 15px auto; }
        .section-desc { font-family: 'Montserrat', sans-serif; font-size: 14px; color: #94a3b8; margin-top: 15px;}
        .product-section, .lookbook-section { max-width: 1400px; margin: 80px auto; padding: 0 20px; }

        /* Lookbook - 16:9 Widescreen Editorial Constraints */
        .lookbook-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }
        .lookbook-card { position: relative; aspect-ratio: 16 / 9; background: #0f172a; overflow: hidden; border: 1px solid #1e293b; border-radius: 4px; box-shadow: 0 10px 30px rgba(0,0,0,0.6); display: flex; align-items: center; justify-content: center; }
        .lookbook-img { width: 100%; height: 100%; object-fit: cover; opacity: 0.7; transition: 0.7s cubic-bezier(0.25, 1, 0.5, 1); mix-blend-mode: luminosity; }
        .lookbook-card:hover .lookbook-img { opacity: 1; transform: scale(1.03); mix-blend-mode: normal; }
        .lookbook-overlay { position: absolute; bottom: 30px; left: 30px; }
        .lookbook-overlay h3 { font-size: 24px; text-transform: uppercase; letter-spacing: 3px; color: #fff; text-shadow: 0 2px 10px rgba(0,0,0,0.8); }

        /* Product Grid - 9:16 Vertical Portrait Constraints */
        .product-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 40px; }
        .product-card { background: rgba(15, 23, 42, 0.4); border: 1px solid #1e293b; padding: 20px; text-align: center; border-radius: 6px; transition: 0.4s; backdrop-filter: blur(5px); }
        .product-card:hover { border-color: #facc15; transform: translateY(-8px); box-shadow: 0 20px 40px rgba(250, 204, 21, 0.08); background: rgba(15, 23, 42, 0.8); }

        /* Studio Lighting Simulation (Emerald / Teal Backlight) */
        .image-wrapper { aspect-ratio: 9 / 16; background: radial-gradient(circle, #134e4a 0%, #020617 80%); margin-bottom: 20px; display: flex; align-items: center; justify-content: center; overflow: hidden; border-radius: 4px; }
        .image-wrapper img { width: 85%; height: 85%; object-fit: contain; filter: drop-shadow(0 15px 25px rgba(0,0,0,0.9)); transition: 0.6s cubic-bezier(0.25, 1, 0.5, 1); }
        .product-card:hover .image-wrapper img { transform: scale(1.08); }

        .product-name { font-size: 18px; margin-bottom: 10px; font-weight: 400; letter-spacing: 1px; color: #e2e8f0; }
        .product-price { color: #facc15; font-weight: 600; margin-bottom: 20px; font-family: 'Montserrat', sans-serif; font-size: 16px; }

        /* Hollow Accent Buttons */
        .btn-add-cart { background: transparent; border: 1px solid #475569; color: #f8fafc; padding: 12px 20px; width: 100%; cursor: pointer; transition: 0.4s; text-transform: uppercase; font-family: 'Montserrat', sans-serif; font-size: 11px; letter-spacing: 2px; border-radius: 2px; }
        .btn-add-cart:hover { border-color: #facc15; color: #020617; background: #facc15; }

        .view-all-container { text-align: center; margin-top: 50px; }
        .btn-secondary { display: inline-block; padding: 12px 30px; border-bottom: 2px solid #facc15; color: #facc15; text-transform: uppercase; letter-spacing: 2px; font-size: 12px; }

        /* About Us - Rich Plum Tint */
        .about-section { max-width: 800px; margin: 100px auto; text-align: center; padding: 40px; background: linear-gradient(180deg, transparent, rgba(30, 27, 75, 0.3), transparent); border-radius: 8px; }
        .about-content p { color: #cbd5e1; margin-bottom: 20px; font-size: 16px; }

        /* Footer */
        .luxury-footer { background: #020617; border-top: 1px solid #1e293b; padding: 80px 20px 30px; margin-top: 80px; }
        .footer-grid { max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 40px; }
        .footer-column h3, .footer-column h4 { color: #facc15; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 20px; font-size: 14px; }
        .footer-column ul { list-style: none; }
        .footer-column li, .footer-column p, .footer-column a { color: #94a3b8; margin-bottom: 10px; font-size: 14px; font-family: 'Montserrat', sans-serif; }
        .footer-column a:hover { color: #f8fafc; padding-left: 5px; }
        .footer-bottom { text-align: center; margin-top: 60px; padding-top: 20px; border-top: 1px solid #1e293b; color: #475569; font-size: 12px; font-family: 'Montserrat', sans-serif; }
    </style>
</head>
<body>

    <header class="luxury-header">
        <div class="nav-container">
            <div class="brand-logo">SHADOW & CUT</div>
            <nav>
                <ul class="nav-links">
                    <li><a href="#lookbook">The Lookbook</a></li>
                    <li><a href="#collection">Collection</a></li>
                    <li><a href="#about-us">House Heritage</a></li>
                    <li><a href="#support">Concierge</a></li>
                </ul>
            </nav>
            <div class="user-actions">
                <span class="user-greeting">Welcome, ${sessionScope.loggedInUser.fullName}</span>
                <a href="/profile" class="nav-icon">My Account</a>
                <a href="/cart" class="nav-icon cart-icon">Cart <span class="cart-count">0</span></a>
                <a href="/logout" class="nav-icon logout-link">Logout</a>
            </div>
        </div>
    </header>

    <section class="hero-banner">
        <div class="hero-content">
            <h1 class="hero-title">The Obsidian Collection</h1>
            <p class="hero-subtitle">Raw depth. Architectural precision. Unapologetic luxury.</p>
            <a href="#collection" class="btn-primary">Shop The Collection</a>
        </div>
    </section>

    <section id="lookbook" class="lookbook-section">
        <div class="section-header">
            <h2>Campaign Profiles</h2>
            <div class="divider-line"></div>
        </div>
        <div class="lookbook-grid">
            <div class="lookbook-card">
                <img src="/images/model-editorial-1.jpg" alt="Editorial Campaign 1" class="lookbook-img">
                <div class="lookbook-overlay">
                    <h3>Evening Silhouettes</h3>
                </div>
            </div>
            <div class="lookbook-card">
                <img src="/images/model-editorial-2.jpg" alt="Editorial Campaign 2" class="lookbook-img">
                <div class="lookbook-overlay">
                    <h3>Structural Minimalism</h3>
                </div>
            </div>
        </div>
    </section>

    <section id="collection" class="product-section">
        <div class="section-header">
            <h2>Featured Pieces</h2>
            <div class="divider-line"></div>
            <p class="section-desc">Ethically-sourced carbonado diamonds set in geometric weight-balanced frames.</p>
        </div>

        <div class="product-grid">
            <div class="product-card">
                <div class="image-wrapper">
                    <img src="/images/ring-obsidian.jpg" alt="Obsidian Solitaire Ring">
                </div>
                <div class="product-info">
                    <h3 class="product-name">The Nocturnal Solitaire</h3>
                    <p class="product-price">$2,450</p>
                    <button class="btn-add-cart">Add To Cart</button>
                </div>
            </div>

            <div class="product-card">
                <div class="image-wrapper">
                    <img src="/images/necklace-eclipse.jpg" alt="Eclipse Pendant">
                </div>
                <div class="product-info">
                    <h3 class="product-name">Eclipse Pavé Pendant</h3>
                    <p class="product-price">$3,100</p>
                    <button class="btn-add-cart">Add To Cart</button>
                </div>
            </div>

            <div class="product-card">
                <div class="image-wrapper">
                    <img src="/images/cuff-midnight.jpg" alt="Midnight Silhouette Cuff">
                </div>
                <div class="product-info">
                    <h3 class="product-name">Midnight Structural Cuff</h3>
                    <p class="product-price">$4,800</p>
                    <button class="btn-add-cart">Add To Cart</button>
                </div>
            </div>
        </div>

        <div class="view-all-container">
            <a href="/products" class="btn-secondary">View All Jewelry</a>
        </div>
    </section>

    <section id="about-us" class="about-section">
        <div class="about-content">
            <h2>House Heritage</h2>
            <div class="divider-line"></div>
            <p>Founded on the philosophy of unconventional luxury, SHADOW & CUT challenges traditional fine jewelry layout standards. We curate exclusively ethically-sourced black diamonds, setting them against geometric, architectural structures designed to emphasize confidence and distinct weight balance.</p>
            <p>Every piece is forged with the understanding that true luxury is not just seen, but felt.</p>
        </div>
    </section>

    <footer id="support" class="luxury-footer">
        <div class="footer-grid">
            <div class="footer-column brand-column">
                <h3>SHADOW & CUT</h3>
                <p>Redefining luxury through precise, high-contrast designs.</p>
            </div>

            <div class="footer-column">
                <h4>Client Concierge</h4>
                <ul>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Bespoke Sizing Services</a></li>
                    <li><a href="#">Insured Global Shipping</a></li>
                    <li><a href="#">Returns & Exchanges</a></li>
                </ul>
            </div>

            <div class="footer-column">
                <h4>The House</h4>
                <ul>
                    <li><a href="#">Our Ethics</a></li>
                    <li><a href="#">Press & Editorials</a></li>
                    <li><a href="#">Careers</a></li>
                </ul>
            </div>

            <div class="footer-column support-column">
                <h4>Direct Support</h4>
                <p>Speak directly with a private design expert.</p>
                <p class="contact-info">concierge@shadowandcut.com</p>
                <p class="contact-info">1-800-SHADOW</p>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2026 SHADOW & CUT Fine Jewelry Inc. All Rights Reserved.</p>
        </div>A
    </footer>

</body>
</html>