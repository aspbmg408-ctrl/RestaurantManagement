<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký Tài khoản Khách hàng</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .register-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0px 0px 10px 0px #0000001a; width: 350px; }
        .register-box h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-submit { width: 100%; padding: 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px; }
        .btn-submit:hover { background-color: #0056b3; }
        .error { color: red; text-align: center; margin-bottom: 15px; }
        .link-login { display: block; text-align: center; margin-top: 15px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="register-box">
        <h2>ĐĂNG KÝ HỘI VIÊN</h2>
        
        <c:if test="${not empty message}">
            <div class="error">${message}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label>Tài khoản (Tên đăng nhập)</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>Họ và tên</label>
                <input type="text" name="fullname" required>
            </div>
            <div class="form-group">
                <label>Email liên hệ</label>
                <input type="email" name="email" required>
            </div>
            <button type="submit" class="btn-submit">Hoàn tất đăng ký</button>
        </form>
        <a href="${pageContext.request.contextPath}/login" class="link-login">Đã có tài khoản? Đăng nhập ngay</a>
    </div>
</body>
</html>