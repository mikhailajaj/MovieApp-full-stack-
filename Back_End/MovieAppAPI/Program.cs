using Microsoft.OpenApi.Models;
using MovieStore.DB;
var builder = WebApplication.CreateBuilder(args);


builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
     c.SwaggerDoc("v1", new OpenApiInfo { Title = "Movie API", Description = "Moves are better when watched together", Version = "v1" });
});
var app = builder.Build();
app.UseSwagger();
app.UseSwaggerUI(c =>
{
   c.SwaggerEndpoint("/swagger/v1/swagger.json", "Movie API V1");
});
app.MapGet("/", () => "Hello World!");
app.MapGet("/movies/{id}", (int id) => MovieDB.GetMovie(id));
app.MapGet("/movies", () => MovieDB.GetMovies());
app.MapPost("/movies", (Movie movie) => MovieDB.CreateMovie(movie));
app.MapPut("/movies", (Movie movie) => MovieDB.UpdateMovie(movie));
app.MapDelete("/movies/{id}", (int id) => MovieDB.RemoveMovie(id));

app.Run();
