using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;



using System;


public class Cofrinho
{
    [Key]
    public int IdCofrinho { get; set; }
    public decimal Economia { get; set; }
    public int QtsMoedas { get; set; }
    public decimal DinheiroEconomizado { get; set; }
    public DateTime DataCriacao { get; set; }
    public DateTime DataTermino { get; set; }
    public string Nome { get; set; }

    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }

    [ForeignKey("Classificacao")]
    public int IdClassificacao { get; set; }
    public Classificacao Classificacao { get; set; }
}
