package com.yash.contactapp.service;

import com.yash.contactapp.domain.Contact;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ContactService {

    public void save(Contact contact);

    public void update(Contact contact);

    public void delete(Integer cotactId);

    void delete(Integer[] cotactIds);

    public List<Contact> findUserContact(Integer userId);

    public List<Contact> findUserContact(Integer userId, String txt);

    Contact findById(Integer cotactId);
}
