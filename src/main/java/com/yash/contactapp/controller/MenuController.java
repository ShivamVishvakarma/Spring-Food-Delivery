package com.yash.contactapp.controller;

import com.yash.contactapp.command.MenuCommand;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.service.menuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MenuController {

    @Autowired
    private menuService menuService;

    @RequestMapping(value = {"/user/menu"})
    public String index(Model m) {
        MenuCommand cmd = new MenuCommand();
        cmd.setMenu(new Menu()); // Ensure you initialize the Menu object
        m.addAttribute("command", cmd);
        return "menu";
    }

    @RequestMapping(value = "/seller/save_menu")
    public String saveOrUpdateMenu(@ModelAttribute("command") MenuCommand command, @RequestParam String contactId, Model m, HttpSession session) {
        System.out.println("inside save or update controller");

        try {
            if (command == null || command.getMenu() == null) {
                throw new RuntimeException("Form data not properly bound");
            }
           // System.out.println("label1");
            Menu menu = command.getMenu();
            Integer menuId = (Integer) session.getAttribute("menuId");
            //System.out.println("menuId: " + menuId);
            //System.out.println("contactId" + contactId);
            if (contactId == null) {
                m.addAttribute("err", "No contact ID found in session");
                return "menu";
            }
            menu.setContactId(Integer.valueOf(contactId));


            if (menuId == null) {
                // Save new menu item
                menuService.save(menu);
                m.addAttribute("message", "Menu item saved successfully");
            } else {
                // Update existing menu item
                menu.setMenuId(menuId);
                menuService.update(menu);
                session.removeAttribute("menuId");
                m.addAttribute("message", "Menu item updated successfully");
            }

            return "menu_list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("err", "Failed to process menu item: " + e.getMessage());
            return "menu";
        }

    }
    @RequestMapping(value = "/seller/menu_list")
    public String menuList(Model m,HttpSession session , @RequestParam("cid") Integer cid) {
        List<Menu> menus = menuService.findByContactId(cid);
        m.addAttribute("menuList", menus);
        return "menu_list"; // This will be your JSP/view name
    }

    @RequestMapping(value = "/user/menu_list")
    public String usermenuList(Model m,HttpSession session , @RequestParam("cid") Integer cid) {
        List<Menu> menus = menuService.findByContactId(cid);
        m.addAttribute("menuList", menus);
        return "user_menu"; // This will be your JSP/view name
    }



}


