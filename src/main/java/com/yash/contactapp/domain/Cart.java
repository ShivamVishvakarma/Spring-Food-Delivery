package com.yash.contactapp.domain;

public class Cart {

    private Integer cart_id;
    private Integer userId;
    private Integer menuId;

    private Menu menu;
    private Integer contactId;
    private Integer quantity;
    private Double totalPrice;

    // Constructors
    public Cart() {}

    public Cart(Integer userId, Integer menuId, Integer contactId, Integer quantity, Double totalPrice) {
        this.userId = userId;
        this.menuId = menuId;
        this.contactId = contactId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters

    public Integer getCart_id() {
        return cart_id;
    }

    public void setCart_id(Integer cart_id) {
        this.cart_id = cart_id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getContactId() {
        return contactId;
    }

    public void setContactId(Integer shopId) {
        this.contactId = shopId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }


    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cart_id=" + cart_id +
                ", userId=" + userId +
                ", menuId=" + menuId +
                ", shopId=" + contactId +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
