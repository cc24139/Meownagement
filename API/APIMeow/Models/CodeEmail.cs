using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.Models
{
    public class CodeEmail
    {
        /*create table Meownagement.CodeEmail(
	idUsuario int foreign key references Meownagement.Usuario(idUsuario),
	code varchar(6) unique,
	tempoExp dateTime,
	email varchar(67) unique,
	nome varchar(100),
	biografia varchar (200),
	senha varchar(50)
)
)*/

        [Key]
        public int IdCode { get; set; }
        public string Code { get; set; }
        public string Email { get; set; }
        public DateTime TempoExp { get; set; }
        public string Nome { get; set; }
        public string? Biografia { get; set; }
        public string Senha { get; set; }
    }
}