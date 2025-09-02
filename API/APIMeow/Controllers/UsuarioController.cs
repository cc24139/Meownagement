using APIMeow.Controllers;
using APIMeow.Hash;
using APIMeow.Tokens;
using APIMeow.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
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
            return BadRequest("Campos Inválidos!");
        }
        var user = await db.Usuario
            .FirstOrDefaultAsync(u => u.Email == Login.Login && u.Senha == Login.Senha);
        var hash = new PasswordHasher<Usuario>();
        var verifica = hash.VerifyHashedPassword(user, user.Senha, Login.Senha);
        if (verifica == PasswordVerificationResult.Failed)
        {
            return Unauthorized("Usuário ou senha inválidos.");
        }
        var token = new TokenJWTUsuario();
        return Ok(new { Token = token.Generate(user) });
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

    [Authorize]
    [HttpPost]
    [Route("usuarios/cadastrar")]
    public async Task<IActionResult> CadastrarUsuario([FromBody] Usuario usuario, DBMeownagement db)
    {
        if (string.IsNullOrEmpty(usuario.Nome) || string.IsNullOrEmpty(usuario.Email) || string.IsNullOrEmpty(usuario.Senha))
        {
            return BadRequest("Nome, email ou senha inválidos.");
        }
        var emailExistente = await db.Usuario.AnyAsync(u => u.Email == usuario.Email);
        if (emailExistente)
        {
            return Conflict("Email já está em uso.");
        }
        var senhaHash = new HashUsuario(db);
        await senhaHash.RegistrarUsuarioAsync(usuario.Nome, usuario.Senha);
        usuario.Senha = senhaHash.ToString();
        db.Usuario.Add(usuario);
        await db.SaveChangesAsync();
        return CreatedAtAction(nameof(CadastrarUsuario), new { id = usuario.IdUsuario }, usuario);
    }

    [Authorize]
    [HttpPatch]
    [Route("usuarios/editar")]
    public async Task<IActionResult> EditarUsuario([FromBody] Usuario usuario, DBMeownagement db)
    {
        if (usuario.IdUsuario <= 0 || string.IsNullOrEmpty(usuario.Nome) || string.IsNullOrEmpty(usuario.Email))
        {
            return BadRequest("ID, nome ou email inválidos.");
        }
        var usuarioExistente = await db.Usuario.FindAsync(usuario.IdUsuario);
        if (usuarioExistente == null)
        {
            return NotFound("Usuário não encontrado.");
        }
        usuarioExistente.Nome = usuario.Nome;
        usuarioExistente.Email = usuario.Email;
        await db.SaveChangesAsync();
        return Ok(usuarioExistente);
    }
}