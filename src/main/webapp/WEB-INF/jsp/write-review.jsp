<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write a Review | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-cream: #faf9f7;
            --text-dark: #111111;
            --brand-color: #7b1e2e;
            --gold-accent: #cda53f;
            --border-light: #eaeaea;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: var(--bg-cream); font-family: 'Jost', sans-serif; color: var(--text-dark); display: flex; justify-content: center; align-items: center; min-height: 100vh; }

        .review-container { background: white; padding: 60px 50px; border-radius: 8px; box-shadow: 0 15px 40px rgba(0,0,0,0.03); max-width: 600px; width: 90%; text-align: center; border-top: 4px solid var(--brand-color); animation: slideUp 0.6s ease-out; }
        @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .brand-logo { font-size: 24px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; text-decoration: none; display: inline-block; margin-bottom: 30px; font-family: 'Playfair Display', serif; }
        h1 { font-family: 'Playfair Display', serif; color: var(--text-dark); margin-bottom: 10px; font-size: 32px; }
        p { color: #666; margin-bottom: 40px; font-size: 15px; }

        textarea { width: 100%; height: 160px; padding: 20px; border: 1px solid var(--border-light); border-radius: 4px; font-family: 'Jost', sans-serif; font-size: 15px; outline: none; margin-bottom: 25px; resize: none; transition: 0.3s; background: #fdfdfd; }
        textarea:focus { border-color: var(--gold-accent); background: white; box-shadow: 0 0 15px rgba(205, 165, 63, 0.05); }

        .rating-stars { color: var(--gold-accent); font-size: 28px; margin-bottom: 30px; cursor: pointer; display: flex; justify-content: center; gap: 10px; }
        .rating-stars i { transition: 0.2s; }
        .rating-stars i:hover { transform: scale(1.1); }

        .btn-main { width: 100%; padding: 18px; background: var(--brand-color); color: white; border: none; font-weight: 600; letter-spacing: 2px; text-transform: uppercase; cursor: pointer; transition: 0.4s; font-family: 'Jost', sans-serif; font-size: 13px; border-radius: 4px; }
        .btn-main:hover { background: #5a1420; }

        .back-link { display: inline-flex; align-items: center; gap: 8px; margin-top: 25px; color: #888; text-decoration: none; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; font-weight: 500; transition: 0.3s; }
        .back-link:hover { color: var(--brand-color); }
    </style>
</head>
<body>

    <div class="review-container">
        <a href="/" class="brand-logo">SHADOW & CUT</a>
        <h1>Share Your Story</h1>
        <p>Your experiences inspire our craftsmanship. Let us know how we did.</p>

        <form action="/review/submit" method="POST">
            <div class="rating-stars" id="starContainer">
                <i class="fas fa-star" data-value="1"></i>
                <i class="fas fa-star" data-value="2"></i>
                <i class="fas fa-star" data-value="3"></i>
                <i class="fas fa-star" data-value="4"></i>
                <i class="fas fa-star" data-value="5"></i>
            </div>
            <input type="hidden" name="rating" id="ratingValue" value="5">

            <textarea name="content" placeholder="Tell us about your experience with Shadow & Cut..." required></textarea>

            <button type="submit" class="btn-main">Submit Review</button>
        </form>

        <a href="/" class="back-link"><i class="fas fa-arrow-left"></i> Return to Homepage</a>
    </div>

    <script>
        // Simple star rating interactivity
        const stars = document.querySelectorAll('.rating-stars i');
        const ratingInput = document.getElementById('ratingValue');

        stars.forEach(star => {
            star.addEventListener('click', () => {
                const value = parseInt(star.getAttribute('data-value'));
                ratingInput.value = value;

                stars.forEach((s, index) => {
                    if (index < value) {
                        s.classList.remove('far');
                        s.classList.add('fas');
                    } else {
                        s.classList.remove('fas');
                        s.classList.add('far');
                    }
                });
            });
        });
    </script>
</body>
</html>