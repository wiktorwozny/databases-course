package org.example;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int InvoiceNumber;
    private int Quantity;

    @ManyToMany (cascade = {CascadeType.PERSIST})
    Set<Product> IncludedProducts = new HashSet<Product>();

    public Invoice() {}

    public Invoice(int quantity) {
        this.Quantity = quantity;
    }

    public void sellProduct(Product product) {
        this.IncludedProducts.add(product);
    }
}
