package com.yash.contactapp.service;

import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Order;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface OrderService {
    Integer placeOrder(Order order, List<Cart> cartItems);

    List<Order> getOrdersByUserId(Integer userId);

    Order getOrderById(Integer orderId);

    void updateOrderStatus(Integer orderId, String status);
}
