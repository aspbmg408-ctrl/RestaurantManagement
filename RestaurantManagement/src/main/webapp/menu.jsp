<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thực Đơn Nhà Hàng</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .header-menu { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .menu-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .dish-card { background: white; padding: 15px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .price { color: #dc3545; font-size: 18px; font-weight: bold; }
        .category { background: #007bff; color: white; padding: 3px 8px; border-radius: 12px; font-size: 12px; }
        .btn-cart { display: inline-block; background: #ffc107; color: black; text-decoration: none; padding: 8px 15px; border-radius: 4px; font-weight: bold; }
        .btn-cart:hover { background: #e0a800; }
        .cart-info { font-size: 18px; font-weight: bold; text-decoration: none; color: #333; background: white; padding: 10px 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="header-menu">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" style="text-decoration: none; color: #007bff;">⬅ Quay lại Dashboard</a>
        <h2>THỰC ĐƠN NHÀ HÀNG</h2>
        
        <a href="${pageContext.request.contextPath}/cart?action=view" class="cart-info">
        🛒 Giỏ hàng: <span style="color: red;">${sessionScope.totalQuantity != null ? sessionScope.totalQuantity : 0}</span>
    </a>
    </div>
    <hr>
    
    <div class="menu-grid">
        <c:forEach var="dish" items="${dishes}">
            <div class="dish-card">
                <h3>${dish.name} <span class="category">${dish.category}</span></h3>
                <p><i>${dish.description}</i></p>
                <p class="price">${dish.price} VNĐ</p>
                
                <a href="${pageContext.request.contextPath}/cart?action=add&id=${dish.id}" class="btn-cart">
                   🛒 Thêm vào giỏ
                </a>
            </div>
        </c:forEach>
    </div>
</body>
</html>