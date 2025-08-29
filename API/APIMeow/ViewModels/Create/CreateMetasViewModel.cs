using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.ViewModels
{
    public class CreateMetasViewModel
    {
 public string Nome { get; set; }
    public decimal GastoLimite { get; set; }
    public int QtsMoedas { get; set; }
    public DateTime DataCriacao { get; set; }
    public DateTime DataTermino { get; set; }
    public char Feita { get; set; } = 'N';
    public int IdUsuario { get; set; }
   
    public int IdClassificacao { get; set; }

    }
}