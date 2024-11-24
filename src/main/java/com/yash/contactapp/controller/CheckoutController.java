package com.yash.contactapp.controller;

import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Order;
import com.yash.contactapp.domain.User;
import com.yash.contactapp.service.CartService;
import com.yash.contactapp.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CheckoutController {
    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;


        @GetMapping("/user/checkout")
        public String showCheckout(Model model, HttpSession session) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            List<Cart> cartItems = cartService.getCartItems(user.getUserId());
            if (cartItems.isEmpty()) {
                return "redirect:/user/cart";
            }

            // Calculate subtotal
            double subtotal = cartItems.stream()
                    .mapToDouble(cart -> cart.getMenu().getPrice() * cart.getQuantity())
                    .sum();

            model.addAttribute("cartItems", cartItems);
            model.addAttribute("subtotal", subtotal);
            model.addAttribute("checkout", new Order());
            return "checkout";
        }

        @PostMapping("/user/checkout")
        public String processCheckout(@ModelAttribute("checkout") Order order,
                                      HttpSession session,
                                      RedirectAttributes redirectAttributes) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            try {
                List<Cart> cartItems = cartService.getCartItems(user.getUserId());
                order.setUserId(user.getUserId());
                Integer orderId = orderService.placeOrder(order, cartItems);
                redirectAttributes.addFlashAttribute("message",
                        "Order placed successfully! Your order ID is: " + orderId);
                return "redirect:/user/orders";
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error",
                        "Failed to place order: " + e.getMessage());
                return "redirect:/user/checkout";
            }
        }

        @GetMapping("/users/orders")
        public String viewOrders(Model model, HttpSession session) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            List<Order> orders = orderService.getOrdersByUserId(user.getUserId());
            model.addAttribute("orders", orders);
            return "orders";
        }

        @GetMapping("/user/orders/{orderId}")
        public String viewOrderDetails(@PathVariable Integer orderId,
                                       Model model,
                                       HttpSession session) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            Order order = orderService.getOrderById(orderId);
            // Verify the order belongs to the logged-in user
            if (!order.getUserId().equals(user.getUserId())) {
                return "redirect:/user/orders";
            }

            model.addAttribute("order", order);
            return "orderDetails";
        }

        @PostMapping("/user/orders/{orderId}/status")
        @ResponseBody
        public ResponseEntity<String> updateOrderStatus(@PathVariable Integer orderId,
                                                        @RequestParam String status,
                                                        HttpSession session) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("User not authenticated");
            }

            try {
                Order order = orderService.getOrderById(orderId);
                if (!order.getUserId().equals(user.getUserId())) {
                    return ResponseEntity.status(HttpStatus.FORBIDDEN)
                            .body("Access denied");
                }

                orderService.updateOrderStatus(orderId, status);
                return ResponseEntity.ok("Order status updated successfully");
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body("Failed to update order status: " + e.getMessage());
            }
        }
    }


