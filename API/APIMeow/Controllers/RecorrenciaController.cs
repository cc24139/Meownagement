using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace APIMeow.Controllers
{
    [ApiController]
    [Route("v1")]
    public class RecorrenciaController : ControllerBase
    {
        [Authorize]
        [HttpGet("recorrencia/listar")]
        public async Task<IActionResult> ListarRecorrencias(DBMeownagement db)
        {
            try
            {
                var idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var transacoesIds = await db.Transacao
                    .Where(t => t.IdUsuario == idUsuario)
                    .Select(t => t.IdRecorrencia)
                    .ToListAsync();
                var recorrencias = await db.Recorrencia
                    .Where(r => transacoesIds.Contains(r.IdRecorrencia))
                    .ToListAsync();

            return Ok(recorrencias);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }


        }

        [Authorize]
        [HttpGet("recorrencia/{id}")]
        public async Task<IActionResult> RecorrenciaId(int id, DBMeownagement db)
        {
            try
            {
                var idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var recorrencia = await db.Recorrencia.Where(r => r.IdRecorrencia == id).FirstOrDefaultAsync();

                if (recorrencia == null)
                {
                    return NotFound();
                }

                return Ok(recorrencia);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [Authorize]
        [HttpDelete("recorrencia/deletar/{id}")]
        public async Task<IActionResult> DeletarRecorrencia(int id, DBMeownagement db)
        {
            try
            {
                var idUsuario = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
                var recorrencia = await db.Recorrencia.FindAsync(id);
                var transacao = await db.Transacao.Where(t=> t.IdRecorrencia == id).FirstOrDefaultAsync();
                transacao.IdRecorrencia = null;
                db.Recorrencia.Remove(recorrencia);
                await db.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [Authorize]
        [HttpPost("recorrencia/criar")]

        public async Task<IActionResult> CriarRecorrencia(Recorrencia model, DBMeownagement db)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
            var recorrencia = new Recorrencia
            {
                QtsDias = model.QtsDias,
                QtsAnos = model.QtsAnos,
                QtsMeses = model.QtsMeses
            };
            db.Recorrencia.Add(recorrencia);
            await db.SaveChangesAsync();
            return Ok("Criado com sucesso");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
        }
    }
}