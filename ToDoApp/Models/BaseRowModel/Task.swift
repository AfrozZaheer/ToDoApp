//
//  Task.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class Task {
    
    var name: String?
    var type: TaskType
    var taskIdentifier: Date!
    
    init(name: String, type: TaskType) {
        self.name = name
        self.type = type
        taskIdentifier = Date.init()
    }
    
}

enum TaskType: String {
    case Done
    case Pending
}
