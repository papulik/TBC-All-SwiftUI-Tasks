//
//  SearchView.swift
//  MoviesDB N-6
//
//  Created by Zuka Papuashvili on 05.06.24.
//

import SwiftUI

enum SearchOption: String, CaseIterable, Identifiable {
    case name = "Name"
    case genre = "Genre"
    case releaseYear = "Year"
    
    var id: String { self.rawValue }
}

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @State private var query: String = ""
    @State private var hasSearched: Bool = false
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                searchFieldWithMenu
                if isLoading {
                    loadingView
                } else if !hasSearched {
                    placeholderView
                } else if viewModel.searchResults.isEmpty {
                    noResultsView
                } else {
                    searchResultsList
                }
            }
            .navigationTitle("Search")
            .background(Color.movieBackGround.ignoresSafeArea())
        }
    }
    
    private var searchFieldWithMenu: some View {
        HStack {
            HStack {
                TextField("Search movies...", text: $query, onCommit: {
                    hasSearched = true
                    isLoading = true
                    viewModel.searchMovies(query: query) {
                        isLoading = false
                    }
                })
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color.primary)
                .padding(5)
                Image("Search")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.primary)
                    .frame(width: 16, height: 16)
            }
            .frame(height: 22)
            .padding()
            .background(Color("SearchBackGround"))
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            Spacer(minLength: 19)
            
            Menu {
                ForEach(SearchOption.allCases) { option in
                    Button(action: {
                        viewModel.searchOption = option
                        query = ""
                        hasSearched = false
                    }) {
                        HStack {
                            if viewModel.searchOption == option {
                                Image(systemName: "checkmark")
                            }
                            Text(option.rawValue)
                        }
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 25, height: 25)
            }
        }
        .padding([.leading, .trailing], 16)
    }

    private var searchResultsList: some View {
        List {
            ForEach(viewModel.searchResults) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    ReusableListCell(movie: movie)
                }
                
            }
            .listRowBackground(Color.movieBackGround)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .background(Color.movieBackGround)
    }
    
    private var placeholderView: some View {
        VStack {
            Spacer()
            Text("Use the magic search!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text("I will do my best to search everything relevant, I promise!")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 24)
            Spacer()
        }
    }

    private var noResultsView: some View {
        VStack {
            Spacer()
            Text("Oh no, isn’t this so embarrassing?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text("I cannot find any movie with this name.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 24)
            Spacer()
        }
    }

    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Searching...")
                .progressViewStyle(CircularProgressViewStyle())
                .font(.title2)
                .padding(.bottom, 8)
            Spacer()
        }
    }
}

#Preview {
    let searchViewModel = SearchViewModel()
    searchViewModel.searchResults = [
        MoviesInfo(id: 1, title: "Search Result 1", posterPath: "/path1.jpg", backdropPath: "/backdrop1.jpg", rating: 9.0, genreIDs: [28, 53], releaseDate: "2020-01-01", duration: 130, overview: "Overview of Search Result 1"),
        MoviesInfo(id: 2, title: "Search Result 2", posterPath: "/path2.jpg", backdropPath: "/backdrop2.jpg", rating: 7.0, genreIDs: [12, 14], releaseDate: "2019-01-01", duration: 115, overview: "Overview of Search Result 2"),
        MoviesInfo(id: 3, title: "Search Result 3", posterPath: nil, backdropPath: "/backdrop3.jpg", rating: 8.0, genreIDs: [80, 9648], releaseDate: "2018-01-01", duration: 105, overview: "Overview of Search Result 3")
    ]
    return SearchView()
        .environmentObject(searchViewModel)
}
