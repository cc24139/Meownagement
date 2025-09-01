using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.Services
{

    public interface IGatoImagem
    {
        string NomeImagem { get; set; }
    }

    public class ImagemGatos<T> where T : Gatos, IGatoImagem
    {
        private readonly T _gatoImagem;

        public ImagemGatos(T gatoImagem)
        {
            _gatoImagem = gatoImagem;
        }

        private string UrlBase => $"..\\..\\Resources\\gatosGacha\\imagensTamanhos\\{_gatoImagem.NomeImagem}";
        public string imagemPequena => $"{UrlBase}\\{_gatoImagem.NomeImagem}Pequena.jpg";
        public string imagemMedia => $"{UrlBase}\\{_gatoImagem.NomeImagem}Media.jpg";
        public string imagemGrande => $"{UrlBase}\\{_gatoImagem.NomeImagem}Grande.jpg";
    }
}