package com.yash.contactapp.service;

import com.yash.contactapp.domain.Restaurant;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface RestaurantService {

    public void save(Restaurant restaurant);

    public void update(Restaurant restaurant);

    public void delete(Integer cotactId);

    void delete(Integer[] cotactIds);

    public List<Restaurant> findUserContact(Integer userId);

    public List<Restaurant> findUserContact(Integer userId, String txt);

    Restaurant findById(Integer cotactId);

    List<Restaurant> findAll();

    int getTotalRestaurants();
}
