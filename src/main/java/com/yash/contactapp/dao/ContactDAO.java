package com.yash.contactapp.dao;

import com.yash.contactapp.domain.Contact;

import java.util.List;

public interface ContactDAO {

    public void save(Contact contact);
    public void update(Contact contact);
    public void delete(Contact contact);
    public void delete(Integer contactId);
    public Contact findById(Integer contactId);
    public List<Contact> findAll();
    public List<Contact> findByProperty(String propName ,Object propValue );
}
