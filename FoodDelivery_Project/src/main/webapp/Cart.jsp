<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restaurant.model.Cart, com.restaurant.model.CartItem, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart — Namma Kichen</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        /* --- THEME & BASE STYLES --- */
        :root{
          --bg:#f6f8fb;
          --card:#ffffff;
          --muted:#6b7280;
          --text:#0b1220;
          --accent:#ff6f00; /* Changed primary accent to orange for a food theme */
          --accent-dark:#e05d00;
          --shadow: 0 10px 30px rgba(15,23,42,0.1);
          --soft-shadow: 0 5px 15px rgba(15,23,42,0.05);
          --border: rgba(11,17,32,0.08);
          --radius: 12px;
          --maxw:1180px;
        }

        :root.dark{
          --bg:#071228;
          --card:#081426;
          --muted:#9aa6b2;
          --text:#e6eef3;
          --accent:#ff8a00;
          --accent-dark:#ff6f00;
          --shadow: 0 12px 36px rgba(0,0,0,0.6);
          --soft-shadow: 0 8px 20px rgba(0,0,0,0.45);
          --border: rgba(255,255,255,0.06);
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        .wrap{max-width:var(--maxw);margin:0 auto;padding:12px 18px}
        
        /* --- HEADER STYLES (Kept intact) --- */
        .header{display:flex;align-items:center;gap:12px;padding:10px 0;position:sticky;top:0;background:var(--bg);z-index:40}
        .logo{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
        .logo-badge{width:44px;height:44px;border-radius:10px;background:linear-gradient(135deg,#ff7043,#ff8a00);display:grid;place-items:center;color:#fff;font-weight:800;font-size:20px;box-shadow:var(--shadow)}
        .brand{font-weight:700;font-size:1.15rem}
        .header-center{flex:1;display:flex;align-items:center;gap:12px;padding-left:8px}
        .header-right{display:flex;align-items:center;gap:10px}
        .search-compact{display:flex;align-items:center;gap:8px;background:var(--card);border-radius:999px;padding:8px 12px;border:1px solid var(--border);min-width:260px;box-shadow:var(--shadow);color:var(--text)}
        .search-compact input{border:0;outline:0;background:transparent;color:var(--text);width:180px;font-size:0.95rem}
        .icon-btn{display:inline-grid;align-items:center;justify-items:center;background:var(--card);border-radius:10px;padding:8px;min-width:40px;min-height:40px;cursor:pointer;border:1px solid var(--border);color:var(--text);position:relative;text-decoration:none}
        .icon-btn svg *,:root svg *,.search-compact svg *{ stroke: currentColor !important; fill: none !important; }
        .cart-badge{position:absolute;top:-6px;right:-6px;min-width:20px;height:20px;padding:0 6px;border-radius:999px;background:#e63946;color:#fff;font-weight:700;font-size:12px;display:flex;align-items:center;justify-content:center;box-shadow:0 6px 14px rgba(230,57,70,0.18)}
        :root.dark .cart-badge{ background:#ff6b78; box-shadow: 0 6px 14px rgba(255,107,120,0.11) }
        .login-btn{background:var(--accent);color:#fff;border:none;padding:8px 12px;border-radius:999px;font-weight:700;cursor:pointer;box-shadow:0 8px 20px rgba(255,111,0,0.12)}
        /* --- END HEADER STYLES --- */


        /* --- PAGE LAYOUT & CART STYLES --- */
        .page-wrapper { width:100%; max-width:1000px; margin: 18px auto 60px; }
        .heading { text-align:center;color:var(--text);font-size:2.4rem;font-weight:700;margin-bottom:30px }

        /* Use flex for main cart content */
        .cart-content-wrap { display: flex; gap: 20px; align-items: flex-start; }
        .cart-items-section { flex: 2; min-width: 60%; }
        .cart-summary-section { flex: 1; min-width: 300px; position: sticky; top: 70px; }


        .cart-card { 
            background:var(--card); 
            border-radius:var(--radius); 
            box-shadow:var(--shadow); 
            padding:0; /* Padding removed from card to use in table */
            border:1px solid var(--border) 
        }

        /* --- TABLE STYLES --- */
        table { width:100%; border-collapse:collapse; background:transparent; }
        th, td { padding:14px 16px; text-align:left; font-size:0.95rem; color:var(--text); vertical-align:middle; border-bottom:1px solid var(--border); }
        thead th { background: var(--accent); color:#fff; font-weight:600; border-bottom:0; }
        
        /* Style for the last row to remove border */
        tbody tr:last-child td { border-bottom: none; }
        
        .price,.subtotal{ font-weight:700; color:var(--accent) }
        .item-name { font-weight: 500; }

        /* --- QUANTITY CONTROLS --- */
        .qty-actions{ display:inline-flex; align-items:center; gap:8px; background:var(--bg); padding:4px 8px; border-radius:999px; border:1px solid var(--border); box-shadow:var(--soft-shadow); }
        .qty-display{ min-width:28px; text-align:center; font-weight:600; color:var(--text); }
        .qty-btn{ border:none; border-radius:999px; padding:6px 10px; font-size:0.95rem; font-weight:700; cursor:pointer; background-color:var(--accent); color:#fff; line-height:1; transition: background .15s ease }
        .qty-btn:hover{ background-color: var(--accent-dark); }


        /* --- BUTTON STYLES --- */
        .btn { 
            border:none; 
            border-radius:8px; /* Slightly squarer buttons */
            padding:10px 18px; 
            font-size:0.95rem; 
            font-weight:600; 
            cursor:pointer; 
            display:inline-flex; 
            gap:6px;
            text-decoration: none;
            transition: transform .15s ease, opacity .15s ease;
        }
        .btn:hover{ transform: translateY(-1px); }
        .btn-remove{ background-color:#e63946; color:#fff; padding:8px 12px; border-radius:6px }
        .btn-secondary{ background:transparent; color:var(--accent); border:1px solid var(--accent); }
        .btn-primary{ background:var(--accent); color:#fff; }
        
        /* --- SUMMARY BOX STYLES --- */
        .summary-card {
            background: var(--card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 24px;
            border: 1px solid var(--border);
        }
        .summary-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text);
            padding-bottom: 15px;
            margin-bottom: 15px;
            border-bottom: 1px solid var(--border);
        }
        .summary-row-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1rem;
            color: var(--muted);
        }
        .summary-row-item strong {
            color: var(--text);
            font-weight: 600;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            margin-top: 15px;
            border-top: 2px dashed var(--border);
        }
        .summary-total span {
            font-size: 1.15rem;
            font-weight: 700;
        }
        .summary-total strong {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--accent);
        }

        .checkout-btn-wrap { margin-top: 20px; }
        .checkout-btn-wrap a { width: 100%; justify-content: center; }

        .actions-bar { 
            margin-top: 15px; 
            display: flex; 
            justify-content: center;
        }
        
        /* --- RESPONSIVENESS --- */
        @media (max-width:900px){
            .cart-content-wrap { flex-direction:column; }
            .cart-summary-section { position:static; min-width:auto; }
            .cart-items-section { min-width: auto; }
        }

        @media (max-width:600px){
            .heading { font-size: 2rem; margin-bottom: 20px; }
            .search-compact{min-width:140px}
            .search-compact input{width:110px}
            .page-wrapper{ padding: 18px 12px }
            table, th, td { font-size:0.85rem; padding: 10px 8px; }
        }
    </style>
</head>
<body>

<%
    // compute cart count from session (show 0 if no cart)
    
    Cart sessionCart = (Cart) session.getAttribute("cart");
    int cartCount = 0;
    if (sessionCart != null) {
        try { cartCount = sessionCart.getTotalQuantity(); } catch(Exception e){ cartCount = 0; }
    }
%>

<div class="wrap">
  <header class="header">
    <a class="logo" href="<%= request.getContextPath() %>/">
      <div class="logo-badge">🍛</div>
      <div class="brand">Namma Kitchen</div>
    </a>

    <div class="header-center"></div>

    <div class="header-right">
      <div class="search-compact" role="search" aria-label="Search">
        <svg width="16" height="16" viewBox="0 0 24 24"><path d="M21 21l-4.35-4.35" stroke-width="1.4"/><circle cx="11" cy="11" r="5" stroke-width="1.4"/></svg>
        <input id="searchInput" placeholder="Search dishes, restaurants..." />
      </div>

      <button class="login-btn" onclick="window.location.href='<%= request.getContextPath() %>/login'">Login</button>

      <a class="icon-btn" title="Cart" href="<%= request.getContextPath() %>/Cart.jsp" role="button" aria-label="Open cart">
        <svg width="18" height="18" viewBox="0 0 24 24"><path d="M6 6h13l-1.5 9h-11z" stroke-width="1.2"/><circle cx="10" cy="19" r="1"/><circle cx="18" cy="19" r="1"/></svg>
        <% if (cartCount > 0) { %><span class="cart-badge"><%= cartCount %></span><% } %>
      </a>

      <a class="icon-btn" title="Profile" href="<%= request.getContextPath() %>/profile.jsp" role="button" aria-label="Profile">
        <svg width="18" height="18" viewBox="0 0 24 24"><circle cx="12" cy="8" r="3" stroke-width="1.2"/><path d="M5 20c1.5-4 11-4 14 0" stroke-width="1.0"/></svg>
      </a>

      <button class="icon-btn" id="themeToggle" title="Toggle theme">
        <svg id="themeIcon" width="18" height="18" viewBox="0 0 24 24"><path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" stroke-width="1.2"/></svg>
      </button>
    </div>
  </header>
</div>

<div class="page-wrapper">
    <h1 class="heading">Review Your Order</h1>

    <%
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
    %>
        <div class="cart-card" style="padding: 24px; text-align: center;">
            <div class="empty-msg">
                Your cart is currently empty. <br><br>
                <a href="<%= request.getContextPath() %>/restaurants" class="btn btn-primary">← Browse Restaurants</a>
            </div>
        </div>
    <%
        } else {
            // --- Sample Delivery Fee and Taxes for summary calculation ---
            float deliveryFee = 40.00f; 
            float taxRate = 0.05f; // 5%
            float itemTotal = cart.getTotalCartPrice();
            float taxAmount = itemTotal * taxRate;
            float grandTotal = itemTotal + deliveryFee + taxAmount;
    %>

    <div class="cart-content-wrap">
        
        <div class="cart-items-section">
            <div class="cart-card">
                <table>
                    <thead>
                    <tr>
                        <th style="width:40px">#</th>
                        <th>Item</th>
                        <th style="width:110px">Price (₹)</th>
                        <th style="width:170px">Quantity</th>
                        <th style="width:120px">Subtotal (₹)</th>
                        <th style="width:100px;text-align:center;">Remove</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int index = 1;
                        for (CartItem item : cart.getItems()) {
                    %>
                    <tr>
                        <td><%= index++ %></td>
                        <td class="item-name"><%= item.getName() %></td>
                        <td class="price">₹ <%= String.format("%.2f", item.getPrice()) %></td>

                        <td>
                            <div class="qty-actions">
                                <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;margin:0;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                    <input type="hidden" name="quantity" value="<%= Math.max(0, item.getQuantity() - 1) %>">
                                    <button type="submit" class="qty-btn">−</button>
                                </form>

                                <span class="qty-display"><%= item.getQuantity() %></span>

                                <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;margin:0;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                    <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                                    <button type="submit" class="qty-btn">+</button>
                                </form>
                            </div>
                        </td>

                        <td class="subtotal">₹ <%= String.format("%.2f", item.getTotalPrice()) %></td>

                        <td style="text-align:center;">
                            <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <button type="submit" class="btn-remove">X</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <div class="actions-bar">
                <button type="button" class="btn btn-secondary"
                    onclick="window.location.href='<%= request.getContextPath() %>/restaurants'">
                ← Continue Shopping
                </button>
            </div>
        </div>
        
        <div class="cart-summary-section">
            <div class="summary-card">
                <h3 class="summary-title">Order Summary</h3>

                <div class="summary-row-item">
                    <span>Total Items:</span>
                    <strong><%= cart.getTotalQuantity() %></strong>
                </div>
                
                <div class="summary-row-item">
                    <span>Item Subtotal:</span>
                    <strong>₹ <%= String.format("%.2f", itemTotal) %></strong>
                </div>
                
                <div class="summary-row-item">
                    <span>Delivery Fee:</span>
                    <strong>₹ <%= String.format("%.2f", deliveryFee) %></strong>
                </div>

                <div class="summary-row-item">
                    <span>Taxes (5%):</span>
                    <strong>₹ <%= String.format("%.2f", taxAmount) %></strong>
                </div>

                <div class="summary-total">
                    <span>Grand Total:</span>
                    <strong>₹ <%= String.format("%.2f", grandTotal) %></strong>
                </div>

                <div class="checkout-btn-wrap">
                    <a href="<%= request.getContextPath() %>/checkout.jsp" class="btn btn-primary">
                        Proceed to Checkout →
                    </a>
                </div>
            </div>
        </div>


    </div>

    <%
        }
    %>
</div>

<script>
  // apply saved theme on load and toggle
  (function(){
    const root = document.documentElement;
    const saved = localStorage.getItem('bhojana-theme');
    if(saved === 'dark') root.classList.add('dark');

    const toggle = document.getElementById('themeToggle');
    const icon = document.getElementById('themeIcon');

    function setIcon(){
      if(root.classList.contains('dark')){
        icon.innerHTML = '<circle cx="12" cy="12" r="4" stroke-width="1.2"/>';
      } else {
        icon.innerHTML = '<path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" stroke-width="1.2"/>';
      }
    }
    setIcon();

    if(toggle) toggle.addEventListener('click', function(){
      root.classList.toggle('dark');
      localStorage.setItem('bhojana-theme', root.classList.contains('dark') ? 'dark' : 'light');
      setIcon();
    });

    // search submit
    const searchInput = document.getElementById('searchInput');
    if (searchInput){
      searchInput.addEventListener('keydown', function(e){
        if(e.key === 'Enter'){
          const q = this.value.trim();
          if(q) window.location.href = '<%= request.getContextPath() %>/search?q=' + encodeURIComponent(q);
        }
      });
    }
  })();
</script>

</body>
</html>