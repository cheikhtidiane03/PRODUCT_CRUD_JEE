package com.example.product_crud.dao;

import com.example.product_crud.model.Category;
import com.example.product_crud.model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private static List<Category> categories = new ArrayList<>();
    private static List<Product>  products   = new ArrayList<>();
    private static int nextProductId = 4;

    static {
        categories.add(new Category(1, "Électronique"));
        categories.add(new Category(2, "Alimentation"));
        categories.add(new Category(3, "Vêtements"));

        products.add(new Product(1, "Téléphone",  100000, 1));
        products.add(new Product(2, "Pain",          200, 2));
        products.add(new Product(3, "T-Shirt",      3500, 3));
    }


    public List<Category> getAllCategories() {
        return categories;
    }

    public Category getCategoryById(int id) {
        for (Category c : categories) {
            if (c.getId() == id) return c;
        }
        return null;
    }

    public List<Product> getAllProducts() {
        return products;
    }

    public Product getProductById(int id) {
        for (Product p : products) {
            if (p.getId() == id) return p;
        }
        return null;
    }

    public void addProduct(String name, double price, int categoryId) {
        products.add(new Product(nextProductId++, name, price, categoryId));
    }

    public void updateProduct(int id, String name, double price, int categoryId) {
        Product p = getProductById(id);
        if (p != null) {
            p.setName(name);
            p.setPrice(price);
            p.setCategoryId(categoryId);
        }
    }

    public void deleteProduct(int id) {
        products.removeIf(p -> p.getId() == id);
    }
}