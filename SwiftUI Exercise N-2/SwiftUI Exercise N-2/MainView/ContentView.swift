//
//  ContentView.swift
//  SwiftUI Exercise N-2
//
//  Created by Zuka Papuashvili on 23.05.24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = TaskViewModel()
    
    // MARK: - Main View
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            completeAllButton
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    progressSection
                    Text("Completed Tasks")
                        .font(.title3)
                    reminderListView
                }
                .padding(.bottom, 20)
            }
        }
        .padding()
        .background(Color.mainViewColoring)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("You have \(viewModel.remainingTaskCount) tasks to complete")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            profileView
        }
    }
    
    // MARK: - Profile View
    private var profileView: some View {
        Image("profileImage")
            .resizable()
            .frame(width: 44, height: 45)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [.imageGradientColor1, .imageGradientColor2]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
            )
            .overlay(
                Text("\(viewModel.remainingTaskCount)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .padding([.bottom, .trailing], -5),
                alignment: .bottomTrailing
            )
    }
    
    // MARK: - Button All View
    private var completeAllButton: some View {
        Button(action: {
            viewModel.completeAllTasks()
        }) {
            Text("Complete All")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.buttonGradientColor1, .buttonGradientColor2]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
        }
        .padding(.vertical)
    }
    
    // MARK: - Progress Section
    private var progressSection: some View {
        VStack(alignment: .leading) {
            Text("Progress")
                .font(.title3)
            progressView
        }
        .padding(.bottom)
    }
    
    // MARK: - Progress Bar View
    private var progressView: some View {
        VStack(alignment: .leading) {
            progressDetailView
            ProgressView(value: Double(viewModel.completedTasks.count), total: Double(viewModel.tasks.count))
                .progressViewStyle(CustomProgressViewStyle(strokeColor: .progressColoring, strokeWidth: 18))
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .padding(.top, 15)
        .padding(.bottom, 23)
        .background(Color.smallViewColoring)
        .cornerRadius(10)
    }
    
    // MARK: - Progress Details View
    private var progressDetailView: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Daily Task")
            
            Text("\(viewModel.completedTasks.count)/\(viewModel.tasks.count) Task Completed")
            
            HStack {
                Text("Keep working")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                Spacer()
                
                Text("\(Int(Double(viewModel.completedTasks.count) / Double(viewModel.tasks.count) * 100))%")
            }
            .padding(.trailing, 16)
        }
    }
    
    // MARK: - Reminder Cell's View
    private var reminderListView: some View {
        LazyVStack(spacing: 10) {
            ForEach(viewModel.completedTasks) { task in
                ReminderView(task: task) { _ in
                    viewModel.toggleTaskCompletion(task: task)
                }
            }
            Spacer()
            ForEach(viewModel.incompleteTasks) { task in
                ReminderView(task: task) { _ in 
                    viewModel.toggleTaskCompletion(task: task)
                }
            }
        }
    }
    
    // MARK: - Reminder View
    struct ReminderView: View {
        var task: DailyTaskInfo
        var toggleCompletion: (DailyTaskInfo) -> Void
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            HStack {
                Rectangle()
                    .frame(width: 15)
                    .foregroundColor(task.color)
                VStack(alignment: .leading) {
                    Text(task.name)
                    HStack {
                        Image(colorScheme == .dark ? "lightDocImage" : "docImage")
                            .resizable()
                            .frame(width: 15, height: 17)
                            .scaledToFit()
                        Text(task.date)
                            .font(.caption)
                    }
                }
                .padding(.leading, 14)
                .padding(.vertical, 20)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        toggleCompletion(task)
                    }
                }) {
                    ZStack {
                        Circle()
                            .strokeBorder(task.isCompleted ? Color.primary : Color.blue, lineWidth: 2)
                            .background(
                                Circle()
                                    .foregroundColor(task.isCompleted ? Color.lightCheckMark : Color.clear)
                            )
                        if task.isCompleted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.primary)
                                .scaleEffect(0.7)
                        }
                    }
                    .frame(width: 26, height: 26)
                }
            }
            .frame(height: 80)
            .padding(.trailing, 11)
            .background(Color.smallViewColoring)
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

