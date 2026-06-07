<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | SHADOW & CUT</title>
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
            --error-color: #d9534f;
            --success-color: #4cae4c;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-white); color: var(--text-dark); font-family: 'Jost', sans-serif; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.4s ease; cursor: pointer; }
        button { font-family: 'Jost', sans-serif; cursor: pointer; outline: none; border: none; background: none; }

        /* === PAGE LAYOUT === */
        .auth-container { display: flex; width: 100vw; height: 100vh; }

        /* === LEFT SIDE: 3D PRODUCT DISPLAY === */
       /* === LEFT SIDE: FULL-BLEED IMAGE DISPLAY === */
               .auth-image-panel {
                   flex: 1.2;
                   position: relative;
                   overflow: hidden;
                   border-right: 1px solid var(--border-light);
                   background: var(--bg-white); /* Changed to white to seamlessly blend with AI images */
               }

               .auth-image-panel img {
                   width: 100%;
                   height: 100%;
                   object-fit: cover;
                   object-position: center;
                   /* Added animation and scale to make it float without showing edges */
                   animation: floatJewelry 6s ease-in-out infinite;
                   transform: scale(1.05);
               }

               @keyframes floatJewelry {
                   0% { transform: scale(1.05) translateY(0px); }
                   50% { transform: scale(1.05) translateY(-15px); }
                   100% { transform: scale(1.05) translateY(0px); }
               }

        /* === RIGHT SIDE: FORM === */
        .auth-form-panel { flex: 1; background: var(--bg-cream); display: flex; flex-direction: column; padding: 40px 60px; overflow-y: auto; position: relative; }

        .back-to-home { position: absolute; top: 40px; right: 60px; font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-to-home:hover { color: var(--brand-color); }

        .form-content-wrapper { margin: auto; max-width: 420px; width: 100%; animation: slideInRight 0.8s cubic-bezier(0.25, 1, 0.5, 1) forwards; opacity: 0; }
        @keyframes slideInRight { from { opacity: 0; transform: translateX(30px); } to { opacity: 1; transform: translateX(0); } }

        .brand-logo { font-size: 32px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; text-align: center; display: block; margin-bottom: 40px; }

        .auth-title { font-size: 32px; margin-bottom: 10px; color: var(--text-dark); text-align: center; }
        .auth-subtitle { text-align: center; color: var(--text-gray); font-size: 14px; margin-bottom: 30px; }

        /* === ALERTS (JSTL Integration) === */
        .alert-box { padding: 15px; margin-bottom: 25px; border-radius: 4px; font-size: 13px; text-align: center; letter-spacing: 0.5px; animation: fadeIn 0.5s ease-out; }
        .alert-error { background: #fdf2f2; color: var(--error-color); border: 1px solid #f8d7da; }
        .alert-success { background: #f0fdf4; color: var(--success-color); border: 1px solid #d1e7dd; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        /* === FORM INPUTS === */
        .input-group { position: relative; margin-bottom: 30px; }
        .input-group label { position: absolute; top: 50%; left: 0; transform: translateY(-50%); font-size: 14px; color: var(--text-gray); transition: 0.3s cubic-bezier(0.25, 1, 0.5, 1); pointer-events: none; }
        .input-group input { width: 100%; padding: 15px 0 10px 0; border: none; border-bottom: 1px solid var(--border-light); background: transparent; font-size: 15px; color: var(--text-dark); font-family: 'Jost', sans-serif; transition: 0.3s; outline: none; }

        /* Floating Label Effect */
        .input-group input:focus ~ label,
        .input-group input:valid ~ label { top: -5px; font-size: 11px; color: var(--brand-color); font-weight: 500; text-transform: uppercase; letter-spacing: 1px; }

        .input-group input:focus { border-bottom-color: var(--brand-color); }

        .password-toggle { position: absolute; right: 0; top: 50%; transform: translateY(-50%); color: var(--text-gray); cursor: pointer; transition: 0.3s; padding: 10px; font-size: 14px; }
        .password-toggle:hover { color: var(--brand-color); }

        .btn-main { width: 100%; padding: 16px; background: var(--brand-color); color: white; text-transform: uppercase; font-size: 12px; font-weight: 600; letter-spacing: 3px; border: 1px solid var(--brand-color); transition: 0.4s; text-align: center; margin-top: 10px; margin-bottom: 30px; }
        .btn-main:hover { background: transparent; color: var(--brand-color); }

        .auth-footer { text-align: center; margin-top: 20px; font-size: 14px; color: var(--text-gray); }
        .auth-footer a { color: var(--brand-color); font-weight: 600; margin-left: 5px; position: relative; }
        .auth-footer a::after { content: ''; position: absolute; width: 100%; height: 1px; bottom: -2px; left: 0; background-color: var(--brand-color); transform: scaleX(0); transform-origin: bottom right; transition: transform 0.3s ease-out; }
        .auth-footer a:hover::after { transform: scaleX(1); transform-origin: bottom left; }

        /* === RESPONSIVE === */
        @media (max-width: 900px) {
            .auth-container { flex-direction: column; overflow-y: auto; height: auto; min-height: 100vh; }
            .auth-image-panel { flex: none; height: 40vh; border-right: none; border-bottom: 1px solid var(--border-light); }
            .auth-image-panel img { max-height: 80%; }
            .auth-form-panel { padding: 40px 30px; }
            .back-to-home { top: 20px; right: 20px; }
        }
    </style>
</head>
<body>

    <div class="auth-container">

        <!-- LEFT: 3D JEWELRY DISPLAY (1:1 Ratio, White Background) -->
        <div class="auth-image-panel">
                    <img src="https://res.cloudinary.com/dq3omqbjo/image/upload/v1780750869/Gemini_Generated_Image_ww0phsww0phsww0p_sdn3np.webp" alt="Shadow & Cut Signature Piece">
                </div>

        <!-- RIGHT: FORM PANEL -->
        <div class="auth-form-panel">
            <a href="/" class="back-to-home">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>

            <div class="form-content-wrapper">
                <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>

                <h2 class="auth-title serif-font">Welcome Back</h2>
                <p class="auth-subtitle">Log in to access your wishlist, orders, and exclusive offers.</p>

                <!-- JSTL Error & Success Messages -->
                <c:if test="${not empty error}">
                    <div class="alert-box alert-error">
                        <i class="fas fa-exclamation-circle" style="margin-right: 5px;"></i> ${error}
                    </div>
                </c:if>

                <c:if test="${param.registered == 'true'}">
                    <div class="alert-box alert-success">
                        <i class="fas fa-check-circle" style="margin-right: 5px;"></i> Registration successful! Please log in.
                    </div>
                </c:if>

                <c:if test="${param.logout == 'true'}">
                    <div class="alert-box alert-success">
                        <i class="fas fa-info-circle" style="margin-right: 5px;"></i> You have been successfully logged out.
                    </div>
                </c:if>

                <!-- LOGIN FORM -->
                <form action="/login" method="post">

                    <div class="input-group">
                        <input type="text" id="email" name="email" required autocomplete="email">
                        <label for="email">Email Address</label>
                    </div>

                    <div class="input-group">
                        <input type="password" id="password" name="password" required autocomplete="current-password">
                        <label for="password">Password</label>
                        <i class="far fa-eye password-toggle" id="togglePassword" onclick="togglePasswordVisibility()"></i>
                    </div>

                    <button type="submit" class="btn-main">Sign In</button>
                </form>

                <p class="auth-footer">
                    Don't have an account? <a href="/register">Register here</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('togglePassword');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>