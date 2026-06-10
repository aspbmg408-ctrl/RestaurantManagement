<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Khách Hàng & Đặc Quyền - Marcel</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* Thiết lập nền tảng không gian hoàng gia */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Montserrat', sans-serif; 
            background: linear-gradient(rgba(10, 12, 22, 0.94), rgba(10, 12, 22, 0.94)), 
                        url('https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            color: #fcfbf7; 
            min-height: 100vh;
            padding: 60px 40px;
        }

        /* Khung chứa pha lê mờ cao cấp */
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: rgba(17, 20, 36, 0.85); 
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 45px; 
            border: 1px solid #d4af37; /* Đường viền vàng thương hiệu độc bản */
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
        }

        /* Đường dẫn lội ngược dòng tinh tế */
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

        /* Tiêu đề vùng quản trị nghệ thuật */
        .header-section {
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            padding-bottom: 25px;
            margin-bottom: 35px;
        }
        .header-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            font-weight: 700;
            letter-spacing: 1px;
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

        /* Thanh Tìm Kiếm Hội Viên Sang Trọng */
        .search-box { 
            display: flex; 
            gap: 12px; 
            margin-bottom: 30px; 
        }
        .search-box input { 
            flex: 1; 
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(212, 175, 55, 0.25);
            padding: 12px 18px; 
            color: #fff;
            font-family: 'Montserrat', sans-serif;
            font-size: 14px; 
            transition: all 0.3s ease;
        }
        .search-box input:focus {
            outline: none;
            border-color: #d4af37;
            background: rgba(212, 175, 55, 0.05);
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.15);
        }
        .search-box button { 
            background: transparent;
            color: #d4af37;
            border: 1px solid #d4af37;
            padding: 12px 30px; 
            font-family: 'Montserrat', sans-serif;
            font-size: 12px;
            font-weight: 600; 
            text-transform: uppercase;
            letter-spacing: 1.5px;
            cursor: pointer; 
            transition: all 0.3s ease;
        }
        .search-box button:hover { 
            background: #d4af37; 
            color: #111424; 
        }

        /* Bảng Danh Sách Hội Viên */
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 15px; 
        }
        th, td { 
            padding: 16px 20px; 
            text-align: left; 
            vertical-align: middle;
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
        }

        /* Nhãn hiển thị vai trò (Badge) */
        .role-badge {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 4px 10px;
            border-radius: 2px;
            display: inline-block;
        }
        .role-admin {
            color: #d4af37;
            border: 1px solid rgba(212, 175, 55, 0.4);
            background: rgba(212, 175, 55, 0.05);
        }
        .role-customer {
            color: #aaa;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.02);
        }

        /* Form thao tác Voucher tinh gọn bên trong ô Table */
        .voucher-action-form {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .input-voucher {
            background: rgba(255, 255, 255, 0.03) !important;
            border: 1px solid rgba(212, 175, 55, 0.25) !important;
            color: #fff !important;
            padding: 8px 12px !important;
            font-family: 'Montserrat', sans-serif;
            font-size: 13px !important;
            width: 130px;
            transition: all 0.3s;
        }
        .input-voucher:focus {
            outline: none;
            border-color: #d4af37 !important;
            background: rgba(212, 175, 55, 0.05) !important;
        }
        
        /* Bộ đôi nút Cấp / Thu hồi phẳng */
        .btn-voucher-add {
            background: #d4af37;
            color: #111424;
            border: 1px solid #d4af37;
            padding: 8px 14px;
            font-family: 'Montserrat', sans-serif;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-voucher-add:hover {
            background: transparent;
            color: #d4af37;
        }
        .btn-voucher-remove {
            background: rgba(231, 76, 60, 0.1);
            color: #ff7675;
            border: 1px solid rgba(231, 76, 60, 0.3);
            padding: 8px 14px;
            font-family: 'Montserrat', sans-serif;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-voucher-remove:hover {
            background: #e74c3c;
            color: #fff;
            border-color: #e74c3c;
        }
    </style>
</head>
<body>

    <div class="container">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="back-link">← Quay lại Không gian điều khiển</a>
        
        <div class="header-section">
            <h2>User & Voucher Privilege</h2>
            <p>Quản trị cơ sở dữ liệu thượng khách và điều phối định ngạch ưu đãi Marcel</p>
        </div>

        <form action="${pageContext.request.contextPath}/admin/users" method="GET" class="search-box">
            <input type="text" name="search" placeholder="Nhập tên đăng nhập hoặc họ tên để tra cứu thông tin..." required>
            <button type="submit">Truy Vết</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Tài khoản</th>
                    <th>Danh tính thượng khách</th>
                    <th>Địa chỉ Email</th>
                    <th>Cấp bậc / Vai trò</th>
                    <th style="text-align: center;">Voucher sở hữu</th>
                    <th style="width: 360px; text-align: center;">Điều phối đặc quyền (Voucher)</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <%-- Nhánh kiểm tra điều kiện danh sách rỗng từ logic cũ của bạn --%>
                    <c:when test="${empty users}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #666; padding: 40px; font-style: italic;">
                                Không tìm thấy dữ liệu hội viên trùng khớp với từ khóa.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%-- Vòng lặp kết xuất thông tin thực thể người dùng --%>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td style="font-weight: 500; color: #aaa;">@${u.username}</td>
                                <td><strong>${u.fullname}</strong></td>
                                <td style="color: #999;">${u.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 'ADMIN'}">
                                            <span class="role-badge role-admin">Quản trị viên</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="role-badge role-customer">Hội viên</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center; font-weight: 600; font-size: 16px; color: #ff7675;">
                                    <span style="color: #d4af37; font-family: 'Playfair Display', serif; font-size: 18px;">
                                        ${u.voucherCount != null ? u.voucherCount : 0}
                                    </span>
                                </td>
                                <td>
                                    <%-- Form cấp phát thu hồi ưu đãi dành riêng cho Customer --%>
                                    <c:if test="${u.role == 'CUSTOMER'}">
                                        <form action="${pageContext.request.contextPath}/admin/voucher" method="GET" class="voucher-action-form">
                                            <input type="hidden" name="username" value="${u.username}">
                                            
                                            <input type="text" name="voucherCode" class="input-voucher" placeholder="Nhập mã ưu đãi..." required>
                                            
                                            <button type="submit" name="action" value="add" class="btn-voucher-add" title="Cấp phát mã này cho khách">➕ Cấp</button>
                                            <button type="submit" name="action" value="remove" class="btn-voucher-remove" title="Thu hồi mã này từ khách">➖ Thu hồi</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</body>
</html>