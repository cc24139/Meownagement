using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Post
{
    [Key]
    public int IdPost { get; set; }
    public string Titulo { get; set; }
    public string Conteudo { get; set; }
    public DateTime Data { get; set; }
    public int Likes { get; set; }
    public int Deslikes { get; set; }

    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }

    public ICollection<Comentario> Comentarios { get; set; }
}
