<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.restaurant.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Successful — Namma Kitchen</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
:root {
  --bg: #f6f8fb;
  --card: #ffffff;
  --text: #0b1220;
  --muted: #6b7280;
  --accent: #ff6f00;
  --success: #22c55e;
  --danger: #ef4444;
  --shadow: 0 10px 40px rgba(0,0,0,0.08);
  --radius: 16px;
}

* { box-sizing: border-box; }
body { 
    font-family: 'Poppins', sans-serif; 
    background: var(--bg); 
    color: var(--text); 
    margin: 0; 
    display: flex; 
    align-items: center; 
    justify-content: center; 
    min-height: 100vh;
    padding: 20px;
}

.conf-card {
    background: var(--card);
    width: 100%;
    max-width: 550px;
    padding: 40px;
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    text-align: center;
    animation: slideUp 0.5s ease-out;
}

@keyframes slideUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.success-icon {
    width: 80px;
    height: 80px;
    background: #dcfce7;
    color: var(--success);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40px;
    margin: 0 auto 20px;
}

h2 { margin: 0 0 10px; font-weight: 700; color: var(--text); }
.subtitle { color: var(--muted); margin-bottom: 30px; font-size: 0.95rem; }

.order-box {
    background: #f9fafb;
    border: 1px dashed #e5e7eb;
    border-radius: 12px;
    padding: 20px;
    text-align: left;
    margin-bottom: 30px;
}

.order-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
    font-size: 0.9rem;
}

.label { color: var(--muted); font-weight: 500; }
.value { color: var(--text); font-weight: 600; }

.items-list {
    text-align: left;
    margin-bottom: 30px;
}

.items-list h3 { font-size: 1.1rem; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px; }

.item-entry {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    font-size: 0.95rem;
}

.total-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 20px;
    margin-top: 10px;
    border-top: 2px solid #f1f1f1;
}

.total-price { font-size: 1.5rem; font-weight: 700; color: var(--accent); }

.btn-group { display: flex; flex-direction: column; gap: 12px; margin-top: 30px; }
.btn {
    padding: 14px;
    border-radius: 10px;
    font-weight: 600;
    text-decoration: none;
    transition: 0.2s;
    cursor: pointer;
    border: none;
    font-size: 1rem;
    display: block;
    text-align: center;
}

.btn-track { background: var(--accent); color: white; }
.btn-track:hover { background: #e66400; transform: scale(1.02); }

.btn-outline { background: transparent; border: 1px solid #e5e7eb; color: var(--muted); }
.btn-outline:hover { background: #f9fafb; color: var(--text); }

.btn-danger { color: var(--danger); font-size: 0.85rem; background: none; margin-top: 10px; opacity: 0.7; }
.btn-danger:hover { opacity: 1; text-decoration: underline; }

</style>
</head>
<body>

<div class="conf-card">
    <div class="success-icon">✓</div>
    <h2>Order Placed Successfully!</h2>
    <p class="subtitle">Thank you for your order. We’ve received it and are preparing your food.</p>

    <div class="order-box">
        <div class="order-row">
            <span class="label">Order ID</span>
            <span class="value">#${orderId}</span>
        </div>
        <div class="order-row">
            <span class="label">Delivery to</span>
            <span class="value">${shippingAddress}</span>
        </div>
    </div>

    <div class="items-list">
        <h3>Order Summary</h3>
        <%
            Collection<CartItem> items = (Collection<CartItem>) request.getAttribute("cartItems");
            if(items != null) {
                for(CartItem item : items) {
        %>
            <div class="item-entry">
                <span><%= item.getName() %> <b>× <%= item.getQuantity() %></b></span>
                <span class="value">₹<%= (int)(item.getPrice() * item.getQuantity()) %></span>
            </div>
        <% 
                } 
            }
        %>
        
        <div class="total-section">
            <span class="value" style="font-size: 1.1rem;">Amount Paid</span>
            <span class="total-price">₹${grandTotal}</span>
        </div>
    </div>

    <div class="btn-group">
        <a href="<%= request.getContextPath() %>/MyOrders.jsp" class="btn btn-track">Track Your Order</a>
        <a href="<%= request.getContextPath() %>/restaurants" class="btn btn-outline">Continue Shopping</a>
        <button class="btn btn-danger">Cancel Order</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

<script>
    window.onload = function() {
        const count = 200;
        const defaults = { origin: { y: 0.7 }, colors: ['#ff6f00', '#22c55e', '#ffffff'] };
        function fire(ratio, opts) {
            confetti({ ...defaults, ...opts, particleCount: Math.floor(count * ratio) });
        }
        fire(0.25, { spread: 26, startVelocity: 55 });
        fire(0.2, { spread: 60 });
        fire(0.35, { spread: 100, decay: 0.91, scalar: 0.8 });
        fire(0.1, { spread: 120, startVelocity: 25, decay: 0.92, scalar: 1.2 });
    };
</script>

</body>
</html>