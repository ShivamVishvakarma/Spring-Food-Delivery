package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartDAO {


    void addToCart(Cart cart);
    List<Cart> findCartItemsByUserId(Integer userId);
    void updateCartItemQuantity(Integer cart_id, Integer quantity);
    void removeCartItem(Integer cart_id);
    void clearCart(Integer userId);
    Cart findCartItemByUserIdAndMenuId(Integer userId, Integer menuId);

    List<Cart> findByUserId(Integer userId);

    void deleteByUserId(Integer userId);
}
