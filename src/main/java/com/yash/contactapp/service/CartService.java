package com.yash.contactapp.service;

import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CartService {


    void addToCart(Integer userId, Integer menuId, Integer quantity, Integer shopId);

    List<Cart> getCartItems(Integer userId);

    void updateCartItemQuantity(Integer cart_id, Integer quantity);

    void removeCartItem(Integer cart_id);

    void clearCart(Integer userId);

}
