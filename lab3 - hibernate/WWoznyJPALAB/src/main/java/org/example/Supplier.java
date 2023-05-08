package org.example;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

//@Entity
//@SecondaryTable(name = "ADDRESS_TBL")
//public class Supplier {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
//    private int dbID;
//
//    private String CompanyName;
//
//    @Column(table = "ADDRESS_TBL")
//    private String Street;
//
//    @Column(table = "ADDRESS_TBL")
//    private String City;
//
//    @OneToMany
//    @JoinColumn(name = "SUPPLIER_DBID")
//    private Set<Product> Products = new HashSet<Product>();
//
//
//    public Supplier() {
//    }
//
////    public Supplier(String companyName, Address address) {
////        this.CompanyName = companyName;
////        this.Address = address;
////    }
//
//    public Supplier(String companyName, String city, String street) {
//        this.CompanyName = companyName;
//        this.Street = street;
//        this.City = city;
//    }
//
//    public void addProduct(Product product) {
//        this.Products.add(product);
//        product.setSupplier(this);
//    }
//
//    public Set<Product> getProducts() {
//        return Products;
//    }
//}

@Entity
public class Supplier extends Company {

    private String bankAccountNumber;

    public Supplier() {}

    public Supplier(String companyName, String street, String city, String zipCode, String bankAccountNumber) {
        super(companyName, street, city, zipCode);
        this.bankAccountNumber = bankAccountNumber;
    }

}
