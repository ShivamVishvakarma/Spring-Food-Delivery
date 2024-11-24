package com.yash.contactapp.service;

import com.yash.contactapp.dao.CartDAO;
import com.yash.contactapp.dao.OrderDAO;
import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Order;
import com.yash.contactapp.domain.OrderItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {


    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private CartDAO cartDAO;

    @Override
    @Transactional
    public Integer placeOrder(Order order, List<Cart> cartItems) {
        // Create the order
        Integer orderId = orderDAO.createOrder(order);

        // Convert cart items to order items
        List<OrderItem> orderItems = new ArrayList<>();
        for (Cart cart : cartItems) {
            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setMenuId(cart.getMenuId());
            item.setQuantity(cart.getQuantity());
            item.setPrice(cart.getMenu().getPrice());
            orderItems.add(item);
        }

        // Add order items
        orderDAO.addOrderItems(orderItems);

        // Clear the user's cart
        cartDAO.clearCart(order.getUserId());

        return orderId;
    }

    @Override
    public Order getOrderById(Integer orderId) {
        return orderDAO.findOrderById(orderId);
    }

    @Override
    public List<Order> getOrdersByUserId(Integer userId) {
        return orderDAO.findOrdersByUserId(userId);
    }

    @Override
    public void updateOrderStatus(Integer orderId, String status) {
        orderDAO.updateOrderStatus(orderId, status);
    }
}

