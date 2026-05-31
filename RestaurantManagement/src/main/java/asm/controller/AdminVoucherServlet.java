package asm.controller;

import java.io.IOException;

import asm.dao.UserDAO;
import asm.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/voucher")
public class AdminVoucherServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String action = req.getParameter("action");

        // Kiểm tra xem Admin vừa bấm nút của ai và hành động là gì
        if (username != null && action != null) {
            User u = userDAO.getUserByUsername(username);
            
            if (u != null) {
                // Nếu bấm nút Cộng (+)
                if ("add".equals(action)) {
                    u.setVoucherCount(u.getVoucherCount() + 1);
                } 
                // Nếu bấm nút Trừ (-) và số vé đang lớn hơn 0
                else if ("remove".equals(action) && u.getVoucherCount() > 0) {
                    u.setVoucherCount(u.getVoucherCount() - 1);
                }
                
                // Lưu trạng thái mới xuống Database
                userDAO.updateUser(u);
            }
        }
        
        // Cấp phát xong thì load lại trang danh sách khách hàng
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}