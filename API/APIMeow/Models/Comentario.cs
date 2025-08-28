using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Comentario
{
    [Key]
    public int IdComentario { get; set; }
    public string Titulo { get; set; }
    public string Conteudo { get; set; }
    public DateTime Data { get; set; }
    public int Likes { get; set; }
    public int Deslikes { get; set; }

    [ForeignKey("Usuario")]
    public int IdUsuario { get; set; }
    public Usuario Usuario { get; set; }

    [ForeignKey("Post")]
    public int IdPost { get; set; }
    public Post Post { get; set; }
}
