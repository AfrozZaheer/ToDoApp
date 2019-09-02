//
//  PendingViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Khawar Shahzad on 03/09/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import XCTest
@testable import ToDoApp

class PendingViewControllerTests: XCTestCase {

    var controller: PendingTaskViewController! = nil
    
    override func setUp() {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle(for: PendingTaskViewController.self))
        controller = storyBoard.instantiateViewController(withIdentifier: "PendingTaskViewController") as? PendingTaskViewController
        controller.loadViewIfNeeded() // UIElements should load if need to avoid crash
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testControllerInit() {
        if controller == nil {
            XCTFail()
        } else {
            XCTAssert(true)
        }
    }
    
    func testCreateNewTask() {
        controller.createNewTask(name: "My Task")
        XCTAssert(TaskManager.sharedManager.allTasks.count > 0 , "One element added succefully")
    }
    
    func testNewTaskValidy() {
        let taskName = "My Task"
        controller.createNewTask(name: taskName)
        XCTAssert(TaskManager.sharedManager.allTasks.count > 0 , "One element added succefully")
        
        let arrayOfTasks = TaskManager.sharedManager.allTasks
        
        arrayOfTasks.forEach { (model) in
            if let task = model.rowValue {
                if (task.name ?? "") == taskName {
                    XCTAssertEqual(task.name ?? "" , taskName, "Task created and task in array are same")
                }
            } else {
                XCTFail() // Task not found but row models is there
            }
        }
    }
    
    func testNewTaskAlwaysPending() {
        let taskName = "My Task"
        controller.createNewTask(name: taskName)
        XCTAssert(TaskManager.sharedManager.allTasks.count > 0 , "One element added succefully")
        
        let arrayOfTasks = TaskManager.sharedManager.allTasks
        
        arrayOfTasks.forEach { (model) in
            if let task = model.rowValue {
                XCTAssertEqual(task.type , TaskType.Pending, "Task created and task type is pending initialy")
                
            } else {
                XCTFail() // Task not found but row models is there
            }
        }

    }
    
}
