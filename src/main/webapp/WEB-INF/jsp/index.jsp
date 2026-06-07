<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SHADOW & CUT | Certified Fine Jewellery</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* === LUXURY VARIABLES === */
        :root {
            --bg-white: #ffffff;
            --bg-cream: #faf9f7;
            --text-dark: #111111;
            --text-gray: #666666;
            --icon-light: #444444;
            --brand-color: #7b1e2e;
            --gold-accent: #cda53f;
            --border-light: #eaeaea;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        body { background-color: var(--bg-white); color: var(--text-dark); font-family: 'Jost', sans-serif; overflow-x: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.4s ease; cursor: pointer; }
        ul { list-style: none; }
        button { font-family: 'Jost', sans-serif; cursor: pointer; outline: none; border: none; background: none; }

        /* === SLEEK SCROLLBAR === */
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: var(--bg-cream); }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }

        /* === PREMIUM SCROLL ANIMATIONS === */
        .reveal-up { opacity: 0; transform: translateY(50px); transition: all 1s cubic-bezier(0.25, 1, 0.5, 1); }
        .reveal-up.active { opacity: 1; transform: translateY(0); }
        .reveal-zoom { opacity: 0; transform: scale(0.95); transition: all 1.2s cubic-bezier(0.25, 1, 0.5, 1); }
        .reveal-zoom.active { opacity: 1; transform: scale(1); }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        /* === HEADER & NAV === */
        .utility-bar { background-color: var(--brand-color); color: white; text-align: center; padding: 12px; font-size: 11px; letter-spacing: 2px; text-transform: uppercase; font-weight: 500; }
        .header-main { display: flex; justify-content: space-between; align-items: center; padding: 25px 50px; background: rgba(255, 255, 255, 0.98); border-bottom: 1px solid var(--border-light); position: sticky; top: 0; z-index: 1000; box-shadow: 0 10px 30px rgba(0,0,0,0.02); transition: all 0.3s; }
        .brand-logo { font-size: 32px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; }

        .search-box { flex-grow: 1; max-width: 500px; margin: 0 40px; position: relative; }
        .search-box input { width: 100%; padding: 14px 20px 14px 45px; border-radius: 30px; border: 1px solid var(--border-light); background: #f9f9f9; outline: none; transition: 0.4s; font-size: 13px; }
        .search-box input:focus { border-color: var(--gold-accent); background: white; box-shadow: 0 0 20px rgba(205, 165, 63, 0.08); }
        .search-box i.fa-search { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: var(--icon-light); }

        .header-actions { display: flex; gap: 30px; align-items: flex-end; }
        .action-item { position: relative; display: flex; flex-direction: column; align-items: center; font-size: 14px; color: #333; transition: 0.3s; font-weight: 500; padding-bottom: 10px; margin-bottom: -10px; }
        .action-item i { font-size: 24px; margin-bottom: 5px; color: var(--icon-light); transition: 0.3s; font-weight: 900; }
        .action-item:hover, .action-item:hover i { color: var(--brand-color); }
        .cart-count { position: absolute; top: -6px; right: -8px; background: var(--brand-color); color: white; font-size: 10px; border-radius: 50%; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-weight: 600; }

        .profile-dropdown-container { position: relative; cursor: pointer; }
        .profile-dropdown {
            position: absolute; top: 100%; left: 50%; transform: translateX(-50%);
            background: white; border: 1px solid var(--border-light);
            border-radius: 6px; box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 140px; display: flex; flex-direction: column;
            opacity: 0; visibility: hidden; transition: 0.3s; z-index: 100; margin-top: 5px;
        }
        .profile-dropdown::before { content: ''; position: absolute; top: -6px; left: 50%; transform: translateX(-50%) rotate(45deg); width: 10px; height: 10px; background: white; border-left: 1px solid var(--border-light); border-top: 1px solid var(--border-light); }
        .profile-dropdown-container:hover .profile-dropdown { opacity: 1; visibility: visible; }
        .profile-dropdown a { padding: 12px 20px; font-size: 14px; color: var(--text-dark); border-bottom: 1px solid var(--border-light); text-align: left; }
        .profile-dropdown a:last-child { border-bottom: none; }
        .profile-dropdown a:hover { color: var(--brand-color); background: var(--bg-cream); }

        .nav-tabs { display: flex; justify-content: center; gap: 50px; padding: 20px 20px; background: var(--bg-white); border-bottom: 1px solid var(--border-light); flex-wrap: wrap; }
        .nav-item { font-size: 13px; font-weight: 500; text-transform: uppercase; letter-spacing: 2px; color: var(--text-dark); position: relative; padding-bottom: 5px; cursor: pointer; }
        .nav-item::after { content: ''; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); width: 0; height: 2px; background: var(--brand-color); transition: 0.4s ease; }
        .nav-item:hover::after { width: 100%; }

        /* === INTERACTIVE HERO SLIDER === */
        .hero-slider { position: relative; width: 100%; height: 80vh; overflow: hidden; background: #000; }
        .slide { position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0; transition: opacity 1s cubic-bezier(0.25, 1, 0.5, 1); display: flex; align-items: center; padding-left: 10%; }
        .slide.active { opacity: 1; z-index: 10; }
        .slide-bg, .slide-video { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; z-index: -1; filter: brightness(0.85); transform: scale(1.05); transition: transform 7s ease-out; }
        .slide.active .slide-bg, .slide.active .slide-video { transform: scale(1); }

        .slide-content { background: rgba(255, 255, 255, 0.95); padding: 60px 50px; box-shadow: 0 20px 40px rgba(0,0,0,0.1); max-width: 500px; transform: translateY(40px); opacity: 0; transition: all 1s cubic-bezier(0.25, 1, 0.5, 1) 0.3s; }
        .slide.active .slide-content { transform: translateY(0); opacity: 1; }
        .slide-content h2 { font-size: 48px; color: var(--brand-color); margin-bottom: 20px; line-height: 1.1; }

        .btn-main { display: inline-block; padding: 15px 45px; background: var(--brand-color); color: white; text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 3px; border: 1px solid var(--brand-color); transition: 0.4s; cursor: pointer; text-align: center; }
        .btn-main:hover { background: transparent; color: var(--brand-color); }

        .slider-btn { position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,0.9); width: 55px; height: 55px; border-radius: 50%; font-size: 20px; color: var(--brand-color); z-index: 100; transition: 0.4s; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .slider-btn:hover { background: var(--brand-color); color: white; transform: translateY(-50%) scale(1.1); }
        .prev-btn { left: 40px; }
        .next-btn { right: 40px; }
        .slider-dots { position: absolute; bottom: 40px; left: 50%; transform: translateX(-50%); display: flex; gap: 12px; z-index: 100; }
        .dot { width: 10px; height: 10px; border-radius: 50%; background: rgba(255,255,255,0.4); transition: 0.4s; cursor: pointer; }
        .dot.active { background: white; transform: scale(1.4); }

        /* === 10-CARD ENDLESS COVERFLOW === */
        .coverflow-section { padding: 100px 0; background: var(--bg-cream); overflow: hidden; position: relative; text-align: center; }
        .coverflow-title { font-size: 42px; margin-bottom: 60px; color: var(--text-dark); letter-spacing: 1px; }
        .coverflow-title span { color: var(--gold-accent); }

        .cf-wrapper { position: relative; max-width: 1400px; margin: 0 auto; display: flex; justify-content: center; align-items: center; }
        .cf-container { position: relative; width: 100%; height: 480px; display: flex; justify-content: center; align-items: center; perspective: 1200px; overflow: visible; }

        .cf-item { position: absolute; width: 260px; height: 420px; background: white; border-radius: 12px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); transition: all 0.8s cubic-bezier(0.25, 1, 0.5, 1); display: flex; flex-direction: column; align-items: center; justify-content: space-between; padding: 20px; border: 1px solid var(--border-light); z-index: 0; cursor: pointer; opacity: 0; pointer-events: none; }

        /* Fixed Aspect Ratio Images */
        .cf-item .img-wrapper { width: 100%; height: 220px; overflow: hidden; border-radius: 6px; margin-bottom: 15px; }
        .cf-item .img-wrapper img { width: 100%; height: 100%; object-fit: cover; }

        .cf-item h3 { font-size: 15px; color: var(--text-dark); margin-bottom: 5px; text-align: center; }
        .cf-item p { font-size: 17px; color: var(--brand-color); font-weight: 600; font-family: 'Playfair Display', serif; }
        .cf-item .btn-main { width: 100%; padding: 10px; font-size: 10px; margin-top: 10px; background: var(--bg-cream); color: var(--text-dark); border-color: var(--border-light); }

        /* Seamless Slider Map - Expanded for 10 cards */
        .cf-item.active { transform: translateX(0) scale(1.1); z-index: 10; opacity: 1; pointer-events: auto; box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15); border-color: var(--gold-accent); }
        .cf-item.active .btn-main { background: var(--brand-color); color: white; border-color: var(--brand-color); }

        .cf-item.prev { transform: translateX(-160px) scale(0.9); z-index: 9; opacity: 0.95; pointer-events: auto; }
        .cf-item.next { transform: translateX(160px) scale(0.9); z-index: 9; opacity: 0.95; pointer-events: auto; }

        .cf-item.prev-2 { transform: translateX(-290px) scale(0.75); z-index: 8; opacity: 0.8; pointer-events: auto; }
        .cf-item.next-2 { transform: translateX(290px) scale(0.75); z-index: 8; opacity: 0.8; pointer-events: auto; }

        .cf-item.prev-3 { transform: translateX(-400px) scale(0.6); z-index: 7; opacity: 0.5; pointer-events: auto; }
        .cf-item.next-3 { transform: translateX(400px) scale(0.6); z-index: 7; opacity: 0.5; pointer-events: auto; }

        .cf-item.prev-4 { transform: translateX(-490px) scale(0.45); z-index: 6; opacity: 0.2; }
        .cf-item.next-4 { transform: translateX(490px) scale(0.45); z-index: 6; opacity: 0.2; }

        .cf-btn { position: absolute; top: 50%; transform: translateY(-50%); width: 50px; height: 50px; border-radius: 50%; background: white; border: 1px solid var(--border-light); color: var(--brand-color); font-size: 18px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); z-index: 20; transition: 0.3s; cursor: pointer; }
        .cf-btn:hover { background: var(--brand-color); color: white; }
        .cf-btn.left { left: 40px; }
        .cf-btn.right { right: 40px; }

        /* === ANIMATED VIDEO ACCORDION === */
        .video-showcase { padding: 100px 50px; background: var(--bg-white); max-width: 1400px; margin: 0 auto; text-align: center; }
        .video-accordion { display: flex; gap: 15px; height: 600px; margin-top: 50px; }
        .video-panel { flex: 1; position: relative; overflow: hidden; border-radius: 15px; transition: flex 0.6s cubic-bezier(0.25, 1, 0.5, 1); cursor: pointer; background: #000; }
        .video-panel:hover { flex: 3; }
        .video-panel video { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0.7; transition: 0.6s; }
        .video-panel:hover video { opacity: 1; transform: scale(1.05); }
        .panel-content { position: absolute; bottom: -50px; left: 0; width: 100%; padding: 30px; background: linear-gradient(to top, rgba(0,0,0,0.9), transparent); color: white; text-align: left; opacity: 0; transition: 0.6s; }
        .video-panel:hover .panel-content { bottom: 0; opacity: 1; }
        .panel-content h3 { font-size: 28px; margin-bottom: 10px; }
        .panel-content p { font-size: 14px; color: #ddd; margin-bottom: 15px; font-family: 'Jost', sans-serif; }
        .panel-btn { padding: 10px 20px; border: 1px solid white; color: white; text-transform: uppercase; font-size: 11px; letter-spacing: 2px; transition: 0.3s; }
        .panel-btn:hover { background: white; color: black; }

        /* === PRODUCTS & CATEGORIES === */
        .section-container { padding: 80px 50px; max-width: 1400px; margin: 0 auto; text-align: center; }
        .section-title { font-size: 40px; color: var(--text-dark); margin-bottom: 25px; }

        .filter-bar { display: flex; justify-content: center; margin-bottom: 50px; padding: 20px 0; border-bottom: 1px solid var(--border-light); border-top: 1px solid var(--border-light); }
        .filter-tabs { display: flex; gap: 25px; flex-wrap: wrap; justify-content: center; }
        .filter-tab { font-size: 12px; text-transform: uppercase; font-weight: 500; letter-spacing: 1px; color: var(--text-gray); transition: 0.3s; cursor: pointer; }
        .filter-tab.active, .filter-tab:hover { color: var(--brand-color); }

        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 40px; text-align: left; }
        .product-card { background: white; transition: 0.5s; position: relative; overflow: hidden; border: 1px solid transparent; display: none; }
        .product-card:hover { box-shadow: 0 15px 40px rgba(0,0,0,0.08); border-color: var(--border-light); transform: translateY(-5px); }

        /* UNIFORM IMAGES FIX */
        .img-wrap { height: 380px; position: relative; overflow: hidden; cursor: pointer; background: var(--bg-cream); display: block; }
        .slider-img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; opacity: 0; transition: opacity 0.6s ease-in-out, transform 0.8s cubic-bezier(0.25, 1, 0.5, 1); z-index: 1; }
        .slider-img.active { opacity: 1; z-index: 2; }
        .product-card:hover .slider-img.active { transform: scale(1.08); }

        .img-wrap::after { content: ''; position: absolute; top: 0; left: -150%; width: 50%; height: 100%; background: linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(255,255,255,0.4) 50%, rgba(255,255,255,0) 100%); transform: skewX(-25deg); transition: 0.7s ease-in-out; z-index: 3; pointer-events: none; }
        .product-card:hover .img-wrap::after { left: 150%; }

        .card-actions { position: absolute; bottom: -60px; left: 0; width: 100%; padding: 15px; background: rgba(255,255,255,0.95); backdrop-filter: blur(5px); display: flex; gap: 10px; transition: bottom 0.4s cubic-bezier(0.25, 1, 0.5, 1); border-top: 1px solid var(--border-light); z-index: 4; }
        .product-card:hover .card-actions { bottom: 0; }

        .prod-info { padding: 25px 10px 10px; text-align: center; }
        .prod-price { font-size: 22px; font-weight: 600; color: var(--brand-color); margin-bottom: 8px; font-family: 'Playfair Display', serif; }
        .prod-name { font-size: 14px; color: #666; letter-spacing: 0.5px; }

        .btn-outline { flex: 1; padding: 12px; border: 1px solid var(--brand-color); color: var(--brand-color); background: transparent; text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 1px; transition: 0.3s; text-align: center; cursor: pointer; }
        .btn-outline:hover { background: var(--brand-color); color: white; }

        .pagination { display: flex; justify-content: center; gap: 15px; margin-top: 60px; }
        .page-link { width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; border: 1px solid var(--border-light); color: var(--text-dark); transition: 0.4s; border-radius: 50%; font-size: 14px; cursor: pointer; }
        .page-link.active, .page-link:hover:not(:disabled) { background: var(--brand-color); color: white; border-color: var(--brand-color); }
        .page-link:disabled { opacity: 0.3; cursor: not-allowed; }

        .no-products-msg { display: none; padding: 50px; font-size: 18px; color: var(--text-gray); }

        /* === ABOUT US === */
        .about-section { display: flex; align-items: center; background: var(--bg-cream); margin: 80px 0; }
        .about-img { flex: 1; height: 600px; overflow: hidden; }
        .about-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 1.5s; }
        .about-section:hover .about-img img { transform: scale(1.05); }
        .about-text { flex: 1; padding: 80px; text-align: left; }

        /* === CLOTHESLINE REVIEWS === */
        .testimonial-section { background: #fdfbf9; padding: 100px 0; text-align: center; position: relative; }
        .rope-wrapper { position: relative; max-width: 1300px; margin: 40px auto; padding: 0 60px; }
        .rope-line { position: absolute; top: 60px; left: 0; width: 100%; height: 4px; background: #8c2633; box-shadow: 0 5px 10px rgba(0,0,0,0.15); z-index: 1; }
        .rope-track { display: flex; gap: 40px; overflow-x: auto; scroll-snap-type: x mandatory; scrollbar-width: none; scroll-behavior: smooth; padding: 20px 10px 60px; position: relative; z-index: 2; }
        .rope-track::-webkit-scrollbar { display: none; }

        .hanging-card { position: relative; background: white; padding: 50px 40px; border-radius: 2px; box-shadow: 0 15px 40px rgba(0,0,0,0.06); transform-origin: top center; transition: all 0.5s; min-width: 320px; max-width: 320px; flex-shrink: 0; scroll-snap-align: center; margin-top: 15px; }
        .hanging-card::before { content: ''; position: absolute; top: -35px; left: 50%; transform: translateX(-50%); width: 16px; height: 45px; background: linear-gradient(to right, #e2e8f0, #94a3b8); border-radius: 3px; box-shadow: 2px 2px 8px rgba(0,0,0,0.2); }
        .hanging-card::after { content: ''; position: absolute; top: -25px; left: 50%; transform: translateX(-50%); width: 8px; height: 8px; background: #1e293b; border-radius: 50%; }
        .hanging-card:hover { transform: rotate(2deg) translateY(-10px); box-shadow: 0 25px 50px rgba(0,0,0,0.12); }

        .review-btn { position: absolute; top: 50%; transform: translateY(-50%); background: white; width: 45px; height: 45px; border-radius: 50%; color: var(--brand-color); z-index: 10; font-size: 18px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: 0.3s; border: 1px solid var(--border-light); cursor: pointer; }
        .review-btn:hover { background: var(--brand-color); color: white; }
        .review-btn-left { left: 10px; }
        .review-btn-right { right: 10px; }

        /* === MODALS (QUICK VIEW & JOURNEY) === */
        .modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,0.8); z-index: 2000; opacity: 0; visibility: hidden; transition: 0.4s; display: flex; align-items: center; justify-content: center; backdrop-filter: blur(5px); }
        .modal-overlay.active { opacity: 1; visibility: visible; }
        .modal-content { background: white; width: 900px; max-width: 95%; height: 60vh; display: flex; position: relative; transform: scale(0.95); opacity: 0; transition: 0.4s cubic-bezier(0.25, 1, 0.5, 1); border-radius: 10px; overflow: hidden;}
        .modal-overlay.active .modal-content { transform: scale(1); opacity: 1; }
        .close-modal { position: absolute; top: 20px; right: 25px; font-size: 24px; cursor: pointer; color: var(--text-gray); z-index: 10; transition: 0.3s; }
        .close-modal:hover { color: var(--brand-color); transform: rotate(90deg); }

        .modal-left { flex: 1; background: var(--bg-cream); display: flex; align-items: center; justify-content: center; padding: 30px; }
        .modal-right { flex: 1; padding: 50px 40px; display: flex; flex-direction: column; justify-content: center; }
        .wishlist-btn { background: none; border: 1px solid var(--border-light); width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--icon-light); transition: 0.3s; cursor: pointer; }
        .wishlist-btn:hover { border-color: var(--brand-color); color: var(--brand-color); }
        .wishlist-btn.active { background: var(--brand-color); color: white; border-color: var(--brand-color); }

        /* Journey Modal Specific */
        #journeyModal .modal-content { width: 800px; height: 80vh; flex-direction: column; padding: 50px; overflow-y: auto; background: var(--bg-cream); }
        .timeline { border-left: 2px solid var(--gold-accent); padding-left: 30px; margin-top: 30px; margin-left: 20px; }
        .timeline-item { position: relative; margin-bottom: 40px; }
        .timeline-item::before { content: ''; position: absolute; left: -37px; top: 5px; width: 12px; height: 12px; background: var(--brand-color); border-radius: 50%; box-shadow: 0 0 0 4px var(--bg-cream); }
        .timeline-year { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--gold-accent); margin-bottom: 10px; font-weight: 600; }
        .timeline-text { font-size: 15px; color: var(--text-gray); line-height: 1.7; }

        /* === FOOTER (OPTIMIZED) === */
        .footer { background: #041527; color: white; padding: 45px 50px 20px; font-family: 'Jost', sans-serif; }
        .footer-grid { display: grid; grid-template-columns: 1.5fr 1.5fr 1.5fr 2fr; gap: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 30px; margin-bottom: 20px; max-width: 1400px; margin-left: auto; margin-right: auto; }
        .footer-col h4 { font-size: 13px; font-weight: 600; margin-bottom: 15px; letter-spacing: 0.5px; color: #ffffff; text-transform: uppercase; }
        .footer-col ul { list-style: none; padding: 0; }
        .footer-col ul li { margin-bottom: 8px; }
        .footer-col a, .footer-col p { color: #d1d5db; font-size: 12px; transition: 0.3s; text-decoration: none; display: block; line-height: 1.5; }
        .footer-col a:hover { color: white; }

        .newsletter-form { display: flex; width: 100%; border-radius: 4px; overflow: hidden; margin-top: 15px; }
        .newsletter-form input { flex: 1; padding: 10px 15px; background: #112236; border: none; color: white; outline: none; font-size: 12px; }
        .newsletter-form input::placeholder { color: #8892b0; }
        .newsletter-form button { padding: 10px 20px; background: white; color: #041527; font-weight: 600; border: none; cursor: pointer; font-size: 12px; transition: 0.3s; }
        .newsletter-form button:hover { background: #e2e8f0; }
        .contact-group { margin-top: 25px; }
        .contact-group h4 { margin-bottom: 12px; }

        .footer-bottom { display: flex; justify-content: space-between; align-items: flex-start; max-width: 1400px; margin: 0 auto; flex-wrap: wrap; gap: 20px; padding-top: 10px; }

        .social-horizontal-container { display: flex; align-items: center; gap: 20px; }
        .social-horizontal-container > span { color: #d1d5db; font-size: 14px; font-weight: 500; letter-spacing: 1px; }
        .social-icons-row { display: flex; flex-direction: row; gap: 12px; }
        .social-icons-row a { display: flex; align-items: center; justify-content: center; width: 32px; height: 32px; background: white; color: #041527; border-radius: 50%; font-size: 14px; transition: 0.3s; }
        .social-icons-row a:hover { transform: scale(1.1); background: var(--gold-accent); color: white; }

        .payment-row { display: flex; align-items: center; gap: 10px; color: #d1d5db; font-size: 12px; margin-bottom: 10px; justify-content: flex-end; }
        .payment-row img { height: 24px; border-radius: 3px; }
        .copyright-text { text-align: right; color: #8892b0; font-size: 12px; line-height: 1.5; }

        /* === RESPONSIVE === */
        @media (max-width: 1024px) {
            .header-main { padding: 15px 30px; flex-wrap: wrap; }
            .search-box { order: 3; width: 100%; max-width: 100%; margin: 15px 0 0 0; }
            .footer-grid { grid-template-columns: 1fr 1fr; gap: 40px; }
            .video-accordion { flex-direction: column; height: 900px; }
        }

        @media (max-width: 768px) {
            .brand-logo { font-size: 24px; }
            .header-actions { gap: 15px; }
            .action-item span { display: none; }
            .nav-tabs { gap: 15px; padding: 15px; }
            .nav-item { font-size: 10px; }
            .hero-slider { height: 60vh; }
            .slide-content h2 { font-size: 32px; }
            .cf-item { width: 220px; height: 340px; }
            .cf-item .img-wrapper { height: 160px; }
            .cf-btn { display: none; }
            .section-container, .video-showcase { padding: 50px 20px; }
            .product-grid { grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 20px; }
            .rope-wrapper { padding: 0 20px; }
            .review-btn { display: none; }
            .footer-grid { grid-template-columns: 1fr; gap: 30px; }
            .footer-bottom { flex-direction: column; align-items: center; text-align: center; }
            .social-horizontal-container { flex-direction: column; margin-bottom: 20px; }
            .payment-row { justify-content: center; }
            .copyright-text { text-align: center; margin-top: 10px; }
            .modal-content { flex-direction: column; height: 85vh; overflow-y: auto; }
        }
    </style>
</head>
<body>

    <div class="utility-bar">
        ${not empty applicationScope.adminHeaderText ? applicationScope.adminHeaderText : 'Free Insured Shipping Across India | 100% Certified Jewellery'}
    </div>

    <header class="header-main" id="navbar">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>

        <div class="search-box">
            <form onsubmit="handleSearch(event)">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search for Gold Rings, Diamond Pendants...">
            </form>
        </div>

        <div class="header-actions">
            <a href="/stores" class="action-item"><i class="fas fa-location-dot"></i><span>Stores</span></a>
            <a href="/wishlist" class="action-item"><i class="fas fa-heart"></i><span>Wishlist</span></a>

            <div class="action-item profile-dropdown-container">
                <i class="fas fa-user"></i><span>Profile</span>
                <div class="profile-dropdown">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <div style="padding: 10px 20px; font-size: 11px; color: var(--brand-color); border-bottom: 1px solid var(--border-light); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; background: var(--bg-cream);">
                                Hi, ${sessionScope.loggedInUser.fullName}
                            </div>

                            <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                                <a href="/admin/dashboard" style="color: #d9534f; font-weight: 600;"><i class="fas fa-shield-alt" style="margin-right: 5px; font-size: 12px;"></i> Admin Panel</a>
                            </c:if>

                            <a href="/profile">My Account</a>
                            <a href="/orders">My Orders</a>
                            <a href="/logout">Logout</a>
                        </c:when>

                        <c:otherwise>
                            <a href="/login">Login</a>
                            <a href="/register">Signup</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <a href="/cart" class="action-item">
                <div style="position: relative;">
                    <i class="fas fa-shopping-bag"></i>
                    <span class="cart-count">${not empty sessionScope.cart ? sessionScope.cart.size() : '0'}</span>
                </div>
                <span>Cart</span>
            </a>
        </div>
    </header>

    <nav class="nav-tabs">
        <a class="nav-item filter-trigger" data-filter="all" onclick="filterCategory('all')">All Jewellery</a>
        <a class="nav-item filter-trigger" data-filter="gold" onclick="filterCategory('gold')">Gold</a>
        <a class="nav-item filter-trigger" data-filter="diamond" onclick="filterCategory('diamond')">Diamond</a>
        <a class="nav-item filter-trigger" data-filter="ring" onclick="filterCategory('ring')">Rings</a>
        <a href="#about-us" class="nav-item">About Us</a>
    </nav>

    <section class="hero-slider">
        <button class="slider-btn prev-btn" onclick="moveSlide(-1)"><i class="fas fa-chevron-left"></i></button>
        <button class="slider-btn next-btn" onclick="moveSlide(1)"><i class="fas fa-chevron-right"></i></button>

        <div class="slide active">
            <video class="slide-video" autoplay muted loop playsinline>
                <source src="https://cdn.pixabay.com/video/2021/08/25/86259-592868735_large.mp4" type="video/mp4">
            </video>
            <div class="slide-content">
                <h2 class="serif-font">The Bridal Masterpiece</h2>
                <p style="color: var(--text-gray); margin-bottom: 30px;">Exquisite craftsmanship for your most special day. Certified gold and diamonds forged into perfection.</p>
                <a onclick="filterCategory('bridal')" class="btn-main">Explore Collection</a>
            </div>
        </div>

        <div class="slide">
            <img src="https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=100&w=2800&auto=format&fit=crop" class="slide-bg">
            <div class="slide-content">
                <h2 class="serif-font">Diamond Elegance</h2>
                <p style="color: var(--text-gray); margin-bottom: 30px;">Discover our latest arrivals in pure diamond settings. Crafted for the modern silhouette.</p>
                <a onclick="filterCategory('diamond')" class="btn-main">Shop Diamonds</a>
            </div>
        </div>

        <div class="slider-dots">
            <div class="dot active" onclick="setSlide(0)"></div>
            <div class="dot" onclick="setSlide(1)"></div>
        </div>
    </section>

    <section class="coverflow-section reveal-up">
        <h2 class="coverflow-title serif-font">Our <span>Top Picks</span></h2>

        <div class="cf-wrapper">
            <button class="cf-btn left" onclick="autoMoveCoverflow(-1)"><i class="fas fa-chevron-left"></i></button>

            <div class="cf-container" id="coverflow">
                <div class="cf-item" onclick="filterCategory('diamond')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=600&auto=format&fit=crop" alt="Earrings"></div>
                    <h3 class="serif-font">Diamond Drop Earrings</h3>
                    <p>₹ 34,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('gold')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=600&auto=format&fit=crop" alt="Necklace"></div>
                    <h3 class="serif-font">Bridal Gold Necklace</h3>
                    <p>₹ 1,12,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('ring')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop" alt="Ring"></div>
                    <h3 class="serif-font">Platinum Solitaire Ring</h3>
                    <p>₹ 45,500</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('gold')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1599643478514-41d3b0704040?q=80&w=600&auto=format&fit=crop" alt="Bangle"></div>
                    <h3 class="serif-font">Kundan Gold Bangle</h3>
                    <p>₹ 85,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('diamond')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?q=80&w=600&auto=format&fit=crop" alt="Pendant"></div>
                    <h3 class="serif-font">Minimalist Pendant</h3>
                    <p>₹ 22,500</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('ring')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1611591437281-460bfbe1220a?q=80&w=600&auto=format&fit=crop" alt="Emerald Ring"></div>
                    <h3 class="serif-font">Emerald Cut Ring</h3>
                    <p>₹ 68,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('gold')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?q=80&w=600&auto=format&fit=crop" alt="Gold Chain"></div>
                    <h3 class="serif-font">22Kt Linked Gold Chain</h3>
                    <p>₹ 55,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('diamond')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1596944924616-7b38e7cfac36?q=80&w=600&auto=format&fit=crop" alt="Diamond Bracelet"></div>
                    <h3 class="serif-font">Tennis Diamond Bracelet</h3>
                    <p>₹ 1,45,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('gold')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1610662243654-e0eb36355655?q=80&w=600&auto=format&fit=crop" alt="Pearl Drop"></div>
                    <h3 class="serif-font">Gold & Pearl Jhumka</h3>
                    <p>₹ 42,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
                <div class="cf-item" onclick="filterCategory('ring')">
                    <div class="img-wrapper"><img src="https://images.unsplash.com/photo-1589156229687-496a31ad1d1f?q=80&w=600&auto=format&fit=crop" alt="Mens Band"></div>
                    <h3 class="serif-font">Classic Platinum Band</h3>
                    <p>₹ 30,000</p>
                    <button type="button" class="btn-main">View in Collection</button>
                </div>
            </div>

            <button class="cf-btn right" onclick="autoMoveCoverflow(1)"><i class="fas fa-chevron-right"></i></button>
        </div>
    </section>

    <section class="video-showcase reveal-up">
        <h2 class="section-title serif-font" style="margin-bottom: 10px;">The Collection in Motion</h2>
        <p style="color: var(--text-gray);">Experience the brilliance of our pieces worn by muses.</p>

        <div class="video-accordion">
            <div class="video-panel">
                <video autoplay muted loop playsinline src="https://res.cloudinary.com/dq3omqbjo/video/upload/q_auto/f_auto/v1780766925/Cinematic_macro_slow_motion_sh_processed_ch1rhq.mp4"></video>
                <div class="panel-content">
                    <h3 class="serif-font">Aura Rings</h3>
                    <p>Witness the dazzling cut and clarity of our signature engagement rings in natural light.</p>
                    <button onclick="filterCategory('ring')" class="panel-btn">Shop Rings</button>
                </div>
            </div>
            <div class="video-panel">
                <video autoplay muted loop playsinline src="https://res.cloudinary.com/dq3omqbjo/video/upload/q_auto/f_auto/v1780767017/Close_up_lifestyle_shot_of_a_w_processed_w0zmdu.mp4"></video>
                <div class="panel-content">
                    <h3 class="serif-font">Royal Necklaces</h3>
                    <p>Feel the weight and drape of pure 22Kt gold adorning the neckline.</p>
                    <button onclick="filterCategory('gold')" class="panel-btn">Shop Necklaces</button>
                </div>
            </div>
            <div class="video-panel">
                <video autoplay muted loop playsinline src="https://res.cloudinary.com/dq3omqbjo/video/upload/v1780766841/Macro_shot_of_black_diamonds_a_processed_si6sgq.mp4"></video>
                <div class="panel-content">
                    <h3 class="serif-font">Bridal Sets</h3>
                    <p>The perfect matching sets designed to make your special day truly unforgettable.</p>
                    <button onclick="filterCategory('bridal')" class="panel-btn">Shop Bridal</button>
                </div>
            </div>
        </div>
    </section>

    <section id="collection-section" class="section-container reveal-up">
        <h2 class="section-title serif-font">Our Signature Collections</h2>

        <div class="filter-bar">
            <div class="filter-tabs">
                <div class="filter-tab active filter-trigger" data-filter="all" onclick="filterCategory('all')">All Pieces</div>
                <div class="filter-tab filter-trigger" data-filter="gold" onclick="filterCategory('gold')">Gold</div>
                <div class="filter-tab filter-trigger" data-filter="diamond" onclick="filterCategory('diamond')">Diamond</div>
                <div class="filter-tab filter-trigger" data-filter="ring" onclick="filterCategory('ring')">Rings</div>
            </div>
        </div>

        <div class="no-products-msg" id="no-products-msg">
            <i class="fas fa-search" style="font-size: 30px; color: var(--gold-accent); margin-bottom:15px;"></i><br>
            No products match your search. Try exploring our other categories!
        </div>

        <div class="product-grid" id="paginated-products">
            <div class="product-card" data-category="gold diamond ring">
                <div class="img-wrap hover-slider" onclick="openQuickView('18Kt Yellow Gold & Diamond Solitaire', '₹ 45,500', 'https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop', '1')">
                    <img src="https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop" class="slider-img active" alt="Ring 1">
                    <img src="https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=80&w=600&auto=format&fit=crop" class="slider-img" alt="Ring 2">
                    <div class="card-actions">
                        <button class="btn-outline" onclick="event.stopPropagation(); openQuickView('18Kt Yellow Gold & Diamond Solitaire', '₹ 45,500', 'https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop', '1')">Quick View</button>
                        <form action="/cart/add" method="POST" style="flex:1;">
                            <input type="hidden" name="productId" value="1">
                            <button type="submit" class="btn-outline" style="background: var(--brand-color); color: white;" onclick="event.stopPropagation();">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <div class="prod-info">
                    <div class="prod-price">₹ 45,500</div>
                    <div class="prod-name">18Kt Yellow Gold & Diamond Solitaire</div>
                </div>
            </div>

            <div class="product-card" data-category="gold bridal">
                <div class="img-wrap hover-slider" onclick="openQuickView('22Kt Traditional Gold Bridal Necklace', '₹ 1,12,000', 'https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=600&auto=format&fit=crop', '2')">
                    <img src="https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=600&auto=format&fit=crop" class="slider-img active" alt="Necklace 1">
                    <img src="https://images.unsplash.com/photo-1599643478514-41d3b0704040?q=80&w=600&auto=format&fit=crop" class="slider-img" alt="Necklace 2">
                    <div class="card-actions">
                        <button class="btn-outline" onclick="event.stopPropagation(); openQuickView('22Kt Traditional Gold Bridal Necklace', '₹ 1,12,000', 'https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=600&auto=format&fit=crop', '2')">Quick View</button>
                        <form action="/cart/add" method="POST" style="flex:1;">
                            <input type="hidden" name="productId" value="2">
                            <button type="submit" class="btn-outline" style="background: var(--brand-color); color: white;" onclick="event.stopPropagation();">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <div class="prod-info">
                    <div class="prod-price">₹ 1,12,000</div>
                    <div class="prod-name">22Kt Traditional Gold Bridal Necklace</div>
                </div>
            </div>

            <div class="product-card" data-category="diamond">
                <div class="img-wrap hover-slider" onclick="openQuickView('Rose Gold Diamond Drop Earrings', '₹ 34,000', 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=600&auto=format&fit=crop', '3')">
                    <img src="https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=600&auto=format&fit=crop" class="slider-img active" alt="Earrings 1">
                    <img src="https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?q=80&w=600&auto=format&fit=crop" class="slider-img" alt="Earrings 2">
                    <div class="card-actions">
                        <button class="btn-outline" onclick="event.stopPropagation(); openQuickView('Rose Gold Diamond Drop Earrings', '₹ 34,000', 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=600&auto=format&fit=crop', '3')">Quick View</button>
                        <form action="/cart/add" method="POST" style="flex:1;">
                            <input type="hidden" name="productId" value="3">
                            <button type="submit" class="btn-outline" style="background: var(--brand-color); color: white;" onclick="event.stopPropagation();">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <div class="prod-info">
                    <div class="prod-price">₹ 34,000</div>
                    <div class="prod-name">Rose Gold Diamond Drop Earrings</div>
                </div>
            </div>

            <div class="product-card" data-category="gold">
                <div class="img-wrap hover-slider" onclick="openQuickView('Kundan Studded Gold Bangle', '₹ 85,000', 'https://images.unsplash.com/photo-1599643478514-41d3b0704040?q=80&w=600&auto=format&fit=crop', '4')">
                    <img src="https://images.unsplash.com/photo-1599643478514-41d3b0704040?q=80&w=600&auto=format&fit=crop" class="slider-img active" alt="Bangle 1">
                    <img src="https://images.unsplash.com/photo-1599643477877-530eb83abc8e?q=80&w=600&auto=format&fit=crop" class="slider-img" alt="Bangle 2">
                    <div class="card-actions">
                        <button class="btn-outline" onclick="event.stopPropagation(); openQuickView('Kundan Studded Gold Bangle', '₹ 85,000', 'https://images.unsplash.com/photo-1599643478514-41d3b0704040?q=80&w=600&auto=format&fit=crop', '4')">Quick View</button>
                        <form action="/cart/add" method="POST" style="flex:1;">
                            <input type="hidden" name="productId" value="4">
                            <button type="submit" class="btn-outline" style="background: var(--brand-color); color: white;" onclick="event.stopPropagation();">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <div class="prod-info">
                    <div class="prod-price">₹ 85,000</div>
                    <div class="prod-name">Kundan Studded Gold Bangle</div>
                </div>
            </div>

            <div class="product-card" data-category="diamond">
                <div class="img-wrap hover-slider" onclick="openQuickView('Minimalist Diamond Pendant', '₹ 22,500', 'https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?q=80&w=600&auto=format&fit=crop', '5')">
                    <img src="https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?q=80&w=600&auto=format&fit=crop" class="slider-img active" alt="Pendant 1">
                    <img src="https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=600&auto=format&fit=crop" class="slider-img" alt="Pendant 2">
                    <div class="card-actions">
                        <button class="btn-outline" onclick="event.stopPropagation(); openQuickView('Minimalist Diamond Pendant', '₹ 22,500', 'https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?q=80&w=600&auto=format&fit=crop', '5')">Quick View</button>
                        <form action="/cart/add" method="POST" style="flex:1;">
                            <input type="hidden" name="productId" value="5">
                            <button type="submit" class="btn-outline" style="background: var(--brand-color); color: white;" onclick="event.stopPropagation();">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <div class="prod-info">
                    <div class="prod-price">₹ 22,500</div>
                    <div class="prod-name">Minimalist Diamond Pendant</div>
                </div>
            </div>

            <div class="product-card" data-category="ring">
                <div class="img-wrap hover-slider" onclick="openQuickView('Platinum Eternity Band', '₹ 65,000', 'https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop', '6')">
                    <img src="https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop" class="slider-img active" alt="Band 1">
                    <img src="https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=80&w=600&auto=format&fit=crop" class="slider-img" alt="Band 2">
                    <div class="card-actions">
                        <button class="btn-outline" onclick="event.stopPropagation(); openQuickView('Platinum Eternity Band', '₹ 65,000', 'https://images.unsplash.com/photo-1605100804763-247f66126e28?q=80&w=600&auto=format&fit=crop', '6')">Quick View</button>
                        <form action="/cart/add" method="POST" style="flex:1;">
                            <input type="hidden" name="productId" value="6">
                            <button type="submit" class="btn-outline" style="background: var(--brand-color); color: white;" onclick="event.stopPropagation();">Add to Cart</button>
                        </form>
                    </div>
                </div>
                <div class="prod-info">
                    <div class="prod-price">₹ 65,000</div>
                    <div class="prod-name">Platinum Eternity Band</div>
                </div>
            </div>
        </div>

        <div class="pagination" id="pagination-controls"></div>
    </section>

    <section id="about-us" class="about-section reveal-zoom">
        <div class="about-img">
            <img src="https://res.cloudinary.com/dq3omqbjo/image/upload/v1780753910/photo-1617038220319-276d3cfab638_w1augr.webp" alt="Craftsmanship">
        </div>
        <div class="about-text">
            <h2 class="serif-font" style="font-size: 44px; color: var(--brand-color); margin-bottom: 25px;">The Legacy of Craftsmanship</h2>
            <p style="font-size: 16px; color: var(--text-gray); line-height: 1.8; margin-bottom: 40px;">Founded on a legacy of purity and trust, our master artisans spend countless hours forging ethically sourced gold and conflict-free diamonds into timeless expressions of art.</p>
            <button class="btn-main" onclick="openJourneyModal()">View Our Journey</button>
        </div>
    </section>

    <section class="testimonial-section reveal-up">
        <h2 class="section-title serif-font" style="margin-bottom: 10px;">Stories of Love</h2>
        <p style="color: var(--text-gray); margin-bottom: 40px;">What our family of customers says</p>

        <div class="rope-wrapper">
            <div class="rope-line"></div>
            <button class="review-btn review-btn-left" onclick="scrollReviews(-1)"><i class="fas fa-chevron-left"></i></button>
            <button class="review-btn review-btn-right" onclick="scrollReviews(1)"><i class="fas fa-chevron-right"></i></button>

            <div class="rope-track" id="review-track">
                <div class="hanging-card">
                    <i class="fas fa-quote-left" style="font-size: 28px; color: var(--gold-accent); margin-bottom: 20px;"></i>
                    <p style="font-size: 15px; color: #555; font-style: italic; line-height: 1.7; margin-bottom: 25px;">"The diamond quality is absolutely breathtaking. I bought an engagement ring and the service was phenomenal."</p>
                    <h4 class="serif-font" style="font-size: 16px; color: var(--brand-color);">- Ananya S.</h4>
                </div>
                <div class="hanging-card" style="margin-top: 45px;">
                    <i class="fas fa-quote-left" style="font-size: 28px; color: var(--gold-accent); margin-bottom: 20px;"></i>
                    <p style="font-size: 15px; color: #555; font-style: italic; line-height: 1.7; margin-bottom: 25px;">"Stunning designs! I love how transparent they are about pricing. The shipping was fast and securely packaged."</p>
                    <h4 class="serif-font" style="font-size: 16px; color: var(--brand-color);">- Priya M.</h4>
                </div>
                <div class="hanging-card">
                    <i class="fas fa-quote-left" style="font-size: 28px; color: var(--gold-accent); margin-bottom: 20px;"></i>
                    <p style="font-size: 15px; color: #555; font-style: italic; line-height: 1.7; margin-bottom: 25px;">"Their bespoke service is unmatched. They helped me design the perfect 22Kt gold necklace for my mother."</p>
                    <h4 class="serif-font" style="font-size: 16px; color: var(--brand-color);">- Rohan K.</h4>
                </div>
                <div class="hanging-card" style="margin-top: 45px;">
                    <i class="fas fa-quote-left" style="font-size: 28px; color: var(--gold-accent); margin-bottom: 20px;"></i>
                    <p style="font-size: 15px; color: #555; font-style: italic; line-height: 1.7; margin-bottom: 25px;">"I was worried about buying jewelry online, but the certification and beautiful unboxing experience won me over completely."</p>
                    <h4 class="serif-font" style="font-size: 16px; color: var(--brand-color);">- Vikram D.</h4>
                </div>
            </div>
        </div>
        <div style="margin-top: 50px;">
            <button class="btn-main" onclick="window.location.href='/login?redirect=/review/new'">Write a Review</button>
        </div>
    </section>

    <div class="modal-overlay" id="quickViewModal">
        <div class="modal-content">
            <i class="fas fa-times close-modal" onclick="closeQuickView()"></i>
            <div class="modal-left">
                <img id="qv-img" src="" style="max-width: 100%; max-height: 100%; object-fit: contain;">
            </div>
            <div class="modal-right">
                <h2 id="qv-title" class="serif-font" style="font-size: 32px; margin-bottom: 10px; color: var(--text-dark);">Product Name</h2>
                <h3 id="qv-price" class="serif-font" style="font-size: 26px; color: var(--brand-color); margin-bottom: 20px;">Price</h3>
                <p style="color: var(--text-gray); font-size: 14px; line-height: 1.8; margin-bottom: 30px;">
                    This exquisite piece is crafted with precision, featuring certified stones and hallmarked gold. Perfect for elevating your everyday elegance or adding sparkle to a special occasion.
                </p>
                <div style="display: flex; gap: 15px; align-items: center; margin-top: auto;">
                    <form action="/wishlist/add" method="POST" id="wishlist-form">
                        <input type="hidden" name="productId" id="qv-wishlist-id" value="">
                        <button type="button" class="wishlist-btn" id="wishlistToggleBtn" onclick="toggleWishlist()">
                            <i class="far fa-heart" id="wishlistIcon"></i>
                        </button>
                    </form>
                    <form action="/cart/add" method="POST" style="flex: 1;">
                        <input type="hidden" name="productId" id="qv-cart-id" value="">
                        <button type="submit" class="btn-main" style="width: 100%; padding: 18px; font-size: 12px;">Add to Cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="journeyModal">
        <div class="modal-content">
            <i class="fas fa-times close-modal" onclick="closeJourneyModal()"></i>
            <h2 class="serif-font" style="font-size: 40px; color: var(--brand-color); text-align: center;">Our Journey</h2>
            <p style="text-align: center; color: var(--text-gray); margin-bottom: 20px;">Decades of purity, trust, and craftsmanship.</p>

            <div class="timeline">
                <div class="timeline-item">
                    <div class="timeline-year">2010</div>
                    <div class="timeline-text">Founded by a family of traditional goldsmiths in a small workshop, focusing entirely on handcrafted, bespoke bridal jewelry.</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-year">2015</div>
                    <div class="timeline-text">Opened our first luxury flagship boutique. We introduced our renowned 100% certified, conflict-free diamond guarantee, setting a new standard for trust in the industry.</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-year">2020</div>
                    <div class="timeline-text">Launched our global online concierge service, delivering fully insured fine jewelry securely to clients worldwide.</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-year">2026</div>
                    <div class="timeline-text">Pioneering sustainable luxury by fully transitioning to recycled gold and lab-grown diamond alternatives alongside our natural collections.</div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer" id="footer">
        <div class="footer-grid">
            <div class="footer-col">
                <h4>ABOUT US</h4>
                <ul>
                    <li><a href="/contact">Contact Us</a></li>
                    <li><a href="/faq">Frequently Asked Questions</a></li>
                    <li><p>1800-419-0066 (9 am-10 pm)</p></li>
                    <li><a href="mailto:cs@shadowandcut.com">cs@shadowandcut.com</a></li>
                </ul>
                <div class="contact-group">
                    <h4>CUSTOMER DELIGHT</h4>
                    <ul>
                        <li><a href="/support">Help & Support</a></li>
                        <li><a href="/faq">FAQ</a></li>
                        <li><p><i class="fas fa-phone" style="width:20px;"></i> 1800-419-0066</p></li>
                        <li><a href="mailto:cs@shadowandcut.com"><i class="fas fa-envelope" style="width:20px;"></i> cs@shadowandcut.com</a></li>
                        <li><p>(9 am-10 pm, 7 days a week)</p></li>
                    </ul>
                </div>
            </div>

            <div class="footer-col">
                <h4>POLICIES</h4>
                <ul>
                    <li><a href="/about-us">Who we are?</a></li>
                    <li><a href="/investors">Investor Relations</a></li>
                    <li><a href="/design-philosophy">Design Philosophy</a></li>
                </ul>
                <div class="contact-group">
                    <h4>SHOP WITH CONFIDENCE</h4>
                    <ul>
                        <li><a href="/returns-policy">30-Day Returns</a></li>
                        <li><a href="/exchange-buyback">Lifetime Exchange & Buy back</a></li>
                        <li><a href="/privacy-policy">Privacy Policy</a></li>
                        <li><a href="/terms">Terms & Conditions</a></li>
                        <li><a href="/fraud-warning">Fraud Warning Disclaimer</a></li>
                    </ul>
                </div>
            </div>

            <div class="footer-col">
                <h4>JEWELLERY GUIDE</h4>
                <ul>
                    <li><a href="/why-buy-from-us">Why Buy From Us?</a></li>
                    <li><a href="/certifications">Our Certifications</a></li>
                    <li><a href="/press-room">Press Room</a></li>
                    <li><a href="/testimonials">Testimonials</a></li>
                    <li><a href="/corporate-gifting">Corporate Gifting</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>SUBSCRIBE TO OUR NEWSLETTER</h4>
                <p>Subscribe to receive updates on new arrivals, special offers, and styling inspiration directly to your inbox.</p>
                <form action="/newsletter/subscribe" method="POST" class="newsletter-form">
                    <input type="email" name="email" placeholder="Enter email for our newsletter" required>
                    <button type="submit">SUBSCRIBE</button>
                </form>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="social-horizontal-container">
                <span>Follow us on</span>
                <div class="social-icons-row">
                    <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
                    <a href="https://pinterest.com" target="_blank"><i class="fab fa-pinterest-p"></i></a>
                    <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                </div>
            </div>

            <div>
                <div class="payment-row">
                    <span>We Accept:</span>
                    <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg" alt="Mastercard">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Visa_Inc._logo.svg" alt="Visa">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/American_Express_logo_%282018%29.svg" alt="Amex">
                </div>
                <div class="copyright-text">
                    &copy; 2026 Shadow & Cut. All Rights Reserved.<br>
                    CIN: L72900KA2011PLC059678
                </div>
            </div>
        </div>
    </footer>

    <script>
        // === HERO SLIDER LOGIC ===
        const slides = document.querySelectorAll('.slide');
        const dots = document.querySelectorAll('.dot');
        let currentSlide = 0;

        function updateSlide() {
            slides.forEach(s => s.classList.remove('active'));
            dots.forEach(d => d.classList.remove('active'));
            slides[currentSlide].classList.add('active');
            dots[currentSlide].classList.add('active');
        }
        function moveSlide(dir) {
            currentSlide = (currentSlide + dir + slides.length) % slides.length;
            updateSlide();
        }
        function setSlide(index) {
            currentSlide = index;
            updateSlide();
        }
        setInterval(() => moveSlide(1), 6000);

        // === SCROLL ANIMATIONS ===
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => { if (entry.isIntersecting) entry.target.classList.add('active'); });
        }, { threshold: 0.1 });
        document.querySelectorAll('.reveal-up, .reveal-zoom').forEach((el) => observer.observe(el));

        // === DYNAMIC ENDLESS COVERFLOW LOGIC ===
        let cfItems;
        let currentCfIndex = 0;
        let cfAutoInterval;

        // Simulate "most browsed" by randomizing items on load
        function shuffleTopPicks() {
            const container = document.getElementById('coverflow');
            const items = Array.from(container.children);
            for (let i = items.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                container.appendChild(items[j]);
            }
            cfItems = document.querySelectorAll('.cf-item');
        }

        // Modular math mapping to create a seamless infinite loop
        function setCoverflow(index) {
            currentCfIndex = index;
            const total = cfItems.length;

            cfItems.forEach((item, i) => {
                item.className = 'cf-item'; // reset classes

                // Calculate distance wrapped around the array length
                let diff = (i - index + total) % total;

                if (diff === 0) item.classList.add('active');
                else if (diff === 1) item.classList.add('next');
                else if (diff === 2) item.classList.add('next-2');
                else if (diff === 3) item.classList.add('next-3');
                else if (diff === 4) item.classList.add('next-4');

                else if (diff === total - 1) item.classList.add('prev');
                else if (diff === total - 2) item.classList.add('prev-2');
                else if (diff === total - 3) item.classList.add('prev-3');
                else if (diff === total - 4) item.classList.add('prev-4');

                else item.classList.add('hidden'); // For arrays larger than 9
            });
        }

        function autoMoveCoverflow(direction) {
            let nextIndex = (currentCfIndex + direction + cfItems.length) % cfItems.length;
            setCoverflow(nextIndex);
            resetCfAutoSlide();
        }

        function startCfAutoSlide() {
            cfAutoInterval = setInterval(() => { autoMoveCoverflow(1); }, 3500);
        }
        function resetCfAutoSlide() {
            clearInterval(cfAutoInterval);
            startCfAutoSlide();
        }

        window.addEventListener('DOMContentLoaded', () => {
            shuffleTopPicks(); // Randomize items dynamically
            setCoverflow(currentCfIndex);
            startCfAutoSlide();
        });

        // === MULTI-IMAGE HOVER SLIDER ===
        document.querySelectorAll('.hover-slider').forEach(wrap => {
            let interval;
            let images = wrap.querySelectorAll('.slider-img');
            if(images.length <= 1) return;
            let currentIndex = 0;

            wrap.addEventListener('mouseenter', () => {
                interval = setInterval(() => {
                    images[currentIndex].classList.remove('active');
                    currentIndex = (currentIndex + 1) % images.length;
                    images[currentIndex].classList.add('active');
                }, 1000);
            });

            wrap.addEventListener('mouseleave', () => {
                clearInterval(interval);
                images[currentIndex].classList.remove('active');
                currentIndex = 0;
                images[currentIndex].classList.add('active');
            });
        });

        // === CLIENT-SIDE SEARCH & FILTERING ENGINE ===
        const allProductCards = Array.from(document.querySelectorAll('#paginated-products .product-card'));
        let filteredProducts = [...allProductCards];
        const itemsPerPage = 3;
        let currentPage = 1;
        let currentFilter = 'all';
        let searchQuery = '';

        function handleSearch(e) {
            e.preventDefault();
            searchQuery = document.getElementById('searchInput').value.toLowerCase();
            document.getElementById('collection-section').scrollIntoView({ behavior: 'smooth' });
            applyFilters();
        }

        function filterCategory(category) {
            currentFilter = category;
            document.querySelectorAll('.filter-trigger').forEach(tab => {
                if(tab.getAttribute('data-filter') === category) tab.classList.add('active');
                else tab.classList.remove('active');
            });

            searchQuery = '';
            document.getElementById('searchInput').value = '';
            document.getElementById('collection-section').scrollIntoView({ behavior: 'smooth' });
            applyFilters();
        }

        function applyFilters() {
            filteredProducts = allProductCards.filter(product => {
                const prodName = product.querySelector('.prod-name').innerText.toLowerCase();
                const prodCategory = product.getAttribute('data-category').toLowerCase();
                const matchesSearch = prodName.includes(searchQuery);
                const matchesCategory = currentFilter === 'all' || prodCategory.includes(currentFilter);
                return matchesSearch && matchesCategory;
            });

            const noProductsMsg = document.getElementById('no-products-msg');
            noProductsMsg.style.display = filteredProducts.length === 0 ? 'block' : 'none';

            currentPage = 1;
            renderPagination();
        }

        function renderPagination() {
            const totalPages = Math.ceil(filteredProducts.length / itemsPerPage);
            const pagContainer = document.getElementById('pagination-controls');
            pagContainer.innerHTML = '';

            if (totalPages <= 1) {
                showPage(currentPage);
                return;
            }

            pagContainer.innerHTML += `<button class="page-link" onclick="changePage(\${currentPage - 1})" \${currentPage === 1 ? 'disabled' : ''}>&laquo;</button>`;
            for (let i = 1; i <= totalPages; i++) {
                pagContainer.innerHTML += `<button class="page-link \${i === currentPage ? 'active' : ''}" onclick="changePage(\${i})">\${i}</button>`;
            }
            pagContainer.innerHTML += `<button class="page-link" onclick="changePage(\${currentPage + 1})" \${currentPage === totalPages ? 'disabled' : ''}>&raquo;</button>`;

            showPage(currentPage);
        }

        function changePage(page) {
            const totalPages = Math.ceil(filteredProducts.length / itemsPerPage);
            if (page < 1 || page > totalPages) return;
            currentPage = page;
            renderPagination();
            document.getElementById('collection-section').scrollIntoView({ behavior: 'smooth', block: 'start' });
        }

        function showPage(page) {
            allProductCards.forEach(p => p.style.display = 'none');
            const start = (page - 1) * itemsPerPage;
            const end = start + itemsPerPage;

            filteredProducts.forEach((product, index) => {
                if (index >= start && index < end) {
                    product.style.display = 'block';
                    product.style.animation = 'none';
                    setTimeout(() => product.style.animation = 'fadeIn 0.5s ease-out forwards', 10);
                }
            });
        }

        window.addEventListener('DOMContentLoaded', renderPagination);

        // === REVIEW CAROUSEL LOGIC ===
        function scrollReviews(direction) {
            const track = document.getElementById('review-track');
            const cardWidth = 360;
            track.scrollBy({ left: direction * cardWidth, behavior: 'smooth' });
        }

        // === MODALS LOGIC ===
        function openQuickView(title, price, img, id) {
            document.getElementById('qv-title').innerText = title;
            document.getElementById('qv-price').innerText = price;
            document.getElementById('qv-img').src = img;
            document.getElementById('qv-cart-id').value = id;
            document.getElementById('qv-wishlist-id').value = id;

            const icon = document.getElementById('wishlistIcon');
            const btn = document.getElementById('wishlistToggleBtn');
            icon.className = 'far fa-heart';
            btn.classList.remove('active');

            document.getElementById('quickViewModal').classList.add('active');
        }
        function closeQuickView() { document.getElementById('quickViewModal').classList.remove('active'); }

        function toggleWishlist() {
            const icon = document.getElementById('wishlistIcon');
            const btn = document.getElementById('wishlistToggleBtn');
            if (icon.classList.contains('far')) {
                icon.className = 'fas fa-heart';
                btn.classList.add('active');
                alert("Added to your wishlist!");
            } else {
                icon.className = 'far fa-heart';
                btn.classList.remove('active');
                alert("Removed from your wishlist!");
            }
        }

        function openJourneyModal() { document.getElementById('journeyModal').classList.add('active'); }
        function closeJourneyModal() { document.getElementById('journeyModal').classList.remove('active'); }
    </script>
</body>
</html>