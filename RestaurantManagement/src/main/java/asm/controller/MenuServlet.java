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

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private DishDAO dishDAO = new DishDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Rút toàn bộ món ăn từ DB
        List<Dish> menuList = dishDAO.getAllDishes();
        
        // Đóng gói gửi sang giao diện JSP
        req.setAttribute("dishes", menuList);
        req.getRequestDispatcher("/menu.jsp").forward(req, resp);
    }
}