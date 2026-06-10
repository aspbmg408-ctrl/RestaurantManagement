package asm.controller;

import asm.dao.DishDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/delete-dish")
public class DeleteDishServlet extends HttpServlet {
    private DishDAO dishDAO = new DishDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            Long id = Long.parseLong(idParam);
            dishDAO.deleteDish(id); // Xóa trong Database
        }
        // Xóa xong thì load lại trang danh sách món ăn
        resp.sendRedirect(req.getContextPath() + "/admin/menu");
    }
}