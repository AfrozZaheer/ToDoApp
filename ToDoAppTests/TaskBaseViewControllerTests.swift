//
//  TaskBaseViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Khawar Shahzad on 03/09/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskBaseViewControllerTests: XCTestCase {

    var taskController: TaskViewController! = nil
    var pendingTaskController: PendingTaskViewController! = nil

    override func setUp() {
        taskController = TaskViewController()
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle(for: PendingTaskViewController.self))
        pendingTaskController = storyBoard.instantiateViewController(withIdentifier: "PendingTaskViewController") as? PendingTaskViewController
        pendingTaskController.loadViewIfNeeded() // UIElements should load if need to avoid crash

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testControllerInit() {
        if taskController != nil && pendingTaskController != nil {
            XCTAssert(true, "Controller init successfully")
        } else {
            XCTFail() // controller dose not init
        }
    }
    
    func testCheckStatusChangeOfTask() {
        pendingTaskController.createNewTask(name: "My Task")
        XCTAssert(TaskManager.sharedManager.allTasks.count > 0 , "One element added succefully")
        
        let arrayOfTasks = TaskManager.sharedManager.allTasks
        
        arrayOfTasks.forEach { (model) in
            if let task = model.rowValue {
                XCTAssertEqual(task.type , TaskType.Pending, "Task created and task type is pending initialy")
                
            } else {
                XCTFail() // Task not found but row models is there
            }
        }

        
        if let model = TaskManager.sharedManager.allTasks.first {
            taskController.changeStatusAndNotify(rowModel: model)
            
            if let task = model.rowValue {
                XCTAssertEqual(task.type , TaskType.Done, "Task status changed successfully")
                
            } else {
                XCTFail() // Task not found but row models is there
            }
        }
    }
}
