using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Core.Dtos;
using Core.Entities;
using Infrastructure.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : BaseApiController
    {

        private readonly UserManager<User> _userManager;
        public SignInManager<User> _signInManager { get; set; }
        private readonly IConfiguration _configuration;
        private readonly DataContext _context;

        public UserController(UserManager<User> userManager, SignInManager<User> signInManager, IConfiguration configuration, DataContext context)
        {
            _context = context;
            _configuration = configuration;
            _signInManager = signInManager;
            _userManager = userManager;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(UserDto model)
        {
            var user = new User
            {
                UserName = model.UserName,
                Email = model.Email,
                Name = model.Name,
                Surname = model.Surname
            };

            var result = await _userManager.CreateAsync(user, model.Password);

            if (result.Succeeded)
            {
                return Ok(true);
            }

            return BadRequest(result.Errors);
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(UserForLoginDto model)
        {
            var user = await _userManager.FindByNameAsync(model.UserName);
            if (user == null)
            {
                return BadRequest(new { message = "username is incorrect" });
            }
            var result = await _signInManager.CheckPasswordSignInAsync(user, model.Password, false);

            if (result.Succeeded)
            {
                return Ok(new
                {
                    token = GenerateJwtToken(user)
                });
            }

            return Unauthorized();
        }

        [HttpGet("getUser")]
        public async Task<IActionResult> GetUser(string email)
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user == null)
            {
                user = await _userManager.FindByNameAsync(email);
                if (user == null)
                {
                    return BadRequest(new { message = "user not found" });
                }
            }

            return Ok(new UserDto
            {
                Id = user.Id,
                Name = user.Name,
                Surname = user.Surname,
                Email = user.Email,
                UserName = user.UserName
            });
        }

        [HttpGet("getUsers")]
        public async Task<IActionResult> GetUsers(int id)
        {
            var ids = await _context.Works.Where(w => w.OwnerId == id && w.PersonId.HasValue).Select( p => p.PersonId).ToListAsync();

            List<UserDto> list = new List<UserDto>();
            foreach (var i in ids)
            {
                var tmp = await _context.Users.FindAsync(i);
                list.Add(
                    new UserDto{
                        Name = tmp.Name,
                        Surname = tmp.Surname,
                        Email = tmp.Email,
                        UserName = tmp.UserName
                    }
                );
            }

            return Ok(list);
        }

        private string GenerateJwtToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration.GetSection("AppSettings:Secret").Value);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]{
                    new Claim(ClaimTypes.NameIdentifier , user.Id.ToString()),
                    new Claim(ClaimTypes.Name , user.UserName)
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }
    }
}