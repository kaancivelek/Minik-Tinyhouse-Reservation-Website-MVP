﻿namespace Minik.Server.Models
{
    public class UsersPatchDTO
    {
        public string? FullName { get; set; }
        public string? Email { get; set; }
        
        public int? RoleId { get; set; }
        public string? PhoneNumber { get; set; }
    }
}
