package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Menu;
import com.yash.contactapp.domain.User;
import com.yash.contactapp.rm.MenuRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MenuDAOImpl extends BaseDAO implements MenuDAO {
    @Override
    public void save(Menu menu) {

        System.out.println("menudao -> save");
        System.out.println("menu3:  " + menu);

        String sql = "INSERT INTO menu(menuId, Itemname, description, price, foodCategory, image, contactId) VALUES(:menuId, :Itemname, :description, :price, :foodCategory, :image, :contactId)";
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

    @Override
    public List<Menu> findAll() {
        String sql = "SELECT menuId, Itemname, description, price, foodCategory, contactId, image FROM menu";
        return getJdbcTemplate().query(sql, new MenuRowMapper());
    }

    @Override
    public List<Menu> findByContactId(Integer contactId) {
        String sql = "SELECT menuId, Itemname, description, price, foodCategory, contactId, image FROM menu WHERE contactId=?";
        return getJdbcTemplate().query(sql, new MenuRowMapper(), contactId);
    }

    @Override
    public Menu getMenuItemById(int menuId) {
        String sql = "SELECT menuId, Itemname, description, price, foodCategory, contactId, image FROM menu WHERE menuId=?";
        Menu menu = getJdbcTemplate().queryForObject(sql, new MenuRowMapper(),menuId);
        return menu;
    }

    @Override
    public Menu findById(Integer menuId) {
        String sql = "SELECT menuId, Itemname, description, price, foodCategory, image, contactId FROM menu WHERE menuId=?";
        return getJdbcTemplate().queryForObject(sql, new MenuRowMapper(), menuId);}
}

