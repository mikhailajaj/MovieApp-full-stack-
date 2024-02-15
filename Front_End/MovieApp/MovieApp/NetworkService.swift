//
//  NetworkService.swift
//  MovieApp
//
//  Created by Mikha2il 3ajaj on 2024-02-15.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchMovies(completion: @escaping ([Movie]?) -> Void) {
        let urlString = "https://movieapistoreapp.azurewebsites.net/movies"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let movies = try? JSONDecoder().decode([Movie].self, from: data)
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
    
    func addMovie(movie: Movie, completion: @escaping (Bool) -> Void) {
        let urlString = "https://movieapistoreapp.azurewebsites.net/movies"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    func updateMovie(movie: Movie, completion: @escaping (Bool) -> Void) {
        let urlString = "https://movieapistoreapp.azurewebsites.net/movies/\(movie.id)"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    func deleteMovie(id: Int, completion: @escaping (Bool) -> Void) {
        let urlString = "https://movieapistoreapp.azurewebsites.net/movies/\(id)"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }


}
