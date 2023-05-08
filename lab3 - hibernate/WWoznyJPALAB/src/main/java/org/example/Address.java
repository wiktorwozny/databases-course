package org.example;

import javax.persistence.Embeddable;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Embeddable
public class Address {

    private String Street;
    private String City;

    public Address() {}

    public Address(String street, String city) {
        this.Street = street;
        this.City = city;
    }

}
