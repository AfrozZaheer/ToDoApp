//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class TaskManager: NSObject {
    static let sharedManager = TaskManager()
    
    var allTasks = [BaseRowModel<Task>]() {
        didSet {
            NotificationCenter.default.post(name: .taskArrayUpdated, object: nil)
        }
    }
    var pendingTasks: [BaseRowModel<Task>] {
        return self.filterWithTask(type: .Pending)
    }
    
    var completedTasks: [BaseRowModel<Task>] {
        return self.filterWithTask(type: .Done)
    }

    private override init() {
        super.init()
    }
    
    private func filterWithTask(type: TaskType) -> [BaseRowModel<Task>] {
        return allTasks.filter { (item) -> Bool in
            if let _item = item.rowValue {
                 return _item.type == type
            }
            return false
        }
    }
    
    
}
