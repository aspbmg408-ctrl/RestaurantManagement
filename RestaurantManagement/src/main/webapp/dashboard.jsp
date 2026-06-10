<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page import="asm.dao.UserDAO" %>

<%
    // Khởi tạo dữ liệu hệ thống từ DAO
    UserDAO userDAO = new UserDAO();
    int totalUsers = 0;
    if (userDAO.getAllUsers() != null) {
        totalUsers = userDAO.getAllUsers().size();
    }
    request.setAttribute("totalUsers", totalUsers);
%>

<%-- Kiểm tra trạng thái đăng nhập bảo mật --%>
<c:if test="${empty sessionScope.currentUser}">
    <c:redirect url="/login" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tổng Quan Hệ Thống - Marcel</title>
    <!-- Nhúng phông chữ quý phái từ Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            background-color: #0a0c16;
            color: #fcfbf7; 
            min-height: 100vh;
            display: flex;
        }

        /* Thanh Điều Hướng Dọc */
        .sidebar { 
            width: 280px; 
            background: #111424;
            height: 100vh; 
            position: fixed; 
            top: 0; left: 0;
            padding-top: 40px; 
            border-right: 1px solid rgba(212, 175, 55, 0.15);
            display: flex;
            flex-direction: column;
            z-index: 100;
        }
        .sidebar-brand {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            color: #fff;
            text-align: center;
            letter-spacing: 4px;
            margin-bottom: 50px;
            text-decoration: none;
        }
        .sidebar-user-info {
            padding: 0 30px 25px;
            margin-bottom: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 13px;
            color: #aaa;
        }
        .sidebar-user-info strong {
            font-family: 'Playfair Display', serif;
            color: #d4af37;
            font-size: 16px;
            display: block;
            margin-top: 4px;
        }
        .sidebar-heading {
            margin: 15px 30px 5px; 
            font-size: 10px; 
            color: #666; 
            text-transform: uppercase; 
            letter-spacing: 2px;
        }
        .sidebar a { 
            display: block; 
            color: #fcfbf7; 
            padding: 14px 30px; 
            text-decoration: none; 
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1); 
            border-left: 3px solid transparent;
        }
        .sidebar a:hover { 
            background: rgba(212, 175, 55, 0.05); 
            color: #d4af37;
            padding-left: 35px;
            border-left-color: #d4af37;
        }
        .sidebar a.active {
            background: rgba(212, 175, 55, 0.08);
            color: #d4af37;
            border-left-color: #d4af37;
            font-weight: 600;
        }

        /* Khu Vực Nội Dung Chính */
        .content { 
            margin-left: 280px; 
            flex: 1;
            padding: 50px 60px; 
            background: linear-gradient(rgba(10, 12, 22, 0.95), rgba(10, 12, 22, 0.95)), 
                        url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
        }

        .content-header { margin-bottom: 40px; }
        .content-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 36px;
            font-weight: 700;
            color: #fff;
            letter-spacing: 1px;
        }
        .content-header p {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 15px;
            margin-top: 5px;
        }

        /* ADMIN WIDGETS */
        .admin-widgets { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); 
            gap: 30px; 
            margin-top: 20px;
        }
        .widget-card { 
            background: rgba(17, 20, 36, 0.8); 
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 35px 30px; 
            border: 1px solid rgba(212, 175, 55, 0.2);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            transition: transform 0.3s, border-color 0.3s;
        }
        .widget-card:hover {
            transform: translateY(-5px);
            border-color: #d4af37;
        }
        .widget-card h3 { 
            font-family: 'Playfair Display', serif;
            font-size: 16px; 
            color: #d4af37; 
            font-weight: 600;
            letter-spacing: 0.5px;
            margin-bottom: 15px;
        }
        .widget-card .number { 
            font-size: 38px; 
            font-weight: 300; 
            color: #fff;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }
        .widget-card p { 
            color: #888; 
            font-size: 13px; 
            font-weight: 300;
        }

        /* CUSTOMER BANNER */
        .customer-banner { 
            background: rgba(17, 20, 36, 0.75);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 60px 50px; 
            border: 1px solid #d4af37;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            text-align: center;
            max-width: 850px;
            margin: 0 auto;
        }
        .customer-banner h1 { 
            font-family: 'Playfair Display', serif; 
            font-size: 40px; 
            font-weight: 700; 
            color: #fff;
            margin-bottom: 15px;
            letter-spacing: 1px;
        }
        .customer-banner .subtitle { 
            font-family: 'Playfair Display', serif;
            font-style: italic; 
            color: #d4af37;
            font-size: 18px; 
            margin-bottom: 35px; 
        }
        .cart-status-box {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(212, 175, 55, 0.25);
            padding: 15px 30px;
            display: inline-block;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 40px;
            color: #eee;
        }
        .cart-status-box strong {
            font-size: 20px;
            color: #d4af37;
            font-family: 'Playfair Display', serif;
            margin: 0 5px;
        }
        .quick-links {
            display: flex;
            justify-content: center;
            gap: 25px;
        }
        .btn-panel {
            background: #d4af37;
            color: #111424;
            padding: 15px 35px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            border: 1px solid #d4af37;
            transition: all 0.4s ease;
        }
        .btn-panel:hover {
            background: transparent;
            color: #d4af37;
        }
        .btn-panel-outline {
            background: transparent;
            color: #fcfbf7;
            padding: 15px 35px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
        }
        .btn-panel-outline:hover {
            border-color: #d4af37;
            color: #d4af37;
            background: rgba(212, 175, 55, 0.02);
        }
    </style>
</head>
<body>

    <!-- SIDEBAR PHÂN QUYỀN -->
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="sidebar-brand">MARCEL</a>
        
        <div class="sidebar-user-info">
            Xin chào,
            <strong>${sessionScope.currentUser.fullname}</strong>
            <span style="font-size: 10px; color: #666; text-transform: uppercase; letter-spacing: 1px; display: block; margin-top: 2px;">
                Vai trò: ${sessionScope.currentUser.role}
            </span>
        </div>
        
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="active">Tổng Quan</a>
        
        <%-- Menu chỉ dành cho Quản trị viên --%>
        <c:if test="${sessionScope.currentUser.role == 'ADMIN' or sessionScope.currentUser.role == 'MANAGER'}">
            <div class="sidebar-heading">Quản trị hệ thống</div>
            <a href="${pageContext.request.contextPath}/admin/menu">Quản lý Thực Đơn</a>
            <a href="${pageContext.request.contextPath}/admin/users">Quản lý Người Dùng</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Quản lý Đơn / Bàn</a>
        </c:if>
        
        <%-- Menu dành cho Khách hàng --%>
        <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
            <div class="sidebar-heading">Dịch vụ khách hàng</div>
            <a href="${pageContext.request.contextPath}/menu">Thực Đơn</a>
            <a href="${pageContext.request.contextPath}/reservation.jsp">Đặt Bàn</a>
            <a href="${pageContext.request.contextPath}/cart">Giỏ Hàng Của Bạn</a>
        </c:if>

        <a href="${pageContext.request.contextPath}/logout" style="border-top: 1px solid rgba(255,255,255,0.05); margin-top: 15px; color: #ff7675;">Đăng Xuất</a>
    </div>

    <!-- KHU VỰC NỘI DUNG -->
    <div class="content">
        <div class="content-header">
            <h2>Control Panel</h2>
            <p>Hệ thống vận hành không gian ẩm thực Marcel</p>
        </div>

        <%-- GIAO DIỆN DÀNH CHO ADMIN --%>
        <c:if test="${sessionScope.currentUser.role == 'ADMIN' or sessionScope.currentUser.role == 'MANAGER'}">
            <div class="admin-widgets">
                <div class="widget-card">
                    <h3>Đơn Chờ Phục Vụ</h3>
                    <div class="number">${applicationScope.orderList != null ? applicationScope.orderList.size() : 0}</div>
                    <p>Số lượng Đơn hàng & Đặt bàn chờ xử lý</p>
                </div>

                <div class="widget-card">
                    <h3>Doanh Thu Tạm Tính</h3>
                    <div class="number">
                        <fmt:formatNumber value="${applicationScope.totalRevenue != null ? applicationScope.totalRevenue : 0}" type="number" maxFractionDigits="0"/> 
                        <span style="font-size: 16px; color: #a67c1e;">VNĐ</span>
                    </div>
                    <p>Tổng kết từ các hóa đơn đã chốt</p>
                </div>
                
                <div class="widget-card">
                    <h3>Tổng Số Khách Hàng</h3>
                    <div class="number">${totalUsers}</div>
                    <p>Số lượng tài khoản đã đăng ký</p>
                </div>
            </div>
        </c:if>

        <%-- GIAO DIỆN DÀNH CHO CUSTOMER --%>
        <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
            <div class="customer-banner">
                <h1>Chào Mừng Tới Marcel</h1>
                <div class="subtitle">Nơi nghệ thuật ẩm thực tinh tế kết tạo trải nghiệm thượng lưu</div>
                
                <div class="cart-status-box">
                    Giỏ hàng của thượng khách hiện có: 
                    <strong>${sessionScope.totalQuantity != null ? sessionScope.totalQuantity : 0}</strong> 
                    món đang chờ
                </div>

                <div class="quick-links">
                    <a href="${pageContext.request.contextPath}/menu" class="btn-panel">Khám Phá Thực Đơn</a>
                    <a href="${pageContext.request.contextPath}/reservation.jsp" class="btn-panel-outline">Đặt Bàn Ngay</a>
                </div>
            </div>
        </c:if>
    </div>

</body>
</html>