//
//  ContentView.swift
//  todo-list
//
//  Created by Daniel Mancilla on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var task = ""
    @State private var tasks: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                    }
                    .onDelete(perform: deleteTask)
                }

                TextField("Add a new task", text: $task, onCommit: addTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: addTask) {
                    Text("Add Task")
                }
            }
            .padding(.bottom)
            .navigationTitle("To-Do List")
        }
    }

    func addTask() {
        if !task.isEmpty {
            tasks.append(task)
            task = ""
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
