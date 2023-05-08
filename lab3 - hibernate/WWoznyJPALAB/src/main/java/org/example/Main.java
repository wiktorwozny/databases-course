package org.example;

//import org.hibernate.HibernateException;
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.hibernate.Transaction;
//import org.hibernate.cfg.Configuration;
//import org.hibernate.query.Query;
//
//import java.sql.SQLOutput;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Objects;

//public class Main {
//    private static final SessionFactory ourSessionFactory;
//
//    static {
//        try {
//            Configuration configuration = new Configuration();
//            configuration.configure();
//
//            ourSessionFactory = configuration.buildSessionFactory();
//        } catch (Throwable ex) {
//            throw new ExceptionInInitializerError(ex);
//        }
//    }
//
//    public static Session getSession() throws HibernateException {
//        return ourSessionFactory.openSession();
//    }
//
//    public static void main(final String[] args) throws Exception {
//        final Session session = getSession();
//
//        Invoice invoice1 = new Invoice(2);
//        Invoice invoice2 = new Invoice(4);
//
//        try {
//            Transaction tx = session.beginTransaction();
//            Product prod1 = session.get(Product.class, 122);
//            Product prod2 = session.get(Product.class, 124);
//            Product prod3 = session.get(Product.class, 126);
//
//            invoice1.sellProduct(prod1);
//            invoice1.sellProduct(prod2);
//            invoice2.sellProduct(prod3);
//
//            session.save(invoice1);
//            session.save(invoice2);
//
//            tx.commit();
//        } finally {
//            session.close();
//        }
//    }

//        Supplier supplier1 = new Supplier("DHL", "mazowiecka", "Krakow");
//        Supplier supplier2 = new Supplier("SUPP", "kolorowa", "Warszawa");
//
//        Product product1 = new Product("product1", 10);
//        Product product2 = new Product("product2", 111);
//        Product product3 = new Product("product3", 20);
//        Product product4 = new Product("product4", 15);
//        Product product5 = new Product("product5", 4);
//}

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;


public class Main {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("WWoznyJPAConfig");
        EntityManager em = emf.createEntityManager();
        EntityTransaction etx = em.getTransaction();
        etx.begin();


        etx.commit();
        em.close();
    }
}



