package asm.controller;

import java.io.IOException;

import asm.dao.UserDAO;
import asm.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hỗ trợ gõ tiếng Việt không bị lỗi font
        req.setCharacterEncoding("UTF-8");

        // 1. Phải lấy dữ liệu từ form trước tiên
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");

        // 2. CHỐT CHẶN: Kiểm tra xem Email đã bị ai dùng chưa
        if (userDAO.checkEmailExist(email)) {
            // Đã tồn tại -> Báo lỗi và dừng luôn
            req.setAttribute("message", "❌ Email này đã được đăng ký. Vui lòng dùng Email khác!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return; 
        }

        // 3. Nếu Email an toàn -> Đóng gói vào đối tượng User
        User newUser = new User();
        newUser.setUsername(user);
        newUser.setPassword(pass);
        newUser.setFullname(fullname);
        newUser.setEmail(email);
        newUser.setIsActive(true);
        // Quan trọng nhất: Ép quyền mặc định là Khách Hàng
        newUser.setRole("CUSTOMER"); 

        // 4. Gọi DAO lưu xuống DB
        boolean isSuccess = userDAO.registerUser(newUser);

        if (isSuccess) {
            // Đăng ký thành công, đẩy về trang đăng nhập
            req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } else {
            // Thất bại (Tên tài khoản trùng)
            req.setAttribute("message", "❌ Tên tài khoản đã tồn tại, vui lòng chọn tên khác!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}