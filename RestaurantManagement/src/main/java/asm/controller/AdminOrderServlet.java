package asm.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        // Nếu Admin bấm nút Xong
        if ("complete".equals(action)) {
            String indexStr = req.getParameter("index");
            if (indexStr != null) {
                int index = Integer.parseInt(indexStr);
                List<String> orderList = (List<String>) getServletContext().getAttribute("orderList");
                
                // Xóa đơn hàng đó khỏi hệ thống bộ nhớ
                if (orderList != null && index >= 0 && index < orderList.size()) {
                    orderList.remove(index);
                    getServletContext().setAttribute("orderList", orderList);
                }
            }
            // Load lại trang Orders
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }
        
        req.getRequestDispatcher("/admin-order.jsp").forward(req, resp);
    }
}