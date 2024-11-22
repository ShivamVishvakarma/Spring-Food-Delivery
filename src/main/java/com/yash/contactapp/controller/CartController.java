package com.yash.contactapp.controller;

import com.yash.contactapp.dao.MenuDAO;
import com.yash.contactapp.dao.UserDAO;
import com.yash.contactapp.domain.Cart;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import com.yash.contactapp.service.CartService;
import com.yash.contactapp.service.menuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private menuService menuService;


    @PostMapping("/user/add-to-cart")
    public String addToCart(
            @RequestParam("menuId") Integer menuId,
            @RequestParam("quantity") Integer quantity,
            @RequestParam("cid") Integer contactId, // Add this parameter
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        // Get the logged-in user from session
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // Redirect to login if no user in session
            return "redirect:/login";
        }

        try {
            // Add item to cart with shopId
            cartService.addToCart(user.getUserId(), menuId, quantity, contactId);
            redirectAttributes.addFlashAttribute("message", "Item added to cart successfully!");
            return "redirect:/user/cart"; // Changed redirect
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("err", "Failed to add item to cart: " + e.getMessage());
            return "redirect:/seller/menu_list";
        }
    }

    @GetMapping("/user/cart")
    public String showCart(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        System.out.println("User ID: " + user.getUserId());
        System.out.println("User ID from Session: " + (user != null ? user.getUserId() : "NULL"));

        List<Cart> cartItems = cartService.getCartItems(user.getUserId());

        System.out.println("Cart Items Count: " + cartItems.size());

        // Eager load or populate menu details
        for (Cart cart : cartItems) {
            // Fetch menu details or ensure they are loaded
            Menu menu = menuService.findById(cart.getMenuId());
            cart.setMenu(menu);

            System.out.println("Cart Item: " + cart);
            System.out.println("Associated Menu: " + menu);

        }

        // Calculate total cart value
        double totalCartValue = cartItems.stream()
                .filter(cart -> cart.getMenu() != null)
                .mapToDouble(cart -> cart.getMenu().getPrice() * cart.getQuantity())
                .sum();

        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalCartValue", totalCartValue);
        return "add_to_cart";
    }



    @PostMapping("/user/update-cart-item")
    public String updateCartItem(
            @RequestParam("cart_id") Integer cart_id,
            @RequestParam("quantity") Integer quantity,
            RedirectAttributes redirectAttributes
    ) {
        try {
            cartService.updateCartItemQuantity(cart_id, quantity);
            redirectAttributes.addFlashAttribute("message", "Cart item updated successfully!");
            return "redirect:/user/cart";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("err", "Failed to update cart item: " + e.getMessage());
            return "redirect:/user/cart";
        }
    }

    @GetMapping("/user/remove-cart-item")
    public String removeCartItem(
            @RequestParam("cart_id") Integer cart_id,
            RedirectAttributes redirectAttributes
    ) {
        try {
            cartService.removeCartItem(cart_id);
            redirectAttributes.addFlashAttribute("message", "Item removed from cart successfully!");
            return "redirect:/user/cart";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("err", "Failed to remove cart item: " + e.getMessage());
            return "redirect:/user/cart";
        }
    }

    @GetMapping("/user/clear-cart")
    public String clearCart(
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        try {
            cartService.clearCart(user.getUserId());
            redirectAttributes.addFlashAttribute("message", "Cart cleared successfully!");
            return "redirect:/user/cart";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("err", "Failed to clear cart: " + e.getMessage());
            return "redirect:/user/cart";
        }
    }
}



