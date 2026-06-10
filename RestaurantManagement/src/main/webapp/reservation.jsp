<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt Bàn Thượng Hạng - Marcel</title>
    <!-- Nhúng phông chữ quý phái giống trang chủ Marcel -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Toàn bộ nền tảng */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            background: linear-gradient(rgba(10, 12, 22, 0.85), rgba(10, 12, 22, 0.85)), 
                        url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Thanh Điều Hướng Trên (Navbar đồng bộ) */
        .navbar {
            display: flex; justify-content: space-between; align-items: center;
            padding: 25px 80px; background-color: rgba(17, 20, 36, 0.95);
            position: fixed; top: 0; width: 100%; z-index: 1000;
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
        }
        .navbar-brand { 
            font-family: 'Playfair Display', serif; font-size: 26px; font-weight: 700; 
            color: #fff; text-decoration: none; letter-spacing: 3px;
        }
        .navbar-menu a {
            color: #fcfbf7; text-decoration: none; margin-left: 35px; font-size: 12px;
            text-transform: uppercase; letter-spacing: 2px; transition: color 0.3s;
            font-weight: 500;
        }
        .navbar-menu a:hover { color: #d4af37; }

        /* Khung nội dung đặt bàn chính */
        .main-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 140px 20px 60px;
        }

        .form-container { 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(10px);
            max-width: 550px; 
            width: 100%;
            padding: 50px 40px; 
            border: 1px solid #d4af37; /* Viền vàng đồng đẳng cấp */
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            text-align: center;
        }

        /* Tiêu đề biểu mẫu */
        .form-container h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: 2px;
            color: #fff;
            margin-bottom: 5px;
            text-transform: uppercase;
        }
        .form-subtitle {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 15px;
            margin-bottom: 25px;
        }
        
        .back-link {
            display: inline-block;
            margin-bottom: 30px;
            color: #aaa;
            text-decoration: none;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: color 0.3s;
        }
        .back-link:hover { color: #d4af37; }

        /* Các ô nhập liệu phẳng tinh tế */
        .form-group { margin-bottom: 25px; text-align: left; }
        label { 
            display: block; 
            font-size: 11px;
            font-weight: 600; 
            margin-bottom: 8px; 
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: #d4af37;
        }
        
        input[type="date"], input[type="time"], input[type="number"], textarea { 
            width: 100%; 
            padding: 14px 16px; 
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(212, 175, 55, 0.25); 
            color: #fff;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        /* Hiệu ứng lịch và đồng hồ chuyển màu tối phù hợp hệ thống */
        input::-webkit-calendar-picker-indicator {
            filter: invert(80%) sepia(50%) saturate(400%) hue-rotate(10deg);
            cursor: pointer;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: #d4af37;
            background: rgba(255, 255, 255, 0.07);
            box-shadow: 0 0 8px rgba(212, 175, 55, 0.2);
        }
        
        textarea { resize: none; }

        /* Nút bấm đặt bàn dạng viền đặc trưng cao cấp */
        .btn-submit { 
            background: #d4af37; 
            color: #111424; 
            border: 1px solid #d4af37; 
            padding: 16px; 
            width: 100%; 
            font-size: 13px; 
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer; 
            transition: all 0.4s ease;
            margin-top: 10px;
        }
        .btn-submit:hover { 
            background: transparent; 
            color: #d4af37; 
        }

        /* Khung thông báo thành công */
        .alert-success { 
            background-color: rgba(212, 175, 55, 0.15); 
            color: #d4af37; 
            padding: 15px; 
            border: 1px solid #d4af37;
            font-size: 13px;
            margin-bottom: 25px; 
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

    <!-- Thanh Navbar đỉnh cao -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="navbar-brand">MARCEL</a>
        <div class="navbar-menu">
            <a href="${pageContext.request.contextPath}/dashboard.jsp">Tổng Quan</a>
            <a href="${pageContext.request.contextPath}/menu">Thực Đơn</a>
            <a href="${pageContext.request.contextPath}/reservation.jsp" style="color: #d4af37;">Đặt Bàn</a>
            <a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a>
        </div>
    </nav>

    <!-- Khối trung tâm xử lý giao diện -->
    <div class="main-wrapper">
        <div class="form-container">
            <h2>Reservation</h2>
            <div class="form-subtitle">Đặt bàn trước để có trải nghiệm trọn vẹn nhất</div>
            
            <a href="${pageContext.request.contextPath}/dashboard.jsp" class="back-link">← Quay lại Dashboard</a>
            
            <!-- Thông báo trạng thái xử lý dữ liệu -->
            <c:if test="${not empty message}">
                <div class="alert-success"><strong>${message}</strong></div>
            </c:if>

            <form action="${pageContext.request.contextPath}/reservation" method="post">
                <div class="form-group">
                    <label>Ngày đến</label>
                    <input type="date" name="date" required>
                </div>
                <div class="form-group">
                    <label>Giờ đến</label>
                    <input type="time" name="time" required>
                </div>
                <div class="form-group">
                    <label>Số lượng khách</label>
                    <input type="number" name="guests" min="1" max="50" value="2" required>
                </div>
                <div class="form-group">
                    <label>Ghi chú đặc biệt (Tùy chọn)</label>
                    <textarea name="note" rows="3" placeholder="Ví dụ: Cần không gian yên tĩnh, dị ứng thực phẩm..."></textarea>
                </div>
                <button type="submit" class="btn-submit">Xác Nhận Đặt Bàn</button>
            </form>
        </div>
    </div>

</body>
</html>