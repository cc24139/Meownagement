using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.Models
{
    public class MetaCofrinhoTransacao
    {
        public int? IdMeta { get; set; }
        public int? IdCofrinho { get; set; }
        public int IdTransacao { get; set; }
    }
}