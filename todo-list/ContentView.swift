//
//  ContentView.swift
//  todo-list
//
//  Created by Daniel Mancilla on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var task = ""
    @State private var tasks: [Task] = []

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($tasks) { $task in
                        HStack {
                            Button(action: { task.isCompleted.toggle() }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(task.isCompleted ? .green : .primary)
                            }

                            Text(task.text)
                                .strikethrough(task.isCompleted)
                                .foregroundColor(task.isCompleted ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(PlainListStyle())

                TextField("Add a new task", text: $task, onCommit: addTask)
                    .onSubmit {
                        task = ""
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: addTask) {
                    Text("Add Task")
                }
            }
            .padding(.bottom)
            .navigationTitle("To-Do List")
        }
        .onTapGesture {
            // Hide keyboard when tapping outside of the TextField
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    func addTask() {
        if !task.isEmpty {
            tasks.append(Task(text: task))
            task = ""
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct Task: Identifiable {
    let id = UUID()
    var text: String
    var isCompleted = false
}


#Preview {
    ContentView()
}
