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
    public class MetasController : ControllerBase
    {


        [Authorize]
        [HttpGet("metas/listar")]
        public async Task<IActionResult> ListarMetas(DBMeownagement db)
        {
            var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var listMetas = await db.Metas.Where(m => m.IdUsuario.ToString() == id).ToListAsync();
            return Ok(listMetas);
        }
        [Authorize]
        [HttpGet("metas/listarConcluidas")]
        public async Task<IActionResult> ListarMetasConcluidas(DBMeownagement db)
        {
            var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var listMetas = await db.Metas.Where(m => m.IdUsuario.ToString() == id && m.Feita == 'S').ToListAsync();
            return Ok(listMetas);
        }
        [Authorize]
        [HttpGet("metas/listarNaoConcluidas")]
        public async Task<IActionResult> ListarMetasNaoConcluidas(DBMeownagement db)
        {
            var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var listMetas = await db.Metas.Where(m => m.IdUsuario.ToString() == id && m.Feita == 'N').ToListAsync();
            return Ok(listMetas);
        }

        [Authorize]
        [HttpPost("metas/criar")]
        public async Task<IActionResult> CriarMeta([FromBody] CreateMetasViewModel meta, DBMeownagement db)
        {
            try
            {
                var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                var usuario = await db.Usuario.FindAsync(int.Parse(usuarioId));
                var classificacao = await db.Classificacao.FindAsync(meta.IdClassificacao);

                if (usuario == null || classificacao == null)
                {
                    return NotFound("Usuário ou classificação não encontrada.");
                }
                db.Metas.Add(new Metas
                {
                    Nome = meta.Nome,
                    GastoLimite = meta.GastoLimite,
                    QtsMoedas = 2 * meta.DataCriacao.Day + 67 ,
                    DataCriacao = meta.DataCriacao,
                    DataTermino = meta.DataTermino,
                    Feita = meta.Feita,
                    IdUsuario = usuario.IdUsuario,
                    IdClassificacao = classificacao.IdClassificacao
                });
                await db.SaveChangesAsync();

                return Ok("Meta criada com sucesso!");
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao criar a meta: {ex.Message}");
            }
        }
        [Authorize]
        [HttpDelete("metas/deletar/{id}")]
        public async Task<IActionResult> DeletarMeta(int id, DBMeownagement db)
        {
            try
            {
                var meta = await db.Metas.FindAsync(id);
                if (meta == null)
                {
                    return NotFound("Meta não encontrada.");
                }

                db.Metas.Remove(meta);
                await db.SaveChangesAsync();

                return Ok("Meta deletada com sucesso!");
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao deletar a meta: {ex.Message}");
            }
        }

        [Authorize]
        [HttpPatch("metas/Concluir/{id}")]
        public async Task<IActionResult> ConcluirMeta(int id, DBMeownagement db)
        {
            try
            {
                var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                var meta = await db.Metas.FindAsync(id);
                if (usuarioId != meta.IdUsuario.ToString())
                {
                    return BadRequest("Usuário não autorizado a concluir esta meta.");
                }

                var metaExistente = await db.Metas.FindAsync(meta.IdMeta);
                if (metaExistente == null)
                {
                    return NotFound("Meta não encontrada.");
                }
                if (meta.DataTermino.Date == DateTime.Now.Date && meta.Feita == 'N')
                {
                    var listTransacaoGastos = await db.Transacao
                    .Where(t => t.IdUsuario.ToString() == usuarioId && t.IdClassificacao == meta.IdClassificacao
                    && t.Feita == 'S'&& t.DataCriacao.Date >= meta.DataCriacao.Date && t.DataFinalizacao.Date <= meta.DataTermino.Date && t.QuantiaDinheiro < 0
                    //Busca todas as transacoes relacionadas a meta
                    && db.MetaCofrinhoTransacao.Any(mct => mct.IdTransacao == t.IdTransacao && mct.IdMeta == meta.IdMeta) 
                    )
                    .ToListAsync();
                    decimal gastoTotal = listTransacaoGastos.Sum(t => t.QuantiaDinheiro*(-1));
                    if (gastoTotal < meta.GastoLimite)
                    {
                        var usuario = await db.Usuario.FindAsync(meta.IdUsuario);
                        usuario.Pontos += meta.QtsMoedas;
                        meta.Feita = 'S';
                        await db.SaveChangesAsync();
                        return Ok("Meta concluída com sucesso! Moedas adicionadas ao saldo.");
                    }
                    else
                    {
                        meta.Feita = 'N';
                        await db.SaveChangesAsync();
                        return Ok("Gastos excedeu a meta :( sem pontos adicionados.");
                    }
                }
                else
                {
                    return Ok("Meta ainda não atingiu a data de término.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao concluir a meta: {ex.Message}");
            }
        }
    }
}