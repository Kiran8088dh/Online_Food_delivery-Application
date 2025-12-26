<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.restaurant.model.Menu" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu | Namma Kitchen</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: #fcfcfd;
            --card: #ffffff;
            --text: #1a1a1a;
            --muted: #64748b;
            --accent: #ff6f00;
            --primary-gradient: linear-gradient(135deg, #ff6f00, #ff9100);
            --shadow: 0 10px 40px rgba(0,0,0,0.04);
            --radius: 24px;
            --rating-green: #22c55e;
        }

        :root.dark {
            --bg: #0f172a;
            --card: #1e293b;
            --text: #f8fafc;
            --muted: #94a3b8;
            --shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        * { box-sizing: border-box; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }

        body {
            margin: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            padding-bottom: 50px;
        }

        /* --- STICKY TOP NAV --- */
        .top-nav {
            position: sticky;
            top: 0;
            z-index: 100;
            padding: 15px 5vw;
            background: rgba(252, 252, 253, 0.8);
            backdrop-filter: blur(12px);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        :root.dark .top-nav { background: rgba(15, 23, 42, 0.8); }

        .back-link {
            text-decoration: none;
            color: var(--text);
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: var(--card);
            border-radius: 14px;
            box-shadow: var(--shadow);
            border: 1px solid rgba(0,0,0,0.05);
        }

        /* --- HERO SECTION --- */
        .menu-hero {
            text-align: center;
            padding: 40px 20px;
        }
        .menu-hero h1 {
            font-size: 3rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1.5px;
        }
        .menu-hero p { color: var(--muted); font-weight: 500; }

        /* --- MENU GRID --- */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            max-width: 1300px;
            margin: 0 auto;
            padding: 0 5vw;
        }

        .menu-card {
            background: var(--card);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            border: 1px solid rgba(0,0,0,0.03);
            position: relative;
        }

        .menu-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.12);
        }

        .img-container {
            position: relative;
            height: 220px;
            overflow: hidden;
        }
        .menu-img { width: 100%; height: 100%; object-fit: cover; }

        /* Veg/Non-Veg Icon */
        .diet-icon {
            position: absolute;
            top: 15px;
            left: 15px;
            background: white;
            padding: 4px;
            border-radius: 4px;
            border: 1px solid #ddd;
            display: flex;
        }
        .dot { width: 10px; height: 10px; border-radius: 50%; background: #22c55e; } /* Green for Veg */

        .menu-content { padding: 24px; }

        .menu-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .menu-name { font-size: 1.3rem; font-weight: 800; margin: 0; line-height: 1.2; }

        .rating-chip {
            background: #f0fdf4;
            color: #166534;
            padding: 4px 10px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        :root.dark .rating-chip { background: #14532d; color: #4ade80; }

        .menu-desc {
            font-size: 0.9rem;
            color: var(--muted);
            margin-bottom: 20px;
            line-height: 1.6;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .menu-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
        }

        .price-tag {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text);
        }
        .price-tag span { font-size: 1rem; color: var(--accent); margin-right: 2px; }

        .add-btn {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 14px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(255, 111, 0, 0.3);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(255, 111, 0, 0.4);
        }

        .add-btn svg { width: 18px; height: 18px; }

        /* Empty state */
        .empty-state {
            grid-column: 1/-1;
            text-align: center;
            padding: 100px 0;
            color: var(--muted);
        }

        @media (max-width: 600px) {
            .menu-hero h1 { font-size: 2.2rem; }
            .menu-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<nav class="top-nav">
    <a href="<%= request.getContextPath() %>/restaurants" class="back-link">


        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
        Back
    </a>
    <div style="font-weight: 800; font-size: 1.2rem;">Menu</div>
    <div style="width: 40px;"></div> </nav>

<div class="menu-hero">
    <h1>Today's Specials</h1>
    <p>Freshly prepared ingredients for a perfect meal.</p>
</div>

<div class="menu-grid">
<%
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
    if (menuList != null && !menuList.isEmpty()) {
        for (Menu menu : menuList) {
%>
    <div class="menu-card">
        <div class="img-container">
            <div class="diet-icon"><div class="dot"></div></div>
            <img src="<%= request.getContextPath() %>/Menuimages/<%= menu.getImage() %>" 
                 alt="<%= menu.getName() %>" class="menu-img"
                 onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500'">
        </div>

        <div class="menu-content">
            <div class="menu-header">
                <h3 class="menu-name"><%= menu.getName() %></h3>
                <div class="rating-chip">★ <%= menu.getRating() %></div>
            </div>
            
            <p class="menu-desc"><%= menu.getDescription() %></p>

            <div class="menu-footer">
                <div class="price-tag"><span>₹</span><%= menu.getPrice() %></div>
                
                <form action="<%= request.getContextPath() %>/cart" method="post" style="margin:0;">
                    <input type="hidden" name="menuId" value="<%= menu.getId() %>">
                    <input type="hidden" name="quantity" value="1">
                    <input type="hidden" name="restaurantId" value="<%= menu.getRestaurant_Id() %>">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="add-btn">
                        <svg viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3"><path d="M12 5v14M5 12h14"/></svg>
                        Add
                    </button>
                </form>
            </div>
        </div>
    </div>
<%
        }
    } else {
%>
    <div class="empty-state">
        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="#ccc" stroke-width="1" style="margin-bottom:20px;"><path d="M3 3h18v18H3zM9 9h6v6H9z"/></svg>
        <h3>No items available right now.</h3>
        <p>Check back later for fresh dishes!</p>
    </div>
<%
    }
%>
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