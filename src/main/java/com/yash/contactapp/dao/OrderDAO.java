package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Order;
import com.yash.contactapp.domain.OrderItem;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderDAO {
    Integer createOrder(Order order);

    void addOrderItems(List<OrderItem> orderItems);

    Order findOrderById(Integer orderId);

    List<Order> findOrdersByUserId(Integer userId);

    void updateOrderStatus(Integer orderId, String status);
}
