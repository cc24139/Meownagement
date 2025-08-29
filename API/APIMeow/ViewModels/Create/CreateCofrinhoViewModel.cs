
namespace APIMeow.ViewModels
{
    public class CreateCofrinhoViewModel
    {
        public decimal Economia { get; set; }
        public DateTime DataCriacao { get; set; }
        public DateTime DataTermino { get; set; }
        public char Feita { get; set; } = 'N';
        public string Nome { get; set; }
        public int IdClassificacao { get; set; }
        
    }
}