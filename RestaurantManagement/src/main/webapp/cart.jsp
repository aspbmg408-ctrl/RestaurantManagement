<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng Thượng Hạng - Marcel</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Cấu trúc nền tảng tinh tế */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            background: linear-gradient(rgba(10, 12, 22, 0.88), rgba(10, 12, 22, 0.88)), 
                        url('https://images.unsplash.com/photo-1544025162-8366fd061595?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Thanh Điều Hướng Trên (Navbar đồng bộ Marcel) */
        .navbar {
            display: flex; justify-content: space-between; align-items: center;
            padding: 25px 80px; background-color: rgba(17, 20, 36, 0.95);
            position: fixed; top: 0; width: 100%; z-index: 1000;
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
        }
        .navbar-brand { 
            font-family: 'Playfair Display', serif; font-size: 26px; font-weight: 700; 
            color: #fff; text-decoration: none; letter-spacing: 3px;
        }
        .navbar-menu a {
            color: #fcfbf7; text-decoration: none; margin-left: 35px; font-size: 12px;
            text-transform: uppercase; letter-spacing: 2px; transition: color 0.3s;
            font-weight: 500;
        }
        .navbar-menu a:hover { color: #d4af37; }

        /* Khung chứa nội dung Giỏ hàng */
        .cart-wrapper {
            flex: 1;
            max-width: 900px;
            width: 100%;
            margin: 140px auto 60px;
            padding: 0 20px;
        }

        .cart-container {
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 45px 40px;
            border: 1px solid #d4af37; /* Viền vàng thương hiệu */
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.5);
        }

        /* Tiêu đề giỏ hàng nghệ thuật */
        .cart-container h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: 2px;
            color: #fff;
            margin-bottom: 5px;
            text-align: center;
            text-transform: uppercase;
        }
        .cart-subtitle {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 15px;
            margin-bottom: 30px;
            text-align: center;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 25px;
            color: #aaa;
            text-decoration: none;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }
        .back-link:hover { color: #d4af37; }

        /* Thiết kế bảng danh sách món ăn */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 30px;
        }
        th, td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid rgba(212, 175, 55, 0.15);
        }
        th {
            font-family: 'Playfair Display', serif;
            color: #d4af37;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 1px;
            border-bottom: 2px solid #d4af37;
        }
        td {
            font-size: 14px;
            color: #fcfbf7;
        }
        td strong {
            font-family: 'Playfair Display', serif;
            font-size: 16px;
            font-weight: 500;
            color: #fff;
        }

        /* Nút hành động xóa món ăn */
        .btn-remove {
            color: #ff7675;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }
        .btn-remove:hover {
            color: #ff4757;
            text-decoration: underline;
        }

        /* Dòng hiển thị tổng tiền quý phái */
        .total-row {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 600;
            color: #d4af37;
            text-align: right;
            margin-bottom: 35px;
            padding-top: 15px;
            letter-spacing: 0.5px;
        }

        /* Khối các nút điều hướng thanh toán cuối trang */
        .action-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-continue {
            color: #d4af37;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            border: 1px solid rgba(212, 175, 55, 0.4);
            padding: 14px 28px;
            transition: all 0.3s ease;
        }
        .btn-continue:hover {
            background: rgba(212, 175, 55, 0.05);
            border-color: #d4af37;
        }
        .btn-checkout {
            background: #d4af37;
            color: #111424;
            padding: 14px 35px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            border: 1px solid #d4af37;
            transition: all 0.4s ease;
        }
        .btn-checkout:hover {
            background: transparent;
            color: #d4af37;
        }

        /* Giao diện thông báo khi Giỏ hàng trống rỗng */
        .empty-cart-box {
            text-align: center;
            padding: 40px 0;
        }
        .empty-cart-box p {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #aaa;
            font-size: 16px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="navbar-brand">MARCEL</a>
        <div class="navbar-menu">
            <a href="${pageContext.request.contextPath}/dashboard.jsp">Tổng Quan</a>
            <a href="${pageContext.request.contextPath}/menu">Thực Đơn</a>
            <a href="${pageContext.request.contextPath}/reservation.jsp">Đặt Bàn</a>
            <a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a>
        </div>
    </nav>

    <div class="cart-wrapper">
        <div class="cart-container">
            <h2>Your Cart</h2>
            <div class="cart-subtitle">Hương vị tinh tuyển bạn đã chọn giữ riêng</div>
            
            <a href="${pageContext.request.contextPath}/menu" class="back-link">← Tiếp tục xem thực đơn</a>
            
            <c:choose>
                <%-- TRƯỜNG HỢP GIỎ HÀNG TRỐNG --%>
                <c:when test="${empty sessionScope.cart}">
                    <div class="empty-cart-box">
                        <p>Hiện tại giỏ hàng ẩm thực của bạn đang trống.</p>
                        <a href="${pageContext.request.contextPath}/menu" class="btn-checkout" style="display: inline-block;">Khám Phá Thực Đơn</a>
                    </div>
                </c:when>
                
                <%-- TRƯỜNG HỢP CÓ MÓN ĂN TRONG GIỎ --%>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Món ăn</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th style="text-align: center;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalAmount" value="0" />
                            
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <tr>
                                    <td><strong>${item.dish.name}</strong></td>
                                    <td>
                                        <fmt:formatNumber value="${item.dish.price}" type="number" maxFractionDigits="0"/> VNĐ
                                    </td>
                                    <td>${item.quantity}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.totalPrice}" type="number" maxFractionDigits="0"/> VNĐ
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.dish.id}" class="btn-remove">Xóa Món</a>
                                    </td>
                                </tr>
                                <c:set var="totalAmount" value="${totalAmount + item.totalPrice}" />
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <div class="total-row">
                        Tổng thanh toán: <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> VNĐ
                    </div>
                    
                    <div class="action-group">
                        <a href="${pageContext.request.contextPath}/menu" class="btn-continue">Thêm Món Khác</a>
                        <a href="${pageContext.request.contextPath}/cart?action=checkout" class="btn-checkout">Thanh Toán & Đặt Bàn</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>