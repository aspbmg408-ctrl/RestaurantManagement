package asm.controller;

import java.io.IOException;

import asm.dao.DishDAO;
import asm.model.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/edit-dish")
public class EditDishServlet extends HttpServlet {
    private DishDAO dishDAO = new DishDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy ID món ăn cần sửa, móc dữ liệu lên và ném sang file JSP
        Long id = Long.parseLong(req.getParameter("id"));
        Dish dish = dishDAO.getDishById(id);
        req.setAttribute("dish", dish);
        req.getRequestDispatcher("/edit-dish.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        // Hứng dữ liệu mới Admin vừa gõ
        Dish dish = new Dish();
        dish.setId(Long.parseLong(req.getParameter("id"))); // Phải có ID để biết sửa món nào
        dish.setName(req.getParameter("name"));
        dish.setPrice(Double.parseDouble(req.getParameter("price")));
        dish.setCategory(req.getParameter("category"));
        dish.setDescription(req.getParameter("description"));
        
        // Checkbox trạng thái: Nếu có tích (on) thì là true, ngược lại false
        dish.setAvailable(req.getParameter("available") != null); 

        dishDAO.updateDish(dish); // Lưu xuống DB
        
        // Sửa xong quay lại bảng danh sách
        resp.sendRedirect(req.getContextPath() + "/admin/menu");
    }
}