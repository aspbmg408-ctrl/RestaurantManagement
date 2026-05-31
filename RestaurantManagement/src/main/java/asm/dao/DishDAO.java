package asm.dao;

import java.util.List;

import asm.model.Dish;
import asm.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class DishDAO {
    
    // 1. Dành cho Admin: Thêm món ăn mới vào Menu
    public boolean addDish(Dish dish) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(dish);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    // 2. Dành cho Khách hàng: Lấy danh sách tất cả món ăn đang được bán
    public List<Dish> getAllDishes() {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            String jpql = "SELECT d FROM Dish d WHERE d.available = true";
            TypedQuery<Dish> query = em.createQuery(jpql, Dish.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
 // 3. Lấy đúng 1 món ăn theo ID để hiển thị lên form Sửa
    public Dish getDishById(Long id) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            return em.find(Dish.class, id); // Tìm theo khóa chính
        } finally {
            em.close();
        }
    }

    // 4. Lưu thông tin món ăn đã bị Sửa
    public boolean updateDish(Dish dish) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(dish); // merge dùng để Cập nhật (Update)
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    // 5. Xóa món ăn khỏi DB
    public boolean deleteDish(Long id) {
        EntityManager em = JpaUtils.getEntityManager();
        try {
            em.getTransaction().begin();
            Dish dish = em.find(Dish.class, id);
            if (dish != null) {
                em.remove(dish); // Lệnh xóa
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }
}