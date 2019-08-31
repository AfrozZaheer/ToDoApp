//
//  PendingTaskViewController.swift
//  ToDoApp
//
//  Created by Khawar Shahzad on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class PendingTaskViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - IBAction

    @IBAction func didClickedAddTask(_ sender: UIBarButtonItem) {
        presentNewTaskAlert()
    }
    
}
//MARK: Utility Methods

extension PendingTaskViewController {
    fileprivate func presentNewTaskAlert() {
        let alert = UIAlertController(title: "", message: "Task Information", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Enter Task Name"
            textField.autocapitalizationType = .sentences
        })
        
        let createAction = UIAlertAction(title: buttonCreate, style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            let textfields = alert.textFields
            let taskfield: UITextField = textfields![0]
            
            if taskfield.text!.isEmpty {
                Utility.showAlert("", message: "Please enter task name", onController: self)
            }
            else {
                self.createNewTask(name: taskfield.text!)
            }
        })
        
        let cancelAction = UIAlertAction(title: buttonCancel, style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

    }
    
    fileprivate func createNewTask(name: String) {
        let task = Task()
        task.name = name
        let rowModel = BaseRowModel<Task>()
        rowModel.rowCellIdentifier = "TaskTableViewCell"
        rowModel.rowValue = task
        content.append(rowModel)
        tableView.reloadData()
    }
}
