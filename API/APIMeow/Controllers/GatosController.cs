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
        [HttpGet("gatos/listar")]
        public async Task<IActionResult> ListarGatos(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var GatosUsuario = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => GatosUsuario.Contains(g.IdGato)).ToListAsync();
            return Ok(gatos);
        }

        [Authorize]
        [HttpGet("gatos/listarNome/{nome}")]
        public async Task<IActionResult> ListarGatosPorNome(string nome, DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var GatosUsuario = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => GatosUsuario.Contains(g.IdGato) && g.Nome.Contains(nome)).ToListAsync();
            return Ok(gatos);
        }

        [Authorize]
        [HttpGet("gatos/listarIdGato/{id:int}")]
        public async Task<IActionResult> ListarGatosPorId(int id, DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var GatosUsuario = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => GatosUsuario.Contains(g.IdGato) && g.IdGato == id).ToListAsync();
            return Ok(gatos);
        }

        [Authorize]
        [HttpGet("gatos/listarRaridade")]
        public async Task<IActionResult> ListarGatosPorRaridade([FromQuery] int raridade, DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var GatosUsuario = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => GatosUsuario.Contains(g.IdGato) && g.Raridade == raridade).ToListAsync();
            return Ok(gatos);
        }
        [Authorize]
        [HttpGet("gatos/estaticas/{id}")]
        public async Task<IActionResult> ObterGatoEstatico(int id, DBMeownagement db)
        {
            var gato = await db.Gatos.FindAsync(id);
            if (gato == null)
            {
                return NotFound("Gato não encontrado.");
            }
            var qtsUsuarios = await db.Usuario.CountAsync();
            var qtsPossuem = await db.UsuarioGato.CountAsync(ug => ug.IdGato == id) / qtsUsuarios * 100; //porcentagem
            var qtsCopias = await db.UsuarioGato.Where(ug => ug.IdGato == id).SumAsync(ug => ug.Copias);
            return Ok(new { gato, qtsPossuem, qtsCopias });
        }
        [Authorize]
        [HttpGet("gatos/listarDesbloqueados")]
        public async Task<IActionResult> ListarGatosDesbloqueados(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var gatosIds = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => gatosIds.Contains(g.IdGato)).OrderBy(g => g.Raridade).ThenBy(g => g.Nome).ToListAsync();
            return Ok(gatos);
        }
        [Authorize]
        [HttpGet("gatos/listarBloqueados")]
        public async Task<IActionResult> ListarGatosBloqueados(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var gatosIds = await db.UsuarioGato.Where(ug => ug.IdUsuario == userId).Select(ug => ug.IdGato).ToListAsync();
            var gatos = await db.Gatos.Where(g => !gatosIds.Contains(g.IdGato)).OrderBy(g => g.Raridade).ThenBy(g => g.Nome).ToListAsync();
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
        [HttpGet("gatos/equipado")]

        public async Task<IActionResult> ObterGatoEquipado(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var gatoEquipado = await db.Gatos
                .Where(g => g.IdGato == db.UsuarioGato
                    .Where(ug => ug.IdUsuario == userId && ug.Equipado == 'S')
                    .Select(ug => ug.IdGato)
                    .FirstOrDefault()).FirstOrDefaultAsync();
            if (gatoEquipado == null)
            {
                return NotFound("Gato não encontrado.");
            }
            return Ok(gatoEquipado);
        }

        [Authorize]
        [HttpPatch("gatos/equipar/{idGato}")]
        public async Task<IActionResult> EquiparGato(int idGato, DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var usuarioGato = await db.UsuarioGato.FirstOrDefaultAsync(ug => ug.IdUsuario == userId && ug.IdGato == idGato);
            if (usuarioGato == null)
            {
                return NotFound("Você não possui esse gato.");
            }
            var gatoAtualmenteEquipado = await db.UsuarioGato.FirstOrDefaultAsync(ug => ug.IdUsuario == userId && ug.Equipado == 'S');
            if (gatoAtualmenteEquipado != null)
            {
                gatoAtualmenteEquipado.Equipado = 'N';
            }
            usuarioGato.Equipado = 'S';
            await db.SaveChangesAsync();
            return Ok("Gato equipado com sucesso.");
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
                IdGato = gato.IdGato,
                Equipado = 'N',
                Copias = 1
            };
            db.UsuarioGato.Add(usuarioGato);
            await db.SaveChangesAsync();
            return Ok("Gato adicionado com sucesso.");
        }

        [HttpGet("gatos/paleta/{id}")]
        public async Task<IActionResult> ObterGatoPorId(int id, DBMeownagement db)
        {
            var gato = await db.Gatos.FindAsync(id);
            if (gato == null)
            {
                return NotFound("Gato não encontrado.");
            }
            return Ok(gato.CodPaleta);
        }
        [Authorize]
        [HttpGet("gatos/paleta/usuario")]
        public async Task<IActionResult> ObterPaletaUsuario(DBMeownagement db)
        {
            var userId = int.Parse(User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value);
            var paleta = await db.UsuarioGato
                .Where(ug => ug.IdUsuario == userId)
                .Select(ug => ug.Gato.CodPaleta)
                .ToListAsync();
            return Ok(paleta);
        }
    }
}