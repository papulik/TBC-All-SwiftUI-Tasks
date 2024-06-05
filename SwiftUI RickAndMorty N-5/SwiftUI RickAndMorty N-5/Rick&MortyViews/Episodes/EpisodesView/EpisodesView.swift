//
//  EpisodesView.swift
//  SwiftUI RickAndMorty N-5
//
//  Created by Zuka Papuashvili on 31.05.24.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject private var viewModel = EpisodesViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                backgroundView
                content
            }
            .navigationTitle("Episodes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchEpisodes()
            }
            .navigationDestination(for: Episode.self) { episode in
                EpisodeDetailView(episode: episode)
                    .environmentObject(viewModel)
            }
        }
    }

    private var backgroundView: some View {
        Color.customGradient.ignoresSafeArea()
    }

    private var content: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                ForEach(viewModel.episodes.indices, id: \.self) { index in
                    episodeCell(for: viewModel.episodes[index], index: index)
                        .onTapGesture {
                            viewModel.navigationPath.append(viewModel.episodes[index])
                        }
                }
            }
            .padding()
        }
    }

    private func episodeCell(for episode: Episode, index: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center) {
                Text(episode.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                Spacer()
                
                Text("Air Date: \(episode.air_date)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40, height: 150)
            .background(
                Image(viewModel.getImageName(for: index))
                    .resizable()
                    .scaledToFill()
                    .opacity(0.6)
            )
            .background(Color.elementColors.opacity(0.3))
            .cornerRadius(15)
            .shadow(radius: 10)
            
            Button(action: {
                viewModel.toggleFavorite(episode)
            }) {
                Image(systemName: viewModel.isFavorite(episode) ? "star.fill" : "star")
                    .foregroundColor(.red)
                    .padding(8)
            }
        }
    }
}

#Preview {
    EpisodesView()
}
