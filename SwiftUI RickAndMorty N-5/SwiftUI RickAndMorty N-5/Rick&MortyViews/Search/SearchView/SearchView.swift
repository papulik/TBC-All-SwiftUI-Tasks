//
//  SearchView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedSegment = 0
    @StateObject private var viewModel = SearchViewModel()
    @State private var refreshId = UUID()

    var body: some View {
        NavigationView {
            ZStack {
                backgroundView
                
                VStack {
                    searchPicker
                    searchTextField

                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        searchResults
                    }
                }
                .navigationTitle("Search")
                .id(refreshId)
            }
        }
    }

    private var backgroundView: some View {
        Color.customGradient.ignoresSafeArea()
    }
    
    private var searchPicker: some View {
        Picker("Search", selection: $selectedSegment) {
            Text("Characters").tag(0)
            Text("Episodes").tag(1)
            Text("Locations").tag(2)
        }
        .colorMultiply(.green)
        .background(Color(uiColor: .gray))
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .onChange(of: selectedSegment) {
            viewModel.searchResults.removeAll()
            viewModel.episodeResults.removeAll()
            searchText = ""
            refreshId = UUID()
        }
    }
    
    private var searchTextField: some View {
        TextField("Search", text: $searchText, onCommit: {
            switch selectedSegment {
            case 0:
                viewModel.searchCharacters(query: searchText)
            case 1:
                viewModel.searchEpisodes(query: searchText)
            case 2:
                viewModel.searchLocations(query: searchText)
            default:
                break
            }
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }
    
    private var searchResults: some View {
        ScrollView {
            LazyVStack {
                switch selectedSegment {
                case 0:
                    ForEach(viewModel.searchResults) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            characterRow(for: character)
                        }
                    }
                case 1:
                    ForEach(viewModel.episodeResults) { episode in
                        episodeRow(for: episode)
                    }
                case 2:
                    ForEach(viewModel.locationResults) { location in
                        locationRow(for: location)
                    }
                default:
                    EmptyView()
                }
            }
        }
    }
    
    // MARK: - Private Methods
    private func characterRow(for character: Character) -> some View {
        HStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .background(Color.elementColors)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
    
    private func episodeRow(for episode: Episode) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "tv")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text(episode.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(episode.air_date)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Text(episode.episode)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding()
            .background(Color.elementColors)
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
    
    private func locationRow(for location: Location) -> some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(location.type)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Text(location.dimension)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .background(Color.elementColors)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

#Preview {
    SearchView()
}
