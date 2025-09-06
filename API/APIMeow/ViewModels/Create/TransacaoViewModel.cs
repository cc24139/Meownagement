using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.ViewModels
{
    public class TransacaoViewModel
    {
        public string Nome { get; set; }
        public decimal QuantiaDinheiro { get; set; }
        public DateTime DataCriacao { get; set; }
        public char Feita { get; set; } = 'N';
        public decimal SaldoAtual { get; set; }
        public DateTime DataFinalizacao { get; set; }
        public int IdClassificacao { get; set; }
        public int? IdRecorrencia { get; set; }
        public int? IdMeta { get; set; }
        public int? IdCofrinho { get; set; }
    }
}