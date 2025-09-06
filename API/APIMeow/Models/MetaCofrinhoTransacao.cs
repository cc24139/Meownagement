using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.Models
{
    public class MetaCofrinhoTransacao
    {
        [Key]
        public int IdRel { get; set; }
        public int? IdMeta { get; set; }
        public int? IdCofrinho { get; set; }
        [ForeignKey("Transacao")]
        public int IdTransacao { get; set; }
        public Transacao Transacao { get; set; }
    }
}