using APIMeow.Controllers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("v1/usuarios")]
public class UsuarioController : ControllerBase
{
    [HttpPost]
    [Route("login")]
    public async Task<IActionResult> Login([FromBody] string Login,string Senha, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(Login) || string.IsNullOrEmpty(Senha))
        {
            return BadRequest("Usuário ou senha inválidos.");
        }
        var achou = db.Usuario
            .FirstOrDefault(u => u.Email == Login && u.Senha == Senha);

        if (achou == null)
        {
            return Unauthorized("Usuário ou senha inválidos.");
        }
        var token = new TokenJWTUsuario();
        return Ok(new { Token = token.Generate(achou) });
    }

    [Authorize]
    [HttpGet]
    [Route("listar")]
    public IActionResult ListarUsuarios(DBMeownagement db)
    {
        var usuarios = db.Usuario.ToList();
        return Ok(usuarios);
    }
}