<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập Hệ thống Nhà hàng</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0px 0px 10px 0px #0000001a; width: 300px; }
        .login-box h2 { text-align: center; margin-bottom: 20px; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-login { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-login:hover { background-color: #218838; }
        .error { color: red; text-align: center; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>ĐĂNG NHẬP</h2>
        <c:if test="${not empty message}">
            <div class="error">${message}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
        <div style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/" style="text-decoration: none; color: #6c757d; margin-right: 15px;">🏠 Trang chủ</a>
            <a href="${pageContext.request.contextPath}/register" style="text-decoration: none; color: #007bff;">Chưa có tài khoản?</a>
        </div>
            <div class="form-group">
                <label>Tài khoản</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn-login">Đăng nhập</button>
        </form>
    </div>
</body>
</html>