package com.yash.contactapp.rm;


import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CartRowMapper implements RowMapper<Cart> {

        @Override
        public Cart mapRow(ResultSet rs, int rowNum) throws SQLException {
            Cart cart = new Cart();
            cart.setCart_id(rs.getInt("cart_id"));
            cart.setUserId(rs.getInt("userId"));
            cart.setMenuId(rs.getInt("menuId"));
            cart.setContactId(rs.getInt("contactId"));
            cart.setQuantity(rs.getInt("quantity"));
            cart.setTotalPrice(rs.getDouble("total_price"));
            return cart;
        }
    }

