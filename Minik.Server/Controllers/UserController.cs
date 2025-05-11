using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using Minik.Server.Models;


using BCrypt.Net;

namespace Minik.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly string _connectionString;

        public UserController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }



        // Tüm kullanıcıları getir
        [HttpGet("users")]
        public ActionResult<List<UserDto>> GetAllUsers()
        {
            List<UserDto> users = new List<UserDto>();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "SELECT id, full_name, email, role_id, phone_number FROM users";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        users.Add(new UserDto
                        {
                            Id = reader.GetInt32(0),
                            FullName = reader.GetString(1),
                            Email = reader.GetString(2),
                            RoleId = reader.IsDBNull(3) ? (int?)null : reader.GetInt32(3),
                            PhoneNumber = reader.IsDBNull(4) ? null : reader.GetString(4)
                        });
                    }
                }
            }

            return Ok(users);
        }


        [HttpGet("user/{id}")]
        public ActionResult<UserDto> GetUserById(int id)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "SELECT id, full_name, email, role_id, phone_number FROM users WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var userDto = new UserDto
                            {
                                Id = reader.GetInt32(0),
                                FullName = reader.GetString(1),
                                Email = reader.GetString(2),
                                RoleId = reader.IsDBNull(3) ? (int?)null : reader.GetInt32(3),
                                PhoneNumber = reader.IsDBNull(4) ? null : reader.GetString(4)
                            };

                            return Ok(userDto);
                        }
                        else
                        {
                            return NotFound($"ID {id} olan kullanıcı bulunamadı.");
                        }
                    }
                }
            }
        }

        [HttpGet("users/{email}")]
        public ActionResult<UserDto> GetUserByEmail([FromRoute] string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return BadRequest("E-posta adresi belirtilmelidir.");

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = @"SELECT id, full_name, email, role_id, phone_number 
                         FROM users WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var user = new UserDto
                            {
                                Id = reader.GetInt32(0),
                                FullName = reader.GetString(1),
                                Email = reader.GetString(2),
                                RoleId = reader.IsDBNull(3) ? null : reader.GetInt32(3),
                                PhoneNumber = reader.IsDBNull(4) ? null : reader.GetString(4)
                            };

                            return Ok(user);
                        }
                        else
                        {
                            return NotFound("Bu e-posta adresiyle eşleşen kullanıcı bulunamadı.");
                        }
                    }
                }
            }
        }


        [HttpPut("users/{id}")]
        public IActionResult UpdateUser(int id, [FromBody] Users2DTO updatedUser)
        {
            if (updatedUser == null || id <= 0)
                return BadRequest("Geçersiz kullanıcı verisi.");

            // Şifre doğruluğunu kontrol et
            if (!string.IsNullOrWhiteSpace(updatedUser.PasswordHash))
            {
                if (!IsValidPassword(updatedUser.PasswordHash))
                {
                    return BadRequest("Şifre en az 8 karakter, bir büyük harf, bir rakam ve bir özel karakter içermelidir.");
                }
            }

            // Şifreyi hashle
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(updatedUser.PasswordHash);

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                // Kullanıcı var mı kontrol et
                string checkQuery = "SELECT COUNT(*) FROM users WHERE id = @id";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@id", id);
                    int exists = (int)checkCmd.ExecuteScalar();
                    if (exists == 0)
                        return NotFound($"ID {id} olan kullanıcı bulunamadı.");
                }

                // Güncelleme sorgusu
                string updateQuery = @"
            UPDATE users
            SET full_name = @full_name,
                email = @email,
                password_hash = @password_hash,
                role_id = @role_id,
                phone_number = @phone_number
            WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@full_name", updatedUser.FullName ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@email", updatedUser.Email ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@password_hash", hashedPassword);
                    cmd.Parameters.AddWithValue("@role_id", updatedUser.RoleId ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@phone_number", updatedUser.PhoneNumber ?? (object)DBNull.Value);

                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { Message = "Kullanıcı başarıyla güncellendi." });
        }

        [HttpPut("fullname/{id}")]
        public IActionResult UpdateFullName(int id, [FromBody] string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
                return BadRequest("Ad boş olamaz.");

            return UpdateUserField(id, "full_name", fullName);
        }


        [HttpPut("email/{id}")]
        public IActionResult UpdateEmail(int id, [FromBody] string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return BadRequest("E-posta boş olamaz.");

            var emailChecker = new EmailAddressAttribute();
            if (!emailChecker.IsValid(email))
                return BadRequest("Geçerli bir e-posta adresi giriniz.");

            return UpdateUserField(id, "email", email);
        }

        [HttpPut("password/{id}")]
        public IActionResult UpdatePassword(int id, [FromBody] string password)
        {
            if (!IsValidPassword(password))
                return BadRequest("Şifre en az 8 karakter, bir büyük harf, bir rakam ve bir özel karakter içermelidir.");

            string hashed = BCrypt.Net.BCrypt.HashPassword(password);
            return UpdateUserField(id, "password_hash", hashed);
        }

        [HttpPut("role/{id}")]
        public IActionResult UpdateUserRole(int id, [FromBody] int roleId)
        {
            if (roleId < 0 || roleId > 2)
            {
                return BadRequest("Role ID yalnızca 0, 1 veya 2 olabilir.");
            }

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = "UPDATE users SET role_id = @role_id WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@role_id", roleId);
                    cmd.Parameters.AddWithValue("@id", id);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        return NotFound("Kullanıcı bulunamadı.");
                    }
                }
            }

            return Ok(new { Message = "Role ID başarıyla güncellendi." });
        }


        [HttpPut("phonenumber/{id}")]
        public IActionResult UpdatePhoneNumber(int id, [FromBody] string phoneNumber)
        {
            if (string.IsNullOrWhiteSpace(phoneNumber))
                return BadRequest("Telefon numarası boş olamaz.");

            if (!IsValidTurkishPhoneNumber(phoneNumber))
                return BadRequest("Geçerli bir Türkiye cep telefonu numarası girin. Örnek: 5XXXXXXXXX");

            return UpdateUserField(id, "phone_number", phoneNumber);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            // Kullanıcı ID'si geçerli mi kontrol et
            if (id <= 0)
            {
                return BadRequest("Geçersiz kullanıcı ID.");
            }

            // Kullanıcıyı kontrol et
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string checkQuery = "SELECT COUNT(*) FROM users WHERE id = @id";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@id", id);
                    int exists = (int)checkCmd.ExecuteScalar();
                    if (exists == 0)
                        return NotFound("Kullanıcı bulunamadı.");
                }

                // Kullanıcıyı sil
                string deleteQuery = "DELETE FROM users WHERE id = @id";
                using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn))
                {
                    deleteCmd.Parameters.AddWithValue("@id", id);
                    deleteCmd.ExecuteNonQuery();
                }
            }

            return Ok(new { Message = "Kullanıcı başarıyla silindi." });
        }



        // Şifre doğrulama: en az 8 karakter, bir büyük harf, bir rakam, bir özel karakter
        private bool IsValidPassword(string password)
        {
            return password.Length >= 8 &&
                   password.Any(char.IsUpper) &&
                   password.Any(char.IsDigit) &&
                   password.Any(ch => "!@#$%^&*()".Contains(ch));
        }

        private bool IsValidTurkishPhoneNumber(string number)
        {
            // 11 haneli, sadece rakam, 0 ile başlamalı, ardından 5 gelmeli (mobil numara için)
            return number.Length == 11 &&
                   number.All(char.IsDigit) &&
                   number.StartsWith("05");
        }

        private IActionResult UpdateUserField(int id, string columnName, object value)
        {
            if (id <= 0)
                return BadRequest("Geçersiz kullanıcı ID.");

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                // Kullanıcı var mı?
                string checkQuery = "SELECT COUNT(*) FROM users WHERE id = @id";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@id", id);
                    int exists = (int)checkCmd.ExecuteScalar();
                    if (exists == 0)
                        return NotFound("Kullanıcı bulunamadı.");
                }

                // Güncelle
                string updateQuery = $"UPDATE users SET {columnName} = @value WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@value", value ?? DBNull.Value);
                    cmd.ExecuteNonQuery();
                }
            }

            return Ok(new { Message = $"{columnName} başarıyla güncellendi." });
        }




        [HttpPatch("update/{inputEmail}")]
        public IActionResult PatchUser(string inputEmail, [FromBody] UsersPatchDTO update)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                List<string> setClauses = new List<string>();
                List<string> skippedFields = new List<string>();  // Güncellenemeyen alanlar
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                // FullName kontrolü
                if (update.FullName != null)
                {
                    setClauses.Add("full_name = @FullName");
                    cmd.Parameters.AddWithValue("@FullName", update.FullName);
                }

                // E-posta kontrolü
                if (update.Email != null)
                {
                    if (!new EmailAddressAttribute().IsValid(update.Email))
                    {
                        skippedFields.Add("email");
                        // Geçerli bir e-posta adresi girilmediği için bu alanı güncellemiyoruz
                    }
                    else
                    {
                        // Aynı e-posta başka kullanıcıya ait mi kontrolü
                        using (SqlCommand checkEmailCmd = new SqlCommand("SELECT COUNT(*) FROM users WHERE email = @Email AND email != @Id", conn))
                        {
                            checkEmailCmd.Parameters.AddWithValue("@Email", update.Email);
                            checkEmailCmd.Parameters.AddWithValue("@Id", inputEmail);

                            int count = (int)checkEmailCmd.ExecuteScalar();
                            if (count > 0)
                            {
                                skippedFields.Add("email");
                                // Başka kullanıcıya ait olduğu için güncellenmez
                            }
                            else
                            {
                                setClauses.Add("email = @Email");
                                cmd.Parameters.AddWithValue("@Email", update.Email);
                            }
                        }
                    }
                }

                // Telefon numarası kontrolü
                if (update.PhoneNumber != null)
                {
                    if (!Regex.IsMatch(update.PhoneNumber, @"^0[1-9]\d{9}$"))
                    {
                        skippedFields.Add("phone_number");
                        // Geçerli değil, bu yüzden güncellenmiyor
                    }
                    else
                    {
                        // Telefon numarasının başka biri tarafından kullanılıyor olup olmadığını kontrol et
                        using (SqlCommand checkPhoneCmd = new SqlCommand("SELECT COUNT(*) FROM users WHERE phone_number = @PhoneNumber AND email != @Id", conn))
                        {
                            checkPhoneCmd.Parameters.AddWithValue("@PhoneNumber", update.PhoneNumber);
                            checkPhoneCmd.Parameters.AddWithValue("@Id", inputEmail);

                            int count = (int)checkPhoneCmd.ExecuteScalar();
                            if (count > 0)
                            {
                                skippedFields.Add("phone_number");
                                // Başka kullanıcıya ait olduğu için güncellenmez
                            }
                            else
                            {
                                setClauses.Add("phone_number = @PhoneNumber");
                                cmd.Parameters.AddWithValue("@PhoneNumber", update.PhoneNumber);
                            }
                        }
                    }
                }

                // RoleId kontrolü (sadece 0, 1, 2 değerleri geçerli)
                if (update.RoleId.HasValue)
                {
                    if (update.RoleId < 0 || update.RoleId > 2)
                    {
                        skippedFields.Add("roleId");
                        // Geçersiz RoleId olduğu için bu alan güncellenmiyor
                    }
                    else
                    {
                        setClauses.Add("role_id = @RoleId");
                        cmd.Parameters.AddWithValue("@RoleId", update.RoleId.Value);
                    }
                }

                // Şifre kontrolü ve hashleme
                if (!string.IsNullOrWhiteSpace(update.PasswordHash))
                {
                    string password = update.PasswordHash;

                    // Şifre uzunluğu, büyük harf, rakam ve özel karakter kontrolü
                    if (password.Length < 8 ||
                        !Regex.IsMatch(password, @"[A-Z]") ||
                        !Regex.IsMatch(password, @"[0-9]") ||
                        !Regex.IsMatch(password, @"[\W_]"))
                    {
                        skippedFields.Add("passwordHash");
                        // Şifre hatalı olduğu için bu alan güncellenmiyor
                    }
                    else
                    {
                        // BCrypt ile hashle
                        string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);
                        setClauses.Add("password_hash = @PasswordHash");
                        cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                    }
                }

                // Hiçbir alan güncellenmiyorsa hata döndür
                if (!setClauses.Any())
                    return BadRequest("Güncellenecek herhangi bir alan belirtilmedi.");

                // SQL sorgusunu oluştur
                cmd.CommandText = $"UPDATE users SET {string.Join(", ", setClauses)} WHERE email = @Id";
                cmd.Parameters.AddWithValue("@Id", inputEmail);

                // Sorguyu çalıştır
                int affected = cmd.ExecuteNonQuery();
                if (affected == 0)
                    return NotFound("Belirtilen ID ile eşleşen kullanıcı bulunamadı.");

                // Güncellenen alanları bildir
                return Ok(new
                {
                    Message = "Kullanıcı başarıyla güncellendi.",
                    UpdatedFields = setClauses,
                    SkippedFields = skippedFields
                });
            }
        }







    }
}

    

