<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.restaurant.model.Restaurant, com.restaurant.model.Cart" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Namma Kitchen — Restaurants</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
@charset "UTF-8";

/* -------------------- ROOT VARIABLES -------------------- */
:root{
  --bg:#f6f8fb;
  --card:#fff;
  --muted:#6b7280;
  --text:#0b1220;
  --accent:#ff6f00;
  --shadow: 0 10px 30px rgba(11,17,32,0.06);
  --radius:12px;
  --maxw:1180px;
  --border: rgba(11,17,32,0.05);
  --carousel-speed: 25s; /* Speed of movement */
}

/* dark theme */
:root.dark{
  --bg:#071228;
  --card:#081426;
  --muted:#9aa6b2;
  --text:#e6eef3;
  --accent:#ff8a00;
  --shadow: 0 12px 36px rgba(0,0,0,0.6);
  --border: rgba(255,255,255,0.08);
}

*{box-sizing:border-box}
body{
  margin:0;
  font-family:'Poppins',Arial;
  background:var(--bg);
  color:var(--text);
  -webkit-font-smoothing:antialiased;
}

/* PAGE WRAPPER */
.wrap{max-width:var(--maxw);margin:0 auto;padding:12px 18px}

/* -------------------- MODERN GLASS HEADER (NEW) -------------------- */
.header{
  display:flex;
  align-items:center;
  gap:12px;
  padding:10px 16px;
  position:sticky;
  top:0;
  backdrop-filter: blur(14px);
  background: rgba(255,255,255,0.55);
  border-bottom:1px solid rgba(255,255,255,0.25);
  z-index:50;
  transition:background 0.3s ease;
}

:root.dark .header{
  background: rgba(15,15,30,0.45);
  border-bottom:1px solid rgba(255,255,255,0.08);
}

