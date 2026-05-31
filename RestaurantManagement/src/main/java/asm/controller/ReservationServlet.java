package asm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/reservation.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        // 1. Hứng dữ liệu khách nhập
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        String guests = req.getParameter("guests");
        String note = req.getParameter("note");
        if (note == null || note.trim().isEmpty()) {
            note = "Không có";
        }
        
        // 2. Lấy tên người đang đăng nhập
        HttpSession session = req.getSession();
        asm.model.User user = (asm.model.User) session.getAttribute("currentUser");
        String customerName = (user != null) ? user.getFullname() : "Khách vãng lai";

        // 3. Móc bộ nhớ chung của Nhà hàng ra
        List<String> orderList = (List<String>) getServletContext().getAttribute("orderList");
        if (orderList == null) {
            orderList = new ArrayList<>();
        }
        
        // 4. In một cái "Phiếu đặt bàn" (Thiết kế khác màu với phiếu gọi món để Bếp dễ nhìn)
        String reservationTicket = "📅 <strong>ĐẶT BÀN</strong> | Khách: <strong>" + customerName + "</strong> | Thời gian: <span style='color:#007bff; font-weight:bold;'>" + time + " ngày " + date + "</span> | Số lượng: <strong>" + guests + " người</strong> | Ghi chú: <i>" + note + "</i> | Trạng thái: <span style='color:orange;'>⏳ Chờ xác nhận</span>";
        
        // Nhét vào danh sách và lưu lại
        orderList.add(reservationTicket);
        getServletContext().setAttribute("orderList", orderList);
        
        // 5. Gửi thông báo thành công về lại màn hình khách hàng
        req.setAttribute("message", "🎉 Đặt bàn thành công cho " + guests + " người vào lúc " + time + " ngày " + date + ". Nhà hàng sẽ gọi điện xác nhận sớm!");
        req.getRequestDispatcher("/reservation.jsp").forward(req, resp);
    }
}