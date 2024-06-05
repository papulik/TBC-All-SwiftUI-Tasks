//
//  EpisodeDetailView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    @StateObject private var viewModel: EpisodeDetailViewModel
    @EnvironmentObject var episodesViewModel: EpisodesViewModel

    init(episode: Episode) {
        _viewModel = StateObject(wrappedValue: EpisodeDetailViewModel(episode: episode))
        self.episode = episode
        setupNavigationBarAppearance()
    }

    var body: some View {
        ZStack {
            backgroundView
            content
        }
        .onAppear {
            viewModel.fetchCharacters(for: episode)
        }
        .navigationTitle(episode.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: favoriteButton)
    }

    private var backgroundView: some View {
        Color.customGradient.ignoresSafeArea()
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Air Date: \(episode.air_date)")
                    .font(.headline)
                    .padding(.bottom, 10)

                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    charactersSection
                }
            }
            .padding()
        }
    }

    private var charactersSection: some View {
        VStack(alignment: .leading) {
            Text("Characters")
                .font(.title2)
                .padding(.bottom, 10)

            LazyVStack {
                ForEach(viewModel.characters) { character in
                    characterRow(for: character)
                }
            }
        }
    }

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
    
    private var favoriteButton: some View {
        Button(action: {
            episodesViewModel.toggleFavorite(episode)
        }) {
            Image(systemName: episodesViewModel.isFavorite(episode) ? "star.fill" : "star")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    EpisodeDetailView(episode: Episode(
        id: 1,
        name: "Pilot",
        air_date: "December 2, 2013",
        episode: "S01E01",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2"
        ],
        url: "https://rickandmortyapi.com/api/episode/1",
        created: "2017-11-10T12:56:33.798Z"
    ))
}
