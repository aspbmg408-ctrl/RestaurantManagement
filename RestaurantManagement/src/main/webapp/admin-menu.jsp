<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Thực Đơn - Admin</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #343a40; color: white; }
        .btn-add { background: #28a745; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .btn-edit { background: #ffc107; color: black; padding: 5px 10px; text-decoration: none; border-radius: 4px; }
        .btn-delete { background: #dc3545; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>BẢNG QUẢN LÝ THỰC ĐƠN</h2>
        
        <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/dashboard.jsp" style="text-decoration: none; color: #007bff;">⬅ Quay lại Dashboard</a>
            
            <a href="${pageContext.request.contextPath}/admin/add-dish" class="btn-add">➕ Thêm món mới</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên món ăn</th>
                    <th>Phân loại</th>
                    <th>Giá tiền (VNĐ)</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dish" items="${dishes}">
                    <tr>
                        <td>${dish.id}</td>
                        <td><strong>${dish.name}</strong></td>
                        <td>${dish.category}</td>
                        <td>${dish.price}</td>
                        <td>
                            <span style="color: ${dish.available ? 'green' : 'red'}; font-weight: bold;">
                                ${dish.available ? 'Đang bán' : 'Ngừng bán'}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/edit-dish?id=${dish.id}" class="btn-edit">Sửa</a>
    <a href="${pageContext.request.contextPath}/admin/delete-dish?id=${dish.id}" class="btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa món này vĩnh viễn?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>