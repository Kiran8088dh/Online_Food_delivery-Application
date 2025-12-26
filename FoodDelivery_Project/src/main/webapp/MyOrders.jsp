<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.restaurant.model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders — Namma Kitchen</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #ff6f00;
            --bg: #f8fafc;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --white: #ffffff;
            --shadow: 0 4px 15px rgba(0,0,0,0.05);
            --border: #e2e8f0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            margin: 0;
            padding: 40px 20px;
        }

        .container {
            max-width: 850px;
            margin: 0 auto;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        h2 { font-weight: 700; font-size: 1.8rem; margin: 0; }

        /* Order Card Styling */
        .order-card {
            background: var(--white);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            position: relative;
        }

        .order-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 1px solid var(--border);
            padding-bottom: 15px;
            margin-bottom: 15px;
        }

        .order-meta { display: flex; flex-direction: column; }
        .order-id { font-weight: 600; font-size: 0.95rem; color: var(--text-main); }
        .order-id span { color: var(--text-muted); font-family: monospace; font-size: 0.85rem; }

        /* Status Badges */
        .badge {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-placed { background: #dcfce7; color: #15803d; }
        .status-pending { background: #fef9c3; color: #a16207; }

        .card-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .info-row { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 8px; }
        .info-icon { font-size: 1.1rem; }
        .address-text { font-size: 0.9rem; color: var(--text-muted); line-height: 1.4; }

        .price-section {
            text-align: right;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .total-amount { font-size: 1.5rem; font-weight: 700; color: var(--primary); }
        .payment-mode { font-size: 0.75rem; color: var(--text-muted); font-weight: 500; }

        /* Button Styling */
        .view-details-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        .view-details-btn:hover {
            background: var(--primary);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-section">
        <h2>📦 My Orders</h2>
        <a href="restaurants" style="color: var(--primary); font-weight: 600; text-decoration: none;">Order More →</a>
    </div>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orderList");
        if(orders == null || orders.isEmpty()){
    %>
        <div class="empty-state">
            <h1 style="font-size: 4rem; margin: 0;">🥘</h1>
            <h3>No orders yet!</h3>
            <p style="color: var(--text-muted);">Hungry? Start exploring the best local foods near you.</p>
            <a href="restaurants" class="view-details-btn" style="background: var(--primary); color: white;">Browse Restaurants</a>
        </div>
    <% 
        } else { 
            for(Order o : orders){ 
                // Simple logic to change badge color
                String statusClass = "status-placed";
                if(o.getOrderStatus().equalsIgnoreCase("Pending")) statusClass = "status-pending";
    %>
    <div class="order-card">
        <div class="card-top">
            <div class="order-meta">
                <div class="order-id">ORDER ID: <span>#<%= o.getOrderId() %></span></div>
            </div>
            <div class="badge <%= statusClass %>">
                <%= o.getOrderStatus() %>
            </div>
        </div>

        <div class="card-content">
            <div class="info-side">
                <div class="info-row">
                    <span class="info-icon">📍</span>
                    <div class="address-text">
                        <strong>Delivery Address</strong><br>
                        <%= o.getShippingAddress() %>
                    </div>
                </div>
            </div>

            <div class="price-section">
                <span class="total-amount">₹<%= o.getTotalAmount() %></span>
                <span class="payment-mode">via <%= o.getPaymentMode() %></span>
            </div>
        </div>

        <a href="orderDetails?orderId=<%= o.getOrderId() %>" class="view-details-btn">
            View Details
        </a>
    </div>
    <% } } %>
</div>

</body>
</html>