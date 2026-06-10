package asm.controller;

import java.io.IOException;

import asm.dao.UserDAO;
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
        
        // MỚI: Lấy thêm mã voucher được gửi từ giao diện web xuống
        String voucherCode = req.getParameter("voucherCode");

        // Kiểm tra xem Admin có truyền đủ thông tin không
        if (username != null && action != null && voucherCode != null && !voucherCode.isEmpty()) {
            
            // Nếu bấm nút Cấp (+)
            if ("add".equals(action)) {
                userDAO.processVoucher(username, voucherCode, true);
            } 
            // Nếu bấm nút Thu hồi (-)
            else if ("remove".equals(action)) {
                userDAO.processVoucher(username, voucherCode, false);
            }
        }
        
        // Cấp phát hoặc thu hồi xong thì tự động load lại trang danh sách khách hàng
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}