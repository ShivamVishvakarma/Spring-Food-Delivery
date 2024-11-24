package com.yash.contactapp.controller;

import com.yash.contactapp.command.UserCommand;
import com.yash.contactapp.command.LoginCommand;
import com.yash.contactapp.dao.UserDAO;
import com.yash.contactapp.domain.User;
import com.yash.contactapp.exception.UserBlockedException;
import com.yash.contactapp.service.RestaurantService;
import com.yash.contactapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RestaurantService restaurantService;

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = {"/", "/index"})
    public String index(Model m) {
        m.addAttribute("command", new LoginCommand());
        return "index"; //JSP - /WEB-INF/view/index.jsp
    }

    @RequestMapping(value = {"/login"})
    public String login(Model m) {
        m.addAttribute("command", new LoginCommand());
        return "login"; //JSP - /WEB-INF/view/index.jsp
    }


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String handleLogin(@ModelAttribute("command") LoginCommand cmd, Model m, HttpSession session) {
        try {
            User loggedInUser = userService.login(cmd.getLoginName(), cmd.getPassword());
            if (loggedInUser == null) {
                //FAILED
                //add error message and go back to login-form
                m.addAttribute("err", "Login Failed! Enter valid credentials.");
                return "login";//JSP - Login FORM
            } else //SUCCESS
            //check the role and redirect to a appropriate dashboard
            {
                if (loggedInUser.getRole().equals(UserService.ROLE_ADMIN)) {
                    //add user detail in session (assign session to logged in user)
                    addUserInSession(loggedInUser, session);
                    return "redirect:admin/dashboard";
                } else if (loggedInUser.getRole().equals(UserService.ROLE_SELLER)) {
                    //add user detail in session (assign session to logged in user)
                    addUserInSession(loggedInUser, session);
                    return "redirect:/user/clist?act=sv";
                }

                else if (loggedInUser.getRole().equals(UserService.ROLE_BUYER)) {
                    //add user detail in session (assign session to logged in user)
                    addUserInSession(loggedInUser, session);
                    return "redirect:user/dashboard";
                }else {
                    //add error message and go back to login-form
                    m.addAttribute("err", "Invalid User ROLE");
                    return "login";//JSP - Login FORM
                }
            }
        } catch (UserBlockedException ex) {
            //add error message and go back to login-form
            m.addAttribute("err", ex.getMessage());
            return "index";//JSP - Login FORM
        }
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:index?act=lo";
    }

    @RequestMapping(value = "/admin/dashboard")
    public String adminDashboard(Model model ) {
        int totalRestaurants = restaurantService.getTotalRestaurants();
        int totalUsers = userService.getTotalUsers();
       // int totalOrders = orderService.getTotalOrders();

        model.addAttribute("totalRestaurants", totalRestaurants);
        model.addAttribute("totalUsers", totalUsers);
       // model.addAttribute("totalOrders", totalOrders);

        return "dashboard_admin"; //JSP
    }

    @RequestMapping(value = "/seller/dashboard")
    public String sellerDashboard() {
        return "dashboard_seller"; //JSP
    }


    @RequestMapping(value = "/admin/buyers")
    public String getBuyerList(Model m) {
        m.addAttribute("userList", userService.getBuyerList());
        return "users"; // JSP
    }

    @RequestMapping(value = "/admin/sellers")
    public String getSellerList(Model m) {
        m.addAttribute("userList", userService.getSellerList());
        return "seller"; // JSP
    }


    @RequestMapping(value = "/reg_form")
    public String registrationForm(Model m) {
        UserCommand cmd = new UserCommand();
        m.addAttribute("command", cmd);
        return "reg_form";//JSP
    }

    @RequestMapping(value = "/register")
    public String registerUser(@ModelAttribute("command") UserCommand cmd, Model m) {
        try {
            User user = cmd.getUser ();
            if (user.getRole().equals(UserService.ROLE_SELLER)) {
                user.setLoginStatus(UserService.LOGIN_STATUS_BLOCKED);
            } else {
                user.setLoginStatus(UserService.LOGIN_STATUS_ACTIVE);
            }
            userService.register(user);
            return "redirect:login?act=reg"; //Login Page
        } catch (DuplicateKeyException e) {
            e.printStackTrace();
            m.addAttribute("err", "Username is already registered. Please select another username.");
            return "reg_form"; //JSP
        }
    }

    @RequestMapping(value = "/user/edit_profile")
    public String prepareEditForm(Model m, HttpSession session, @RequestParam("userId") Integer userId) {
        User command = userDAO.findById(userId);

        // Add the user to the model with the correct attribute name
        m.addAttribute("command", command);

        // Store userId in session if needed
        session.setAttribute("userId", userId);

        return "reg_form";
    }


    private void addUserInSession(User u, HttpSession session) {
        session.setAttribute("user", u);
        session.setAttribute("userId", u.getUserId());
        session.setAttribute("role", u.getRole());
    }

    @RequestMapping(value = "/admin/change_status")
    @ResponseBody
    public String changeLoginStatus(@RequestParam Integer userId, @RequestParam Integer loginStatus) {
        try {
            userService.changeLoginStatus(userId, loginStatus);
            return "SUCCESS: Status Changed";
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: Unable to Change Status";
        }
    }

    @RequestMapping(value = "/check_avail")
    @ResponseBody
    public String checkAvailability(@RequestParam String username) {
        if(userService.isUsernameExist(username)){
            return "<span style=\"color:red;\">ERROR: This username is already taken. Choose another name</span>\"";
        }else{
            return "<span style=\"color:green;\">Yes! You can take this</span>";
        }
    }

    @GetMapping("/user/profile")
    public String showProfile(HttpSession session, Model model) {
        // Assuming user is stored in session
        if(session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "profile";
    }
    @GetMapping("/user/orders")
    public String myOrders(HttpSession session, Model model) {
        // Assuming user is stored in session
        if(session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "myorders";
    }


}