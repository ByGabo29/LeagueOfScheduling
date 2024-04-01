//
//  AddTaskView.swift
//  ScheduleMaster
//
//  Created by 64026339 on 3/25/24.
//

import SwiftUI


struct Task: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var timeMinutes: Int
    var timeHours: Int
    var difficultyRating: Double
    
    init(name: String, description: String, timeMinutes: Int, timeHours: Int, difficultyRating: Double) {
        self.name = name
        self.description = description
        self.timeMinutes = timeMinutes
        self.timeHours = timeHours
        self.difficultyRating = difficultyRating
    }
}


struct AddTaskView: View {
    @State private var task = Task(name: "", description: "", timeMinutes: 0, timeHours: 0, difficultyRating: 0.0)
    
    @Binding var tasks: [Task]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            List{
                Section("Name"){
                    
                    HStack{
                        
                        TextField("Name", text: $task.name)
                    }
                    
                }
                
                Section("Description"){
                    
                    TextField("Description", text: $task.description,  axis: .vertical)
                        .lineLimit(1...10)
                    
                }.pickerStyle(.navigationLink)
                
                Section("estimated time"){
                    
                    HStack{
                        Spacer()
                        Picker("", selection: $task.timeHours){
                            ForEach(0...8, id: \.self){ i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 50)
                        Text("Hours").fontWeight(.bold)
                        Spacer()
                        Picker("", selection: $task.timeMinutes){
                            ForEach(0...59, id: \.self){ i in
                                Text("\(i)").tag(i)
                            }
                            
                        }.pickerStyle(WheelPickerStyle())
                            .frame(width: 60)
                        Text("Min").fontWeight(.bold)
                        Spacer()
                    }.padding(.horizontal)
                    
                    Text("\(task.timeHours) Hours \(task.timeMinutes) Minutes")
                }
                
                Section("Difficulty Rating"){
                    HStack{
                        Text("\(task.difficultyRating, specifier: "%.0f")")
                            .padding(.horizontal)
                        Slider(value: $task.difficultyRating, in: 1...5, step: 1){
                        }
                    
                    }
                }
                
                Button {
                    tasks.append(task)
                    dismiss()
                } label: {
                    Text("Submit")
                }
                
                
            }
        }
        .navigationTitle("New Task")
    }
}

#Preview {
    @State var tasks: [Task] = []
    return AddTaskView(tasks: $tasks)
}
