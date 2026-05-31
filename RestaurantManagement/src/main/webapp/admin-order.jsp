<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Đơn Hàng / Bàn</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .order-card { padding: 15px; border: 1px solid #ddd; border-left: 5px solid #ffc107; margin-top: 15px; border-radius: 5px; background: #fff; font-size: 16px; }
        .btn-done { float: right; background: #28a745; color: white; border: none; padding: 8px 15px; border-radius: 4px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🛎️ MÀN HÌNH QUẢN LÝ BÀN & ĐƠN HÀNG</h2>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" style="text-decoration: none; color: #007bff;">⬅ Quay lại Dashboard</a>
        
        <div style="margin-top: 20px;">
            <c:choose>
                <c:when test="${empty applicationScope.orderList}">
                    <p style="color: #777; font-style: italic;">Hiện chưa có khách nào đặt bàn hoặc gọi món.</p>
                </c:when>
                <c:otherwise>
                   <c:forEach var="order" items="${applicationScope.orderList}" varStatus="loop">
                        <div class="order-card">
                            ${order}
                            <a href="${pageContext.request.contextPath}/admin/orders?action=complete&index=${loop.index}" class="btn-done">✔️ Xác nhận xong</a>
                            <div style="clear:both;"></div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>