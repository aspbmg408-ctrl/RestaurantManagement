<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="asm.dao.UserDAO" %>

<%
    UserDAO userDAO = new UserDAO();
    int totalUsers = 0;
    if (userDAO.getAllUsers() != null) {
        totalUsers = userDAO.getAllUsers().size();
    }
    request.setAttribute("totalUsers", totalUsers);
%>

<c:if test="${empty sessionScope.currentUser}">
    <c:redirect url="/login" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tổng Quan - Nhà Hàng</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f8f9fa; }
        .sidebar { width: 250px; background: #343a40; color: white; height: 100vh; float: left; padding-top: 20px; position: fixed; }
        .sidebar a { display: block; color: white; padding: 15px; text-decoration: none; transition: 0.2s; }
        .sidebar a:hover { background: #495057; padding-left: 20px; }
        .content { margin-left: 250px; padding: 20px; }
        .header { background: white; padding: 15px 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; border-radius: 8px; margin-bottom: 25px;}
        .btn-logout { background: #dc3545; color: white; padding: 8px 15px; text-decoration: none; border-radius: 4px; font-weight: bold; }
        
        .widget-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 20px; }
        .widget-card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); text-align: center; border-top: 5px solid #007bff; }
        .widget-card h3 { margin: 0; color: #6c757d; font-size: 16px; text-transform: uppercase; }
        .widget-card .number { font-size: 38px; font-weight: bold; color: #333; margin: 10px 0; }

        .customer-banner { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 40px; border-radius: 12px; margin-top: 20px; text-align: center; box-shadow: 0 10px 20px rgba(0,0,0,0.15); }
        .customer-banner h1 { margin-top: 0; font-size: 32px; }
        .quick-links { display: flex; justify-content: center; gap: 20px; margin-top: 30px; }
        .btn-quick { background: #ffc107; color: #333; padding: 12px 30px; text-decoration: none; border-radius: 50px; font-weight: bold; font-size: 16px; transition: 0.3s; box-shadow: 0 4px 6px rgba(0,0,0,0.2); }
        .btn-quick:hover { background: #e0a800; transform: translateY(-3px); }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3 style="text-align: center; margin-bottom: 20px; letter-spacing: 1px;">MENU QUẢN TRỊ</h3>
        
        <c:if test="${sessionScope.currentUser.role == 'ADMIN' or sessionScope.currentUser.role == 'MANAGER'}">
            <a href="${pageContext.request.contextPath}/admin/menu">🍔 Quản lý Thực đơn</a>
            <a href="${pageContext.request.contextPath}/admin/users">👥 Quản lý Nhân sự / Khách</a>
            <a href="${pageContext.request.contextPath}/admin/orders">🛒 Quản lý Bàn / Order</a>
        </c:if>
        
        <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
            <a href="${pageContext.request.contextPath}/menu">📖 Xem Thực Đơn</a>
            <a href="${pageContext.request.contextPath}/reservation">📅 Đặt Bàn Trước</a>
            <a href="${pageContext.request.contextPath}/offers">⭐ Ưu Đãi Hội Viên</a>
        </c:if>
    </div>

    <div class="content">
        <div class="header">
            <h2 style="margin: 0; color: #2c3e50;">Xin chào, ${sessionScope.currentUser.fullname}! <span style="font-size: 16px; color: #7f8c8d;">(${sessionScope.currentUser.role})</span></h2>
            <a href="#" class="btn-logout" onclick="confirmLogout()">Đăng xuất</a>

<script>
    function confirmLogout() {
        if (confirm("Bạn có chắc chắn muốn đăng xuất khỏi hệ thống không?")) {
            window.location.href = "${pageContext.request.contextPath}/logout";
        }
    }
</script>
        </div>

        <c:if test="${sessionScope.currentUser.role == 'ADMIN' or sessionScope.currentUser.role == 'MANAGER'}">
            <h3 style="color: #333; margin-top: 30px;">📊 Bảng Thống Kê Hoạt Động (Live)</h3>
            <div class="widget-grid">
                
                <div class="widget-card" style="border-top-color: #ffc107;">
                    <h3>Đơn Chờ Phục Vụ</h3>
                    <div class="number">${applicationScope.orderList != null ? applicationScope.orderList.size() : 0}</div>
                    <p style="color: #777; font-size: 14px; margin: 0;">Đơn hàng & Đặt bàn</p>
                </div>
                
                <div class="widget-card" style="border-top-color: #28a745;">
                    <h3>Doanh Thu Tạm Tính</h3>
                    <div class="number">${applicationScope.totalRevenue != null ? applicationScope.totalRevenue : 0} ₫</div>
                    <p style="color: #777; font-size: 14px; margin: 0;">Từ các hóa đơn đã chốt</p>
                </div>
                
                <div class="widget-card" style="border-top-color: #17a2b8;">
                    <h3>Tổng Số Khách Hàng</h3>
                    <div class="number">${totalUsers}</div>
                    <p style="color: #777; font-size: 14px; margin: 0;">Tài khoản đã đăng ký</p>
                </div>
            </div>
        </c:if>

        <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
            <div class="customer-banner">
                <h1>Chào mừng bạn đến với Nhà Hàng Cương Phùng! 🍽️</h1>
                <p style="font-size: 18px; margin-bottom: 20px;">Không gian ẩm thực tinh tế và dịch vụ chuẩn 5 sao đang chờ đón bạn.</p>
                
                <div style="background: rgba(255,255,255,0.2); padding: 15px; border-radius: 8px; display: inline-block;">
                    Giỏ hàng của bạn đang có: <strong style="font-size: 22px; color: #ffeb3b;">${sessionScope.totalQuantity != null ? sessionScope.totalQuantity : 0}</strong> món ăn chờ thanh toán
                </div>

                <div class="quick-links">
                    <a href="${pageContext.request.contextPath}/menu" class="btn-quick">📖 Xem Thực Đơn Ngay</a>
                    <a href="${pageContext.request.contextPath}/reservation" class="btn-quick">📅 Đặt Bàn</a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>