/* logo */
.logo{display:flex;align-items:center;gap:10px;text-decoration:none;color:var(--text)}
.logo-badge{width:44px;height:44px;border-radius:10px;background:linear-gradient(135deg,#ff7043,#ff8a00);display:grid;place-items:center;color:#fff;font-weight:800;font-size:20px;box-shadow:var(--shadow)}
.brand{font-weight:700;font-size:1.15rem}

/* center area - kept for spacing (or filters) */
.header-center{flex:1;display:flex;align-items:center;gap:12px;padding-left:8px}

/* right area contains search + buttons but we will move search to rightmost */
.header-right{display:flex;align-items:center;gap:15px}

/* -------------------- ANIMATED SEARCH BAR (NEW) -------------------- */
.search-compact{
  display:flex;
  align-items:center;
  gap:8px;
  background:var(--card);
  border-radius:999px;
  padding:8px 14px;
  border:1px solid var(--border);
  min-width:260px;
  transition:all 0.25s ease;
  box-shadow:var(--shadow);
  color:var(--text);
}
.search-compact:focus-within{
  min-width:420px;
  border-color:var(--accent);
  background:#fff;
  box-shadow:0 0 0 5px rgba(255,111,0,0.18);
}
.search-compact input{border:0;outline:0;background:transparent;color:var(--text);width:100%;font-size:0.95rem}
:root.dark .search-compact:focus-within{background:#0b1429;border-color:var(--accent);box-shadow:0 0 0 5px rgba(255,140,0,0.18);}

/* -------------------- UPDATED BUTTONS START -------------------- */

/* modern icon button design */
.icon-btn{
  display:inline-grid;
  align-items:center;
  justify-items:center;
  background:var(--card);
  border-radius:14px; /* More rounded modern look */
  padding:8px;
  min-width:42px;
  min-height:42px;
  cursor:pointer;
  border:1px solid var(--border);
  color:var(--text);
  position:relative;
  text-decoration:none;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.icon-btn:hover {
  transform: translateY(-2px);
  border-color: var(--accent);
  background: var(--bg);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.icon-btn:active {
  transform: translateY(0);
}

/* My Orders Button - Premium Design */
.btn-orders-premium {
  padding: 10px 22px;
  background: linear-gradient(135deg, #0d6efd, #004dc7);
  color: white !important;
  border-radius: 12px;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
  border: none;
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-orders-premium:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(13, 110, 253, 0.4);
  filter: brightness(1.1);
}

/* cart badge improvement */
.cart-badge {
  position: absolute;
  top: -5px;
  right: -5px;
  min-width:18px;
  height:18px;
  padding:0 5px;
  border-radius:10px;
  background: #ff3b30;
  color: #fff;
  font-weight:700;
  font-size:11px;
  display:flex;
  align-items:center;
  justify-content:center;
  border: 2px solid var(--card);
}

/* theme icon rotation animation */
#themeToggle svg {
    transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}
#themeToggle:hover svg {
    transform: rotate(15deg);
}

/* -------------------- UPDATED BUTTONS END -------------------- */

/* ensure svg paths/circles use currentColor */
.icon-btn svg *,:root svg *,.search-compact svg *{
  stroke: currentColor !important;
  fill: none !important;
}

/* login */
.login-btn{background:var(--accent);color:#fff;border:none;padding:8px 12px;border-radius:999px;font-weight:700;cursor:pointer;box-shadow:0 8px 20px rgba(255,111,0,0.12)}

/* -------------------- CATEGORY SLIDER (LARGER + SNAP) -------------------- */

.category-scroll{
  display:flex;
  gap:16px;                  
  overflow-x:auto;
  padding:16px 8px;         
  scrollbar-width:none;
  margin:14px 0;
  align-items:center;       
  scroll-snap-type: x mandatory; 
  -webkit-overflow-scrolling: touch;
}
.category-scroll::-webkit-scrollbar{ display:none; }

/* larger, tappable chips */

.cat-item{
  padding:12px 22px;         
  min-height:48px;           
  border-radius:999px;
  font-weight:700;
  font-size:1rem;            
  border:1px solid var(--border);
  background:var(--card);
  color:var(--text);
  cursor:pointer;
  white-space:nowrap;
  transition: transform .18s ease, box-shadow .18s ease, background .18s ease;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  box-shadow: 0 6px 18px rgba(11,17,32,0.04); 
  scroll-snap-align: center; 
}

/* increase emoji size inside chips */

.cat-item::first-letter { font-size: 1.05em; }

/* stronger hover / active state */

.cat-item:hover,
.cat-item:focus{
  background:var(--accent);
  color:white;
  transform: translateY(-4px) scale(1.03);
  box-shadow: 0 12px 30px rgba(11,17,32,0.12);
}

/* smaller screens — keep chips usable */

@media (max-width:480px){
  .category-scroll{ padding:12px 6px; gap:10px; }
  .cat-item{ padding:10px 16px; min-height:44px; font-size:0.95rem; }
}

/* ================= FOOD CAROUSEL (NEW) ================= */

/* Keyframes for continuous scroll */
@keyframes scrollLeft {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); } /* Move half the doubled content width */
}

.food-carousel-container {
  overflow: hidden;
  margin: 18px 0;
  background: var(--card);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 12px 0;
  border: 1px solid var(--border);
}

.food-carousel {
  display: flex;
  width: 200%; /* Double the width to hold duplicated content for seamless looping */
  animation: scrollLeft var(--carousel-speed) linear infinite;
  animation-play-state: running;
}

.food-carousel:hover {
  animation-play-state: paused; /* Pause on hover */
}

.food-carousel-item {
  flex-shrink: 0; /* Prevents items from shrinking */
  width: 280px; /* Fixed width for each item */
  height: 180px;
  margin: 0 8px;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(11,17,32,0.05);
  cursor: pointer;
  transition: transform 0.2s ease;
}

.food-carousel-item:hover {
  transform: translateY(-4px) scale(1.01);
  box-shadow: 0 8px 20px rgba(11,17,32,0.1);
}

.food-carousel-item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}


/* ================= HERO SECTION ================= */

.hero{
  width:100%;
  height:420px;
  margin:14px auto 12px;

  /* 🖼️ IMAGE BACKGROUND (With dark gradient overlay for text readability) */
  background: linear-gradient(to bottom, rgba(0,0,0,0.2), rgba(0,0,0,0.6)),
              url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop');
  
  background-size: cover;
  background-position: center;

  border-radius:18px;
  overflow:hidden;
  box-shadow:var(--shadow);
  position:relative;
}

/* REMOVE ANY OVERLAY AFTER ELEMENT */
.hero::after{
  content:none;
}


/* ================= HERO TEXT ================= */

.hero-overlay{
  position:absolute;
  left:40px;
  bottom:40px;
  z-index:2;
  color:#fff;
  max-width:520px;
}

.hero-overlay h2{
  margin:0;
  font-size:2.6rem;
  font-weight:700;
}

.hero-overlay p{
  margin-top:12px;
  font-size:1.05rem;
  font-weight:600;
  color:rgba(255,255,255,0.95);
}


/* RESTAURANT  GRID - uniform cards */

.grid{
  display:grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap:20px;
  width:100%;
  margin-bottom:40px;
}

/*card: keep same height and layout */

.card{
  background:var(--card);
  border-radius:12px;
  overflow:hidden;
  box-shadow:var(--shadow);
  border:1px solid var(--border);
  display:flex;
  flex-direction:column;
  height:360px; /* fixed card height for uniformity */
  transition:transform .18s ease,box-shadow .18s ease,opacity .45s ease, transform .45s ease;
  opacity:0;
  transform: translateY(8px);
}
.card.visible{
  opacity:1;
  transform: translateY(0);
}
.card:hover{transform:translateY(-10px) scale(1.02);box-shadow:0 25px 60px rgba(11,17,32,0.18)}
.card .img-wrap{height:190px;overflow:hidden;flex:0 0 190px}
.img-wrap img{width:100%;height:100%;object-fit:cover;display:block}

/* card content area fixed to align */

.card-content{
	padding:14px;display:flex;flex-direction:column;justify-content:space-between;flex:1
}
.restaurant-name{
	margin:0;font-size:1.05rem;font-weight:700
	}
.description{
	margin:8px 0 12px;
	color:var(--muted);
	font-size:0.95rem;
	height:44px;
	overflow:hidden
}
.info{
	display:flex;
	justify-content:space-between;
	align-items:center;
	gap:8px
	}
.rating{
  background: linear-gradient(90deg, #00c853, #00e676);
  color: #ffffff;
  padding: 6px 10px;
  border-radius: 10px;
  font-weight: 800;
  box-shadow: 0 4px 10px rgba(0,200,83,0.25);
  border: 1px solid rgba(255,255,255,0.3);
}

.address{font-size:0.85rem;color:var(--muted);text-align:right}

/* focus outlines for accessibility */

.icon-btn:focus,.login-btn:focus,.search-compact input:focus{outline:3px solid rgba(255,111,0,0.12);outline-offset:2px}

/* responsive tweaks */

@media (max-width:900px){
  .hero{height:260px}
}

@media (max-width:480px){
  .hero{
    height:220px;
    border-radius:14px;
  }
}


/* small helpers */

.link{color:var(--accent);font-weight:700}
.muted{color:var(--muted)}
</style>
</head>
<body>

<%
    // compute cart count from session (show 0 if no cart)
    
    Cart sessionCart = (Cart) session.getAttribute("cart");
    int cartCount = 0;
    if (sessionCart != null) {
        try { cartCount = sessionCart.getTotalQuantity(); } catch (Exception e) { cartCount = 0; }
    }
%>

<div class="wrap">

  <header class="header">
  <a class="logo" href="<%= request.getContextPath() %>/">
    
    <div class="logo-badge" style="background:none; box-shadow:none; padding:0;">
      <img src="<%= request.getContextPath() %>/image/ProjectImageLogo.webp" 
           alt="Logo"
           style="width:44px;height:44px;border-radius:10px;object-fit:cover;">
    </div>

    <div class="brand">Namma Kitchen</div>
  </a>

  <div class="header-center"></div>

  <div class="header-right">

    <div class="search-compact" role="search" aria-label="Search">
      <svg width="16" height="16" viewBox="0 0 24 24">
        <path d="M21 21l-4.35-4.35" stroke-width="1.4"/>
        <circle cx="11" cy="11" r="5" stroke-width="1.4"/>
      </svg>
      <input id="searchInput" placeholder="Search dishes, restaurants..." />
    </div>

    <button class="login-btn" onclick="window.location.href='<%= request.getContextPath() %>/login'">Login</button>

    <a class="icon-btn" id="cartLink" title="Cart" href="<%= request.getContextPath() %>/Cart.jsp" role="button" aria-label="Open cart" tabindex="0">
      <svg width="20" height="20" viewBox="0 0 24 24">
        <path d="M6 6h13l-1.5 9h-11z" stroke-width="1.5"/>
        <circle cx="10" cy="19" r="1"/>
        <circle cx="18" cy="19" r="1"/>
      </svg>
      <% if (cartCount > 0) { %><span class="cart-badge"><%= cartCount %></span><% } %>
    </a>

    <a href="<%= request.getContextPath() %>/myOrders" class="btn-orders-premium">
       <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
       My Orders
    </a>

    <a class="icon-btn" id="profileLink" title="Profile" href="<%= request.getContextPath() %>/profile.jsp" role="button" aria-label="Profile" tabindex="0">
      <svg width="20" height="20" viewBox="0 0 24 24">
        <circle cx="12" cy="8" r="4" stroke-width="1.5"/>
        <path d="M6 21v-2a4 4 0 0 1 4-4h4a4 4 0 0 1 4 4v2" stroke-width="1.5"/>
      </svg>
    </a>

    <button class="icon-btn" id="themeToggle" title="Toggle theme">
      <svg id="themeIcon" width="20" height="20" viewBox="0 0 24 24">
        <path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" stroke-width="1.5"/>
      </svg>
    </button>

  </div>
</header>

  
  <h1 style="text-align: center">Order Your Food In Best Restaurants.</h1>

  <div class="hero" role="banner">
    <div class="hero-overlay">
      </div>
  </div>

  <div class="category-scroll" aria-label="Browse categories">
    <button class="cat-item">🔥 Trending</button>
    <button class="cat-item">🍕 Pizza</button>
    <button class="cat-item">🍔 Burgers</button>
    <button class="cat-item">🥘 Biryani</button>
    <button class="cat-item">🥗 Healthy</button>
    <button class="cat-item">🍣 Asian</button>
    <button class="cat-item">🍽 South Indian</button>
    <button class="cat-item">🍰 Desserts</button>
  </div>
  
  <div class="food-carousel-container" aria-label="Featured Dishes Carousel">
    <div class="food-carousel">
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/BiriyaniImg.jpg" alt="Featured Food Item 1"/>
      </div>
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/BurgurImg.webp" alt="Featured Food Item 2"/>
      </div>
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/DosaImg.webp" alt="Featured Food Item 3"/>
      </div>
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/PizzaImg.png" alt="Featured Food Item 4"/>
      </div>
      
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/BiriyaniImg.jpg" alt="Featured Food Item 1"/> 
      </div>
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/BurgurImg.webp" alt="Featured Food Item 2"/>
      </div>
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/DosaImg.webp" alt="Featured Food Item 3"/>
      </div>
      <div class="food-carousel-item">
        <img src="<%= request.getContextPath() %>/BgImgs/PizzaImg.png" alt="Featured Food Item 4"/> 
      </div>
    </div>
  </div>
  	<p style="text-align:center; font-size:30px; font-weight:bold" >Top Restaurants</p>
  <div class="grid" id="grid">
<%
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
    if (restaurants == null || restaurants.isEmpty()) {
%>
    <div style="grid-column:1/-1;padding:30px;background:var(--card);border-radius:12px;text-align:center;color:var(--muted);">No restaurants found.</div>
<%
    } else {
        for (Restaurant r : restaurants) {
            String img = (r.getImage() != null && !r.getImage().trim().isEmpty()) ? (request.getContextPath() + "/image/" + r.getImage()) : "https://images.unsplash.com/photo-1543353071-087092ec393a?q=80&w=900&auto=format&fit=crop&ixlib=rb-4.0.3&s=3f0a0bbd2e4f9d7c5f6c9b0f6f4a3a2f";
%>
    <a href="<%= request.getContextPath() %>/menu?Restaurant_Id=<%= r.getId() %>" style="text-decoration:none;color:inherit">
      <div class="card">
        <div class="img-wrap">
          <img src="<%= img %>" alt="<%= r.getName() %>" onerror="this.src='https://images.unsplash.com/photo-1541542684-1ec1f04b5c36?q=80&w=900&auto=format&fit=crop&ixlib=rb-4.0.3&s=9b4b2b4f1b9d9a3a6d8b'"/>
        </div>

        <div class="card-content">
          <div>
            <h3 class="restaurant-name"><%= r.getName() %></h3>
            <p class="description"><%= r.getDescription() != null ? r.getDescription() : "Delicious local & regional food" %></p>
          </div>

          <div class="info">
            <div class="rating">★ <%= r.getRating() %></div>
            <div class="address muted"><%= r.getAddress() %></div>
          </div>
        </div>
      </div>
    </a>
<%
        }
    }
%>
  </div>

</div> <script>
  // apply saved theme on load
  (function(){
    const root = document.documentElement;
    const saved = localStorage.getItem('bhojana-theme');
    if(saved === 'dark') root.classList.add('dark');

    const toggle = document.getElementById('themeToggle');
    const icon = document.getElementById('themeIcon');

    function setIcon(){
      if(root.classList.contains('dark')){
        icon.innerHTML = '<circle cx="12" cy="12" r="4" stroke-width="1.5"/><path d="M12 2v2m0 16v2M4.93 4.93l1.41 1.41m11.32 11.32l1.41 1.41M2 12h2m16 0h2M4.93 19.07l1.41-1.41m11.32-11.32l1.41-1.41" stroke-width="1.5"/>';
      } else {
        icon.innerHTML = '<path d="M21 12.79A9 9 0 1111.21 3 7 7 0 0021 12.79z" stroke-width="1.5"/>';
      }
    }
    setIcon();

    toggle.addEventListener('click', function(){
      root.classList.toggle('dark');
      localStorage.setItem('bhojana-theme', root.classList.contains('dark') ? 'dark' : 'light');
      setIcon();
    });
  })();

  // fade-in using IntersectionObserver
  (function(){
    const obs = new IntersectionObserver((entries, o) => {
      entries.forEach(e => {
        if(e.isIntersecting){
          e.target.classList.add('visible');
          o.unobserve(e.target);
        }
      });
    }, {threshold: 0.12});

    document.querySelectorAll('.card').forEach(c => obs.observe(c));
  })();

  // keep old search behavior for Enter (if used)
  const searchInput = document.getElementById('searchInput');
  if (searchInput) {
    searchInput.addEventListener('keydown', function(e){
      if(e.key === 'Enter'){
        const q = this.value.trim();
        if(q) window.location.href = '<%= request.getContextPath() %>/search?q=' + encodeURIComponent(q);
      }
    });
  }

  // category button click behaviour (example: redirect to search with category)
  document.querySelectorAll('.cat-item').forEach(btn => {
    btn.addEventListener('click', () => {
      const q = btn.textContent.trim();
      // remove emoji if present and search by clean text
      const clean = q.replace(/^[^\w]+/,'');
      window.location.href = '<%= request.getContextPath() %>/search?q=' + encodeURIComponent(clean);
    });
  });

  // Fallback: if anchor navigation is blocked, force redirect to cart/profile JSPs
  (function(){
    const cp = '<%= request.getContextPath() %>';
    const cartLink = document.getElementById('cartLink');
    const profileLink = document.getElementById('profileLink');

    if(cartLink){
      cartLink.addEventListener('click', function(e){
        // normal anchor will navigate; fallback after a short delay if still on the page
        setTimeout(() => {
          if(document.visibilityState === 'visible'){
            window.location.href = cp + '/Cart.jsp';
          }
        }, 120);
      });
      cartLink.addEventListener('keydown', function(e){ if(e.key === 'Enter') cartLink.click(); });
    }

    if(profileLink){
      profileLink.addEventListener('click', function(e){
        setTimeout(() => {
          if(document.visibilityState === 'visible'){
            window.location.href = cp + '/profile.jsp';
          }
        }, 120);
      });
      profileLink.addEventListener('keydown', function(e){ if(e.key === 'Enter') profileLink.click(); });
    }
  })();
</script>

</body>
</html>