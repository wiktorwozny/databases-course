package org.example;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int dbID;

    private String ProductName;
    private int UnitsOnStock;
    @ManyToOne
    @JoinColumn(name = "SUPPLIER_DBID")
    private Supplier Supplier;

    @ManyToMany (mappedBy = "IncludedProducts", cascade = {CascadeType.PERSIST})
    private Set<Invoice> Invoices = new HashSet<Invoice>();

    public Product() {}

    public Product(String productName, int unitsOnStock) {
        this.ProductName = productName;
        this.UnitsOnStock = unitsOnStock;
    }

//    public void setSupplier(Supplier supplier) {
//        this.Supplier = supplier;
//        this.Supplier.getProducts().add(this);
//    }

    public String getProductName() {
        return ProductName;
    }

    public void addInvoice(Invoice invoice) {
        this.Invoices.add(invoice);
    }
}
