package com.yash.contactapp.dao;


import com.yash.contactapp.domain.Cart;

import com.yash.contactapp.rm.CartRowMapper;

import org.springframework.stereotype.Repository;


import java.util.List;


@Repository
public class CartDAOImpl extends BaseDAO implements CartDAO{


    @Override
    public void addToCart(Cart cart) {
        // First check if item already exists in cart
        Cart existingCart = findCartItemByUserIdAndMenuId(cart.getUserId(), cart.getMenuId());

        if (existingCart != null) {
            // Update existing cart item - use the exact quantity passed in, not adding
            String sql = "UPDATE cart SET quantity = ?, total_price = ? WHERE cart_id = ?";
            getJdbcTemplate().update(sql,
                    cart.getQuantity(), // Use the exact quantity
                    cart.getTotalPrice(), // Recalculate total price
                    existingCart.getCart_id()
            );
        } else {
            // Insert new cart item
            String sql = "INSERT INTO cart (userId, menuId, contactId, quantity, total_price) VALUES (?, ?, ?, ?, ?)";
            getJdbcTemplate().update(sql,
                    cart.getUserId(),
                    cart.getMenuId(),
                    cart.getContactId(),
                    cart.getQuantity(),
                    cart.getTotalPrice()
            );
        }
    }

    // Rest of the methods remain the same as in your original implementation
    @Override
    public List<Cart> findCartItemsByUserId(Integer userId) {
        String sql = "SELECT * FROM cart WHERE userId = ?";
        return getJdbcTemplate().query(sql, new Object[]{userId}, new CartRowMapper());
    }

    @Override
    public void updateCartItemQuantity(Integer cartId, Integer quantity) {
        // Retrieve the menu price for this cart item
        String getPriceSql = "SELECT m.price FROM cart c JOIN menu m ON c.menuId = m.menuId WHERE c.cart_id = ?";
        Double price = getJdbcTemplate().queryForObject(getPriceSql, Double.class, cartId);

        // Update quantity and total price
        String sql = "UPDATE cart SET quantity = ?, total_price = ? WHERE cart_id = ?";
        getJdbcTemplate().update(sql, quantity, price * quantity, cartId);
    }

    @Override
    public void removeCartItem(Integer cart_id) {
        String sql = "DELETE FROM cart WHERE cart_id = ?";
        getJdbcTemplate().update(sql, cart_id);
    }

    @Override
    public void clearCart(Integer userId) {
        String sql = "DELETE FROM cart WHERE userId = ?";
        getJdbcTemplate().update(sql, userId);
    }

    @Override
    public Cart findCartItemByUserIdAndMenuId(Integer userId, Integer menuId) {
        try {
            String sql = "SELECT * FROM cart WHERE userId = ? AND menuId = ?";
            return getJdbcTemplate().queryForObject(sql, new Object[]{userId, menuId}, new CartRowMapper());
        } catch (Exception e) {
            // If no cart item found, return null
            return null;
        }
    }

    @Override
    public List<Cart> findByUserId(Integer userId) {
        return List.of();
    }

    @Override
    public void deleteByUserId(Integer userId) {

    }


}
