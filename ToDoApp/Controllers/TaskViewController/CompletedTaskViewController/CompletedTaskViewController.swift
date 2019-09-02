//
//  ViewController.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit

class CompletedTaskViewController: TaskViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .taskArrayUpdated, object: nil, queue: nil) {[weak self] (notification) in
            self?.updateTableViewData()
        }
        updateTableViewData()
    }
    
    override func reloadTableView() {
        content = taskManager.completedTasks
        super.reloadTableView()
    }
    
    // MARK: - Utility Methods
    
    fileprivate func updateTableViewData() {
        content = taskManager.completedTasks
    }

}


