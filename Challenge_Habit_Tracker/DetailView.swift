//
//  DetailView.swift
//  Challenge_Habit_Tracker
//
//  Created by Peter Szots on 18/06/2022.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var habits: Habits
    @State var habitItem: HabitItem
    
    var strokeTrim: Double {
        Double(habitItem.actualAmount) / Double(habitItem.amount)
    }
    
    var body: some View {
        
            Group{
                VStack (alignment: .center, spacing: 20) {
                    
                    Spacer()
                    
                    Image(systemName: habitItem.categoryMach)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150, maxHeight: 150)
                        .foregroundColor(Color(red:0.0, green: 0.5, blue: 0.8))
                        .shadow(radius: 2, x: 3, y: 2)
                    
                    Spacer()
                    
                    Text(habitItem.name)
                        .font(.title.smallCaps())
                    
                    Divider()
                    
                    Text("Description:")
                        .font(.footnote.smallCaps())
                    Text("\(habitItem.description == "" ? "n/a" : habitItem.description)")
                        .font(.footnote.smallCaps())
                        .padding(10)
                        .background(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))
                        .border(.cyan, width: 1)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .stroke(.cyan, style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .frame(maxWidth: 180, maxHeight: 120)
                            .background(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.3))
                            
                        Rectangle()
                            .trim(from: 0.0, to: strokeTrim)
                            .stroke(.cyan, style: StrokeStyle(lineWidth: 15))
                            .animation(.easeInOut(duration: 2), value: strokeTrim)
                            .frame(maxWidth: 180, maxHeight: 120)
                            .shadow(radius: 1, x: 1, y: 1)
                        
                        Button() {
                            if habitItem.actualAmount != habitItem.amount {
                                habitItem.actualAmount += 1
                                updateHabit()
                            }
                        } label: {
                            Text("GO")
                            Image(systemName: "arrow.right")
                        }
                        .font(.title.bold())
                        .foregroundColor(Color(red:0.0, green: 0.5, blue: 0.8))
                        .shadow(radius: 1, x: 1, y: 1)
                        
                    }
                    Group {
                        ZStack {
                            Rectangle()
                                .stroke(.cyan, style: StrokeStyle(lineWidth: 3))
                                .frame(maxWidth: 110, maxHeight: 40)
                                .background(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.3))
                                
                            
                            Button() {
                                if habitItem.actualAmount != 0 {
                                    habitItem.actualAmount -= 1
                                    updateHabit()
                                }
                            } label: {
                                Image(systemName: "arrow.left")
                                Text("BACK")
                                
                            }
                            .font(.title3.bold())
                            .foregroundColor(Color(red:0.0, green: 0.5, blue: 0.8))
                            .shadow(radius: 1, x: 1, y: 1)
                        }
                                                
                        Text("You have done \(habitItem.actualAmount)/\(habitItem.amount) of your \(habitItem.frequency)ly goal.")
                            .font(.body.smallCaps())
                            .padding()
                        
                        
                        
                        Spacer()
                    }
                }
            }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    habitItem.actualAmount = 0
                    updateHabit()
                } label: {
                    Text("Reset")
                    Image(systemName: "arrow.counterclockwise.circle")
                }
                .font(.body.smallCaps())
            }
        }
            
                
        
    }
    
    func updateHabit() {
        if let index = habits.items.firstIndex(where: {$0.id == habitItem.id}) {
            habits.items[index] = habitItem
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailView(habits: Habits(), habitItem: .init(name: "DetailView", description: "Here is a long example of description, Here is a long example of description, Here is a long example of description", category: String(), frequency: String(), amount: Int(), actualAmount: Int()))
    }
}
