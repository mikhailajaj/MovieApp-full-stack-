namespace MovieStore.DB;

public record Movie 
{
  public int Id { get; set; }
  public string? Title { get; set; }
  public int Year { get; set; }
  public string? Rating { get; set; }
  public string? ContentRating { get; set; }
  public string? NumberOfReviews { get; set; }
}

public class MovieDB
{
  private static List<Movie> _movies = new List<Movie>()
  {
new Movie { Title = "The Shawshank Redemption", Year = 1994, ContentRating = "R", Rating = "9.3", NumberOfReviews = "2.9M" },
        new Movie { Title = "The Godfather", Year = 1972, ContentRating = "R", Rating = "9.2", NumberOfReviews = "2.2M" },
        new Movie { Title = "The Dark Knight", Year = 2008, ContentRating = "PG-13", Rating = "9.0", NumberOfReviews = "2.8M" },
        new Movie { Title = "The Godfather Part II", Year = 1974, ContentRating = "R", Rating = "9.0", NumberOfReviews = "1.3M" },
        new Movie { Title = "12 Angry Men", Year = 1957, ContentRating = "Approved", Rating = "9.0", NumberOfReviews = "852K" },
        new Movie { Title = "Schindler's List", Year = 1993, ContentRating = "R", Rating = "9.0", NumberOfReviews = "1.4M" }
    // Add more movies as needed
  };

  public static List<Movie> GetMovies() 
  {
    return _movies;
  } 

  public static Movie ? GetMovie(int id) 
  {
    return _movies.SingleOrDefault(movie => movie.Id == id);
  } 

  public static Movie CreateMovie(Movie movie) 
  {
    _movies.Add(movie);
    return movie;
  }

  public static Movie UpdateMovie(Movie update) 
  {
    _movies = _movies.Select(movie =>
    {
      if (movie.Id == update.Id)
      {
        movie.Title = update.Title;
        movie.Year = update.Year;
        movie.ContentRating = update.ContentRating;
        movie.Rating = update.Rating;
        movie.NumberOfReviews = update.NumberOfReviews;
      }
      return movie;
    }).ToList();
    return update;
  }

  public static void RemoveMovie(int id)
  {
    _movies = _movies.FindAll(movie => movie.Id != id).ToList();
  }
}
