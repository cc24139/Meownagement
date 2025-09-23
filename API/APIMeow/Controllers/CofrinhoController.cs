using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using APIMeow.ViewModels;
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
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
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
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
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
            try
            {
            var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
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
        [HttpGet("cofrinho/listar/{data}")]
        public async Task<IActionResult> ListarCofrinhosPorData(DateTime data, DBMeownagement db)
        {
            try
            {
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
                if (user == null)
                {
                    return NotFound();
                }

                var cofrinhos = await db.Cofrinho
                    .Where(c => c.IdUsuario == user.IdUsuario && c.DataCriacao.Date == data.Date)
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
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
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
        [Authorize]
        [HttpDelete("cofrinho/deletar/{id}")]
        public async Task<IActionResult> DeletarCofrinho(int id, DBMeownagement db)
        {
            try
            {
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
                if (user == null)
                {
                    return NotFound();
                }

                var cofre = await db.Cofrinho.FindAsync(id);
                if (cofre == null || cofre.IdUsuario != user.IdUsuario)
                {
                    return NotFound();
                }

                db.Cofrinho.Remove(cofre);
                await db.SaveChangesAsync();

                return Ok("Cofrinho deletado com sucesso!");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erro ao deletar cofre: {ex.Message}");
            }
        }
        [Authorize]
        [HttpPatch("cofrinho/concluir/{id}")]
        public async Task<IActionResult> ConcluirCofrinho(int id, DBMeownagement db)
        {
            try
            {
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var user = await db.Usuario.FindAsync(idUser);
                var cofre = await db.Cofrinho.FindAsync(id);
                if (user == null || cofre == null || cofre.IdUsuario != user.IdUsuario)
                {
                    return NotFound();
                }
                if (cofre.DataTermino.Date > DateTime.Now.Date)
                {
                    return BadRequest("O cofrinho ainda não atingiu a data de término.");
                }
                var transacoes = db.Transacao.Where(x => x.IdUsuario == user.IdUsuario && x.IdClassificacao == cofre.IdClassificacao
                && x.Feita == 'S' && x.DataCriacao.Date >= cofre.DataCriacao.Date && x.DataFinalizacao.Date <= cofre.DataTermino.Date && x.QuantiaDinheiro > 0
                && db.MetaCofrinhoTransacao.Any(mct => mct.IdTransacao == x.IdTransacao && mct.IdCofrinho == cofre.IdCofrinho)
                ).ToList();
                var economias = transacoes.Sum(x => x.QuantiaDinheiro);
                if (economias >= cofre.Economia)
                {
                    cofre.Feita = 'S';
                    user.Pontos += cofre.QtsMoedas;
                    db.Cofrinho.Update(cofre);
                    db.Usuario.Update(user);
                    await db.SaveChangesAsync();
                    return Ok("Cofrinho concluído com sucesso!");
                }
                else
                {
                    cofre.Feita = 'N';
                    db.Cofrinho.Update(cofre);
                    await db.SaveChangesAsync();
                    return BadRequest("Você não atingiu o valor necessário para concluir o cofrinho.");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erro ao concluir cofre: {ex.Message}");
            }
        }
    }
}