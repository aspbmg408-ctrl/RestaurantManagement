<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ưu Đãi Hội Viên</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f9fa; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .voucher-card { background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%); padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        .voucher-info h3 { margin: 0 0 10px 0; color: #d63031; font-size: 24px; }
        .voucher-info p { margin: 0; color: #2d3436; font-size: 16px; }
        .btn-use { background: #d63031; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <h2>⭐ KHO VOUCHER CỦA BẠN</h2>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" style="text-decoration: none; color: #007bff; display: inline-block; margin-bottom: 20px;">⬅ Quay lại Dashboard</a>
        
        <div class="voucher-card">
            <div class="voucher-info">
                <h3>GIẢM 10% TỔNG BILL</h3>
                <p>Áp dụng cho hóa đơn từ 500k. Hạn sử dụng: 31/12/2026</p>
            </div>
            <button class="btn-use" onclick="alert('Đã lưu mã: CHIPICHAPA10. Vui lòng đọc mã này cho nhân viên khi thanh toán!')">Dùng Ngay</button>
        </div>

        <div class="voucher-card" style="background: linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 100%);">
            <div class="voucher-info">
                <h3 style="color: #0984e3;">TẶNG 01 TRÁNG MIỆNG</h3>
                <p>Nhận ngay 1 phần bánh ngọt khi đặt bàn trước 24h.</p>
            </div>
            <button class="btn-use" style="background: #0984e3;" onclick="alert('Đã lưu mã: FREEDESSERT')">Dùng Ngay</button>
        </div>
    </div>
</body>
</html>