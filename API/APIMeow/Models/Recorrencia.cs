
using System.ComponentModel.DataAnnotations;

public class Recorrencia
{
   [Key]
   public int IdRecorrencia { get; set; }
   public int QtsDias { get; set; }
   public int QtsMeses { get; set; }
   public int QtsAnos { get; set; }
}
