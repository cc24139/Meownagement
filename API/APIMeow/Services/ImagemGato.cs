using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.Services
{

    public class ImagemGatos : Gatos
    {
       private string UrlBase => $"..\\..\\Resources\\gatosGacha\\imagensTamanhos\\{NomeImagem}";
        public string imagemPequena => $"{UrlBase}\\{NomeImagem}Pequena.jpg";
        public string imagemMedia => $"{UrlBase}\\{NomeImagem}Media.jpg";
        public string imagemGrande => $"{UrlBase}\\{NomeImagem}Grande.jpg";
    }
}