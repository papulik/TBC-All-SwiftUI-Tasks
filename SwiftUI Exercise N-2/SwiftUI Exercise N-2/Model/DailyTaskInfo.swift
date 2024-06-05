//
//  DailyTaskInfo.swift
//  SwiftUI Exercise N-2
//
//  Created by Zuka Papuashvili on 24.05.24.
//

import SwiftUI

struct DailyTaskInfo: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    var isCompleted: Bool
    let color: Color
}
