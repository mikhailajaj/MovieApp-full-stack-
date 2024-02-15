//
//  Movie.swift
//  MovieApp
//
//  Created by Mikha2il 3ajaj on 2024-02-15.
//

struct Movie: Identifiable, Codable {
    var id: Int
    var title: String
    var year: Int
    var rating: String
    var contentRating: String
    var numberOfReviews: String
}
