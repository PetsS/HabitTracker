//
//  Habits.swift
//  Challenge_Habit_Tracker
//
//  Created by Peter Szots on 17/06/2022.
//

import Foundation

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
}
