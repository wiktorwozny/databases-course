using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WiktorWoznyEPProducts
{
    class Product
    {
        public Product()
        {
            this.Invoices = new HashSet<Invoice>();
        }

        [Key]
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public int UnitsOnStock { get; set; }
        public Supplier? Supplier { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}
