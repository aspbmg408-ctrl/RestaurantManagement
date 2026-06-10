package asm.controller;

import java.io.IOException;

import asm.dao.UserDAO;
import asm.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    // Hàm GET: Dùng để hiển thị trang giao diện login.jsp
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    // Hàm POST: Dùng để xử lý dữ liệu khi người dùng bấm nút Đăng nhập
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        // Gọi DAO đi kiểm tra
        User loggedInUser = userDAO.checkLogin(user, pass);

        if (loggedInUser != null) {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", loggedInUser);
            
            // Chuyển hướng thẳng vào trang quản trị
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
            
        } else {
            // Nếu sai -> Báo lỗi và quay lại trang login
            req.setAttribute("message", "Sai tài khoản hoặc mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}