//
//  CharactersView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct CharactersView: View {
    @StateObject private var viewModel = CharactersViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                backgroundView
                content
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchCharacters()
            }
            .navigationDestination(for: Character.self) { character in
                CharacterDetailView(character: character)
            }
        }
    }
    
    private var backgroundView: some View {
        Color.customGradient.ignoresSafeArea()
    }
    
    private var content: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                ForEach(viewModel.characters) { character in
                    characterCell(for: character)
                }
            }
            .padding()
        }
    }
    
    private func characterCell(for character: Character) -> some View {
        VStack {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            } placeholder: {
                ProgressView()
            }
            
            Text(character.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(width: 150, height: 200)
        .background(Color.elementColors)
        .cornerRadius(15)
        .shadow(radius: 10)
        .onTapGesture {
            viewModel.navigationPath.append(character)
        }
    }
}

#Preview {
    CharactersView()
}
