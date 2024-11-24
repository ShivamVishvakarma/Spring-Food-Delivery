package com.yash.contactapp.rm;

import com.yash.contactapp.domain.Order;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderRowMapper implements RowMapper<Order> {

    @Override
    public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("orderId"));
        order.setUserId(rs.getInt("userId"));
        order.setContactId(rs.getInt("contactId"));
        order.setOrderDate(rs.getTimestamp("orderDate"));
        order.setDeliveryAddress(rs.getString("deliveryAddress"));
        order.setCity(rs.getString("city"));
        order.setState(rs.getString("state"));
        order.setPincode(rs.getString("pincode"));
        order.setContactNumber(rs.getString("contactNumber"));
        order.setTotalAmount(rs.getDouble("totalAmount"));
        order.setPaymentMethod(rs.getString("paymentMethod"));
        order.setUpiId(rs.getString("upiId"));
        order.setOrderStatus(rs.getString("orderStatus"));
        order.setDeliveryCharge(rs.getDouble("deliveryCharge"));
        return order;
    }
}
