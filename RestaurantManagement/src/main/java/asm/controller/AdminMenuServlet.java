package asm.controller;

import java.io.IOException;
import java.util.List;

import asm.dao.DishDAO;
import asm.model.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/menu")
public class AdminMenuServlet extends HttpServlet {
    private DishDAO dishDAO = new DishDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách toàn bộ món ăn
        List<Dish> dishes = dishDAO.getAllDishes();
        
        // Gửi sang trang quản lý của Admin
        req.setAttribute("dishes", dishes);
        req.getRequestDispatcher("/admin-menu.jsp").forward(req, resp);
    }
}