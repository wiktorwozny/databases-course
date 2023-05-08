using System.Data.Entity;
using System.Data.Entity.Core.Objects;

namespace WiktorWoznyEPProducts
{
    class Program
    {
        static void Main(string[] args)
        {

            ProductContext productContext = new ProductContext();
            var suppliers = productContext.Companies.OfType<Supplier>().ToList();
            Console.WriteLine("Suppliers:");
            foreach (var supplier in suppliers)
            {
                Console.WriteLine($"{supplier.CompanyName} ({supplier.BankAccountNumber})");
            }

            var customers = productContext.Companies.OfType<Customer>().ToList();
            Console.WriteLine("Customers:");
            foreach (var customer in customers)
            {
                Console.WriteLine($"{customer.CompanyName} ({customer.Discount})");
            }

            /*ProductContext productContext = new ProductContext();
            Supplier supplier = new Supplier { City = "Warszawka", CompanyName = "WWA", Street = "ciekawa", BankAccountNumber = 123423123 };
            productContext.Suppliers.Add(supplier);

            Customer customer = new Customer { Street = "niewiem", City = "Trzciana", CompanyName = "MediFaraon", Discount = 0.10 };
            productContext.Customers.Add(customer);

            productContext.SaveChanges();*/


            /*ProductContext productContext = new ProductContext();
            List<Company> companies = productContext.Companies.ToList(); 
            foreach (Company company in companies)
            {
                Console.WriteLine(company.CompanyName);
            }*/


            /*ProductContext productContext = new ProductContext();
            Customer customer = new Customer { City = "Rzeszow", CompanyName = "Januszex", Discount = 0.15, Street = "mam zielone" };
            productContext.Customers.Add(customer);
            productContext.SaveChanges();*/



            /*ProductContext productContext = new ProductContext();
            Product product = productContext.Products.Find(3);
            Invoice invoice = productContext.Invoices.Find(2);
            product.Invoices.Add(invoice);
            productContext.SaveChanges();*/


            /*ProductContext productContext = new ProductContext();

            Supplier supplier = new Supplier { City = "Krakow", CompanyName = "DHL", Street = "mazowiecka", BankAccountNumber = 123123123 };

            var products = new List<Product>
                        {
                        new Product { ProductName = "product1", Supplier = supplier, UnitsOnStock = 1 },
                        new Product { ProductName = "product2", Supplier = supplier, UnitsOnStock = 2 },
                        new Product { ProductName = "product3", Supplier = supplier, UnitsOnStock = 3 },
                        new Product { ProductName = "product4", Supplier = supplier, UnitsOnStock = 4 },
                        new Product { ProductName = "product5", Supplier = supplier, UnitsOnStock = 5 },
                        new Product { ProductName = "product6", Supplier = supplier, UnitsOnStock = 6 },
                        new Product { ProductName = "product7", Supplier = supplier, UnitsOnStock = 7 }
                        };

            supplier.Products = products;

            productContext.Suppliers.Add(supplier);
            productContext.Products.AddRange(products);

            productContext.SaveChanges();*/

            //ProductContext productContext = new ProductContext();
            //Supplier supplier = productContext.Suppliers.FirstOrDefault(s => s.CompanyID == 1);
            //Product product = new Product { ProductName = "Flamaster", Supplier = supplier };
            //productContext.SaveChanges();
        }
    }
}


