using System.ComponentModel.DataAnnotations;

namespace APIMeow.ViewModels
{
    public class EditarUsuarioViewModel
    {
        public string? Nome { get; set; }
        public string? Biografia { get; set; }
        public string? Senha { get; set; } = string.Empty;
    }
}
