//
//  MainView.swift
//  ScheduleMaster
//
//  Created by 64026339 on 3/15/24.
//

import SwiftUI

struct MainView: View {
    @State var tasks: [Task] = []
    @State var oldTasks: [Task] = []
    @State var selectedDay: String = ""
    @State var showAlert = false
    
    var body: some View {
        TabView{
            HomePageView(tasks: $tasks, oldTasks: $oldTasks, showAlert: $showAlert)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CalendarPageView(tasks: $tasks, oldTasks: $oldTasks, selectedDay: $selectedDay)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            TasksPageView(tasks: $tasks, oldTasks: $oldTasks, showAlert: $showAlert)
                .tabItem {
                    Label("Tasks", systemImage: "list.clipboard")
            }
        }
    }
}

#Preview {
    MainView()
}
