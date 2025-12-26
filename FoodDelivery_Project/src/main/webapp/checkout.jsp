<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restaurant.model.Cart, com.restaurant.model.CartItem, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - Address & Payment</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* --- Theme Variables (Matching Cart/Menu Pages) --- */
        :root{
          --bg:#f6f8fb;
          --card:#ffffff;
          --muted:#6b7280;
          --text:#0b1220;
          --accent:#ff6f00; /* Primary Brand Color */
          --accent-dark:#e05d00;
          --shadow: 0 16px 32px rgba(11,17,32,0.08); /* Stronger shadows */
          --soft-shadow: 0 5px 15px rgba(15,23,42,0.05);
          --border: rgba(11,17,32,0.1); /* Slightly darker border */
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
          --shadow: 0 18px 45px rgba(0,0,0,0.6);
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
        
        /* Layout */
        .page-wrapper { width:100%; max-width:1100px; margin: 18px auto 60px; padding: 0 18px; }
        .heading { text-align:center;color:var(--text);font-size:2.4rem;font-weight:700;margin-bottom:30px }
        .checkout-grid { display: flex; gap: 30px; align-items: flex-start; }
        .checkout-details { flex: 2; display: flex; flex-direction: column; gap: 25px; } /* Increased gap */
        .order-summary { flex: 1; position: sticky; top: 70px; min-width: 300px; }
        
        /* Cards */
        .card { 
            background:var(--card); 
            border-radius:var(--radius); 
            box-shadow:var(--shadow); 
            padding:30px; /* Increased padding */
            border:1px solid var(--border);
        }
        .card-title {
            font-size: 1.4rem; /* Larger title */
            font-weight: 700;
            color: var(--text);
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 3px solid var(--accent); /* Accent colored underline */
            display: inline-block; /* Only underline the text */
            line-height: 1.2;
        }
        .card-title span {
            font-size: 0.9em;
            font-weight: 500;
            margin-right: 10px;
            color: var(--accent);
        }

        /* Form Elements */
        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px; /* Increased spacing */
            color: var(--text);
            font-size: 0.95rem;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group textarea {
            width: 100%;
            padding: 14px 18px; /* Larger padding for better touch targets */
            border-radius: 8px;
            border: 1px solid var(--border);
            background: var(--bg);
            color: var(--text);
            font-size: 1rem;
            transition: all .2s ease;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(255,111,0,0.2); /* Stronger focus ring */
            background: var(--card); /* Lighten background on focus */
        }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }

        /* Payment Mode Selection */
        .payment-option {
            display: flex;
            align-items: center;
            background: var(--card); /* Background set to card color */
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all .2s ease;
            box-shadow: var(--soft-shadow); /* Soft shadow on options */
        }
        .payment-option:hover { 
            background: rgba(255,111,0,0.08); 
            border-color: var(--accent); 
        }
        .payment-option input[type="radio"] {
            margin-right: 15px;
            appearance: none;
            width: 20px;
            height: 20px;
            border: 2px solid var(--muted);
            border-radius: 50%;
            transition: all .2s ease;
            position: relative;
            cursor: pointer;
            flex-shrink: 0;
        }
        .payment-option input[type="radio"]:checked {
            border-color: var(--accent);
            background-color: var(--accent);
            box-shadow: inset 0 0 0 4px var(--card); 
        }
        .payment-option-text {
            font-weight: 600;
            font-size: 1.1rem; /* Slightly larger text */
            color: var(--text);
        }
        .payment-info {
            font-size: 0.9rem;
            color: var(--muted);
        }

        /* Order Summary Styles */
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
            font-size: 1.2rem;
            font-weight: 700;
        }
        .summary-total strong {
            font-size: 1.8rem; /* Much larger total */
            font-weight: 800;
            color: var(--accent);
        }

        /* Button Styles */
        .btn-primary { 
            background:var(--accent); 
            color:#fff; 
            border:none; 
            padding:15px 18px; /* Taller button */
            border-radius:8px; 
            font-size:1.2rem; /* Larger font */
            font-weight:700; 
            cursor:pointer; 
            width: 100%;
            margin-top: 25px;
            transition: background .2s ease, transform .15s ease;
            box-shadow: 0 8px 18px rgba(255,111,0,0.25); /* Accent shadow */
        }
        .btn-primary:hover { background: var(--accent-dark); transform: translateY(-2px); }
        
        .back-btn { 
            display: block; 
            text-align: center; 
            margin-top: 20px; 
            color: var(--muted); 
            text-decoration: none;
            font-size: 0.95rem;
        }
        
        /* Responsive */
        @media (max-width: 900px) {
            .checkout-grid { flex-direction: column; }
            .order-summary { position: static; min-width: auto; }
            .form-row { flex-direction: column; gap: 0; }
            .card { padding: 20px; }
            .card-title { font-size: 1.25rem; }
            .summary-total strong { font-size: 1.6rem; }
        }
    </style>
