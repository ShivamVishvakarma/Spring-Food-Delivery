package com.yash.contactapp.dao;

import com.yash.contactapp.domain.User;
import com.yash.contactapp.rm.UserRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDAOImpl extends BaseDAO implements UserDAO {
    @Override
    public void save(User user) {
        String sql = "INSERT INTO user(name, phone, email, address, loginName, password, role, loginStatus)"
                + " VALUES(:name, :phone, :email, :address, :loginName, :password, :role, :loginStatus)";
        Map m = new HashMap();
        m.put("name", user.getName());
        m.put("phone", user.getPhone());
        m.put("email", user.getEmail());
        m.put("address", user.getAddress());
        m.put("loginName", user.getLoginName());
        m.put("password", user.getPassword());
        m.put("role", user.getRole());
        m.put("loginStatus", user.getLoginStatus());

        KeyHolder kh = new GeneratedKeyHolder();
        SqlParameterSource ps = new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql, ps, kh);
        Integer userId = kh.getKey().intValue();
        user.setUserId(userId);
    }

    @Override
    public void update(User user) {
        String sql = "UPDATE user "
                + " SET name=:name,"
                + " phone=:phone, "
                + " email=:email,"
                + " address=:address,"
                + " role=:role,"
                + " loginStatus=:loginStatus "
                + " WHERE userId=:userId";
        Map m = new HashMap();
        m.put("name", user.getName());
        m.put("phone", user.getPhone());
        m.put("email", user.getEmail());
        m.put("address", user.getAddress());
        m.put("role", user.getRole());
        m.put("loginStatus", user.getLoginStatus());
        m.put("userId", user.getUserId());
        getNamedParameterJdbcTemplate().update(sql, m);
    }

    @Override
    public void delete(User user) {
        this.delete(user.getUserId());
    }

    @Override
    public void delete(Integer userId) {
        String sql="DELETE FROM user WHERE userId=?";
        getJdbcTemplate().update(sql, userId);
    }


    @Override
    public User findById(Integer userId) {
        String sql = "SELECT userId, name, phone, email, address, loginName, role, loginStatus"
                + " FROM user WHERE userId=?";
        User u = getJdbcTemplate().queryForObject(sql, new UserRowMapper(),userId);
        return u;

    }

    @Override
    public List<User> findAll() {
        String sql = "SELECT userId, name, phone, email, address, loginName, role, loginStatus"
                + " FROM user";

          /* List<User> users = getJdbcTemplate().query(sql, new UserRowMapper());
           return users;*/

        return getJdbcTemplate().query(sql, new UserRowMapper());

    }

    @Override
    public List<User> findByProperty(String propName, Object propValue) {
        String sql = "SELECT userId, name, phone, email, address, loginName, role, loginStatus"
                + " FROM user WHERE "+propName+"=?";
        return getJdbcTemplate().query(sql, new UserRowMapper(), propValue);

    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM user";
        return getJdbcTemplate().queryForObject(sql, Integer.class);
    }
}
