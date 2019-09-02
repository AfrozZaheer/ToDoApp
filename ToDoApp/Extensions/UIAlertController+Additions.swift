//
//  Utility.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit


fileprivate let rootViewController = UIViewController.topViewController()!

extension UIAlertController {
    
    class func showAlert(title: String?, message: String?, parentVC: UIViewController = rootViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.buttonOK, style: .default))
            parentVC.present(alert, animated: true, completion: nil)
        }
    
    }
    
    class func showAlertWithTextFieldToEnterTask(parentVC: UIViewController = rootViewController, success: @escaping (String) -> (), failure: @escaping () -> ()) {
        
        let alert = UIAlertController(title: "", message: "Task Information", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Enter Task Name"
            textField.autocapitalizationType = .words
        })
        
        let createAction = UIAlertAction(title: Constants.buttonCreate, style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            let textfields = alert.textFields
            let taskfield: UITextField = textfields![0]
            
            if taskfield.text!.isEmpty {
                failure()
            }
            else {
                success(taskfield.text ?? "")
            }
        })
        
        let cancelAction = UIAlertAction(title: Constants.buttonCancel, style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        
        parentVC.present(alert, animated: true, completion: nil)

    }
}
