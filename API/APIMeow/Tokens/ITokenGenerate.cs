using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace APIMeow.Tokens
{
    public interface ITokenGenerate<T>
    {
         string Generate(T dado);
         ClaimsIdentity GenerateClaim(T dado);
    
    }
}