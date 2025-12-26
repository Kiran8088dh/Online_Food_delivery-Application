<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Bhojana</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
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
            /* Using the Login Image with a dark overlay */
            background: linear-gradient(135deg, rgba(0,0,0,0.7), rgba(0,0,0,0.5)),
                        url("<%= request.getContextPath() %>/BgImgs/LoginImg.png");
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            padding: 20px;
        }

        /* ================= LOGIN CARD ================= */
        .login-container {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        /* Decorative top bar (Consistent with Register page) */
        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #ff6f00, #ffca28);
        }

        /* ================= HEADING ================= */
        .header-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .header-section h1 {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .header-section span {
            color: #ff6f00;
        }

        .header-section p {
            font-size: 0.9rem;
            color: #666;
        }

        /* ================= ERROR MESSAGES ================= */
        .error-msg {
            background: #ffecec;
            color: #d63031;
            padding: 12px;
            border-left: 4px solid #d63031;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 20px;
            display: none; /* Hidden by default for JS toggling */
            align-items: center;
            gap: 10px;
        }
        
        
        .server-error {
            display: flex; 
        }

        /* ================= FORM STYLING ================= */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #444;
            margin-bottom: 8px;
            margin-left: 2px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 1rem;
            transition: color 0.3s ease;
        }

        input {
            width: 100%;
            padding: 14px 15px 14px 45px; /* Space for icon */
            border-radius: 10px;
            border: 2px solid #eee;
            background: #f9f9f9;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.3s ease;
            color: #333;
        }

        input:focus {
            border-color: #ff6f00;
            background: #fff;
            box-shadow: 0 4px 10px rgba(255, 111, 0, 0.1);
        }

        input:focus + i {
            color: #ff6f00;
        }

        /* ================= BUTTON ================= */
        .login-btn {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(45deg, #ff6f00, #ff8f00);
            color: #fff;
            font-size: 1rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 111, 0, 0.3);
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 111, 0, 0.4);
            background: linear-gradient(45deg, #e65100, #f57c00);
        }

        /* ================= FOOTER ================= */
        .footer-text {
            text-align: center;
            margin-top: 25px;
            font-size: 0.9rem;
            color: #666;
        }

        .footer-text a {
            color: #ff6f00;
            font-weight: 700;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-text a:hover {
            color: #e65100;
            text-decoration: underline;
        }
    </style>

    <script>
        function validateForm() {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            const errBox = document.getElementById('js-error-box');
            const errText = document.getElementById('js-error-text');
            
            // Reset error
            errBox.style.display = 'none';

            if (!email || !emailPattern.test(email)) {
                errBox.style.display = 'flex';
                errText.innerText = 'Please enter a valid email address.';
                return false;
            }
            if (!password) {
                errBox.style.display = 'flex';
                errText.innerText = 'Please enter your password.';
                return false;
            }
            return true;
        }
    </script>
</head>

<body>

<div class="login-container">

    <div class="header-section">
        <h1>Welcome <span>Back</span></h1>
        <p>Login to continue your food journey</p>
    </div>

    <%-- Server Side Error --%>
    <% String loginError = (String) request.getAttribute("loginError"); %>
    <% if (loginError != null) { %>
        <div class="error-msg server-error">
            <i class="fa-solid fa-circle-exclamation"></i>
            <span><%= loginError %></span>
        </div>
    <% } %>

    <%-- Client Side Validation Error --%>
    <div id="js-error-box" class="error-msg">
        <i class="fa-solid fa-circle-exclamation"></i>
        <span id="js-error-text"></span>
    </div>

    <%-- Re-populate email if login failed --%>
    <% String preEmail = (request.getAttribute("email") == null) ? "" : (String) request.getAttribute("email"); %>

    <form action="<%= request.getContextPath() %>/login" method="post" onsubmit="return validateForm()">
        
        <div class="form-group">
            <label for="email">Email Address</label>
            <div class="input-wrapper">
                <input type="text" id="email" name="email" 
                       value="<%= preEmail %>" 
                       placeholder="you@example.com" 
                       autocomplete="email">
                <i class="fa-regular fa-envelope"></i>
            </div>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <div class="input-wrapper">
                <input type="password" id="password" name="password" 
                       placeholder="••••••" 
                       autocomplete="current-password">
                <i class="fa-solid fa-lock"></i>
            </div>
        </div>

        <button type="submit" class="login-btn">Login</button>
    </form>

    <div class="footer-text">
        Don't have an account?
        <a href="<%= request.getContextPath() %>/register">Register Now</a>
    </div>

</div>

</body>
</html>