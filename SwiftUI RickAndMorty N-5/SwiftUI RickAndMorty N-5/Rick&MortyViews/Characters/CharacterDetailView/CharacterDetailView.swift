//
//  CharacterDetailView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @StateObject private var viewModel: CharacterDetailViewModel

    init(character: Character) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character))
        self.character = character
    }

    var body: some View {
        ZStack {
            backgroundView
            content
        }
        .onAppear {
            viewModel.fetchEpisodeNames()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var backgroundView: some View {
        Color.customGradient.ignoresSafeArea()
    }
    
    private var content: some View {
        ScrollView {
            VStack(alignment: .leading) {
                characterImage
                characterDetails
                episodesSection
            }
            .padding()
        }
    }
    
    private var characterImage: some View {
        AsyncImage(url: URL(string: character.image)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 10)
        } placeholder: {
            ProgressView()
        }
    }
    
    private var characterDetails: some View {
        Group {
            Text("Name: \(character.name)")
                .font(.title)
            
            Text("Gender: \(character.gender)")
                .font(.headline)
            
            Text("Status: \(character.status)")
                .font(.headline)
            
            Text("Species: \(character.species)")
                .font(.headline)
            
            Text("Origin: \(character.origin.name)")
                .font(.headline)
        }
        .foregroundColor(.primary)
        .padding(.top, 10)
    }
    
    private var episodesSection: some View {
        VStack(alignment: .leading) {
            Text("Episodes:")
                .font(.title)
                .padding(.top)
                .foregroundColor(.primary)
            
            LazyVStack {
                ForEach(Array(viewModel.episodeNames.enumerated()), id: \.element) { index, episodeName in
                    VStack(alignment: .leading) {
                        Text(episodeName)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.elementColors)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.toggleEpisodeExpansion(episodeName)
                                }
                            }
                        
                        if viewModel.expandedEpisodes.contains(episodeName) {
                            if let characters = viewModel.episodeCharacters[episodeName] {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(characters) { character in
                                            VStack {
                                                AsyncImage(url: URL(string: character.image)) { image in
                                                    image.resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(Circle())
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                                
                                                Text(character.name)
                                                    .font(.caption)
                                                    .foregroundColor(.primary)
                                            }
                                            .padding()
                                        }
                                    }
                                }
                            } else {
                                ProgressView()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterDetailView(character: Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Origin(name: "Earth (C-137)", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: ["https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    ))
}
