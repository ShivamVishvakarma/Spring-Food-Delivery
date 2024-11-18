package com.yash.contactapp.domain;

import java.sql.Blob;

public class Menu {

    private Integer menuId;
    private Integer contactId;
    private String  Itemname;
    private String description;
    private double price;
    private Integer foodCategory;
    private Blob image;

    public Menu(Integer menuId, Integer contactId, String Itemname, String description, double price, Integer foodCategory, Blob image) {
        this.menuId = menuId;
        this.contactId = contactId;
        this.Itemname = Itemname;
        this.description = description;
        this.price = price;
        this.foodCategory = foodCategory;
        this.image = image;
    }

    public Menu() {

    }


    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public Integer getContactId() {
        return contactId;
    }

    public void setContactId(Integer contactId) {
        this.contactId = contactId;
    }

    public String getItemname() {
        return Itemname;
    }

    public void setItemname(String itemname) {
        Itemname = itemname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getFoodCategory() {
        return foodCategory;
    }

    public void setFoodCategory(Integer foodCategory) {
        this.foodCategory = foodCategory;
    }


    public Blob getImage() {
        return image;
    }

    public void setImage(Blob image) {
        this.image = image;
    }



}
