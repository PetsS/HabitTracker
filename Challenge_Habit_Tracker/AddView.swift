//
//  AddView.swift
//  Challenge_Habit_Tracker
//
//  Created by Peter Szots on 17/06/2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    //properties of HabitItem
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 0
    @State private var actualAmount = 0
    @State private var frequency = "day"
    let frequencies = ["day", "week", "month"]
    @State private var category = "sport"
    let categories = ["sport", "mental health", "food and drink"]
    
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Add Your new habit", text: $name)
                        .onReceive(name.publisher.collect()) {
                            name = String($0.prefix(30))
                        }
                        .font(.body.smallCaps())
                    TextField("Write something about it", text: $description)
                        .font(.footnote.smallCaps())
                        .onReceive(description.publisher.collect()) {
                            description = String($0.prefix(120))
                        }
                }
                .listRowBackground(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))
                Section {
                    Picker("Chose a category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                    .font(.body.smallCaps())
                }
                .listRowBackground(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))
                
//                Section ("Set your goal") {
//                        HStack (alignment: .center, spacing: 0) {
//                            TextField("goal", value: $amount, format: .number)
//                                .keyboardType(.decimalPad)
//                            Text("/  \(frequency)")
//                        }
//                        .font(.title3.smallCaps())
//
//                    .listRowBackground(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))
//                }
                
//                Section ("Set your goal") {
//                    GeometryReader { geo in
//                        HStack (alignment: .center ,spacing: 0){
//                            VStack (alignment: .trailing) {
//                                Picker("Goal", selection: $amount) {
//                                    ForEach(0..<31, id: \.self) {
//                                        Text("\($0)")
//                                    }
//                                }
//                                .pickerStyle(.wheel)
//                                .frame(width: geo.size.width/2.5, height: geo.size.height, alignment: .center)
//                                .compositingGroup()
//                                .clipped()
//                                .background(.cyan.opacity(0.7))
//                                .clipShape(RoundedRectangle(cornerRadius: 5))
//                            }
//
//                            Spacer()
//                            Text("per")
//                            Spacer()
//
//                            Picker("Frequency", selection: $frequency) {
//                                ForEach(frequencies, id: \.self) {
//                                    Text($0)
//                                }
//                            }
//                            .pickerStyle(.wheel)
//                            .frame(width: geo.size.width/2.5, height: geo.size.height, alignment: .center)
//                            .compositingGroup()
//                            .clipped()
//                            .background(.cyan.opacity(0.7))
//                            .clipShape(RoundedRectangle(cornerRadius: 5))
//
//                        }
//
//                    }
//
//                }
//                .listRowBackground(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))
                
                Section ("Set your goal") {
                    GeometryReader { geo in
                        HStack (alignment: .center ,spacing: 0){
                            VStack (alignment: .trailing) {
                                Picker("Goal", selection: $amount) {
                                    ForEach(0..<31, id: \.self) {
                                        Text("\($0)")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: geo.size.width/2.5, height: geo.size.height, alignment: .center)
                                .compositingGroup()
                                .clipped()
                                .background(.cyan.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            Spacer()
                            Text("/  \(frequency)")
                        }
                        .font(.title3.smallCaps())
                    }
                }
                .listRowBackground(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))
                
                Section ("Chose frequency") {
                    Picker("Frequency", selection: $frequency) {
                        ForEach(frequencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.cyan.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .listRowBackground(Color(red:0.0, green: 0.5, blue: 0.8).opacity(0.2))

            }
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        dismiss()
                    },
                trailing:
                    Button("Save") {
                        let item = HabitItem(name: name, description: description, category: category, frequency: frequency, amount: amount, actualAmount: actualAmount)
                        habits.items.append(item)
                        dismiss()
                    }
            )
            .navigationTitle("Add a new habit")

        }
    }
    func charLimit() {
        if name.count <= 10 {
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
