package com.yash.contactapp.service;

import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface menuService {



    void save(Menu menu);

    void update(Menu menu);


    List<Menu> findAll();

    List<Menu> findByContactId(Integer cid);
    Menu findById(Integer menuId);
}
