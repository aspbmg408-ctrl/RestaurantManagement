package asm.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtils {
    private static EntityManagerFactory factory;

    public static EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            // Tên "Asm_Restaurant" này khớp 100% với tên trong file persistence.xml
            factory = Persistence.createEntityManagerFactory("Asm_Restaurant");
        }
        return factory.createEntityManager();
    }
}