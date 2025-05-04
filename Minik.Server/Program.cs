using Microsoft.EntityFrameworkCore;
using Minik.Server.Data;
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


// CORS politikasını ekle
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin() // Her yerden erişime izin ver
              .AllowAnyMethod()  // GET, POST, PUT, DELETE vs. her tür isteğe izin ver
              .AllowAnyHeader(); // Her türlü header'a izin ver
    });
});


// Controller'ları aktif et
builder.Services.AddControllers();

// Swagger (API Dökümantasyonu)
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();


// CORS politikasını uygula
app.UseCors("AllowAll");

// Development ortamı için Swagger UI aktif
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();



app.UseAuthorization();

app.MapControllers();

app.Run();
