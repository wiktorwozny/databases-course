package org.example;

public class Customer extends Company {

    private double Discount;

    public Customer() {}

    public Customer(String companyName, String street, String city, String zipCode, double discount) {
        super(companyName, street, city, zipCode);
        this.Discount = discount;
    }
}
