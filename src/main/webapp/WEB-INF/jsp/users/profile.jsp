<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Account | SHADOW & CUT</title>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* === LUXURY VARIABLES === */
        :root {
            --bg-white: #ffffff;
            --bg-cream: #faf9f7;
            --text-dark: #111111;
            --text-gray: #666666;
            --brand-color: #7b1e2e;
            --gold-accent: #cda53f;
            --border-light: #eaeaea;
            --success-color: #28a745;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: var(--bg-cream); color: var(--text-dark); font-family: 'Jost', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        h1, h2, h3, .serif-font { font-family: 'Playfair Display', serif; }
        a { text-decoration: none; color: inherit; transition: 0.3s ease; cursor: pointer; }

        /* === MINIMAL HEADER === */
        .dashboard-header { background: var(--bg-white); padding: 20px 50px; border-bottom: 1px solid var(--border-light); display: flex; justify-content: space-between; align-items: center; }
        .brand-logo { font-size: 24px; font-weight: 600; color: var(--brand-color); letter-spacing: 4px; text-transform: uppercase; }
        .back-to-store { font-size: 13px; text-transform: uppercase; letter-spacing: 2px; color: var(--text-gray); font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .back-to-store:hover { color: var(--brand-color); }

        /* === DASHBOARD LAYOUT === */
        .dashboard-wrapper { display: flex; max-width: 1200px; margin: 50px auto; width: 100%; gap: 40px; padding: 0 20px; flex: 1; }

        /* === SIDEBAR === */
        .sidebar { width: 280px; background: var(--bg-white); padding: 40px 30px; border: 1px solid var(--border-light); border-radius: 4px; align-self: flex-start; }
        .user-greeting { text-align: center; margin-bottom: 40px; padding-bottom: 30px; border-bottom: 1px solid var(--border-light); }
        .avatar-circle { width: 80px; height: 80px; background: var(--bg-cream); border: 1px solid var(--gold-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 32px; color: var(--brand-color); margin: 0 auto 15px; }
        .user-greeting h3 { font-size: 22px; color: var(--text-dark); margin-bottom: 5px; }
        .user-greeting p { font-size: 13px; color: var(--text-gray); letter-spacing: 1px; }

        .sidebar-nav { display: flex; flex-direction: column; gap: 10px; }
        .sidebar-link { padding: 15px 20px; display: flex; align-items: center; gap: 15px; font-size: 14px; color: var(--text-gray); text-transform: uppercase; letter-spacing: 1px; font-weight: 500; border-radius: 4px; transition: 0.3s; }
        .sidebar-link i { font-size: 18px; width: 20px; text-align: center; }
        .sidebar-link:hover, .sidebar-link.active { background: var(--bg-cream); color: var(--brand-color); }

        /* === MAIN CONTENT === */
        .main-content { flex: 1; background: var(--bg-white); padding: 50px; border: 1px solid var(--border-light); border-radius: 4px; }

        .section-header-row { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 40px; }
        .section-header h2 { font-size: 32px; margin-bottom: 10px; color: var(--text-dark); }
        .section-header p { color: var(--text-gray); font-size: 14px; }

        /* Edit Button Style */
        .btn-edit { background: transparent; border: 1px solid var(--border-light); color: var(--text-gray); padding: 10px 20px; border-radius: 4px; font-size: 12px; text-transform: uppercase; letter-spacing: 1.5px; font-weight: 600; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; }
        .btn-edit:hover { color: var(--brand-color); border-color: var(--brand-color); }

        /* Alerts */
        .alert-success { background: #f0fdf4; color: var(--success-color); border: 1px solid #dcfce7; padding: 15px 20px; border-radius: 4px; font-size: 14px; margin-bottom: 30px; display: flex; align-items: center; gap: 10px; animation: fadeIn 0.5s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        /* Forms */
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 30px; }
        .full-width { grid-column: 1 / -1; }

        .input-group { position: relative; }
        .input-group label { position: absolute; top: 15px; left: 0; font-size: 14px; color: var(--text-gray); transition: 0.3s cubic-bezier(0.25, 1, 0.5, 1); pointer-events: none; }
        .input-group input { width: 100%; padding: 25px 0 10px 0; border: none; border-bottom: 1px solid var(--border-light); background: transparent; font-size: 15px; color: var(--text-dark); font-family: 'Jost', sans-serif; transition: 0.3s; outline: none; }

        .input-group input:focus ~ label,
        .input-group input:not(:placeholder-shown) ~ label { top: 0px; font-size: 11px; color: var(--brand-color); font-weight: 500; text-transform: uppercase; letter-spacing: 1px; }
        .input-group input:focus { border-bottom-color: var(--brand-color); }

        /* Locked State Styles */
        .input-group.readonly input.editable-field[readonly] { color: var(--text-gray); border-bottom-color: transparent; }
        .input-group.readonly input.editable-field:not([readonly]) { border-bottom-color: var(--border-light); color: var(--text-dark); }

        .input-group.strict-readonly input { color: #999; border-bottom-style: dashed; cursor: not-allowed; }
        .input-group.strict-readonly label { top: 0px; font-size: 11px; color: #999; font-weight: 500; text-transform: uppercase; letter-spacing: 1px; }

        /* Action Buttons */
        .form-actions { display: none; gap: 15px; animation: fadeIn 0.4s ease-out; }
        .btn-save { padding: 16px 40px; background: var(--brand-color); color: white; text-transform: uppercase; font-size: 12px; font-weight: 600; letter-spacing: 3px; border: 1px solid var(--brand-color); transition: 0.4s; cursor: pointer; display: inline-block; }
        .btn-save:hover { background: transparent; color: var(--brand-color); }
        .btn-cancel { padding: 16px 40px; background: transparent; color: var(--text-gray); text-transform: uppercase; font-size: 12px; font-weight: 600; letter-spacing: 3px; border: 1px solid var(--border-light); transition: 0.4s; cursor: pointer; display: inline-block; }
        .btn-cancel:hover { color: var(--text-dark); border-color: var(--text-dark); }

        /* Responsive */
        @media (max-width: 900px) {
            .dashboard-wrapper { flex-direction: column; }
            .sidebar { width: 100%; }
            .form-grid { grid-template-columns: 1fr; }
            .main-content { padding: 30px; }
            .section-header-row { flex-direction: column; align-items: flex-start; gap: 20px; }
        }
    </style>
</head>
<body>

    <header class="dashboard-header">
        <a href="/" class="brand-logo serif-font">SHADOW & CUT</a>
        <a href="/" class="back-to-store"><i class="fas fa-arrow-left"></i> Back to Store</a>
    </header>

    <div class="dashboard-wrapper">

        <!-- Sidebar Navigation -->
        <aside class="sidebar">
            <div class="user-greeting">
                <div class="avatar-circle">
                    <i class="serif-font" style="font-style: normal;">${not empty user.fullName ? user.fullName.substring(0, 1).toUpperCase() : 'U'}</i>
                </div>
                <h3 class="serif-font">${user.fullName}</h3>
                    <p>
                        <c:choose>
                            <c:when test="${user.role == 'ADMIN'}">Administrator</c:when>
                            <c:otherwise>Member</c:otherwise>
                        </c:choose>
                    </p>
                </div>



            <nav class="sidebar-nav">
                <a href="/profile" class="sidebar-link active"><i class="far fa-user"></i> Account Details</a>
                <a href="/orders" class="sidebar-link"><i class="fas fa-box"></i> Order History</a>
                <a href="/wishlist" class="sidebar-link"><i class="far fa-heart"></i> Wishlist</a>
                <a href="/logout" class="sidebar-link" style="color: #d9534f; margin-top: 20px;"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </nav>
        </aside>

        <!-- Main Form Area -->
        <main class="main-content">
            <div class="section-header-row">
                <div class="section-header" style="margin-bottom: 0;">
                    <h2 class="serif-font">Account Details</h2>
                    <p>Manage your personal information and shipping address.</p>
                </div>

                <!-- Edit Toggle Button -->
                <button type="button" id="editProfileBtn" class="btn-edit" onclick="enableEditMode()">
                    <i class="fas fa-pen"></i> Edit Profile
                </button>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="alert-success">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>

            <form action="/profile/update" method="post" id="profileForm">
                <div class="form-grid">

                    <!-- Strict Readonly Email -->
                    <div class="input-group strict-readonly full-width">
                        <input type="text" value="${user.email}" readonly placeholder=" ">
                        <label>Email Address (Non-editable)</label>
                    </div>

                    <!-- Full Name -->
                    <div class="input-group readonly full-width">
                        <input type="text" id="fullName" name="fullName" value="${user.fullName}" required placeholder=" " readonly class="editable-field">
                        <label for="fullName">Full Name</label>
                    </div>

                    <!-- Phone Number -->
                    <div class="input-group readonly">
                        <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" placeholder=" " readonly class="editable-field">
                        <label for="phoneNumber">Phone Number</label>
                    </div>

                    <!-- Address -->
                    <div class="input-group readonly">
                        <input type="text" id="address" name="address" value="${user.address}" placeholder=" " readonly class="editable-field">
                        <label for="address">Shipping Address</label>
                    </div>

                </div>

                <!-- Hidden by default, shown when editing -->
                <div class="form-actions" id="actionButtons">
                    <button type="submit" class="btn-save">Save Changes</button>
                    <button type="button" class="btn-cancel" onclick="disableEditMode()">Cancel</button>
                </div>
            </form>
        </main>

    </div>

    <script>
        // Store original values in case the user clicks "Cancel"
        const originalData = {
            fullName: document.getElementById('fullName').value,
            phoneNumber: document.getElementById('phoneNumber').value,
            address: document.getElementById('address').value
        };

        function enableEditMode() {
            // Remove readonly attribute from editable fields
            document.querySelectorAll('.editable-field').forEach(input => {
                input.removeAttribute('readonly');
            });

            // Hide Edit button, Show Save/Cancel buttons
            document.getElementById('editProfileBtn').style.display = 'none';
            document.getElementById('actionButtons').style.display = 'flex';

            // Auto-focus the first field for a better UX
            document.getElementById('fullName').focus();
        }

        function disableEditMode() {
            // Restore original values
            document.getElementById('fullName').value = originalData.fullName;
            document.getElementById('phoneNumber').value = originalData.phoneNumber;
            document.getElementById('address').value = originalData.address;

            // Re-add readonly attribute
            document.querySelectorAll('.editable-field').forEach(input => {
                input.setAttribute('readonly', true);
            });

            // Hide Save/Cancel buttons, Show Edit button
            document.getElementById('actionButtons').style.display = 'none';
            document.getElementById('editProfileBtn').style.display = 'flex';
        }
    </script>
</body>
</html>