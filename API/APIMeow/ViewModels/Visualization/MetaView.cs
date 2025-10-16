using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using APIMeow.Models; 

namespace APIMeow.ViewModels.Visualization
{
    public class MetaView
    {
        public Metas metas { get; set; }
        public List<Transacao> transacoes { get; set; }
        public decimal totalGasto { get; set; }
    }
}