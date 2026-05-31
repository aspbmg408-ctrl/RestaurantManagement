<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa thông tin món ăn</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .form-box { background: white; padding: 20px; border-radius: 8px; width: 400px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        input[type="text"], input[type="number"], select, textarea { width: 100%; margin-bottom: 15px; padding: 8px; box-sizing: border-box; }
        button { background: #ffc107; color: black; font-weight: bold; padding: 10px; width: 100%; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Cập Nhật Món Ăn</h2>
        
        <form action="${pageContext.request.contextPath}/admin/edit-dish" method="post">
            <input type="hidden" name="id" value="${dish.id}">
            
            <label>Tên món ăn:</label>
            <input type="text" name="name" value="${dish.name}" required>
            
            <label>Giá tiền (VNĐ):</label>
            <input type="number" name="price" value="${dish.price}" required>
            
            <label>Phân loại:</label>
            <select name="category">
                <option value="Khai vị" ${dish.category == 'Khai vị' ? 'selected' : ''}>Khai vị</option>
                <option value="Món chính" ${dish.category == 'Món chính' ? 'selected' : ''}>Món chính</option>
                <option value="Tráng miệng" ${dish.category == 'Tráng miệng' ? 'selected' : ''}>Tráng miệng</option>
                <option value="Đồ uống" ${dish.category == 'Đồ uống' ? 'selected' : ''}>Đồ uống</option>
            </select>
            
            <label>Mô tả ngắn gọn:</label>
            <textarea name="description" rows="3">${dish.description}</textarea>
            
            <label>
                <input type="checkbox" name="available" ${dish.available ? 'checked' : ''}> Đang bán
            </label>
            <br><br>
            
            <button type="submit">Lưu Cập Nhật</button>
            <br><br>
            <a href="${pageContext.request.contextPath}/admin/menu" style="text-decoration:none;">⬅ Hủy / Quay lại</a>
        </form>
    </div>
</body>
</html>