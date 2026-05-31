<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hệ Thống Quản Lý Nhà Hàng</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }
        .landing-box { 
            background: white; 
            padding: 40px; 
            border-radius: 12px; 
            box-shadow: 0px 10px 20px rgba(0,0,0,0.1); 
            text-align: center;
            width: 450px;
        }
        .landing-box h1 { 
            color: #2c3e50; 
            margin-bottom: 10px;
            font-size: 28px;
        }
        .landing-box p {
            color: #7f8c8d;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            gap: 15px;
        }
        .btn { 
            flex: 1;
            padding: 12px 0; 
            text-decoration: none; 
            border-radius: 6px; 
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .btn-login { 
            background-color: #28a745; 
            color: white; 
            border: 2px solid #28a745;
        }
        .btn-login:hover { 
            background-color: #218838; 
        }
        .btn-register { 
            background-color: transparent; 
            color: #007bff; 
            border: 2px solid #007bff;
        }
        .btn-register:hover { 
            background-color: #007bff;
            color: white;
        }
        .icon-logo {
            font-size: 50px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="landing-box">
        <div class="icon-logo">🍽️</div>
        <h1>Nhà Hàng Âu</h1>
        <p>Hệ thống đặt bàn và quản lý thực đơn thông minh.<br>Vui lòng chọn thao tác để tiếp tục.</p>
        
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Đăng Nhập</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-register">Đăng Ký Mới</a>
        </div>
    </div>
</body>
</html>