using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIMeow.Email
{
    public interface IEmailVerification
    {
        public string Email { get; }
        public Task<bool> SendEmail();
    }
}