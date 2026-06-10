<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Thực Đơn - Nhà Hàng Marcel</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Thiết lập nền móng tổng thể */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            /* Hình nền hậu trường nhà hàng mờ ảo tạo chiều sâu */
            background: linear-gradient(rgba(10, 12, 22, 0.92), rgba(10, 12, 22, 0.92)), 
                        url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            padding: 60px 40px;
        }

        /* Khung chứa quản trị phong cách hộp trang sức đen - vàng */
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 45px; 
            border: 1px solid #d4af37; /* Viền vàng thương hiệu */
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
        }

        /* Khu vực Header nghệ thuật */
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding-bottom: 25px;
            margin-bottom: 35px;
        }
        .header-title h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: 1px;
            color: #fff;
            text-transform: uppercase;
        }
        .header-title p {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 15px;
            margin-top: 5px;
        }

        /* Liên kết quay lại trang chủ quản trị */
        .back-link {
            display: inline-block;
            color: #aaa;
            text-decoration: none;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 15px;
            transition: color 0.3s;
        }
        .back-link:hover { color: #d4af37; }

        /* Nút "Thêm món mới" phong cách Premium */
        .btn-add { 
            background: #d4af37; 
            color: #111424; 
            padding: 13px 25px; 
            text-decoration: none; 
            font-size: 12px; 
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            border: 1px solid #d4af37;
            transition: all 0.4s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-add:hover { 
            background: transparent; 
            color: #d4af37; 
        }

        /* Cấu trúc Bảng dữ liệu đẳng cấp */
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
        }
        th, td { 
            padding: 16px 20px; 
            text-align: left; 
            border-bottom: 1px solid rgba(212, 175, 55, 0.1); 
        }
        th { 
            font-family: 'Playfair Display', serif;
            color: #d4af37; 
            font-size: 15px;
            font-weight: 600; 
            letter-spacing: 1px;
            text-transform: uppercase;
            border-bottom: 2px solid #d4af37;
            background: rgba(255, 255, 255, 0.01);
        }
        td { 
            font-size: 14px; 
            color: #e0e0e0;
        }
        tr:hover td {
            background: rgba(212, 175, 55, 0.02);
            color: #fff;
        }
        td strong {
            font-family: 'Playfair Display', serif;
            font-size: 16px;
            font-weight: 600;
            color: #fff;
            letter-spacing: 0.5px;
        }

        /* Nhãn trạng thái kinh doanh tinh tế */
        .status-badge {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 4px 10px;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 2px;
        }
        .status-active {
            color: #2ecc71;
            border: 1px solid rgba(46, 204, 113, 0.3);
            background: rgba(46, 204, 113, 0.05);
        }
        .status-inactive {
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.3);
            background: rgba(231, 76, 60, 0.05);
        }

        /* Nhóm nút hành động Sửa / Xóa tinh giản */
        .action-links {
            display: flex;
            gap: 20px;
        }
        .btn-edit { 
            color: #d4af37; 
            text-decoration: none; 
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }
        .btn-edit:hover { 
            color: #fff; 
            text-decoration: underline;
        }
        .btn-delete { 
            color: #ff7675; 
            text-decoration: none; 
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }
        .btn-delete:hover { 
            color: #ff4757; 
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="container">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="back-link">← Quay lại Không gian điều khiển</a>
        
        <div class="header-section">
            <div class="header-title">
                <h2>Menu Management</h2>
                <p>Quản trị tinh tuyển danh mục kiệt tác ẩm thực đại tiệc Marcel</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/add-dish" class="btn-add">
                    <span>➕</span> Thêm món mới
                </a>
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th style="width: 80px;">Mã số</th>
                    <th>Tuyệt tác ẩm thực</th>
                    <th>Phân loại dòng món</th>
                    <th>Định ngạch (Giá tiền)</th>
                    <th>Trạng thái phục vụ</th>
                    <th style="width: 160px; text-align: center;">Hành động quản trị</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dish" items="${dishes}">
                    <tr>
                        <td style="color: #777; font-weight: 500;">#${dish.id}</td>
                        <td><strong>${dish.name}</strong></td>
                        <td style="font-style: italic; color: #aaa;">${dish.category}</td>
                        <td style="font-weight: 500; color: #d4af37;">
                            <fmt:formatNumber value="${dish.price}" type="number" maxFractionDigits="0"/> VNĐ
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${dish.available}">
                                    <span class="status-badge status-active">Đang bán</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">Ngừng bán</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="action-links" style="justify-content: center;">
                                <a href="${pageContext.request.contextPath}/admin/edit-dish?id=${dish.id}" class="btn-edit">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/delete-dish?id=${dish.id}" class="btn-delete" onclick="return confirm('Hệ thống cảnh báo: Bạn có chắc chắn muốn xóa vĩnh viễn tuyệt tác ẩm thực này không?');">Xóa</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>