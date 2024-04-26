//
//  TaskFunctions.swift
//  ScheduleMaster
//
//  Created by 64026339 on 4/15/24.
//

import Foundation
import SwiftUI

func organizeTasks(tasks: Binding<[Task]>) {    
    var temp: Task
    if(tasks.wrappedValue.count == 1){
        return
    }
    for i in (0...(tasks.wrappedValue.count-2)){
        for j in ((i+1)...(tasks.wrappedValue.count - 1)){
            if(tasks.wrappedValue[i].dateStart.compare(tasks.wrappedValue[j].dateStart).rawValue > 0){
                temp = tasks.wrappedValue[i]
                tasks.wrappedValue[i] = tasks.wrappedValue[j]
                tasks.wrappedValue[j] = temp
            }
        }
    }
}

func removeTasks(task: Task, tasks: Binding<[Task]>, oldTasks: Binding<[Task]>) -> Task?{
    if(task.dateEnd.compare(Date()).rawValue < 0){
        oldTasks.wrappedValue.append(task)
        tasks.wrappedValue.remove(at: tasks.wrappedValue.firstIndex(of: task)!)
        return nil
    }
    return task
}

func startProcessingTasks(tasks: Binding<[Task]>, oldTasks: Binding<[Task]>) {
    // Start a timer to continuously process tasks
    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        processTasks(tasks: tasks, oldTasks: oldTasks)
    }
    RunLoop.main.add(timer, forMode: .common)
}

func processTasks(tasks: Binding<[Task]>, oldTasks: Binding<[Task]>) {
    for index in tasks.wrappedValue.indices {
        let task = tasks.wrappedValue[index]
        let removedTask = removeTasks(task: task, tasks: tasks, oldTasks: oldTasks)

    }
}


extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
