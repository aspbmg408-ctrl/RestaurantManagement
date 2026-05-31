package asm.controller;

import java.io.IOException;

import asm.dao.DishDAO;
import asm.model.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/add-dish")
public class AddDishServlet extends HttpServlet {
    private DishDAO dishDAO = new DishDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/add-dish.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8"); // Chống lỗi font tiếng Việt
        
        // Nhận dữ liệu từ form
        Dish dish = new Dish();
        dish.setName(req.getParameter("name"));
        dish.setPrice(Double.parseDouble(req.getParameter("price")));
        dish.setCategory(req.getParameter("category"));
        dish.setDescription(req.getParameter("description"));
        dish.setAvailable(true); // Mặc định là đang bán

        // Lưu xuống DB
        if (dishDAO.addDish(dish)) {
            req.setAttribute("message", "Đã thêm món: " + dish.getName() + " thành công!");
        } else {
            req.setAttribute("message", "Thêm món thất bại!");
        }
        req.getRequestDispatcher("/add-dish.jsp").forward(req, resp);
    }
}