package com.yash.contactapp.service;

import com.yash.contactapp.dao.CartDAO;
import com.yash.contactapp.dao.MenuDAO;
import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

     @Autowired
    private CartDAO cartDAO;

    @Autowired
    private MenuDAO menuDAO;

    @Override
    public void addToCart(Integer userId, Integer menuId, Integer quantity, Integer contactId) {
        // Retrieve menu details
        Menu menu =  menuDAO.findById(menuId);

        if (menu != null) {
            Cart cart = new Cart();
            cart.setUserId(userId);
            cart.setMenuId(menuId);
            cart.setContactId(contactId);
            cart.setContactId(menu.getContactId()); // Using contactId as shopId
            cart.setQuantity(quantity);
            cart.setTotalPrice(menu.getPrice() * quantity);

            cartDAO.addToCart(cart);
        } else {
            throw new RuntimeException("Menu item not found");
        }
    }

    @Override
    public List<Cart> getCartItems(Integer userId) {
        return cartDAO.findCartItemsByUserId(userId);
    }

    @Override
    public void updateCartItemQuantity(Integer cart_id, Integer quantity) {
        cartDAO.updateCartItemQuantity(cart_id, quantity);
    }

    @Override
    public void removeCartItem(Integer cart_id) {
        cartDAO.removeCartItem(cart_id);
    }

    @Override
    public void clearCart(Integer userId) {
        cartDAO.clearCart(userId);
    }
}
