//
//  ContentView.swift
//  MovieApp
//
//  Created by Mikha2il 3ajaj on 2024-02-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()
    @State private var showingAddMovieSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies) { movie in
                    MovieRow(movie: movie)
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteMovie(id: movie.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle("Movies")
            .navigationBarItems(trailing: Button(action: {
                showingAddMovieSheet = true
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                viewModel.fetchMovies()
            }
            .sheet(isPresented: $showingAddMovieSheet) {
                AddMovieView(viewModel: viewModel)
            }
        }
    }
}

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.headline)
            HStack {
                Text("Year: \(movie.year)")
                Spacer()
                Text(movie.rating)
            }
            .font(.subheadline)
        }
    }
}

struct AddMovieView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MovieViewModel
    @State private var title = ""
    @State private var year = ""
    @State private var rating = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Year", text: $year)
                TextField("Rating", text: $rating)
                Button("Add Movie") {
                    let newMovie = Movie(id: Int.random(in: 1..<10000), title: title, year: Int(year) ?? 2020, rating: rating, contentRating: "PG", numberOfReviews: "1M")
                    viewModel.addMovie(movie: newMovie)
                    dismiss()
                }
            }
            .navigationTitle("Add Movie")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
