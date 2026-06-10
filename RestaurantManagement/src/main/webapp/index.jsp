<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Marcel - Tinh Hoa Ẩm Thực Châu Âu</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Montserrat', sans-serif; background-color: #fdfbf7; color: #1a1a1a; }
        
        /* Navigation Bar (Thanh Menu Trên) */
        .navbar {
            display: flex; justify-content: space-between; align-items: center;
            padding: 30px 80px; position: absolute; top: 0; width: 100%; z-index: 10;
        }
        .navbar-brand { font-family: 'Playfair Display', serif; font-size: 28px; font-weight: 700; color: #fff; text-decoration: none; letter-spacing: 2px;}
        .navbar-menu a {
            color: #fff; text-decoration: none; margin-left: 40px; font-size: 13px;
            text-transform: uppercase; letter-spacing: 1.5px; transition: color 0.3s ease;
        }
        .navbar-menu a:hover { color: #d4af37; } /* Màu vàng đồng khi di chuột */

        /* Hero Banner (Phần ảnh bìa lớn) */
        .hero-section {
            height: 100vh;
            /* Thay link ảnh dưới đây bằng ảnh nhà hàng của bạn trong thư mục images/ */
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat;
            display: flex; flex-direction: column; justify-content: center; align-items: center;
            text-align: center; color: #fff;
        }
        .hero-subtitle { font-family: 'Playfair Display', serif; font-style: italic; font-size: 22px; color: #d4af37; margin-bottom: 20px; }
        .hero-title { font-family: 'Playfair Display', serif; font-size: 64px; font-weight: 700; letter-spacing: 4px; margin-bottom: 30px; text-transform: uppercase; }
        
        /* Nút bấm sang trọng */
        .btn-gold {
            padding: 16px 40px; font-size: 13px; font-weight: 600; text-transform: uppercase; letter-spacing: 2px;
            color: #fff; background-color: transparent; border: 1px solid #d4af37;
            text-decoration: none; transition: all 0.4s ease;
        }
        .btn-gold:hover { background-color: #d4af37; color: #1a1a1a; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">MARCEL</a>
        <div class="navbar-menu">
            <a href="${pageContext.request.contextPath}/index.jsp">Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/menu">Thực Đơn</a>
            <a href="${pageContext.request.contextPath}/reservation.jsp">Đặt Bàn</a>
            <a href="${pageContext.request.contextPath}/login.jsp">Đăng Nhập</a>
        </div>
    </nav>

    <header class="hero-section">
        <div class="hero-subtitle">Trải nghiệm ẩm thực đích thực</div>
        <h1 class="hero-title">Hương Vị<br>Châu Âu Cổ Điển</h1>
        <a href="${pageContext.request.contextPath}/menu" class="btn-gold">Khám Phá Thực Đơn</a>
    </header>

</body>
</html>