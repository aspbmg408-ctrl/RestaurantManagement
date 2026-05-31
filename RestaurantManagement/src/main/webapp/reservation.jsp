<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Bàn Trước</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; padding: 20px; }
        .form-container { background: white; max-width: 500px; margin: 0 auto; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input[type="date"], input[type="time"], input[type="number"], textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-submit { background: #007bff; color: white; border: none; padding: 12px; width: 100%; font-size: 16px; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background: #0056b3; }
        .alert-success { background-color: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2 style="text-align: center; color: #333;">📅 ĐẶT BÀN TRƯỚC</h2>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" style="display: block; text-align: center; margin-bottom: 20px; text-decoration: none; color: #6c757d;">⬅ Quay lại Dashboard</a>
        
        <c:if test="${not empty message}">
            <div class="alert-success"><strong>${message}</strong></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reservation" method="post">
            <div class="form-group">
                <label>Ngày đến:</label>
                <input type="date" name="date" required>
            </div>
            <div class="form-group">
                <label>Giờ đến:</label>
                <input type="time" name="time" required>
            </div>
            <div class="form-group">
                <label>Số lượng khách:</label>
                <input type="number" name="guests" min="1" max="50" value="2" required>
            </div>
            <div class="form-group">
                <label>Ghi chú đặc biệt (Tùy chọn):</label>
                <textarea name="note" rows="3" placeholder="Ví dụ: Cần ghế trẻ em, dị ứng đậu phộng..."></textarea>
            </div>
            <button type="submit" class="btn-submit">Xác Nhận Đặt Bàn</button>
        </form>
    </div>
</body>
</html>