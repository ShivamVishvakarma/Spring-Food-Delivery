package com.yash.contactapp.controller;

import com.yash.contactapp.command.LoginCommand;
import com.yash.contactapp.command.MenuCommand;
import com.yash.contactapp.command.UserCommand;
import com.yash.contactapp.domain.Contact;
import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import com.yash.contactapp.service.UserService;
import com.yash.contactapp.service.menuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

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
    public String saveOrUpdateMenu(@ModelAttribute("command") MenuCommand command, Model m, HttpSession session) {
        System.out.println("inside save or update controller");
        try {
            if (command == null || command.getMenu() == null) {
                throw new RuntimeException("Form data not properly bound");
            }

            Menu menu = command.getMenu();
            System.out.println("menu: " + menu);
            Integer menuId = (Integer) session.getAttribute("menuId");
            Integer contactId = (Integer) session.getAttribute("aContactId");

            if (contactId == null) {
                m.addAttribute("err", "No contact ID found in session");
                return "menu";
            }

            menu.setContactId(contactId);

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

            return "redirect:menu_list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("err", "Failed to process menu item: " + e.getMessage());
            return "menu";
        }
    }
}


