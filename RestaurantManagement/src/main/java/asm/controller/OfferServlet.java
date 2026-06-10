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
import jakarta.servlet.http.HttpSession;

@WebServlet("/offers")
public class OfferServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // Anh lưu ý chỗ "user" này nhé, có thể anh đặt tên khác lúc login
        User loggedInUser = (User) session.getAttribute("currentUser");
        
        System.out.println("=== KIỂM TRA CHỨC NĂNG VOUCHER ===");
        if (loggedInUser == null) {
            System.out.println("❌ LỖI: Session 'user' bị NULL. Có thể LoginServlet của anh đang lưu bằng biến 'account', 'acc', hoặc anh chưa đăng nhập!");
        } else {
            System.out.println("✅ Tài khoản đang xem: " + loggedInUser.getUsername());
            
            List<String> myVouchers = userDAO.getVouchersByUsername(loggedInUser.getUsername());
            System.out.println("✅ Số lượng mã lấy được từ SQL: " + myVouchers.size());
            
            req.setAttribute("myVouchers", myVouchers);
        }
        System.out.println("==================================");
        
        req.getRequestDispatcher("/offers.jsp").forward(req, resp);
    }
}