<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Define a richer color palette */
        :root {
            --primary: #e65100; /* Richer accent orange/red */
            --secondary: #ff9800; /* Lighter accent */
            --text-dark: #212121;
            --text-muted: #757575;
            --bg-light: #fafafa;
            --bg-input: #f5f5f5;
            --card-bg-opacity: 0.98; /* Less transparency for better readability */
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        /* ================= PAGE BACKGROUND ================= */
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Updated gradient for better contrast */
            background: linear-gradient(135deg, rgba(30, 0, 0, 0.8), rgba(0, 0, 0, 0.6)),
                        url("<%= request.getContextPath() %>/BgImgs/RegisterImg.png");
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            padding: 20px;
        }

        /* ================= REGISTER CARD ================= */
        .register-container {
            width: 100%;
            max-width: 480px; /* Slightly wider */
            background: rgba(255, 255, 255, var(--card-bg-opacity));
            border-radius: 24px; /* More rounded corners */
            padding: 45px 40px;
            /* Multi-layer shadow for premium depth */
            box-shadow: 0 10px 40px rgba(0,0,0,0.2), 0 0 0 1px rgba(0,0,0,0.05);
            backdrop-filter: blur(15px); /* Stronger glass blur effect */
            border: none; /* Removed thin white border */
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out; /* Add animation */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Decorative top bar */
        .register-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px; /* Slightly thicker */
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        /* ================= HEADING ================= */
        .header-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .header-section h2 {
            font-size: 2.2rem; /* Larger heading */
            font-weight: 800; /* Bolder */
            color: var(--text-dark);
            margin-bottom: 5px;
            letter-spacing: -0.5px;
        }

        .header-section h2 span {
            color: var(--primary);
        }

        .header-section p {
            font-size: 0.95rem; /* Slightly larger subtitle */
            color: var(--text-muted);
            font-weight: 400;
        }

        /* ================= ERROR MESSAGE ================= */
        .error-msg {
            background: #fde8e8;
            color: #c0392b;
            padding: 15px; /* More padding */
            border-left: 5px solid #c0392b;
            border-radius: 8px; /* Softer rounded corners */
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .error-msg i {
            font-size: 1.1rem;
        }

        /* ================= FORM STYLING ================= */
        .form-group {
            margin-bottom: 22px; /* More vertical space */
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 0.9rem; /* Larger label */
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 8px;
            margin-left: 4px;
        }

        /* Input Wrapper for Icons */
        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 18px; /* Move icon right */
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1rem;
            transition: color 0.3s ease;
        }
        
        /* Special adjustment for Textarea icon */
        .input-wrapper.textarea-wrapper i {
            top: 20px; 
            transform: none;
        }

        input, textarea {
            width: 100%;
            padding: 14px 20px 14px 50px; /* Increased padding and icon space */
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            background: var(--bg-input);
            font-size: 1rem; /* Slightly larger text */
            outline: none;
            transition: all 0.3s ease;
            color: var(--text-dark);
        }

        textarea {
            resize: none;
            height: 90px;
        }

        /* Focus Effects */
        input:focus, textarea:focus {
            border-color: var(--primary);
            background: var(--bg-light);
            box-shadow: 0 0 0 3px rgba(230, 81, 0, 0.2), 0 4px 10px rgba(0,0,0,0.05); /* Outer glow on focus */
        }

        input:focus + i, 
        textarea:focus + i,
        .input-wrapper:focus-within i {
            color: var(--primary);
        }

        /* ================= BUTTON ================= */
        .register-btn {
            width: 100%;
            padding: 16px; /* Taller button */
            margin-top: 20px;
            border: none;
            border-radius: 14px; /* Matches input radius */
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            color: #fff;
            font-size: 1.1rem; /* Larger text */
            font-weight: 700;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            box-shadow: 0 8px 25px rgba(230, 81, 0, 0.4); /* Stronger, deeper shadow */
            position: relative;
            overflow: hidden;
        }

        /* Subtle ripple effect on hover */
        .register-btn::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            transition: opacity 0.3s ease;
            opacity: 0;
        }

        .register-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(230, 81, 0, 0.6);
        }
        
        .register-btn:hover::after {
            opacity: 1;
        }

        .register-btn:active {
            transform: translateY(0);
            box-shadow: 0 4px 15px rgba(230, 81, 0, 0.4);
        }

        /* ================= FOOTER ================= */
        .footer-text {
            text-align: center;
            margin-top: 30px;
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .footer-text a {
            color: var(--primary);
            font-weight: 700;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-text a:hover {
            color: var(--secondary);
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="register-container">

    <div class="header-section">
        <h2>Create Your <span>Account</span></h2>
        <p>Order delicious food delivered to your door</p>
    </div>

    <% if(request.getAttribute("regError") != null){ %>
        <div class="error-msg">
            <i class="fa-solid fa-circle-exclamation"></i>
            <span><%= request.getAttribute("regError") %></span>
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/register" method="post">

        <div class="form-group">
            <label>Full Name</label>
            <div class="input-wrapper">
                <input type="text" name="name" placeholder="e.g. John Doe"
                    value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                    required>
                <i class="fa-regular fa-user"></i>
            </div>
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <div class="input-wrapper">
                <input type="tel" name="phone" placeholder="+91 9876543210" pattern="[0-9]{10}"
                    value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                    required>
                <i class="fa-solid fa-mobile-screen"></i>
            </div>
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <div class="input-wrapper">
                <input type="email" name="email" placeholder="john@example.com"
                    value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                    required>
                <i class="fa-regular fa-envelope"></i>
            </div>
        </div>

        <div class="form-group">
            <label>Password</label>
            <div class="input-wrapper">
                <input type="password" name="password" placeholder="Create a strong password" required>
                <i class="fa-solid fa-lock"></i>
            </div>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <div class="input-wrapper">
                <input type="password" name="confirm" placeholder="Repeat password" required>
                <i class="fa-solid fa-shield-halved"></i>
            </div>
        </div>

        <div class="form-group">
            <label>Delivery Address</label>
            <div class="input-wrapper textarea-wrapper">
                <textarea name="address" placeholder="House No, Street, Landmark... " required><%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %></textarea>
                <i class="fa-solid fa-location-dot"></i>
            </div>
        </div>

        <button type="submit" class="register-btn">Create Account</button>
    </form>

    <div class="footer-text">
        Already a member?
        <a href="<%= request.getContextPath() %>/login">Login Here</a>
    </div>

</div>

</body>
</html>