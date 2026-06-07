<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Media Management | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-main: #f4f5f7; --bg-panel: #ffffff; --text-dark: #111111;
            --text-gray: #6c757d; --brand-color: #7b1e2e; --gold-accent: #cda53f;
            --border-light: #e2e8f0; --sidebar-width: 260px;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Jost', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-dark); display: flex; height: 100vh; overflow: hidden; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; transition: 0.3s ease; }

       /* === SIDEBAR CSS === */
       .sidebar { width: 260px; background: var(--bg-panel); border-right: 1px solid var(--border-light); display: flex; flex-direction: column; z-index: 10; }
       .brand-header { padding: 30px 20px; text-align: center; border-bottom: 1px solid var(--border-light); }
       .brand-header h2 { font-size: 20px; letter-spacing: 3px; color: var(--brand-color); text-transform: uppercase; margin-bottom: 5px; }
       .admin-badge { display: inline-block; margin-top: 5px; font-size: 10px; text-transform: uppercase; letter-spacing: 2px; color: var(--gold-accent); border: 1px solid var(--gold-accent); padding: 3px 10px; border-radius: 20px; font-weight: 600; }

       .nav-menu { flex: 1; padding: 20px 0; overflow-y: auto; }
       .nav-label { font-size: 11px; text-transform: uppercase; letter-spacing: 2px; color: #adb5bd; margin: 20px 20px 10px; font-weight: 600; }

       /* The Fix: Grey Text & Smooth Left Border Hover */
       .nav-item { display: flex; align-items: center; gap: 15px; padding: 12px 25px; color: var(--text-gray); font-size: 14px; font-weight: 500; border-left: 3px solid transparent; cursor: pointer; transition: 0.3s; }
       .nav-item i { font-size: 16px; width: 20px; text-align: center; transition: 0.3s; }

       .nav-item:hover, .nav-item.active { background: var(--bg-main); color: var(--brand-color); border-left-color: var(--brand-color); }
       .nav-item:hover i { color: var(--brand-color); }

        /* === MAIN CONTENT === */
        .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; background-color: var(--bg-main); }
        .topbar { background: var(--bg-panel); height: 70px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; justify-content: space-between; padding: 0 40px; position: sticky; top: 0; z-index: 5; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .refresh-btn { background: transparent; border: 1px solid var(--border-light); color: var(--text-dark); padding: 8px 15px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .refresh-btn:hover { color: var(--brand-color); border-color: var(--brand-color); background: #fdfaf6; }

        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 40px; max-width: 1100px; margin: 0 auto; width: 100%; animation: fadeIn 0.5s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        .page-header { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: flex-end; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        /* === LUXURY FORMS === */
        .media-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; }

        .media-card { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 8px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.03); transition: 0.3s; }
        .media-card:hover { box-shadow: 0 8px 30px rgba(0,0,0,0.06); border-color: #cbd5e1; }

        .card-header { background: #ffffff; padding: 20px 25px; border-bottom: 1px solid var(--border-light); font-weight: 600; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; color: var(--brand-color); display: flex; align-items: center; gap: 10px; }
        .card-body { padding: 25px; }

        .media-block { background: #f8fafc; border: 1px solid var(--border-light); padding: 20px; border-radius: 6px; margin-bottom: 25px; position: relative; transition: 0.3s; }
        .media-block:focus-within { background: #ffffff; border-color: var(--gold-accent); box-shadow: 0 0 0 3px rgba(205, 165, 63, 0.1); }

        .block-title { font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: var(--text-dark); margin-bottom: 15px; display: flex; justify-content: space-between; }
        .block-title i { color: var(--text-gray); }

        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-size: 11px; text-transform: uppercase; color: var(--text-gray); margin-bottom: 6px; font-weight: 600; letter-spacing: 0.5px; }
        .form-group input, .form-group textarea { width: 100%; padding: 12px 15px; border: 1px solid #cbd5e1; border-radius: 4px; font-size: 13px; outline: none; transition: 0.3s; background: #ffffff; color: var(--text-dark); }
        .form-group input:focus, .form-group textarea:focus { border-color: var(--gold-accent); }

        .btn-submit { background: var(--brand-color); color: white; padding: 14px 25px; border: none; border-radius: 4px; font-size: 12px; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; cursor: pointer; transition: 0.3s; width: 100%; display: flex; justify-content: center; align-items: center; gap: 10px; }
        .btn-submit:hover { background: #111111; transform: translateY(-2px); }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/jsp/admin/admin-sidebar.jsp" %>

    <main class="main-content">
        <header class="topbar">
            <button onclick="window.location.reload();" class="refresh-btn">
                <i class="fas fa-sync-alt"></i> Live Sync
            </button>
            <div class="admin-profile">
                <span>${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName : 'Administrator'}</span>
                <div class="admin-avatar">${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.fullName.substring(0,1).toUpperCase() : 'A'}</div>
            </div>
        </header>

       <div class="dashboard-container">
                   <div class="page-header">
                       <div>
                           <h1 class="serif-font">Storefront Media</h1>
                           <p>Update homepage sliders, videos, and editorial text seamlessly.</p>
                       </div>
                   </div>

                   <c:if test="${not empty successMsg}">
                       <div style="background: #28a745; color: white; padding: 15px 25px; margin-bottom: 25px; border-radius: 6px; font-weight: 500; display: flex; align-items: center; gap: 10px; animation: fadeIn 0.5s;">
                           <i class="fas fa-check-circle"></i> ${successMsg}
                       </div>
                   </c:if>

                   <div class="media-grid">
                       <div class="media-card">
                           <div class="card-header"><i class="fas fa-images"></i> Hero Carousel</div>
                           <div class="card-body">
                               <form action="/admin/media/hero" method="POST">
                                   <div class="media-block">
                                       <div class="block-title">Slide 1 (Main Video) <i class="fas fa-video"></i></div>
                                       <div class="form-group">
                                           <label>Background Video URL (.mp4)</label>
                                           <input type="text" name="slide1_media" value="${not empty applicationScope.slide1_media ? applicationScope.slide1_media : 'https://cdn.pixabay.com/video/2021/08/25/86259-592868735_large.mp4'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Heading Text</label>
                                           <input type="text" name="slide1_heading" value="${not empty applicationScope.slide1_heading ? applicationScope.slide1_heading : 'The Bridal Masterpiece'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Sub-text Description</label>
                                           <textarea name="slide1_desc" rows="2">${not empty applicationScope.slide1_desc ? applicationScope.slide1_desc : 'Exquisite craftsmanship for your most special day.'}</textarea>
                                       </div>
                                   </div>

                                   <div class="media-block">
                                       <div class="block-title">Slide 2 (Static Image) <i class="fas fa-image"></i></div>
                                       <div class="form-group">
                                           <label>Background Image URL</label>
                                           <input type="text" name="slide2_media" value="${not empty applicationScope.slide2_media ? applicationScope.slide2_media : 'https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=100&w=2800'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Heading Text</label>
                                           <input type="text" name="slide2_heading" value="${not empty applicationScope.slide2_heading ? applicationScope.slide2_heading : 'Diamond Elegance'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Sub-text Description</label>
                                           <textarea name="slide2_desc" rows="2">${not empty applicationScope.slide2_desc ? applicationScope.slide2_desc : 'Discover our latest arrivals in pure diamond settings.'}</textarea>
                                       </div>
                                   </div>
                                   <button type="submit" class="btn-submit"><i class="fas fa-cloud-upload-alt"></i> Publish Sliders</button>
                               </form>
                           </div>
                       </div>

                       <div class="media-card">
                           <div class="card-header"><i class="fas fa-play-circle"></i> "Collection In Motion"</div>
                           <div class="card-body">
                               <form action="/admin/media/videos" method="POST">
                                   <div class="media-block">
                                       <div class="block-title">Interactive Panel 1</div>
                                       <div class="form-group">
                                           <label>Video URL</label>
                                           <input type="text" name="video1_url" value="${not empty applicationScope.video1_url ? applicationScope.video1_url : 'https://res.cloudinary.com/dq3omqbjo/video/upload/q_auto/f_auto/v1780766925/Cinematic_macro_slow_motion_sh_processed_ch1rhq.mp4'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Hover Heading</label>
                                           <input type="text" name="video1_heading" value="${not empty applicationScope.video1_heading ? applicationScope.video1_heading : 'Aura Rings'}">
                                       </div>
                                   </div>

                                   <div class="media-block">
                                       <div class="block-title">Interactive Panel 2</div>
                                       <div class="form-group">
                                           <label>Video URL</label>
                                           <input type="text" name="video2_url" value="${not empty applicationScope.video2_url ? applicationScope.video2_url : 'https://res.cloudinary.com/dq3omqbjo/video/upload/q_auto/f_auto/v1780767017/Close_up_lifestyle_shot_of_a_w_processed_w0zmdu.mp4'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Hover Heading</label>
                                           <input type="text" name="video2_heading" value="${not empty applicationScope.video2_heading ? applicationScope.video2_heading : 'Royal Necklaces'}">
                                       </div>
                                   </div>

                                   <div class="media-block">
                                       <div class="block-title">Interactive Panel 3</div>
                                       <div class="form-group">
                                           <label>Video URL</label>
                                           <input type="text" name="video3_url" value="${not empty applicationScope.video3_url ? applicationScope.video3_url : 'https://res.cloudinary.com/dq3omqbjo/video/upload/v1780766841/Macro_shot_of_black_diamonds_a_processed_si6sgq.mp4'}">
                                       </div>
                                       <div class="form-group">
                                           <label>Hover Heading</label>
                                           <input type="text" name="video3_heading" value="${not empty applicationScope.video3_heading ? applicationScope.video3_heading : 'Bridal Sets'}">
                                       </div>
                                   </div>
                                   <button type="submit" class="btn-submit"><i class="fas fa-cloud-upload-alt"></i> Publish Videos</button>
                               </form>
                           </div>
                       </div>
                   </div>

               </div>
           </main>
       </body>
       </html>