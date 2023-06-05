//
//  Task.swift
//  MakanLagi
//
//  Created by Hilary Young on 03/05/2023.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    
}

var tasks: [Task] = [
    
    Task(taskTitle: "Meeting1", taskDescription: "1Discuss team task for the day"),
    Task(taskTitle: "Meeting2", taskDescription: "2Discuss team task for the day"),
    Task(taskTitle: "Meeting3", taskDescription: "3Discuss team task for the day"),
    Task(taskTitle: "Meeting4", taskDescription: "4Discuss team task for the day"),
    Task(taskTitle: "Meeting5", taskDescription: "5Discuss team task for the day"),
    
    Task(taskTitle: "Meeting6", taskDescription: "6Discuss team task for the day"),
    Task(taskTitle: "Meeting7", taskDescription: "7Discuss team task for the day")

]
