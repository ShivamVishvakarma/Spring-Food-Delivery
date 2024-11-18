package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Menu;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class MenuDAOImpl extends BaseDAO implements MenuDAO {
    @Override
    public void save(Menu menu) {

        String sql = "INSERT INTO menu(menuId, Itemname, description, price, foodCategory, image) VALUES(:menuId, :Itemname, :description, :price, :foodCategory, :image)";
        Map m = new HashMap();
        m.put("menuId", menu.getMenuId());
        m.put("Itemname", menu.getItemname());
        m.put("description", menu.getDescription());
        m.put("price", menu.getPrice());
        m.put("foodCategory", menu.getFoodCategory());
        m.put("image", menu.getImage());
        m.put("contactId", menu.getContactId());
        SqlParameterSource ps = new MapSqlParameterSource(m);
        KeyHolder kh = new GeneratedKeyHolder();
        getNamedParameterJdbcTemplate().update(sql, ps, kh);
        menu.setMenuId(kh.getKey().intValue());
    }

    @Override
    public void update(Menu menu) {

    }
}
