package asm.dao;

import java.util.List; // Bắt buộc phải có dòng này để dùng List

import asm.model.User;
import asm.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserDAO {
    
    // Hàm 1: Kiểm tra Đăng nhập
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
            em.close();
        }
    }

    // Hàm 2: Đăng ký tài khoản mới
    public boolean registerUser(User user) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user); // Lệnh lưu đối tượng vào SQL Server
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            em.getTransaction().rollback(); // Nếu lỗi thì hoàn tác
            return false;
        } finally {
            em.close();
        }
    }

    // Hàm 3: Kiểm tra xem Email đã bị ai dùng chưa
    public boolean checkEmailExist(String email) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            Long count = em.createQuery(jpql, Long.class)
                           .setParameter("email", email)
                           .getSingleResult();
            return count > 0; // Nếu lớn hơn 0 tức là đã có người dùng
        } catch (Exception e) {
            return false;
        } finally {
            em.close();
        }
    } // <--- Ban nãy anh bị thiếu mất dấu ngoặc nhọn này ở đây!

    // Hàm 4: Lấy toàn bộ danh sách tài khoản
    public List<User> getAllUsers() {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u";
            return em.createQuery(jpql, User.class).getResultList();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    // Hàm 5: Tìm kiếm khách hàng theo Tên hoặc Email
    public List<User> searchUsers(String keyword) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            // Dùng LIKE để tìm kiếm gần đúng (chứa từ khóa là ra)
            String jpql = "SELECT u FROM User u WHERE u.fullname LIKE :kw OR u.email LIKE :kw";
            return em.createQuery(jpql, User.class)
                     .setParameter("kw", "%" + keyword + "%")
                     .getResultList();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
    public User getUserByUsername(String username) {
        String query = "SELECT * FROM Users WHERE Username = ?";
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=RestaurantDB;encrypt=true;trustServerCertificate=true;", "sa", "0938090938")) {
            java.sql.PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            java.sql.ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUsername(rs.getString("Username"));
                u.setFullname(rs.getString("Fullname"));
                u.setVoucherCount(rs.getInt("VoucherCount"));
                u.setRole(rs.getString("Role"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        String query = "UPDATE Users SET VoucherCount = ? WHERE Username = ?";
        try (java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=RestaurantDB;encrypt=true;trustServerCertificate=true;", "sa", "0938090938")) {
            java.sql.PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, user.getVoucherCount());
            ps.setString(2, user.getUsername());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}