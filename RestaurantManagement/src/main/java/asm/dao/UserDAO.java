package asm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import asm.model.User;
import asm.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserDAO {
    
    // --- THÔNG TIN KẾT NỐI JDBC ---
    private final String dbUrl = "jdbc:sqlserver://localhost:1433;databaseName=RestaurantDB;encrypt=true;trustServerCertificate=true;";
    private final String dbUser = "sa";
    private final String dbPass = "123";

    // --- CÁC HÀM JPA HIỆN TẠI ---

    public User checkLogin(String username, String password) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username = :user AND u.password = :pass AND u.isActive = true";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("user", username);
            query.setParameter("pass", password);
            return query.getSingleResult();
        } catch (Exception e) {
            return null; 
        } finally {
            if (em != null) em.close();
        }
    }

    public boolean registerUser(User user) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user); 
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            em.getTransaction().rollback(); 
            return false;
        } finally {
            if (em != null) em.close();
        }
    }

    public boolean checkEmailExist(String email) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            Long count = em.createQuery(jpql, Long.class)
                           .setParameter("email", email)
                           .getSingleResult();
            return count > 0; 
        } catch (Exception e) {
            return false;
        } finally {
            if (em != null) em.close();
        }
    } 

    public List<User> getAllUsers() {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u";
            return em.createQuery(jpql, User.class).getResultList();
        } catch (Exception e) {
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    public List<User> searchUsers(String keyword) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.fullname LIKE :kw OR u.email LIKE :kw";
            return em.createQuery(jpql, User.class)
                     .setParameter("kw", "%" + keyword + "%")
                     .getResultList();
        } catch (Exception e) {
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    // --- CÁC HÀM JDBC HIỆN TẠI ---

    public User getUserByUsername(String username) {
        String query = "SELECT * FROM Users WHERE Username = ?";
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUsername(rs.getString("Username"));
                    u.setFullname(rs.getString("Fullname"));
                    u.setVoucherCount(rs.getInt("VoucherCount"));
                    u.setRole(rs.getString("Role"));
                    return u;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE Users SET VoucherCount = ? WHERE Username = ?";
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, user.getVoucherCount());
            ps.setString(2, user.getUsername());
            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- TÍNH NĂNG MỚI: LIÊN KẾT VOUCHER (Sử dụng Transaction) ---

    public boolean processVoucher(String username, String voucherCode, boolean isGrant) {
        String sqlUpdateUser = isGrant ? 
            "UPDATE Users SET VoucherCount = VoucherCount + 1 WHERE Username = ?" :
            "UPDATE Users SET VoucherCount = VoucherCount - 1 WHERE Username = ?";
            
        // CHÚ Ý: Đã sửa tên bảng thành Vouchers (có s) để khớp với database của anh
        String sqlUpdateVoucher = isGrant ?
            "UPDATE Vouchers SET Username = ?, Status = 1 WHERE VoucherCode = ?" :
            "UPDATE Vouchers SET Username = NULL, Status = 0 WHERE VoucherCode = ?";

        Connection conn = null;
        try {
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Cập nhật bảng Users
            try (PreparedStatement psUser = conn.prepareStatement(sqlUpdateUser)) {
                psUser.setString(1, username);
                psUser.executeUpdate();
            }

            // 2. Cập nhật bảng Vouchers
            try (PreparedStatement psVoucher = conn.prepareStatement(sqlUpdateVoucher)) {
                if (isGrant) {
                    psVoucher.setString(1, username);
                    psVoucher.setString(2, voucherCode);
                } else {
                    psVoucher.setString(1, voucherCode); // Thu hồi chỉ cần mã Voucher
                }
                psVoucher.executeUpdate();
            }

            conn.commit(); // Cả 2 đều thành công -> Xác nhận lưu
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Có lỗi -> Hủy bỏ toàn bộ quá trình
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
 // --- LẤY DANH SÁCH VOUCHER CỦA KHÁCH HÀNG ---
    public List<String> getVouchersByUsername(String username) {
        List<String> vouchers = new java.util.ArrayList<>();
        String query = "SELECT VoucherCode FROM Vouchers WHERE Username = ? AND Status = 1";
        
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    vouchers.add(rs.getString("VoucherCode"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vouchers;
    }
}