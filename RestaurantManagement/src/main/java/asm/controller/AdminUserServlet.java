package asm.controller;

import java.io.IOException;
import java.util.List;

import asm.dao.UserDAO;
import asm.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String keyword = req.getParameter("keyword");
        List<User> users;

        // Nếu Admin có gõ tìm kiếm thì gọi hàm search, không thì lấy tất cả
        if (keyword != null && !keyword.trim().isEmpty()) {
            users = userDAO.searchUsers(keyword.trim());
            req.setAttribute("keyword", keyword); // Giữ lại từ khóa trên thanh search
        } else {
            users = userDAO.getAllUsers();
        }

        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin-user.jsp").forward(req, resp);
    }
}