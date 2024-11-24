package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Order;
import com.yash.contactapp.domain.OrderItem;
import com.yash.contactapp.rm.OrderRowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderDAOImpl extends BaseDAO implements OrderDAO{

    @Override
    public Integer createOrder(Order order) {
        String sql = "INSERT INTO orders (userId, contactId, deliveryAddress, city, state, " +
                "pincode, contactNumber, totalAmount, paymentMethod, upiId, orderStatus, deliveryCharge) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();
        getJdbcTemplate().update(connection -> {
            var ps = connection.prepareStatement(sql, new String[]{"orderId"});
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getContactId());
            ps.setString(3, order.getDeliveryAddress());
            ps.setString(4, order.getCity());
            ps.setString(5, order.getState());
            ps.setString(6, order.getPincode());
            ps.setString(7, order.getContactNumber());
            ps.setDouble(8, order.getTotalAmount());
            ps.setString(9, order.getPaymentMethod());
            ps.setString(10, order.getUpiId());
            ps.setString(11, "PENDING");
            ps.setDouble(12, 40.00);
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    @Override
    public void addOrderItems(List<OrderItem> items) {
        String sql = "INSERT INTO order_items (orderId, menuId, quantity, price) VALUES (?, ?, ?, ?)";

        for (OrderItem item : items) {
            getJdbcTemplate().update(sql,
                    item.getOrderId(),
                    item.getMenuId(),
                    item.getQuantity(),
                    item.getPrice()
            );
        }
    }

    @Override
    public Order findOrderById(Integer orderId) {
        String sql = "SELECT * FROM orders WHERE orderId = ?";
        return getJdbcTemplate().queryForObject(sql, new Object[]{orderId}, new OrderRowMapper());
    }

    @Override
    public List<Order> findOrdersByUserId(Integer userId) {
        String sql = "SELECT * FROM orders WHERE userId = ? ORDER BY orderDate DESC";
        return getJdbcTemplate().query(sql, new Object[]{userId}, new OrderRowMapper());
    }

    @Override
    public void updateOrderStatus(Integer orderId, String status) {
        String sql = "UPDATE orders SET orderStatus = ? WHERE orderId = ?";
        getJdbcTemplate().update(sql, status, orderId);
    }
}
