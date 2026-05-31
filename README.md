🍽️ Restaurant Management System
Chào mừng đến với dự án Quản lý Nhà hàng. Đây là hệ thống web giúp quản lý thông tin khách hàng, thực đơn và voucher, được xây dựng bằng Java Web, Hibernate, và SQL Server.

🚀 Tính năng chính
Quản lý Voucher: Thêm, sửa, xóa và cấp phát voucher cho khách hàng.

Dashboard quản trị: Xem tổng quan số lượng khách hàng và các chỉ số liên quan.

Bảo mật: Hệ thống đăng nhập/đăng xuất an toàn.

🛠️ Công nghệ sử dụng
Backend: Java (Jakarta EE), Servlets.

Database: SQL Server.

ORM: Hibernate.

Server: Apache Tomcat 11.0.21.

📋 Hướng dẫn cài đặt
Để chạy dự án này trên máy cá nhân, vui lòng làm theo các bước sau:

1. Chuẩn bị Database
Mở SQL Server Management Studio (SSMS).

Tạo database mới với tên: RestaurantDB.

Chạy script SQL có trong thư mục /database/RestaurantDB.sql của dự án để tạo các bảng cần thiết.

2. Thiết lập dự án
Clone dự án về máy:
git clone [https://github.com/aspbmg408-ctrl/RestaurantManagement.git](https://github.com/aspbmg408-ctrl/RestaurantManagement.git)

Import dự án vào Eclipse IDE dưới dạng Existing Maven Project.

Kiểm tra file UserDAO.java để đảm bảo chuỗi kết nối Database (Connection String) đã khớp với cấu hình máy bạn.

3. Cấu hình Server
Cài đặt Apache Tomcat 11.0.21.

Add dự án vào Server Tomcat trong Eclipse.

Nhấn Run trên Server. Truy cập đường dẫn: http://localhost:8080/RestaurantManagement

 Tác giả
Phùng Vũ Chính Cương
Sinh viên FPT Polytechnic
