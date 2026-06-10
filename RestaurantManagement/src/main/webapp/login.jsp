<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập Hệ Thống - Marcel</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Đặt nền móng giao diện */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            /* Hình nền không gian nhà hàng fine-dining làm mờ ẩn hiện phía sau */
            background: linear-gradient(rgba(10, 12, 22, 0.88), rgba(10, 12, 22, 0.88)), 
                        url('https://images.unsplash.com/photo-1544025162-8366fd061595?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Khung đăng nhập phong cách hộp trang sức cao cấp */
        .login-box { 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            max-width: 420px; 
            width: 100%;
            padding: 50px 40px; 
            border: 1px solid #d4af37; /* Viền vàng đồng mỏng tinh tế */
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
            text-align: center;
        }

        /* Tiêu đề Đăng Nhập nghệ thuật */
        .login-box h2 {
            font-family: 'Playfair Display', serif;
            font-size: 30px;
            font-weight: 700;
            letter-spacing: 3px;
            color: #fff;
            margin-bottom: 8px;
            text-transform: uppercase;
        }
        .login-subtitle {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 14px;
            margin-bottom: 35px;
            letter-spacing: 0.5px;
        }

        /* Các khối nhập liệu phẳng (Flat UI) */
        .form-group { 
            margin-bottom: 25px; 
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
            padding: 14px 16px; 
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

        /* Nút bấm Đăng nhập Thượng hạng (Thay thế nút xanh cũ) */
        .btn-login { 
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
        .btn-login:hover { 
            background: transparent; 
            color: #d4af37; 
        }

        /* Khu vực liên kết chuyển hướng phía dưới */
        .login-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            padding-top: 20px;
            margin-top: 10px;
        }
        .login-footer a {
            text-decoration: none; 
            font-size: 12px; 
            transition: color 0.3s;
            font-weight: 400;
        }
        .link-home { color: #aaa; }
        .link-home:hover { color: #fff; }
        .link-register { color: #d4af37; font-weight: 500; }
        .link-register:hover { text-decoration: underline; }

        /* Khung hiển thị thông báo lỗi hệ thống */
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

    <div class="login-box">
        <h2>Sign In</h2>
        <div class="login-subtitle">Hệ thống quản lý nhà hàng Marcel</div>
        
        <c:if test="${not empty message}">
            <div class="error">⚠️ ${message}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Tên đăng nhập / Email</label>
                <input type="text" name="username" placeholder="Nhập tài khoản của bạn" required autocomplete="off">
            </div>
            
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="btn-login">Đăng Nhập Hệ Thống</button>
            
            <div class="login-footer">
                <a href="${pageContext.request.contextPath}/" class="link-home">🏠 Quay lại Trang chủ</a>
                <a href="${pageContext.request.contextPath}/register" class="link-register">Tạo tài khoản mới</a>
            </div>
        </form>
    </div>

</body>
</html>