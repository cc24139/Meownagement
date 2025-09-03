using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
namespace APIMeow.Hash
{
    public class HashUsuario
    {
        private readonly DBMeownagement _context;
        private readonly PasswordHasher<Usuario> _passwordHasher = new PasswordHasher<Usuario>();

        public HashUsuario(DBMeownagement context)
        {
            _context = context;
        }

        public async Task RegistrarUsuarioAsync(Usuario usuario)
        {
            usuario.Senha = _passwordHasher.HashPassword(usuario, usuario.Senha);
            await _context.Usuario.AddAsync(usuario);
            await _context.SaveChangesAsync();
        }
        
    }
}