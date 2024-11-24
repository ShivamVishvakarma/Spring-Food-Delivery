package com.yash.contactapp.service;

import com.yash.contactapp.dao.BaseDAO;
import com.yash.contactapp.dao.RestaurantDAO;
import com.yash.contactapp.domain.Restaurant;
import com.yash.contactapp.rm.RestaurantRowMapper;
import com.yash.contactapp.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

    @Service
    public class RestaurantServiceImpl extends BaseDAO implements RestaurantService {

        @Autowired
        private RestaurantDAO restaurantDAO;

        @Override
        public void save(Restaurant c) {
            restaurantDAO.save(c);
        }

        @Override
        public void update(Restaurant c) {
            restaurantDAO.update(c);
        }

        @Override
        public void delete(Integer cotactId) {
            restaurantDAO.delete(cotactId);
        }

        @Override
        public void delete(Integer[] cotactIds) {
            String ids = StringUtil.toCommaSeparatedString(cotactIds);
            String sql = "DELETE FROM contact WHERE contactId IN(" + ids + ")";
            getJdbcTemplate().update(sql);
        }

        @Override
        public List<Restaurant> findUserContact(Integer userId) {
            return restaurantDAO.findByProperty("userId", userId);
        }

        @Override
        public List<Restaurant> findUserContact(Integer userId, String txt) {
            String sql = "SELECT contactId, userId, name, phone, email, address, remark FROM contact WHERE userId=? AND (name LIKE '%" + txt + "%' OR address LIKE '%" + txt + "%' OR phone LIKE '%" + txt + "%' OR email LIKE '%" + txt + "%' OR remark LIKE '%" + txt + "%')";
            return getJdbcTemplate().query(sql, new RestaurantRowMapper(), userId);
        }

        @Override
        public Restaurant findById(Integer cotactId) {
            return restaurantDAO.findById(cotactId);
        }

        @Override
        public List<Restaurant> findAll() {
            return restaurantDAO.findAll();
        }

        @Override
        public int getTotalRestaurants() {
            return restaurantDAO.count();
        }
    }

