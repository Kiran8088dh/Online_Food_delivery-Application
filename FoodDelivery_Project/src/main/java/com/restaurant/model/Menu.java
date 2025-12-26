package com.restaurant.model;

public class Menu {
    
    private int Id;
    private String Name;
    private int Restaurant_Id;
    private String Description;   // correctly named
    private float Price;
    private float Rating;
    private String Image;

    public Menu() {}

    public Menu(int id, String name, int restaurant_Id, String description,
                float price, float rating, String image) {
        this.Id = id;
        this.Name = name;
        this.Restaurant_Id = restaurant_Id;
        this.Description = description;   // fixed
        this.Price = price;
        this.Rating = rating;
        this.Image = image;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

    public int getRestaurant_Id() {
        return Restaurant_Id;
    }

    public void setRestaurant_Id(int restaurant_Id) {
        this.Restaurant_Id = restaurant_Id;
    }

    public String getDescription() {       // fixed
        return Description;
    }

    public void setDescription(String description) {   // fixed
        this.Description = description;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float price) {
        this.Price = price;
    }

    public float getRating() {
        return Rating;
    }

    public void setRating(float rating) {
        this.Rating = rating;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        this.Image = image;
    }

    @Override
    public String toString() {
        return "Menu [Id=" + Id + ", Name=" + Name +
               ", Restaurant_Id=" + Restaurant_Id +
               ", Description=" + Description +
               ", Price=" + Price + ", Rating=" + Rating +
               ", Image=" + Image + "]";
    }
}
