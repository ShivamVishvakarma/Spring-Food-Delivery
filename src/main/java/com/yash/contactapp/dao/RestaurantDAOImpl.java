package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Restaurant;
import com.yash.contactapp.rm.RestaurantRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class RestaurantDAOImpl extends BaseDAO implements RestaurantDAO {

    @Override
    public void save(Restaurant c) {
        String sql = "INSERT INTO contact(userId, name, phone, email, address, remark) VALUES(:userId, :name, :phone, :email, :address, :remark)";
        Map m = new HashMap();
        m.put("userId", c.getUserId());
        m.put("name", c.getName());
        m.put("phone", c.getPhone());
        m.put("email", c.getEmail());
        m.put("address", c.getAddress());
        m.put("remark", c.getRemark());
        SqlParameterSource ps = new MapSqlParameterSource(m);
        KeyHolder kh = new GeneratedKeyHolder();
        getNamedParameterJdbcTemplate().update(sql, ps, kh);
        c.setContactId(kh.getKey().intValue());
    }

    @Override
    public void update(Restaurant c) {
        String sql = "UPDATE contact SET name=:name, phone=:phone, email=:email, address=:address, remark=:remark WHERE contactId=:contactId";
        Map m = new HashMap();
        m.put("contactId", c.getContactId());
        m.put("name", c.getName());
        m.put("phone", c.getPhone());
        m.put("email", c.getEmail());
        m.put("address", c.getAddress());
        m.put("remark", c.getRemark());
        getNamedParameterJdbcTemplate().update(sql, m);
    }

    @Override
    public void delete(Restaurant c) {
        this.delete(c.getContactId());
    }

    @Override
    public void delete(Integer contactId) {
        String sql = "DELETE FROM contact WHERE contactId=?";
        getJdbcTemplate().update(sql, contactId);
    }

    @Override
    public Restaurant findById(Integer contactId) {
        String sql = "SELECT contactId, userId, name, phone, email, address, remark FROM contact WHERE contactId=?";
        return getJdbcTemplate().queryForObject(sql, new RestaurantRowMapper(), contactId);
    }

    @Override
    public List<Restaurant> findAll() {
        String sql = "SELECT contactId, userId, name, phone, email, address, remark FROM contact";
        return getJdbcTemplate().query(sql, new RestaurantRowMapper());
    }

    @Override
    public List<Restaurant> findByProperty(String propName, Object propValue) {
        String sql = "SELECT contactId, userId, name, phone, email, address, remark FROM contact WHERE "+propName+"=?";
        return getJdbcTemplate().query(sql, new RestaurantRowMapper(), propValue);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM contact";
        return getJdbcTemplate().queryForObject(sql, Integer.class);
    }

}
