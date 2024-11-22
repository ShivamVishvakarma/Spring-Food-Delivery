package com.yash.contactapp.rm;

import com.yash.contactapp.domain.Menu;
import org.springframework.jdbc.core.RowMapper;


import java.sql.ResultSet;
import java.sql.SQLException;

public class MenuRowMapper implements RowMapper<Menu> {


    @Override
    public Menu mapRow(ResultSet rs, int i) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(rs.getInt("menuId"));
        menu.setContactId(rs.getInt("contactId"));
        menu.setItemname(rs.getString("itemname"));
        menu.setDescription(rs.getString("description"));
        menu.setPrice(rs.getDouble("price"));
        menu.setFoodCategory(rs.getString("foodCategory"));
        menu.setImage(rs.getBlob("image"));
        return menu;
    }


}


