package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Restaurant;

import java.util.List;

public interface RestaurantDAO {

    public void save(Restaurant restaurant);
    public void update(Restaurant restaurant);
    public void delete(Restaurant restaurant);
    public void delete(Integer contactId);
    public Restaurant findById(Integer contactId);
    public List<Restaurant> findAll();
    public List<Restaurant> findByProperty(String propName , Object propValue );

    int count();
}
