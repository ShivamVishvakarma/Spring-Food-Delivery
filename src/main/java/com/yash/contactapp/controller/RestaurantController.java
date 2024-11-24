package com.yash.contactapp.controller;

import com.yash.contactapp.domain.Restaurant;
import com.yash.contactapp.domain.User;
import com.yash.contactapp.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class RestaurantController {

    @Autowired
    private RestaurantService restaurantService;

    @RequestMapping(value = "/user/contact_form")
    public String contactForm(Model m) {
        Restaurant restaurant = new Restaurant();
        m.addAttribute("command", restaurant);
        return "contact_form";//JSP form view
    }

    @RequestMapping(value = "/user/edit_contact")
    public String prepareEditForm(Model m, HttpSession session, @RequestParam("cid") Integer contactId) {
        session.setAttribute("aContactId", contactId);
        Restaurant c = restaurantService.findById(contactId);
        m.addAttribute("command", c);
        return "contact_form";//JSP form view
    }

    @RequestMapping(value = "/user/save_contact")
    public String saveOrUpdateContact(@ModelAttribute("command") Restaurant c, Model m, HttpSession session) {
        Integer contactId = (Integer) session.getAttribute("aContactId");
        if (contactId == null) {
            //save task
            try {
                Integer userId = (Integer) session.getAttribute("userId");
                c.setUserId(userId);//FK ; logged in userId
                restaurantService.save(c);
                return "redirect:clist?act=sv";//redirect user to contact list url
            } catch (Exception e) {
                e.printStackTrace();
                m.addAttribute("err", "Failed to save contact");
                return "contact_form";
            }
        } else {
            //update task
            try {
                c.setContactId(contactId); //PK
                restaurantService.update(c);
                session.removeAttribute("aContactId");
                return "redirect:clist?act=ed";//redirect user to contact list url
            } catch (Exception e) {
                e.printStackTrace();
                m.addAttribute("err", "Failed to Edit contact");
                return "contact_form";
            }
        }
    }

    @RequestMapping(value = "/user/clist")
    public String contactList(Model m, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        m.addAttribute("contactList", restaurantService.findUserContact(userId));
        return "clist";       //JSP
    }

    @RequestMapping(value = "/user/contact_search")
    public String contactSearch(Model m, HttpSession session, @RequestParam("freeText") String freeText) {
        Integer userId = (Integer) session.getAttribute("userId");
        m.addAttribute("contactList", restaurantService.findUserContact(userId, freeText));
        return "clist"; //JSP
    }

    @RequestMapping(value = "/user/del_contact")
    public String deleteContact(@RequestParam("cid") Integer contactId) {
        restaurantService.delete(contactId);
        return "redirect:clist?act=del";
    }

    @RequestMapping(value = "/user/bulk_cdelete")
    public String deleteBulkContact(@RequestParam("cid") Integer[] contactIds) {
        restaurantService.delete(contactIds);
        return "redirect:clist?act=del";
    }

    @RequestMapping(value = "/user/dashboard")
    public String showDashboard(Model m, HttpSession session) {
        if(session.getAttribute("userId") == null) {
            return "redirect:/";
        }

        User user = (User) session.getAttribute("user");
        List<Restaurant> restaurant = restaurantService.findAll();

        m.addAttribute("contact", restaurant);
        return "dashboard_user"; // JSP view name
    }

    @RequestMapping(value = "/user/contactList")
    public String getcontactList(Model m) {
        m.addAttribute("contactList", restaurantService.findAll());
        return "clist"; // JSP
    }


}