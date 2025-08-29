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
    public class CofrinhoController : ControllerBase
    {
        [Authorize]
        [HttpGet("cofrinho/listar")]
        public async Task<IActionResult> ListarCofrinhos(DBMeownagement db)
        {
            try
            {
                var user = await db.Usuario.FindAsync(User.Identity.Name);
                if (user == null)
                {
                    return NotFound();
                }

                var cofrinhos = await db.Cofrinho
                    .Where(c => c.IdUsuario == user.IdUsuario)
                    .ToListAsync();

                return Ok(cofrinhos);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [Authorize]
        [HttpGet("cofrinho/listarConcluidos")]

        public async Task<IActionResult> ListarCofrinhosConcluidos(DBMeownagement db)
        {
            try
            {
                var user = await db.Usuario.FindAsync(User.Identity.Name);
                if (user == null)
                {
                    return NotFound();
                }

                var cofrinhos = await db.Cofrinho
                    .Where(c => c.IdUsuario == user.IdUsuario && c.Feita == 'S')
                    .ToListAsync();

                return Ok(cofrinhos);

            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [Authorize]
        [HttpGet("cofrinho/listarNaoConcluidos")]
        public async Task<IActionResult> ListarCofrinhosNaoConcluidos(DBMeownagement db)
        {
            try {
                var user = await db.Usuario.FindAsync(User.Identity.Name);
                if (user == null)
                {
                    return NotFound();
                }

                var cofrinhos = await db.Cofrinho
                    .Where(c => c.IdUsuario == user.IdUsuario && c.Feita == 'N')
                    .ToListAsync();

                return Ok(cofrinhos);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [Authorize]
        [HttpPut("cofrinho/criar")]
        public async Task<IActionResult> CriarCofrinho([FromBody] CreateCofrinhoViewModel model, DBMeownagement db)
        {
            try {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                var user = await db.Usuario.FindAsync(User.Identity.Name);
                if (user == null)
                {
                    return NotFound();
                }

                var cofre = new Cofrinho
                {
                    IdUsuario = user.IdUsuario,
                    Economia = model.Economia,
                    QtsMoedas = 2 * model.DataCriacao.Day + 67,
                    DinheiroEconomizado = 0,
                    DataCriacao = model.DataCriacao,
                    DataTermino = model.DataTermino,
                    Feita = model.Feita,
                    Nome = model.Nome,
                    IdClassificacao = model.IdClassificacao
                };

                db.Cofrinho.Add(cofre);
                await db.SaveChangesAsync();

                return CreatedAtAction(nameof(ListarCofrinhos), new { id = cofre.IdCofrinho }, cofre);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}