<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Hội Viên - Marcel</title>
    <!-- Nhúng cặp phông chữ hoàng gia từ Google Fonts giống trang chủ -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Thiết lập nền móng tổng thể */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            /* Hình nền không gian nhà hàng fine-dining làm mờ ẩn hiện phía sau */
            background: linear-gradient(rgba(10, 12, 22, 0.88), rgba(10, 12, 22, 0.88)), 
                        url('https://images.unsplash.com/photo-1544025162-8366fd061595?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        /* Khung đăng ký phong cách hộp trang sức cao cấp */
        .register-box { 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            max-width: 460px; 
            width: 100%;
            padding: 50px 40px; 
            border: 1px solid #d4af37; /* Viền vàng đồng mỏng tinh tế */
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
        }

        /* Tiêu đề Đăng Ký nghệ thuật */
        .register-box h2 {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 2px;
            color: #fff;
            margin-bottom: 8px;
            text-align: center;
            text-transform: uppercase;
        }
        .register-subtitle {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 14px;
            margin-bottom: 35px;
            text-align: center;
            letter-spacing: 0.5px;
        }

        /* Các khối nhập liệu phẳng (Flat UI) */
        .form-group { 
            margin-bottom: 22px; 
            text-align: left; 
        }
        .form-group label { 
            display: block; 
            font-size: 11px;
            font-weight: 600; 
            margin-bottom: 8px; 
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: #d4af37;
        }
        .form-group input { 
            width: 100%; 
            padding: 13px 16px; 
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(212, 175, 55, 0.25); 
            color: #fff;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-group input:focus {
            outline: none;
            border-color: #d4af37;
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.15);
        }

        /* Nút bấm Hoàn tất đăng ký Thượng hạng */
        .btn-submit { 
            background: #d4af37; 
            color: #111424; 
            border: 1px solid #d4af37; 
            padding: 15px; 
            width: 100%; 
            font-size: 13px; 
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            cursor: pointer; 
            transition: all 0.4s ease;
            margin-top: 10px;
            margin-bottom: 25px;
        }
        .btn-submit:hover { 
            background: transparent; 
            color: #d4af37; 
        }

        /* Đường dẫn đăng nhập điều hướng bên dưới */
        .link-login { 
            display: block; 
            text-align: center; 
            text-decoration: none; 
            color: #aaa;
            font-size: 12px; 
            transition: color 0.3s;
            font-weight: 400;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            padding-top: 25px;
            margin-top: 10px;
            letter-spacing: 0.5px;
        }
        .link-login:hover { 
            color: #d4af37; 
            text-decoration: underline;
        }

        /* Khung hiển thị thông báo lỗi từ hệ thống */
        .error { 
            background-color: rgba(214, 48, 49, 0.15);
            color: #ff7675; 
            padding: 12px; 
            border: 1px solid rgba(214, 48, 49, 0.3);
            font-size: 13px;
            margin-bottom: 25px; 
            text-align: center;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

    <div class="register-box">
        <h2>Membership</h2>
        <div class="register-subtitle">Trở thành mảnh ghép đặc quyền tại Marcel</div>
        
        <!-- Khung hiển thị thông báo lỗi đăng ký nếu trùng tài khoản/email -->
        <c:if test="${not empty message}">
            <div class="error">⚠️ ${message}</div>
        </c:if>
        
        <!-- Form gửi dữ liệu lên xử lý tại RegisterServlet -->
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label>Tài khoản (Tên đăng nhập)</label>
                <input type="text" name="username" placeholder="Nhập tên tài khoản" required autocomplete="off">
            </div>
            
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>
            
            <div class="form-group">
                <label>Họ và tên</label>
                <input type="text" name="fullname" placeholder="Nhập họ và tên của bạn" required>
            </div>
            
            <div class="form-group">
                <label>Email liên hệ</label>
                <input type="email" name="email" placeholder="viethoang@example.com" required>
            </div>
            
            <button type="submit" class="btn-submit">Hoàn tất đăng ký</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/login" class="link-login">Đã có tài khoản? Đăng nhập ngay</a>
    </div>

</body>
</html>