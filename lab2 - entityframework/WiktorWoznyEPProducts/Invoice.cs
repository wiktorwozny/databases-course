using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WiktorWoznyEPProducts
{
    class Invoice
    {
        public Invoice()
        {
            this.Products = new HashSet<Product>();
        }

        [Key]
        public int InvoiceNumber { get; set; }
        public int Quantity { get; set; }
        public virtual ICollection<Product> Products { get; set; }

    }
}
