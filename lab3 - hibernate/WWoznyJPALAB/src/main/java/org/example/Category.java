package org.example;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int CategoryID;
    private String Name;
    @OneToMany
    private List<Product> Products = new ArrayList<Product>();

    public Category() {}

    public Category(String name) {
        this.Name = name;
    }

    public void addProduct(Product product) {
        this.Products.add(product);
    }

    public String getName() {
        return Name;
    }
}
