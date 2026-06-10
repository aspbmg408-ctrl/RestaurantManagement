<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Màn Hình Điều Phối Đơn Hàng & Bàn - Marcel</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            background: linear-gradient(rgba(10, 12, 22, 0.94), rgba(10, 12, 22, 0.94)), 
                        url('https://images.unsplash.com/photo-1543007630-9710e4a00a20?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            padding: 60px 40px;
        }
        .container { 
            max-width: 1000px; 
            margin: 0 auto; 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 45px; 
            border: 1px solid #d4af37; 
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
        }
        .back-link {
            display: inline-block;
            color: #aaa;
            text-decoration: none;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 20px;
            transition: color 0.3s;
        }
        .back-link:hover { color: #d4af37; }
        .header-section {
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding-bottom: 25px;
            margin-bottom: 35px;
        }
        .header-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 30px;
            font-weight: 700;
            letter-spacing: 1.5px;
            color: #fff;
            text-transform: uppercase;
        }
        .header-section p {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #d4af37;
            font-size: 15px;
            margin-top: 5px;
        }
        .order-card { 
            position: relative;
            padding: 25px 30px; 
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(212, 175, 55, 0.15); 
            border-left: 4px solid #d4af37; 
            margin-bottom: 20px; 
            font-size: 15px; 
            line-height: 1.8;
            color: #e0e0e0;
            transition: all 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-card:hover {
            background: rgba(212, 175, 55, 0.03);
            border-color: rgba(212, 175, 55, 0.4);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }
        .order-content {
            flex: 1;
            padding-right: 20px;
            font-weight: 400;
            letter-spacing: 0.3px;
        }
        .order-content b, .order-content strong {
            font-family: 'Playfair Display', serif;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
        }
        .btn-done { 
            background: #d4af37; 
            color: #111424; 
            border: 1px solid #d4af37; 
            padding: 10px 22px; 
            font-family: 'Montserrat', sans-serif;
            font-size: 11px; 
            font-weight: 600; 
            text-transform: uppercase;
            letter-spacing: 1.5px;
            text-decoration: none;
            cursor: pointer; 
            transition: all 0.4s ease;
            white-space: nowrap;
        }
        .btn-done:hover { 
            background: transparent; 
            color: #d4af37; 
        }
        .empty-message {
            color: #666; 
            font-style: italic; 
            text-align: center; 
            padding: 60px 20px;
            font-family: 'Playfair Display', serif;
            font-size: 16px;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="back-link">← Quay lại Không gian điều khiển</a>
        
        <div class="header-section">
            <h2>Live Order & Table Flow</h2>
            <p>Hệ thống giám sát thực tâm và điều phối bàn tiệc thời gian thực tại đại sảnh Marcel</p>
        </div>
        
        <div style="margin-top: 10px;">
            <c:choose>
                <c:when test="${empty applicationScope.orderList}">
                    <p class="empty-message">Hiện tại đại sảnh đang yên ắng, chưa ghi nhận lượt đặt bàn hoặc gọi món nào.</p>
                </c:when>
                <c:otherwise>
                    <%-- Đã khắc phục lỗi các dấu gạch chéo ngược (\) ở đây --%>
                    <c:forEach var="order" items="${applicationScope.orderList}" varStatus="loop">
                        <div class="order-card">
                            <div class="order-content">
                                ${order}
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/admin/order?action=remove&index=${loop.index}" class="btn-done">
                                    ✓ Hoàn tất & Dọn bàn
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>