using Microsoft.EntityFrameworkCore;
using Minik.Server.Data; // AppDbContext'ýn doðru namespace'i

var builder = WebApplication.CreateBuilder(args);

// CORS politikasýný ekle
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin() // Her yerden eriþime izin ver
              .AllowAnyMethod()  // GET, POST, PUT, DELETE vs. her tür isteðe izin ver
              .AllowAnyHeader(); // Her türlü header'a izin ver
    });
});

// Veritabaný baðlantýsýný tanýmlýyoruz
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Controller'larý aktif et
builder.Services.AddControllers();

// Swagger (API Dökümantasyonu)
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// CORS politikasýný uygula
app.UseCors("AllowAll");

// Development ortamý için Swagger UI aktif
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Veritabaný migration iþlemi
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.Migrate(); // Veritabanýný güncelle
}

app.UseAuthorization();

app.MapControllers();

app.Run();
