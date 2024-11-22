package com.yash.contactapp.service;

import com.yash.contactapp.dao.BaseDAO;
import com.yash.contactapp.dao.ContactDAO;
import com.yash.contactapp.domain.Contact;
import com.yash.contactapp.rm.ContactRowMapper;
import com.yash.contactapp.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

    @Service
    public class ContactServiceImpl extends BaseDAO implements ContactService {

        @Autowired
        private ContactDAO contactDAO;

        @Override
        public void save(Contact c) {
            contactDAO.save(c);
        }

        @Override
        public void update(Contact c) {
            contactDAO.update(c);
        }

        @Override
        public void delete(Integer cotactId) {
            contactDAO.delete(cotactId);
        }

        @Override
        public void delete(Integer[] cotactIds) {
            String ids = StringUtil.toCommaSeparatedString(cotactIds);
            String sql = "DELETE FROM contact WHERE contactId IN(" + ids + ")";
            getJdbcTemplate().update(sql);
        }

        @Override
        public List<Contact> findUserContact(Integer userId) {
            return contactDAO.findByProperty("userId", userId);
        }

        @Override
        public List<Contact> findUserContact(Integer userId, String txt) {
            String sql = "SELECT contactId, userId, name, phone, email, address, remark FROM contact WHERE userId=? AND (name LIKE '%" + txt + "%' OR address LIKE '%" + txt + "%' OR phone LIKE '%" + txt + "%' OR email LIKE '%" + txt + "%' OR remark LIKE '%" + txt + "%')";
            return getJdbcTemplate().query(sql, new ContactRowMapper(), userId);
        }

        @Override
        public Contact findById(Integer cotactId) {
            return contactDAO.findById(cotactId);
        }

        @Override
        public List<Contact> findAll() {
            return contactDAO.findAll();
        }

        @Override
        public int getTotalRestaurants() {
            return contactDAO.count();
        }
    }

