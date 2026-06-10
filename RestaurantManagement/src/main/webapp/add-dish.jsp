<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Tuyệt Tác Ẩm Thực - Marcel</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Thiết lập nền móng tổng thể */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            background: linear-gradient(rgba(10, 12, 22, 0.93), rgba(10, 12, 22, 0.93)), 
                        url('https://images.unsplash.com/photo-1544025162-8366fd061595?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        /* Khung chứa Form chế tác kính mờ cao cấp */
        .form-box { 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 50px 45px; 
            border: 1px solid #d4af37; /* Viền vàng thương hiệu */
            border-radius: 0px; /* Cắt góc phẳng tối giản quý phái */
            width: 100%;
            max-width: 520px; 
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
        }

        /* Tiêu đề biểu mẫu nghệ thuật */
        .form-box h2 { 
            font-family: 'Playfair Display', serif;
            text-align: center; 
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 2px;
            color: #fff;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .form-subtitle {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            text-align: center;
            font-size: 14px;
            margin-bottom: 35px;
        }

        /* Nhãn trường thông tin thu gọn tinh tế */
        label { 
            display: block; 
            font-size: 11px; 
            font-weight: 600; 
            text-transform: uppercase; 
            letter-spacing: 1.5px; 
            color: #d4af37; 
            margin-bottom: 8px; 
        }

        /* Tái cấu trúc thẩm mỹ cho các ô điền dữ liệu */
        input[type="text"], 
        input[type="number"], 
        select, 
        textarea { 
            width: 100%; 
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(212, 175, 55, 0.25);
            color: #fff;
            padding: 12px 16px; 
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            margin-bottom: 25px; 
            box-sizing: border-box; 
            transition: all 0.3s ease;
        }

        /* Hiệu ứng focus phát sáng chỉ vàng khi nhấp chuột */
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #d4af37;
            background: rgba(212, 175, 55, 0.05);
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.15);
        }

        /* Tinh chỉnh riêng cho thẻ tùy chọn danh mục */
        select option {
            background: #111424;
            color: #fff;
        }

        /* Nút xác nhận ghi danh món mới phong cách Thượng hạng */
        button { 
            background: #d4af37; 
            color: #111424; 
            padding: 14px; 
            width: 100%; 
            border: 1px solid #d4af37; 
            font-family: 'Montserrat', sans-serif;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer; 
            transition: all 0.4s ease;
            margin-top: 10px;
        }
        button:hover { 
            background: transparent; 
            color: #d4af37; 
        }

        /* Đường dẫn lội ngược dòng quay về danh sách */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #aaa;
            text-decoration: none;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }
        .back-link:hover { 
            color: #d4af37; 
        }

        /* Banner thông báo trạng thái hệ thống mượt mà */
        .msg { 
            background: rgba(46, 204, 113, 0.1);
            border: 1px solid rgba(46, 204, 113, 0.3);
            color: #2ecc71; 
            font-size: 13px;
            padding: 12px;
            text-align: center;
            font-weight: 500; 
            margin-bottom: 25px; 
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

    <div class="form-box">
        <h2>New Masterpiece</h2>
        <div class="form-subtitle">Khai mở hương vị, ghi danh kiệt tác ẩm thực</div>
        
        <%-- Khu vực hiển thị thông điệp phản hồi từ hệ thống --%>
        <c:if test="${not empty message}">
            <div class="msg">${message}</div>
        </c:if>
        
        <%-- Form gửi dữ liệu lên Server xử lý --%>
        <form action="${pageContext.request.contextPath}/admin/add-dish" method="post">
            
            <label>Tên món ăn thượng hạng</label>
            <input type="text" name="name" placeholder="Ví dụ: Wagyu Beef Steak A5" required>
            
            <label>Định ngạch giá trị (VNĐ)</label>
            <input type="number" name="price" placeholder="Nhập số tiền..." required>
            
            <label>Phân loại dòng món</label>
            <select name="category">
                <option value="Khai vị">Khai vị (Appetizers)</option>
                <option value="Món chính">Món chính (Main Course)</option>
                <option value="Tráng miệng">Tráng miệng (Desserts)</option>
                <option value="Đồ uống">Đồ uống (Beverages)</option>
            </select>
            
            <label>Mô tả ngắn gọn hương vị</label>
            <textarea name="description" rows="4" placeholder="Mô tả các nguyên liệu tinh tuyển độc bản và cách chế biến kỹ nghệ..."></textarea>
            
            <button type="submit">Ghi Danh Vào Thực Đơn</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/admin/menu" class="back-link">← Quay lại Quản lý thực đơn</a>
    </div>

</body>
</html>