using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Minik.Server.Models;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace Minik.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RegisterController : ControllerBase
    {
        private readonly string _connectionString;

        public RegisterController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpPost("register")]
        public IActionResult Register([FromBody] Users2DTO user)
        {
            if (!ModelState.IsValid)
                return BadRequest("Geçersiz giriş verileri.");

            if (!new EmailAddressAttribute().IsValid(user.Email))
                return BadRequest("Geçerli bir e-posta adresi girin.");

            if (!IsValidPassword(user.PasswordHash))
                return BadRequest("Şifre en az 8 karakter, bir büyük harf, bir rakam ve bir özel karakter içermelidir.");

            if (IsEmailAlreadyExists(user.Email))
                return BadRequest("Bu e-posta adresi zaten kullanılıyor.");

            if (IsPhoneNumberAlreadyExists(user.PhoneNumber))
                return BadRequest("Bu telefon numarası zaten kullanılıyor.");

            // role_id doğrulaması: 0, 1, 2 dışında değer girilemez
            int roleId = user.RoleId ?? 1; // null ise varsayılan olarak 1

            if (roleId < 0 || roleId > 2)
                return BadRequest("RoleId yalnızca 0, 1 veya 2 olabilir.");

            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(user.PasswordHash);

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = @"
                    INSERT INTO users (full_name, email, password_hash, role_id, phone_number)
                    VALUES (@full_name, @email, @password_hash, @role_id, @phone_number)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@full_name", user.FullName);
                    cmd.Parameters.AddWithValue("@email", user.Email);
                    cmd.Parameters.AddWithValue("@password_hash", hashedPassword);
                    cmd.Parameters.AddWithValue("@role_id", roleId);
                    cmd.Parameters.AddWithValue("@phone_number", user.PhoneNumber);

                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { Message = "Kayıt başarılı." });
        }

        private bool IsEmailAlreadyExists(string email)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM users WHERE email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool IsPhoneNumberAlreadyExists(string phoneNumber)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "SELECT COUNT(*) FROM users WHERE phone_number = @Phone";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Phone", phoneNumber);
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool IsValidPassword(string password)
        {
            return password.Length >= 8 &&
                   password.Any(char.IsUpper) &&
                   password.Any(char.IsDigit) &&
                   password.Any(ch => "!@#$%^&*()".Contains(ch));
        }
    }
}
