using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using APIMeow.Tokens;
using Microsoft.IdentityModel.Tokens;

namespace APIMeow.Tokens
{
    public class TokenJWTUsuario : ITokenGenerate<Usuario>
    {
        private JwtSecurityTokenHandler _handler = new JwtSecurityTokenHandler();
        public string Generate(Usuario user)
        {
            //Instancia o pacote JWT
             _handler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(Configuration.PrivateKey);
            var credencial = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = GenerateClaim(user),
                SigningCredentials = credencial,
                Expires = DateTime.UtcNow.AddHours(2)
            };
            //Geração do token e sua string para enviar
            var token = _handler.CreateToken(tokenDescriptor);
            return _handler.WriteToken(token);
        }
        public  ClaimsIdentity GenerateClaim (Usuario user)
        {
            var ci = new ClaimsIdentity();
            ci.AddClaim(new Claim(ClaimTypes.Email, user.Email));
            ci.AddClaim(new Claim(ClaimTypes.NameIdentifier, user.IdUsuario.ToString()));
            return ci;
        }


        
    }
}