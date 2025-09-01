using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace APIMeow.Controllers
{
    [ApiController]
    [Route("v1")]
    public class GatosController : ControllerBase
    {
        const int precoGacha = 160;
        [Authorize]
        [HttpGet("listar")]
        public async Task<IActionResult> ListarGatos(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var GatosUsuario = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => GatosUsuario.Contains(g.IdGato)).ToListAsync();
            return Ok(gatos);
        }
        [Authorize]
        [HttpGet("gatos/listarRaridade")]
        public async Task<IActionResult> ListarGatosPorRaridade(int raridade, DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var GatosUsuario = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => GatosUsuario.Contains(g.IdGato) && g.Raridade == raridade).ToListAsync();
            return Ok(gatos);
        }
        [Authorize]
        [HttpGet("gatos/roletar")]
        public async Task<IActionResult> RoletarBannerMeiMei(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var usuario = await db.Usuario.FindAsync(userId);
            if (usuario.Pontos < precoGacha)
            {
                return BadRequest("Você não possui pontos suficientes para roletar no banner MeiMei.");
            }
            var numAleatorio = new Random().Next(1, 1000);
            usuario.Pontos -= precoGacha;
            await db.SaveChangesAsync();
            return Ok(numAleatorio);
        }
        [Authorize]
        [HttpPost("gatos/adicionar")]
        public async Task<IActionResult> AdicionarGato([FromBody] string Nome, DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var usuario = await db.Usuario.FindAsync(userId);
            if (usuario.Pontos < 100)
            {
                return BadRequest("Você não possui pontos suficientes para adicionar um gato.");
            }
            var gato = await db.Gatos.FirstOrDefaultAsync(g => g.Nome == Nome);
            if (gato == null)
            {
                return NotFound("Gato não encontrado.");
            }
            var usuarioGatoExistente = await db.UsuarioGato.FirstOrDefaultAsync(ug => ug.IdUsuario == userId && ug.IdGato == gato.IdGato);
            if (usuarioGatoExistente != null)
            {
                usuarioGatoExistente.Copias += 1;
                return BadRequest("Você já possui esse gato.");
            }
            var usuarioGato = new UsuarioGato
            {
                IdUsuario = userId,
                IdGato = gato.IdGato
            };
            db.UsuarioGato.Add(usuarioGato);
            await db.SaveChangesAsync();
            return Ok("Gato adicionado com sucesso.");
        }

        [HttpGet("gatos/paleta")]
        public async Task<IActionResult> ObterGatoPorId(int id, DBMeownagement db)
        {
            var gato = await db.Gatos.FindAsync(id);
            if (gato == null)
            {
                return NotFound("Gato não encontrado.");
            }
            return Ok(gato.CodPaleta);
        }
    }
}