using Microsoft.EntityFrameworkCore;
using Minik.Server.Data; // AppDbContext'�n do�ru namespace'i

var builder = WebApplication.CreateBuilder(args);

// CORS politikas�n� ekle
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin() // Her yerden eri�ime izin ver
              .AllowAnyMethod()  // GET, POST, PUT, DELETE vs. her t�r iste�e izin ver
              .AllowAnyHeader(); // Her t�rl� header'a izin ver
    });
});

// Veritaban� ba�lant�s�n� tan�ml�yoruz
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Controller'lar� aktif et
builder.Services.AddControllers();

// Swagger (API D�k�mantasyonu)
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// CORS politikas�n� uygula
app.UseCors("AllowAll");

// Development ortam� i�in Swagger UI aktif
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Veritaban� migration i�lemi
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.Migrate(); // Veritaban�n� g�ncelle
}

app.UseAuthorization();

app.MapControllers();

app.Run();
