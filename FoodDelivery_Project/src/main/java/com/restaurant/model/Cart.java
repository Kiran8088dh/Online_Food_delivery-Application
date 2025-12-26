package com.restaurant.model;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart {

    private Map<Integer, CartItem> items = new HashMap<>();

    // Add item to cart
    public void addItem(CartItem item) {
        int itemId = item.getItemId();
        
        if (items.containsKey(itemId)) {
            CartItem existingItem = items.get(itemId);
            existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
        } else {
            items.put(itemId, item);
        }
    }

    // Update item quantity
    public void updateItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            CartItem item = items.get(itemId);
            item.setQuantity(quantity);
        }
    }

    // Remove item from cart
    public void removeItem(int itemId) {
        items.remove(itemId);
    }

    // Get all cart items
    public Collection<CartItem> getItems() {
        return items.values();
    }

    // Get total cart price
    public float getTotalCartPrice() {
        float total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    // Get total quantity of all items in the cart
    public int getTotalQuantity() {
        int totalQty = 0;
        for (CartItem item : items.values()) {
            totalQty += item.getQuantity();
        }
        return totalQty;
    }

    // Clear the entire cart
    public void clearCart() {
        items.clear();
    }
}
