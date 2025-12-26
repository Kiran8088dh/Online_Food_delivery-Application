package com.restaurant.model;

public class Restaurant {

    private int id;   // changed from Id to id
    private String name;
    private String address;
    private float rating;
    private String description;
    private String image;

    public Restaurant() {}

    public Restaurant(int id, String name, String address,
                      float rating, String description, String image) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.rating = rating;
        this.description = description;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Restaurant [id=" + id + ", name=" + name + ", address=" + address +
                ", rating=" + rating + ", discription=" + description +
                ", image=" + image + "]";
    }
}
