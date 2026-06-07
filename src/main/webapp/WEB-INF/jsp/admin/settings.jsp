<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Global Settings | Admin Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-main: #f4f5f7; --bg-panel: #ffffff; --text-dark: #111111;
            --text-gray: #6c757d; --brand-color: #7b1e2e; --gold-accent: #cda53f;
            --border-light: #e2e8f0; --danger: #dc3545; --sidebar-width: 260px;
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
        .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
        .topbar { background: var(--bg-panel); height: 70px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; justify-content: space-between; padding: 0 40px; position: sticky; top: 0; z-index: 5; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .refresh-btn { background: transparent; border: 1px solid var(--border-light); color: var(--text-dark); padding: 8px 15px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; text-transform: uppercase; letter-spacing: 1px; }
        .refresh-btn:hover { color: var(--brand-color); border-color: var(--brand-color); background: var(--bg-main); }
        .admin-profile { display: flex; align-items: center; gap: 15px; font-size: 14px; font-weight: 500; }
        .admin-avatar { width: 35px; height: 35px; background: var(--brand-color); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-family: 'Playfair Display', serif; font-size: 18px; }

        .dashboard-container { padding: 40px; max-width: 850px; margin: 0 auto; width: 100%; animation: fadeIn 0.5s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 32px; color: var(--text-dark); margin-bottom: 5px; }
        .page-header p { color: var(--text-gray); font-size: 14px; }

        /* === SETTINGS CARDS === */
        .settings-card { background: var(--bg-panel); border: 1px solid var(--border-light); border-radius: 8px; padding: 35px; margin-bottom: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }

        /* The Danger Zone Card */
        .settings-card.danger-zone { border: 1px solid #f5c6cb; border-left: 4px solid var(--danger); background: #fffcfc; }
        .settings-card.danger-zone .section-title { color: var(--danger); border-bottom-color: #f5c6cb; }

        .section-title { font-size: 16px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; color: var(--text-dark); margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid var(--border-light); display: flex; align-items: center; gap: 10px; }

        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--brand-color); margin-bottom: 5px; font-weight: 600; }
        .form-group p.sub-label { font-size: 13px; color: var(--text-gray); margin-bottom: 12px; }
        .form-group input[type="text"], .form-group input[type="time"] { width: 100%; padding: 14px 15px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; outline: none; transition: 0.3s; background: var(--bg-main); color: var(--text-dark); }
        .form-group input:focus { border-color: var(--gold-accent); background: white; box-shadow: 0 0 0 3px rgba(205, 165, 63, 0.1); }

        /* === TOGGLE SWITCHES === */
        .toggle-row { display: flex; justify-content: space-between; align-items: center; padding: 20px; background: #f8fafc; border: 1px solid var(--border-light); border-radius: 6px; margin-bottom: 15px; transition: 0.3s; }
        .toggle-row:hover { border-color: #cbd5e1; }

        .toggle-info { display: flex; flex-direction: column; gap: 4px; }
        .toggle-title { font-size: 14px; font-weight: 600; color: var(--text-dark); }
        .toggle-desc { font-size: 12px; color: var(--text-gray); }

        .switch { position: relative; display: inline-block; width: 50px; height: 26px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #cbd5e1; transition: .4s; border-radius: 34px; }
        .slider:before { position: absolute; content: ""; height: 18px; width: 18px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; box-shadow: 0 2px 4px rgba(0,0,0,0.2); }

        input:checked + .slider { background-color: var(--gold-accent); }
        .danger-zone input:checked + .slider { background-color: var(--danger); }
        input:checked + .slider:before { transform: translateX(24px); }

        .time-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

        .btn-submit { background: #111; color: white; padding: 16px; border: none; border-radius: 6px; font-size: 12px; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; cursor: pointer; width: 100%; transition: 0.3s; display: flex; justify-content: center; align-items: center; gap: 10px; }
        .btn-submit:hover { background: var(--brand-color); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(123, 30, 46, 0.2); }
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
                      <h1 class="serif-font">Store Configuration</h1>
                      <p>Manage operational announcements and global site behavior.</p>
                  </div>

                  <c:if test="${not empty successMsg}">
                      <div style="background: #28a745; color: white; padding: 15px 25px; margin-bottom: 25px; border-radius: 6px; font-weight: 500; display: flex; align-items: center; gap: 10px; animation: fadeIn 0.5s;">
                          <i class="fas fa-check-circle"></i> ${successMsg}
                      </div>
                  </c:if>

                  <form action="/admin/settings/update" method="POST">

                      <div class="settings-card">
                          <div class="section-title"><i class="fas fa-bullhorn" style="color: var(--text-gray);"></i> Storefront Announcements</div>

                          <div class="form-group">
                              <div class="toggle-row">
                                  <div class="toggle-info">
                                      <span class="toggle-title">Enable Utility Bar</span>
                                      <span class="toggle-desc">Displays the scrolling message at the very top of the website.</span>
                                  </div>
                                  <label class="switch">
                                      <input type="checkbox" name="showAnnouncement" ${applicationScope.showAnnouncement != false ? 'checked' : ''}>
                                      <span class="slider"></span>
                                  </label>
                              </div>
                          </div>

                          <div class="form-group">
                              <label>Utility Bar Text</label>
                              <p class="sub-label">Update the promotional message shown to all customers.</p>
                              <input type="text" name="announcementText" value="${not empty applicationScope.announcementText ? applicationScope.announcementText : 'Free Insured Shipping Across India | 100% Certified Jewellery'}">
                          </div>
                      </div>

                      <div class="settings-card danger-zone">
                          <div class="section-title"><i class="fas fa-exclamation-triangle"></i> Danger Zone</div>
                          <div class="toggle-row" style="border-color: #f5c6cb; background: #fff;">
                              <div class="toggle-info">
                                  <span class="toggle-title" style="color: var(--danger);">Emergency Store Closure</span>
                                  <span class="toggle-desc">Instantly disables checkout and displays a "Holiday/Maintenance" screen.</span>
                              </div>
                              <label class="switch">
                                  <input type="checkbox" name="emergencyClose" ${applicationScope.emergencyClose == true ? 'checked' : ''}>
                                  <span class="slider"></span>
                              </label>
                          </div>
                      </div>

                      <button type="submit" class="btn-submit"><i class="fas fa-save"></i> Save Global Settings</button>
                  </form>
              </div>
          </main>
      </body>
      </html>