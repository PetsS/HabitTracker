//
//  ContentView.swift
//  Challenge_Habit_Tracker
//
//  Created by Peter Szots on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items, id: \.id) { item in
                    NavigationLink(destination: DetailView(habits: self.habits, habitItem: item)) {
                        ZStack {
                            Image(systemName: item.categoryMach)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 35)
                                .foregroundColor(Color(red:0.0, green: 0.5, blue: 0.8))
                                .shadow(radius: 2, x: 2, y: 1)
                                .padding(.trailing, 4)
                        }
                        HStack {
                            VStack (alignment: .leading) {
                                Text(item.name)
                                        .font(.body.bold())
                                        .padding(.vertical, 1)
                                HStack {
                                    Text("\((item.actualAmount == item.amount) ? "Goal completed!" : "\(item.amount - item.actualAmount) more to go!")")
                                    Text("\(item.actualAmount)/\(item.amount)/\(item.frequency)")
                                        .italic()
                                }
                                .font(.caption)
                                
                            }
                            
                            Spacer()
                            ZStack (alignment: .center) {
                                Capsule()
                                    .stroke(.cyan, style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .frame(maxWidth: 50, maxHeight: 33)
                                Capsule()
                                    .trim(from: 0.0, to: Double(item.actualAmount) / Double(item.amount))
                                    .stroke(.cyan, lineWidth: 8)
                                    .frame(maxWidth: 50, maxHeight: 33)
                                    .shadow(radius: 1, x: 1, y: 1)
                                Text("\(item.percentage)%")
                                        .font(.caption)
                            }
                        }
                    }
                    .listRowBackground(
                        item.actualAmount == item.amount ? Color(red:0.0, green: 0.5, blue: 0.8) : Color.blue.opacity(0.2)
                    )

                }
                .onDelete(perform: removeItems)
            }
            
            .navigationBarItems(
                leading:
                    EditButton(),
                trailing:
                    Button {
                        showingAddView = true
                    }label: {
                        Image(systemName: "plus.circle")
                    }
            )
            .sheet(isPresented: $showingAddView) {
                AddView(habits: habits)
            }
            .navigationTitle("HabitTracker")
        }
    }
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
