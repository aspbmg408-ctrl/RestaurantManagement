<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MARCEL Restaurant | Menu</title>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

html{
    scroll-behavior:smooth;
}

body{
    font-family:'Poppins',sans-serif;
    background:#000;
    color:white;
    overflow-x:hidden;
}

/* HERO SECTION */

.hero{
    min-height:100vh;

    background:
    linear-gradient(
    rgba(0,0,0,.65),
    rgba(0,0,0,.75)),
    url("https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1920&q=80");

    background-size:cover;
    background-position:center;
    background-attachment:fixed;

    display:flex;
    flex-direction:column;
}

/* NAVBAR */

.navbar{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    z-index:999;

    padding:25px 70px;

    display:flex;
    justify-content:space-between;
    align-items:center;

    background:rgba(0,0,0,.55);
    backdrop-filter:blur(10px);
}

.logo{
    font-family:'Cormorant Garamond',serif;
    font-size:45px;
    font-weight:700;
    letter-spacing:3px;
}

.nav-links{
    display:flex;
    gap:40px;
}

.nav-links a{
    color:white;
    text-decoration:none;
    letter-spacing:2px;
    transition:.3s;
}

.nav-links a:hover{
    color:#d4af37;
}

.cart-info{
    border:1px solid #d4af37;
    padding:12px 25px;
    border-radius:40px;
    text-decoration:none;
    color:white;
    transition:.3s;
}

.cart-info:hover{
    background:#d4af37;
    color:black;
}

/* HERO CONTENT */

.hero-content{
    flex:1;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    text-align:center;
}

.hero-content p{
    color:#d4af37;
    font-size:22px;
    font-style:italic;
}

.hero-content h1{
    font-family:'Cormorant Garamond',serif;
    font-size:100px;
    line-height:1.05;
    margin:20px 0;
}

.hero-btn{
    text-decoration:none;
    color:#d4af37;
    border:1px solid #d4af37;
    padding:16px 40px;
    letter-spacing:2px;
    transition:.3s;
}

.hero-btn:hover{
    background:#d4af37;
    color:black;
}

/* MENU SECTION */

.menu-section{
    padding:100px 80px;
    background:#0b0b0b;
}

.section-title{
    text-align:center;
    margin-bottom:60px;
}

.section-title h2{
    font-family:'Cormorant Garamond',serif;
    font-size:65px;
    color:#d4af37;
}

.section-title p{
    color:#aaa;
}

/* GRID */

.menu-grid{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(330px,1fr));
    gap:35px;
}

/* CARD */

.dish-card{
    background:#111;
    border-radius:20px;
    overflow:hidden;

    border:1px solid rgba(212,175,55,.15);

    transition:.4s;
}

.dish-card:hover{
    transform:translateY(-12px);
    box-shadow:0 15px 40px rgba(212,175,55,.2);
}

.dish-image{
    height:240px;
    overflow:hidden;
}

.dish-image img{
    width:100%;
    height:100%;
    object-fit:cover;
    transition:.5s;
}

.dish-card:hover img{
    transform:scale(1.1);
}

.dish-content{
    padding:25px;
}

.dish-content h3{
    font-family:'Cormorant Garamond',serif;
    font-size:32px;
    margin-bottom:10px;
}

.category{
    background:#d4af37;
    color:black;
    padding:5px 12px;
    border-radius:20px;
    font-size:12px;
    font-weight:bold;
}

.description{
    color:#bbb;
    margin-top:15px;
    min-height:60px;
}

.price{
    color:#d4af37;
    font-size:30px;
    font-weight:bold;
    margin:20px 0;
}

.btn-cart{
    display:inline-block;
    text-decoration:none;
    color:#d4af37;
    border:1px solid #d4af37;
    padding:12px 25px;
    border-radius:30px;
    transition:.3s;
}

.btn-cart:hover{
    background:#d4af37;
    color:black;
}

/* FOOTER */

.footer{
    background:black;
    text-align:center;
    padding:40px;
    color:#777;
}

/* RESPONSIVE */

@media(max-width:768px){

    .navbar{
        padding:20px;
        flex-direction:column;
        gap:20px;
    }

    .hero-content h1{
        font-size:55px;
    }

    .menu-section{
        padding:80px 20px;
    }

    .nav-links{
        gap:15px;
    }
}

</style>
</head>

<body>

<!-- HERO -->

<section class="hero">

    <nav class="navbar">

        <div class="logo">
            MARCEL
        </div>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">TRANG CHỦ</a>
            <a href="#menu">THỰC ĐƠN</a>
            <a href="#">ĐẶT BÀN</a>
            <a href="${pageContext.request.contextPath}/dashboard.jsp">
                DASHBOARD
            </a>
        </div>

        <a href="${pageContext.request.contextPath}/cart?action=view"
           class="cart-info">

            🛒 Giỏ hàng:
            <b>
                ${sessionScope.totalQuantity != null ? sessionScope.totalQuantity : 0}
            </b>

        </a>

    </nav>

    <div class="hero-content">

        <p>Trải nghiệm ẩm thực đích thực</p>

        <h1>
            HƯƠNG VỊ<br>
            CHÂU ÂU CỔ ĐIỂN
        </h1>

        <a href="#menu" class="hero-btn">
            KHÁM PHÁ THỰC ĐƠN
        </a>

    </div>

</section>

<!-- MENU -->

<section class="menu-section" id="menu">

    <div class="section-title">

        <h2>THỰC ĐƠN CAO CẤP</h2>

        <p>
            Những món ăn được tuyển chọn bởi đầu bếp của MARCEL
        </p>

    </div>

    <div class="menu-grid">

        <c:forEach var="dish" items="${dishes}">

            <div class="dish-card">

                <div class="dish-image">

                    <img src="${empty dish.image ?
                    'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=80'
                    : dish.image}"
                    alt="${dish.name}">

                </div>

                <div class="dish-content">

                    <h3>${dish.name}</h3>

                    <span class="category">
                        ${dish.category}
                    </span>

                    <p class="description">
                        ${dish.description}
                    </p>

                    <div class="price">

                        ${String.format("%,.0f", dish.price)} VNĐ

                    </div>

                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${dish.id}"
                       class="btn-cart">

                        🛒 Thêm vào giỏ

                    </a>

                </div>

            </div>

        </c:forEach>

    </div>

</section>

<footer class="footer">

    © 2026 MARCEL Restaurant | Fine Dining Experience

</footer>

</body>
</html>