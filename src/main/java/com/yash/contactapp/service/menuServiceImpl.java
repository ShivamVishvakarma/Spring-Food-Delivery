package com.yash.contactapp.service;

import com.yash.contactapp.dao.MenuDAO;
import com.yash.contactapp.domain.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class menuServiceImpl implements menuService {

    @Autowired
    private MenuDAO menuDAO;

    @Override
    public void save(Menu menu) {
      menuDAO.save(menu);
    }

    @Override
    public void update(Menu menu) {
     menuDAO.update(menu);
    }
}