</head>
<body>

<%
    // Fetch cart from session
    Cart cart = (Cart) session.getAttribute("cart");
    
    // Safety check - redirect if cart is empty
    if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/Cart.jsp");
        return;
    }

    // Calculations (Matching Cart.jsp)
    float deliveryFee = 40.00f; 
    float taxRate = 0.05f; // 5%
    float itemTotal = cart.getTotalCartPrice();
    float taxAmount = itemTotal * taxRate;
    float grandTotal = itemTotal + deliveryFee + taxAmount;
%>

<div class="page-wrapper">
    <h1 class="heading">Secure Checkout</h1>

<form action="<%= request.getContextPath() %>/placeOrder" method="post">


    <div class="checkout-grid">

        <div class="checkout-details">
            
            <div class="card">
                <div class="card-title"><span>1.</span> Delivery Address</div>
                
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" placeholder="Enter recipient's full name" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="e.g., 9876543210" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email (Optional)</label>
                        <input type="email" id="email" name="email" placeholder="email@example.com">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="addressLine1">Address Line 1 (House No., Building, Landmark)</label>
                    <input type="text" id="addressLine1" name="addressLine1" required>
                </div>
                
                <div class="form-group">
                    <label for="addressLine2">Address Line 2 (Street, Area, Locality)</label>
                    <input type="text" id="addressLine2" name="addressLine2">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" value="Bangalore" required>
                    </div>
                    <div class="form-group">
                        <label for="pincode">Pincode</label>
                        <input type="text" id="pincode" name="pincode" placeholder="e.g., 560001" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="notes">Delivery Notes (Optional)</label>
                    <textarea id="notes" name="notes" rows="3" placeholder="e.g., Call before arrival, leave at door..."></textarea>
                </div>
                
            </div>
            
            <div class="card">
                <div class="card-title"><span>2.</span> Payment Mode</div>
                
                <label class="payment-option">
                    <input type="radio" name="paymentMode" value="COD" required>
                    <div>
                        <div class="payment-option-text">Cash on Delivery (COD)</div>
                        <div class="payment-info">Pay with cash or UPI upon receiving your order.</div>
                    </div>
                </label>
                
                <label class="payment-option">
                    <input type="radio" name="paymentMode" value="ONLINE">
                    <div>
                        <div class="payment-option-text">Online Payment (Credit Card / UPI)</div>
                        <div class="payment-info">Complete the transaction now using a secure payment gateway.</div>
                    </div>
                </label>
            </div>

           <button type="submit" class="btn-primary">
                Place Final Order: ₹ <%= String.format("%.2f", grandTotal) %>
            </button>
            
            <a href="<%= request.getContextPath() %>/Cart.jsp" class="back-btn">← Review Cart Items</a>
        </div>

        <div class="order-summary">
            <div class="card">
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
                
            </div>
        </div>

    </div>
    </form>
</div>

<script>
 
 
  (function(){
    try {
      const root = document.documentElement;
      const saved = localStorage.getItem('bhojana-theme');
      if(saved === 'dark') {
        root.classList.add('dark');
      } else {
        root.classList.remove('dark');
      }
    } catch(e) {
      
      console.warn('theme load error', e);
    }
  })();
</script>
	
</body>
</html>