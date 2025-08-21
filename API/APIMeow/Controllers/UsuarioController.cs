using APIMeow.Controllers;
using APIMeow.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController]
[Route("v1")]
public class UsuarioController : ControllerBase
{
    [HttpPost]
    [Route("usuarios/login")]
    public async Task<IActionResult> Login([FromBody] LoginViewModel Login, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(Login.Login) || string.IsNullOrEmpty(Login.Senha))
        {
            return BadRequest("Usuário ou senha inválidos.");
        }
        var achou = await db.Usuario
            .FirstOrDefaultAsync(u => u.Email == Login.Login && u.Senha == Login.Senha);

        if (achou == null)
        {
            return Unauthorized("Usuário ou senha inválidos.");
        }
        var token = new TokenJWTUsuario();
        return Ok(new { Token = token.Generate(achou) });
    }

    [Authorize]
    [HttpGet]
    [Route("usuarios/listar")]
    public async Task<IActionResult> ListarUsuarios(DBMeownagement db)
    {
        var usuarios = await db.Usuario.AsNoTracking().ToListAsync();
        if (usuarios == null || !usuarios.Any())
        {
            return NotFound("Nenhum usuário encontrado.");
        }
        return Ok(usuarios);
    }
}