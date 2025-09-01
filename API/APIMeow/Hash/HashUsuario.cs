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

        public async Task RegistrarUsuarioAsync(string user, string senha)
        {
            var usuario = new Usuario
            {
                Nome = user,
                Senha = _passwordHasher.HashPassword(null, senha)
            };
            
                await _context.Usuario.AddAsync(usuario);
                await _context.SaveChangesAsync();  
        }
    }
}