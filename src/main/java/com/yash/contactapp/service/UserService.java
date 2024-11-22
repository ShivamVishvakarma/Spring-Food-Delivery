package com.yash.contactapp.service;

import com.yash.contactapp.domain.User;
import com.yash.contactapp.exception.UserBlockedException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {

    public static final Integer LOGIN_STATUS_ACTIVE=1;
    public static final Integer LOGIN_STATUS_BLOCKED=2;

    public static final Integer ROLE_ADMIN=1;
    public static final Integer ROLE_BUYER=2;
    public static final Integer ROLE_SELLER=3;


    public void register(User u);

    public User login(String loginName, String password) throws UserBlockedException;

    public List<User> getBuyerList();

    public List<User> getSellerList();
    public void changeLoginStatus(Integer userId, Integer loginStatus);

    public Boolean isUsernameExist(String username);

    int getTotalUsers();
}

