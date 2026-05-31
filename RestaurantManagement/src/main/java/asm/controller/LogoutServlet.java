package asm.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy phiên làm việc hiện tại
        HttpSession session = req.getSession(false);
        if (session != null) {
            // Hủy bỏ toàn bộ dữ liệu User đã lưu
            session.invalidate(); 
        }
        // Đá người dùng về lại trang đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}