package com.yash.contactapp.controller;

import com.yash.contactapp.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class DashboardController {

    @Autowired
    private RestaurantService restaurantService;

    @RequestMapping(value = "/user/mlist")
    public String contactList(Model m, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        m.addAttribute("contactList", restaurantService.findUserContact(userId));
        return "dashboard_user"; //JSP
    }

}
