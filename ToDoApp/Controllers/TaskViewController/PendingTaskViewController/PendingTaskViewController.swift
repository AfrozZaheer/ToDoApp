//
//  PendingTaskViewController.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class PendingTaskViewController: TaskViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        content = taskManager.pendingTasks
        NotificationCenter.default.addObserver(forName: .taskArrayUpdated, object: nil, queue: nil) {[weak self] (notification) in
            self?.updateTableViewData()
        }
        updateTableViewData()
    }
    
    override func reloadTableView() {
        content = taskManager.pendingTasks
        super.reloadTableView()
    }
    
    // MARK: - Utility Methods
    
    fileprivate func updateTableViewData() {
        content = taskManager.pendingTasks
    }
    
    // MARK: - IBAction

    @IBAction func didClickedAddTask(_ sender: UIBarButtonItem) {
        presentNewTaskAlert()
    }
    
}
//MARK: Utility Methods

extension PendingTaskViewController {
    fileprivate func presentNewTaskAlert() {
        UIAlertController.showAlertWithTextFieldToEnterTask(parentVC: self, success: {[weak self] (title) in
            guard let `self` = self else {return}
            self.createNewTask(name: title)
        }) {
            UIAlertController.showAlert(title: "", message: "Please enter task name", parentVC: self)
        }
    }
    
    
    fileprivate func createNewTask(name: String) {
        let task = Task(name: name, type: .Pending)
        
        let rowModel = BaseRowModel<Task>()
        rowModel.rowCellIdentifier = "TaskTableViewCell"
        rowModel.rowValue = task
        taskManager.allTasks.append(rowModel)
        tableView.reloadData()
    }
}
