package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Menu;

import java.util.List;

public interface MenuDAO {
    void save(Menu menu);

    void update(Menu menu);

    List<Menu> findAll();

    List<Menu> findByContactId(Integer contactId);

    Menu getMenuItemById(int menuId);
    public Menu findById(Integer menuId);
}
