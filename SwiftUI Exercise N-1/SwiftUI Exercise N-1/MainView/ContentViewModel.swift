//
//  ContentViewModel.swift
//  SwiftUI Exercise N-1
//
//  Created by Zuka Papuashvili on 23.05.24.
//

import Foundation

//MARK: - ვამუღამებ რაღაცეებს წინასწარ და ძალიან არ გამაკტირიკოთ პლზ :დ <<<<< 🚨🚨👷🚨🚨 >>>>>
class ContentViewModel: ObservableObject {
    @Published var showNewsAlert = false
    @Published var listItems: [ListItem] = [
        ListItem(title: "რა დაუწუნა ბარბარემ ნიკის?", subtitle: "ნიკის ამაზე ჯერ განცხადება არ გაუკეთებია, ფანები ელოდებიან რომ რომელიმე მალე სიჩუმეს გაფანტავს"),
        ListItem(title: "ამით დაგვეწყო ისე სწავლა", subtitle: "რა აზრი აქვს ისედაც დაგავიწყდებათ უიკიტ"),
        ListItem(title: "ერბო ერბოა და ქონი ქონი?", subtitle: "რაც მართალია, მართალიაო."),
        ListItem(title: "რა მდგომარეობაშია გამტარობა?", subtitle: "გამტარობა არის მაღალი."),
        ListItem(title: "MVC vs MVVM", subtitle: "ვაიპერი ჯობია ყველაფერს, არ მეთანხმებით? თუ არც."),
        ListItem(title: "ამის დამუღამება მაგრად ასწორებს", subtitle: "რასაცა გასცემ შენია, რაც არა დაკარგულია.")
    ]
    
    func changeNewsViewColor() {
        showNewsAlert = true
    }
}
