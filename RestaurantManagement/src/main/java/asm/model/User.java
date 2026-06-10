package asm.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Users") // Đảm bảo tên bảng trong SQL của anh khớp với tên này
public class User {
    
    @Id
    @Column(name = "Username", length = 50)
    private String username;
    
    @Column(name = "Password", length = 50)
    private String password;
    
    @Column(name = "Fullname", columnDefinition = "NVARCHAR(100)")
    private String fullname;
    
    @Column(name = "Email")
    private String email;
    
    // Cột Role để phân quyền: "ADMIN", "MANAGER", "CUSTOMER"
    @Column(name = "Role", length = 20)
    private String role = "CUSTOMER";
    
    // Biến lưu trữ số lượng Voucher khách hàng đang có
    @Column(name = "VoucherCount")
    private int voucherCount = 0;
    
    @Column(name = "IsActive")
    private Boolean isActive = true;

    public User() {}

    // Getters và Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public int getVoucherCount() { return voucherCount; }
    public void setVoucherCount(int voucherCount) { this.voucherCount = voucherCount; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }
}