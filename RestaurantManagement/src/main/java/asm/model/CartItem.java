package asm.model;

public class CartItem {
    private Dish dish;
    private int quantity;

    public CartItem() {}

    public CartItem(Dish dish, int quantity) {
        this.dish = dish;
        this.quantity = quantity;
    }

    public Dish getDish() { return dish; }
    public void setDish(Dish dish) { this.dish = dish; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    // Tự động tính thành tiền: Giá x Số lượng
    public double getTotalPrice() {
        return dish.getPrice() * quantity;
    }
}