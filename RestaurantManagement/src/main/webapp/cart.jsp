<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 800px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #f4f4f4; }
        .total-row { font-size: 20px; font-weight: bold; color: #dc3545; text-align: right; margin-top: 20px; }
        .btn-checkout { background: #28a745; color: white; padding: 12px 20px; text-decoration: none; border-radius: 4px; font-weight: bold; display: inline-block; margin-top: 20px; }
        .btn-checkout:hover { background: #218838; }
        .btn-remove { color: #dc3545; font-weight: bold; text-decoration: none; padding: 5px 10px; border: 1px solid #dc3545; border-radius: 4px; }
        .btn-remove:hover { background: #dc3545; color: white; }
        .alert-success { background-color: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🛒 CHI TIẾT GIỎ HÀNG</h2>
        
        <c:if test="${not empty message}">
            <div class="alert-success">${message}</div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/menu" style="text-decoration: none; color: #007bff;">⬅ Tiếp tục chọn món</a>
        
        <c:choose>
            <c:when test="${empty sessionScope.cart}">
                <p style="text-align: center; color: #777; margin-top: 30px; font-size: 18px;">Giỏ hàng của bạn đang trống.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Tên món ăn</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Thao tác</th> </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalAmount" value="0" />
                        
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <tr>
                                <td><strong>${item.dish.name}</strong></td>
                                <td>${item.dish.price} VNĐ</td>
                                <td>${item.quantity}</td>
                                <td>${item.totalPrice} VNĐ</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.dish.id}" class="btn-remove">❌ Xóa</a>
                                </td>
                            </tr>
                            <c:set var="totalAmount" value="${totalAmount + item.totalPrice}" />
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="total-row">
                    Tổng thanh toán: ${totalAmount} VNĐ
                </div>
                
                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/cart?action=checkout" class="btn-checkout">Thanh Toán & Đặt Bàn</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>