package asm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import asm.dao.DishDAO;
import asm.model.CartItem;
import asm.model.Dish;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private DishDAO dishDAO = new DishDAO();

    private void updateTotalQuantity(HttpSession session, List<CartItem> cart) {
        int totalQty = 0;
        for (CartItem item : cart) {
            totalQty += item.getQuantity();
        }
        session.setAttribute("totalQuantity", totalQty);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if ("add".equals(action)) {
            Long dishId = Long.parseLong(req.getParameter("id"));
            Dish selectedDish = null;
            for (Dish d : dishDAO.getAllDishes()) {
                if (d.getId().equals(dishId)) {
                    selectedDish = d;
                    break;
                }
            }
            if (selectedDish != null) {
                boolean exists = false;
                for (CartItem item : cart) {
                    if (item.getDish().getId().equals(dishId)) {
                        item.setQuantity(item.getQuantity() + 1);
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    cart.add(new CartItem(selectedDish, 1));
                }
            }
            session.setAttribute("cart", cart);
            updateTotalQuantity(session, cart);
            resp.sendRedirect(req.getContextPath() + "/menu");
        } 
        else if ("remove".equals(action)) {
            Long dishId = Long.parseLong(req.getParameter("id"));
            cart.removeIf(item -> item.getDish().getId().equals(dishId));
            session.setAttribute("cart", cart);
            updateTotalQuantity(session, cart);
            resp.sendRedirect(req.getContextPath() + "/cart?action=view");
        }
        else if ("checkout".equals(action)) {
            if (!cart.isEmpty()) {
                List<String> orderList = (List<String>) getServletContext().getAttribute("orderList");
                if (orderList == null) {
                    orderList = new ArrayList<>();
                }
                
                double total = 0;
                StringBuilder details = new StringBuilder();
                for (CartItem item : cart) {
                    total += item.getTotalPrice();
                    details.append("<b>").append(item.getQuantity()).append("</b>x ").append(item.getDish().getName()).append("; ");
                }
                
                // --- TÍNH TOÁN VÀ CỘNG DỒN DOANH THU THẬT ---
                Double totalRevenue = (Double) getServletContext().getAttribute("totalRevenue");
                if (totalRevenue == null) {
                    totalRevenue = 0.0;
                }
                totalRevenue += total; // Cộng tiền đơn này vào tổng doanh thu
                getServletContext().setAttribute("totalRevenue", totalRevenue);
                // ------------------------------------------

                asm.model.User user = (asm.model.User) session.getAttribute("currentUser");
                String customerName = (user != null) ? user.getFullname() : "Khách vãng lai";
                
                String receipt = "Khách hàng: <strong>" + customerName + "</strong> | Chi tiết: " + details.toString() + " | Tổng: <span style='color:red;'>" + total + " VNĐ</span>";
                orderList.add(receipt);
                getServletContext().setAttribute("orderList", orderList);

                session.removeAttribute("cart");
                session.setAttribute("totalQuantity", 0);
                req.setAttribute("message", "🎉 Đặt bàn và thanh toán thành công! Nhà hàng sẽ chuẩn bị món ngay.");
                req.getRequestDispatcher("/cart.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/menu");
            }
        }
        else if ("view".equals(action)) {
            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
        }
    }
}