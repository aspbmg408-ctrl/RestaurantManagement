<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm món ăn mới</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .form-box { background: white; padding: 20px; border-radius: 8px; width: 400px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        input, select, textarea { width: 100%; margin-bottom: 15px; padding: 8px; box-sizing: border-box; }
        button { background: #28a745; color: white; padding: 10px; width: 100%; border: none; cursor: pointer; }
        .msg { color: green; font-weight: bold; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Nhập Món Ăn Mới</h2>
        <c:if test="${not empty message}"><div class="msg">${message}</div></c:if>
        
        <form action="${pageContext.request.contextPath}/admin/add-dish" method="post">
            <label>Tên món ăn:</label>
            <input type="text" name="name" required>
            
            <label>Giá tiền (VNĐ):</label>
            <input type="number" name="price" required>
            
            <label>Phân loại:</label>
            <select name="category">
                <option value="Khai vị">Khai vị</option>
                <option value="Món chính">Món chính</option>
                <option value="Tráng miệng">Tráng miệng</option>
                <option value="Đồ uống">Đồ uống</option>
            </select>
            
            <label>Mô tả ngắn gọn:</label>
            <textarea name="description" rows="3"></textarea>
            
            <button type="submit">Lưu vào Thực Đơn</button>
            <br><br>
            <a href="${pageContext.request.contextPath}/dashboard.jsp">⬅ Quay lại Dashboard</a>
        </form>
    </div>
</body>
</html>