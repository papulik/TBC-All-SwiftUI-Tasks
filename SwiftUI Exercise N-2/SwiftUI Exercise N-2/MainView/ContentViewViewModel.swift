//
//  ContentViewViewModel.swift
//  SwiftUI Exercise N-2
//
//  Created by Zuka Papuashvili on 25.05.24.
//

import SwiftUI

// MARK: - ViewModel ------ import foundation unda ikos marto, da nel nela davxvecav 👷
class TaskViewModel: ObservableObject {
    @Published var tasks: [DailyTaskInfo] = [
        DailyTaskInfo(name: "Mobile App Research", date: "4 Oct", isCompleted: true, color: Color.borderColor1),
        DailyTaskInfo(name: "Prepare Wireframe for Main Flow", date: "4 Oct", isCompleted: true, color: Color.borderColor2),
        DailyTaskInfo(name: "Prepare Screens", date: "4 Oct", isCompleted: true, color: Color.borderColor3),
        DailyTaskInfo(name: "Website Research", date: "5 Oct", isCompleted: false, color: Color.borderColor1),
        DailyTaskInfo(name: "Prepare Wireframe for Main Flow", date: "5 Oct", isCompleted: false, color: Color.borderColor2),
        DailyTaskInfo(name: "Prepare Screens", date: "5 Oct", isCompleted: false, color: Color.borderColor3),
    ]
    
    var completedTasks: [DailyTaskInfo] {
        tasks.filter { $0.isCompleted }
    }
    
    var incompleteTasks: [DailyTaskInfo] {
        tasks.filter { !$0.isCompleted }
    }
    
    var remainingTaskCount: Int {
        incompleteTasks.count
    }
    
    func completeAllTasks() {
        tasks.indices.forEach { tasks[$0].isCompleted = true }
    }
    
    func toggleTaskCompletion(task: DailyTaskInfo) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

