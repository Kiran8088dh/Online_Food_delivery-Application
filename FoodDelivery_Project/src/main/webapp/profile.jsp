<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restaurant.model.User" %>

<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    // Get first letter of name for the avatar
    String initial = (user.getName() != null && !user.getName().isEmpty()) ? user.getName().substring(0, 1).toUpperCase() : "U";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — Namma Kitchen</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: #f8fafc;
            --card: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --primary: #ff6f00;
            --danger: #e11d48;
            --danger-bg: #fff1f2;
            --border: #e2e8f0;
            --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        :root.dark {
            --bg: #0f172a;
            --card: #1e293b;
            --text-dark: #f1f5f9;
            --text-muted: #94a3b8;
            --border: #334155;
            --danger-bg: rgba(225, 29, 72, 0.1);
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg);
            color: var(--text-dark);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .profile-container {
            width: 100%;
            max-width: 450px;
            padding: 20px;
        }

        .profile-card {
            background: var(--card);
            border-radius: 24px;
            padding: 40px 30px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            text-align: center;
            position: relative;
        }

        /* Avatar Styling */
        .avatar {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, var(--primary), #ff9100);
            color: white;
            font-size: 36px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto 20px;
            box-shadow: 0 10px 20px rgba(255, 111, 0, 0.3);
            border: 4px solid var(--card);
        }

        h2 { margin: 0 0 8px; font-weight: 700; font-size: 1.5rem; }
        .user-role { color: var(--text-muted); font-size: 0.9rem; margin-bottom: 30px; display: block; }

        /* Info Rows */
        .info-group {
            text-align: left;
            margin-bottom: 25px;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid var(--border);
        }

        .info-item:last-child { border-bottom: none; }

        .info-icon {
            width: 36px;
            height: 36px;
            background: var(--bg);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 18px;
        }

        .info-text { display: flex; flex-direction: column; }
        .info-label { font-size: 0.75rem; color: var(--text-muted); font-weight: 500; text-transform: uppercase; letter-spacing: 0.5px; }
        .info-value { font-size: 0.95rem; font-weight: 600; color: var(--text-dark); }

        /* Logout Button - Enhanced */
        .logout-wrapper {
            margin-top: 15px;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            padding: 14px;
            background: var(--danger-bg);
            color: var(--danger) !important;
            text-decoration: none;
            border-radius: 16px;
            font-weight: 700;
            font-size: 0.95rem;
            border: 1.5px solid rgba(225, 29, 72, 0.2);
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: var(--danger);
            color: white !important;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(225, 29, 72, 0.2);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.85rem;
            transition: 0.2s;
        }
        .back-link:hover { color: var(--primary); }

    </style>
</head>
<body>

<div class="profile-container">
    <div class="profile-card">
        <div class="avatar"><%= initial %></div>
        <h2><%= user.getName() %></h2>
        <span class="user-role">Valued Customer</span>

        <div class="info-group">
            <div class="info-item">
                <div class="info-icon">📧</div>
                <div class="info-text">
                    <span class="info-label">Email Address</span>
                    <span class="info-value"><%= user.getEmail() %></span>
                </div>
            </div>

            <div class="info-item">
                <div class="info-icon">📞</div>
                <div class="info-text">
                    <span class="info-label">Phone Number</span>
                    <span class="info-value"><%= user.getPhone() %></span>
                </div>
            </div>

            <div class="info-item">
                <div class="info-icon">📍</div>
                <div class="info-text">
                    <span class="info-label">Default Address</span>
                    <span class="info-value"><%= user.getAddress() %></span>
                </div>
            </div>
        </div>

        <div class="logout-wrapper">
            <a href="<%= request.getContextPath() %>/login.jsp" class="logout-btn">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <polyline points="16 17 21 12 16 7"></polyline>
                    <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
                Sign Out
            </a>
        </div>

        <a href="<%= request.getContextPath() %>/restaurants" class="back-link">← Back to Restaurants</a>
    </div>
</div>

<script>
    // Theme Sync
    (function(){
        const saved = localStorage.getItem('bhojana-theme');
        if(saved === 'dark') document.documentElement.classList.add('dark');
    })();
</script>

</body>
</html>