using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using APIMeow.ViewModels;
using APIMeow.ViewModels.Visualization;
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
        [HttpGet("cofrinho/listar/classificacao/{idClassificacao}")]
        public async Task<IActionResult> ListarCofrinhosPorClassificacao(int idClassificacao, DBMeownagement db)
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
                    .Where(c => c.IdUsuario == user.IdUsuario && c.IdClassificacao == idClassificacao)
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
        [HttpGet("cofrinho/listar/data/{data}")]
        public async Task<IActionResult> ListarCofrinhosPorData(DateTime data, DBMeownagement db)
        {
            try
            {
                var idUser = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value!);
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
        [HttpGet("cofrinho/listarGanho")]
        public async Task<IActionResult> ListarCofrinhosGanho(DBMeownagement db)
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

                var totalGanho = cofrinhos.Sum(c => c.Economia);

                return Ok(new { cofrinhos, totalGanho });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [Authorize]
        [HttpGet("cofrinho/listarPorcentagem")]
        public async Task<IActionResult> ListarCofrinhosPorcentagem(DBMeownagement db)
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

                var listCofrinhoViewm = new List<CofrinhoView>();
                foreach (var cofrinho in cofrinhos)
                {
                    var porcentagem = await CalcularPorcentagemConcluida(cofrinho, db);
                    listCofrinhoViewm.Add(new CofrinhoView
                    {
                        cofrinho = cofrinho,
                        totalGanho = porcentagem > 100 ? 100 : porcentagem < 0 ? 0 : porcentagem
                    });
                }

                return Ok(new { listCofrinhoViewm });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        private async Task<decimal> CalcularPorcentagemConcluida(Cofrinho cofrinho, DBMeownagement db)
        {
            var transacoes = db.Transacao.Where(x =>
                x.IdUsuario == cofrinho.IdUsuario &&
                x.IdClassificacao == cofrinho.IdClassificacao &&
                x.Feita == 'S' &&
                x.DataCriacao.Date >= cofrinho.DataCriacao.Date &&
                x.DataFinalizacao.Date <= cofrinho.DataTermino.Date &&
                x.QuantiaDinheiro > 0 &&
                db.MetaCofrinhoTransacao.Any(mct =>  mct.IdCofrinho == cofrinho.IdCofrinho)).ToList();
            if (transacoes.Count == 0)
            {
                return 0;
            }
            var economias = transacoes.Sum(x => x.QuantiaDinheiro);
            cofrinho.DinheiroEconomizado = economias;
            db.Cofrinho.Update(cofrinho);
            await db.SaveChangesAsync();
            return Math.Abs(economias) / cofrinho.Economia * 100;
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
                    QtsMoedas = 100 * Math.Abs(model.DataTermino.DayOfYear - model.DataCriacao.DayOfYear) + 67,
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
                    cofre.Feita = 'S';
                    db.Cofrinho.Update(cofre);
                    await db.SaveChangesAsync();
                    return BadRequest("Você não atingiu o valor necessário para concluir o cofrinho. :( sem pontos adicionados");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erro ao concluir cofre: {ex.Message}");
            }
        }
    }
}