<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ưu Đãi Hội Viên</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .voucher-card { background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%); padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        .voucher-info h3 { margin: 0 0 10px 0; color: #d63031; font-size: 24px; }
        .voucher-info p { margin: 0; color: #2d3436; font-size: 16px; }
        .btn-use { background: #d63031; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
        .empty-msg { text-align: center; padding: 30px; background: white; border-radius: 10px; color: #636e72; font-size: 18px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <div class="container">
        <h2>⭐ KHO VOUCHER CỦA BẠN</h2>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" style="text-decoration: none; color: #007bff; display: inline-block; margin-bottom: 20px;">⬅ Quay lại Dashboard</a>
        
        <c:choose>
            <%-- Nếu danh sách rỗng (Không có voucher nào) --%>
            <c:when test="${empty myVouchers}">
                <div class="empty-msg">
                    😢 Hiện tại bạn chưa có voucher nào. Hãy liên hệ Admin nhé!
                </div>
            </c:when>
            
            <%-- Nếu có voucher, lặp qua danh sách và in ra --%>
            <c:otherwise>
                <c:forEach var="code" items="${myVouchers}">
                    <div class="voucher-card">
                        <div class="voucher-info">
                            <h3>MÃ QUÀ TẶNG: ${code}</h3>
                            <p>Ưu đãi độc quyền dành riêng cho bạn. Hạn sử dụng: Vô thời hạn.</p>
                        </div>
                       <a href="${pageContext.request.contextPath}/use-voucher?code=${code}" class="btn-use" style="text-decoration: none; display: inline-block; text-align: center;" onclick="return confirm('Bạn có chắc chắn muốn dùng thẻ này không? Thẻ sẽ biến mất sau khi dùng!');">Dùng Ngay</a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        
    </div>
</body>
</html>