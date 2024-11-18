package com.yash.contactapp.service;

import com.yash.contactapp.domain.Menu;
import org.springframework.stereotype.Service;

@Service
public interface menuService {
    void save(Menu menu);

    void update(Menu menu);
}
