<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Khách Hàng & Voucher</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f8f9fa; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .search-box { display: flex; gap: 10px; margin-bottom: 20px; }
        .search-box input { flex: 1; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px; }
        .search-box button { padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #343a40; color: white; }
        .badge-admin { background: #dc3545; color: white; padding: 3px 8px; border-radius: 12px; font-size: 12px; }
        .badge-customer { background: #28a745; color: white; padding: 3px 8px; border-radius: 12px; font-size: 12px; }
        .btn-add { background: #28a745; color: white; text-decoration: none; padding: 6px 12px; border-radius: 4px; font-weight: bold; font-size: 13px; display: inline-block; margin-right: 5px; }
        .btn-remove { background: #dc3545; color: white; text-decoration: none; padding: 6px 12px; border-radius: 4px; font-weight: bold; font-size: 13px; display: inline-block; }
    </style>
</head>
<body>
    <div class="container">
        <h2>👥 QUẢN LÝ KHÁCH HÀNG & NHÂN SỰ</h2>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" style="text-decoration: none; color: #007bff; display: inline-block; margin-bottom: 20px;">⬅ Quay lại Dashboard</a>
        
        <form action="${pageContext.request.contextPath}/admin/users" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="Nhập tên hoặc email khách hàng cần tìm..." value="${keyword}">
            <button type="submit">🔍 Tìm Kiếm</button>
            <a href="${pageContext.request.contextPath}/admin/users" style="padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px; font-weight: bold;">Làm mới</a>
        </form>

        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Họ và Tên</th>
                    <th>Email</th>
                    <th>Quyền</th>
                    <th>Kho Voucher</th> <th>Thao tác Cấp / Thu hồi</th> </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty users}">
                        <tr><td colspan="6" style="text-align:center; color:red;">Không tìm thấy kết quả nào phù hợp.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${users}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td><strong>${u.fullname}</strong><br><small style="color:gray;">${u.username}</small></td>
                                <td>${u.email}</td>
                                <td>
                                    <span class="${u.role == 'ADMIN' ? 'badge-admin' : 'badge-customer'}">${u.role}</span>
                                </td>
                                
                                <td style="font-weight: bold; font-size: 16px; color: #d63031;">
                                    🎟️ ${u.voucherCount != null ? u.voucherCount : 0}
                                </td>
                                
                                <td>
                                    <c:if test="${u.role == 'CUSTOMER'}">
                                        <a href="${pageContext.request.contextPath}/admin/voucher?action=add&username=${u.username}" class="btn-add">➕ Cấp vé</a>
                                        <a href="${pageContext.request.contextPath}/admin/voucher?action=remove&username=${u.username}" class="btn-remove">➖ Thu hồi</a>
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