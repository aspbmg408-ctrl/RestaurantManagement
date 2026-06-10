package asm.controller;

import java.io.IOException;

import asm.dao.UserDAO;
import asm.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/use-voucher")
public class UseVoucherServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin khách hàng đang đăng nhập từ Session
        User loggedInUser = (User) req.getSession().getAttribute("currentUser");
        
        // Lấy mã voucher khách vừa bấm từ URL
        String code = req.getParameter("code");

        if (loggedInUser != null && code != null) {
            // Tận dụng hàm processVoucher: Tham số false nghĩa là "Thu hồi / Đã dùng"
            userDAO.processVoucher(loggedInUser.getUsername(), code, false);
        }
        
        // Dùng xong thì load lại trang Kho Voucher, thẻ sẽ tự động biến mất!
        resp.sendRedirect(req.getContextPath() + "/offers");
    }
}