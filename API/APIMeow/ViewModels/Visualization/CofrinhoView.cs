using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.ViewModels.Visualization
{
    public class CofrinhoView
    {
        public Cofrinho cofrinho { get; set; }
        public List<Transacao> transacoes { get; set; }
        public decimal totalGanho { get; set; }
    }
}