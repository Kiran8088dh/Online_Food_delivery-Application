<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f0f4f8;
        }
        .heading {
            text-align: center;
            margin: 32px 0 20px;
            color: #2d3142;
            font-size: 2.2rem;
            letter-spacing: 1.2px;
        }
        .menu-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            padding-bottom: 35px;
        }
        .menu-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(60,60,100,0.12);
            width: 320px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform .18s, box-shadow .18s;
        }
        .menu-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 16px 36px rgba(60,60,120,0.18);
        }
        .menu-img {
            width: 100%;
            height: 172px;
            object-fit: cover;
        }
        .menu-content {
            padding: 20px 20px 16px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .menu-name {
            font-size: 1.1rem;
            font-weight: 700;
            margin: 0 0 8px 0;
            color: #2d3142;
        }
        .menu-desc {
            font-size: .97rem;
            color: #666;
            margin-bottom: 12px;
        }
        .menu-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 13px;
        }
        .menu-rating {
            background: #ffe084;
            color: #e67e22;
            border-radius: 9px;
            padding: 2px 9px;
            font-weight: 700;
            font-size: .99rem;
        }
        .menu-price {
            font-size: 1.08rem;
            font-weight: 700;
            color: #53899a;
            background: #eef4f7;
            border-radius: 7px;
            padding: 3px 14px;
            margin-left: 7px;
        }
        .add-cart-btn {
            background: #4136f1;
            color: #fff;
            border: none;
            padding: 9px 0;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 700;
            letter-spacing: .4px;
            margin: 7px 0 0 0;
            transition: background .18s;
        }
        .add-cart-btn:hover {
            background: #232087;
        }
        @media (max-width:900px) {
            .menu-list {
                flex-direction: column;
                align-items: center;
                gap: 22px;
            }
            .menu-card {
                width: 95vw;
                max-width: 410px;
            }
        }
    </style>
</head>
<body>
    <h1 class="heading">Today's Menu</h1>
    <div class="menu-list">
        <div class="menu-card">
            <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=80" alt="Butter Chicken" class="menu-img">
            <div class="menu-content">
                <div class="menu-name">Butter Chicken</div>
                <div class="menu-desc">Classic North Indian dish with creamy tomato gravy and tender chicken.</div>
                <div class="menu-info">
                    <span class="menu-rating">★ 4.7</span>
                    <span class="menu-price">₹350</span>
                </div>
                <button class="add-cart-btn">Add to Cart</button>
            </div>
        </div>
        <div class="menu-card">
            <img src="https://images.unsplash.com/photo-1516685018646-5499d56385b7?auto=format&fit=crop&w=400&q=80" alt="Veggie Pizza" class="menu-img">
            <div class="menu-content">
                <div class="menu-name">Veggie Pizza</div>
                <div class="menu-desc">Stone-baked pizza topped with fresh veggies and mozzarella cheese.</div>
                <div class="menu-info">
                    <span class="menu-rating">★ 4.4</span>
                    <span class="menu-price">₹290</span>
                </div>
                <button class="add-cart-btn">Add to Cart</button>
            </div>
        </div>
        <div class="menu-card">
            <img src="https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=400&q=80" alt="Paneer Tikka" class="menu-img">
            <div class="menu-content">
                <div class="menu-name">Paneer Tikka</div>
                <div class="menu-desc">Grilled cottage cheese cubes marinated in aromatic spices and herbs.</div>
                <div class="menu-info">
                    <span class="menu-rating">★ 4.6</span>
                    <span class="menu-price">₹220</span>
                </div>
                <button class="add-cart-btn">Add to Cart</button>
            </div>
        </div>
        <div class="menu-card">
            <img src="https://images.unsplash.com/photo-1432139555190-58524dae6a55?auto=format&fit=crop&w=400&q=80" alt="Pasta Alfredo" class="menu-img">
            <div class="menu-content">
                <div class="menu-name">Pasta Alfredo</div>
                <div class="menu-desc">Creamy Alfredo pasta with parmesan and a hint of garlic.</div>
                <div class="menu-info">
                    <span class="menu-rating">★ 4.5</span>
                    <span class="menu-price">₹250</span>
                </div>
                <button class="add-cart-btn">Add to Cart</button>
            </div>
        </div>
        <div class="menu-card">
            <img src="https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=400&q=80" alt="Chocolate Brownie" class="menu-img">
            <div class="menu-content">
                <div class="menu-name">Chocolate Brownie</div>
                <div class="menu-desc">Rich, fudgy chocolate brownie topped with a scoop of vanilla ice cream.</div>
                <div class="menu-info">
                    <span class="menu-rating">★ 4.8</span>
                    <span class="menu-price">₹160</span>
                </div>
                <button class="add-cart-btn">Add to Cart</button>
            </div>
        </div>
    </div>
</body>
</html>
