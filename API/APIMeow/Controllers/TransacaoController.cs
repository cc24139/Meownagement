using System.Security.Claims;
using APIMeow.Models;
using APIMeow.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("v1")]

public class TransacaoController : ControllerBase
{
    //200
    [Authorize]
    [HttpGet("transacoes/listar")]
    public async Task<IActionResult> ListarTransacoes(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var userId = int.Parse(id);
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario == userId).ToListAsync();
        return Ok(listTransacoes);
    }
    [Authorize]
    [HttpGet("transacoes/listarRecorrentes")]
    public async Task<IActionResult> ListarTransacoesRecorrentes(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var userId = int.Parse(id);
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario == userId && t.IdRecorrencia != null).ToListAsync();
        return Ok(listTransacoes);
    }

    //200
    [Authorize]
    [HttpGet("transacoes/listarPositivo")]
    public async Task<IActionResult> ListarTransacoesPositivas(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var userId = int.Parse(id);
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario == userId && t.QuantiaDinheiro > 0).ToListAsync();
        return Ok(listTransacoes);
    }

    //200
    [Authorize]
    [HttpGet("transacoes/listarNegativo")]
    public async Task<IActionResult> ListarTransacoesNegativas(DBMeownagement db)
    {
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var userId = int.Parse(id);
        var listTransacoes = await db.Transacao.Where(t => t.IdUsuario == userId && t.QuantiaDinheiro < 0).ToListAsync();
        return Ok(listTransacoes);
    }

    //204
    [Authorize]
    [HttpPatch("transacoes/editar")]
    public async Task<IActionResult> EditarTransacao(Transacao transacao, DBMeownagement db)
    {
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (usuarioId != transacao.IdUsuario.ToString())
        {
            return BadRequest("Usuário não autorizado a editar esta transação.");
        }
        db.Entry(transacao).State = EntityState.Modified;
        await db.SaveChangesAsync();

        return NoContent();
    }
    //204
    [Authorize]
    [HttpDelete("transacoes/deletar/{id}")]
    public async Task<IActionResult> DeletarTransacao(int id, DBMeownagement db)
    {
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var transacao = await db.Transacao.FindAsync(id);
        if (transacao == null)
        {
            return NotFound();
        }
        if (usuarioId != transacao.IdUsuario.ToString())
        {
            return BadRequest("Usuário não autorizado a deletar esta transação.");
        }
        if(transacao.IdRecorrencia != null)
        {
            var recorrencia = await db.Recorrencia.Where(r => r.IdRecorrencia == transacao.IdRecorrencia).FirstOrDefaultAsync();
            if (recorrencia != null)
            {
                db.Recorrencia.Remove(recorrencia);
            }
        }
        db.Transacao.Remove(transacao);
        await db.SaveChangesAsync();

        return NoContent();
    }
    [Authorize]
    [HttpPost("transacoes/criar")]
    public async Task<IActionResult> CriarTransacao(TransacaoViewModel model, DBMeownagement db)
    {
        try
        {
            var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (db.Usuario.Find(int.Parse(usuarioId)) == null)
            {
                return BadRequest("Usuário não encontrado.");
            }
            var user = await db.Usuario.FindAsync(int.Parse(usuarioId));
            var novaTransacao = new Transacao
            {
                Nome = model.Nome,
                QuantiaDinheiro = model.QuantiaDinheiro,
                DataCriacao = model.DataCriacao,
                Feita = model.Feita,
                SaldoAtual = user.Saldo,
                DataFinalizacao = model.DataFinalizacao,
                IdUsuario = int.Parse(usuarioId),
                IdClassificacao = model.IdClassificacao,
                IdRecorrencia = model.IdRecorrencia,
            };
            
            await db.Transacao.AddAsync(novaTransacao);
            await db.SaveChangesAsync(); // Salva primeiro para gerar o ID
            
            if(model.IdMeta != null || model.IdCofrinho != null)
            {
                db.MetaCofrinhoTransacao.Add(new MetaCofrinhoTransacao
                {
                    IdMeta = model.IdMeta,
                    IdCofrinho = model.IdCofrinho,
                    IdTransacao = novaTransacao.IdTransacao
                });
            }
            await db.SaveChangesAsync();
            return Ok("Transação criada com sucesso");
        }
        catch (Exception ex)
        {
            return BadRequest($"Erro ao criar transação: {ex.Message}");
        }
    }

    [Authorize]
    [HttpGet("transacao/atualizar")]
    public async Task<IActionResult> AtualizarTransacoes(DBMeownagement db)
    {
        var qtsAtualizadas = 0;
        var usuarioId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var userId = int.Parse(usuarioId);
        var usuarioAtual = await db.Usuario.FindAsync(userId);
        var transacoesPendentes = await db.Transacao
            .Where(t => t.IdUsuario == userId && t.Feita=='N' && t.DataFinalizacao.Date == DateTime.Now.Date 
            && t.IdRecorrencia != null)
            .ToListAsync();
        foreach (var transacao in transacoesPendentes)
        {
            var metaCofrinhoTransacaoLigados = await db.MetaCofrinhoTransacao.Where(x=>x.IdTransacao == transacao.IdTransacao).ToListAsync();
            transacao.Feita = 'S';
            transacao.SaldoAtual = transacao.QuantiaDinheiro + usuarioAtual.Saldo;
            usuarioAtual.Saldo += transacao.QuantiaDinheiro;
            if (await GerarNovaTransacao(transacao, db, metaCofrinhoTransacaoLigados))
                qtsAtualizadas++;
        }

        await db.SaveChangesAsync();
        return Ok($"{qtsAtualizadas} transações atualizadas e saldo do usuário ajustado.");
    }

    private async Task<bool> GerarNovaTransacao(Transacao transacaoAntiga, DBMeownagement db, List<MetaCofrinhoTransacao> metaCofrinhoTransacaoLigados)
    {
        try
        {
            var recorrencia = await db.Recorrencia.FindAsync(transacaoAntiga.IdRecorrencia);
            DateTime novaDataFinalizacao = transacaoAntiga.DataFinalizacao
                .AddDays(recorrencia.QtsDias)
                .AddMonths(recorrencia.QtsMeses)
                .AddYears(recorrencia.QtsAnos);

            var novaTransacao = new Transacao
            {
                Nome = transacaoAntiga.Nome,
                QuantiaDinheiro = transacaoAntiga.QuantiaDinheiro,
                DataCriacao = transacaoAntiga.DataFinalizacao,
                Feita = 'N',
                SaldoAtual = transacaoAntiga.SaldoAtual,
                DataFinalizacao = novaDataFinalizacao,
                IdUsuario = transacaoAntiga.IdUsuario,
                IdClassificacao = transacaoAntiga.IdClassificacao,
                IdRecorrencia = transacaoAntiga.IdRecorrencia,
            };
            
            db.Transacao.Add(novaTransacao);
            await db.SaveChangesAsync(); // Salva primeiro para gerar o ID

            if (metaCofrinhoTransacaoLigados != null && metaCofrinhoTransacaoLigados.Count > 0)
                foreach (var x in metaCofrinhoTransacaoLigados)
                {
                    db.MetaCofrinhoTransacao.Add(new MetaCofrinhoTransacao
                    {
                        IdMeta = x.IdMeta,
                        IdCofrinho = x.IdCofrinho,
                        IdTransacao = novaTransacao.IdTransacao
                    });
                await db.SaveChangesAsync();
            }
            return true;
        }
        catch
        {
            return false;
        }
    }
        [Authorize]
        [HttpPatch("transacao/saldo")]
        public async Task<IActionResult> AtualizarSaldo(Transacao transacao, DBMeownagement db)
        {
            if (transacao.DataFinalizacao.Date == DateTime.Now.Date && transacao.Feita == 'N')
        {
            var usuario = await db.Usuario.FindAsync(transacao.IdUsuario);
            usuario.Saldo += transacao.QuantiaDinheiro;
            transacao.Feita = 'S';
            transacao.SaldoAtual = usuario.Saldo;
            await db.SaveChangesAsync();
            return Ok("Saldo Atualizado");
        }
            return BadRequest("Transação não pode ser atualizada");
        }
    }
