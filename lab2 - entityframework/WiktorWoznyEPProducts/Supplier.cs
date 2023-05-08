using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WiktorWoznyEPProducts
{
    class Supplier : Company
    {
        public int BankAccountNumber { get; set; }
        public ICollection<Product>? Products { get; set; }

    }
}
