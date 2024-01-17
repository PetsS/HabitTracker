//
//  HabitItem.swift
//  Challenge_Habit_Tracker
//
//  Created by Peter Szots on 17/06/2022.
//

import Foundation


struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var category: String
    var frequency: String
    var amount: Int
    var actualAmount: Int
    
    var categoryMach: String {
        var logo = ""
        
        if category == "sport" {
            logo = "figure.walk.circle"
        } else if category == "mental health" {
            logo = "heart.circle"
        } else if category == "food and drink" {
            logo = "bag.circle"
        }
        
        return logo
    }
    
//    var percentage: Int{
//        guard amount != 0 else { return 1 }
//        return Int(actualAmount / amount * 100)
//    }
    
    var percentage: Int{
        guard amount != 0 else { return 100 }
        return Int(100 * Double(actualAmount) / Double(amount))
    }
    
    
    
}
