//
//  ContentView.swift
//  SwiftUI Exercise N-1
//
//  Created by Zuka Papuashvili on 22.05.24.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    @StateObject var viewModel = ContentViewModel()
    @State private var chatViewColor: Color = .chatBackgroundColoring
    @State private var newsViewColor: Color = .newsBackgroundColoring
    @State private var reloadButtonColor: Color = .blue
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: - Header
                HStack {
                    Text("SwiftUI Exercise")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                
                //MARK: - Card Section
                HStack(spacing: 10) {
                    GuitarView(imageName: "microphoneImage", title: "ჯუზონები და რამე", subtitle: "We love property wrappers and closures")
                        .frame(width: 160, height: 232)
                    VStack(spacing: 10) {
                        ChatView(imageName: "chatImage", title: "ჩატის", backgroundColor: $chatViewColor) {
                            chatViewColor = chatViewColor == .chatBackgroundColoring ? .blue : .chatBackgroundColoring
                        }
                        .frame(height: 110)
                        NewsView(imageName: "profileImage", title: "სიახლეების", backgroundColor: $newsViewColor, showAlert: $viewModel.showNewsAlert) {
                            newsViewColor = newsViewColor == .newsBackgroundColoring ? .green : .newsBackgroundColoring
                            viewModel.changeNewsViewColor()
                        }
                        .frame(height: 110)
                        .alert(isPresented: $viewModel.showNewsAlert, content: {
                            Alert(title: Text("სვიიიფტ უა იი ალერტი აეე :)"), message: Text("იყო და არა იყო რა ღვთის უკეთესი რა იქნებოდაო."), dismissButton: .default(Text("OK")))
                        })
                    }
                }
                .padding(.horizontal)
                
                //MARK: - List Section
                List {
                    Section {
                        ForEach(viewModel.listItems) { item in
                            ListItemView(item: item)
                                .listRowSeparatorTint(Color.gray)
                                .listRowBackground(Color.backgroundColoring)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            //MARK: Reload Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        reloadButtonColor = reloadButtonColor == .blue ? .red : .blue
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .scaledToFit()
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Circle().fill(reloadButtonColor))
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 50)
                    .padding(.trailing, 30)
                }
            }
        }
        .background(Color.backgroundColoring)
    }
}

//MARK: - Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
