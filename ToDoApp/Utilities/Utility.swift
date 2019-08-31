//
//  Utility.swift
//  ToDoApp
//
//  Created by Afroz Zaheer on 31/08/2019.
//  Copyright © 2019 AfrozZaheer. All rights reserved.
//

import UIKit


let rootViewController = UIViewController.topViewController()!


class Utility: NSObject {
    
    
    // MARK:- Alert Functions
    
    static func showAlert(_ error:NSError, onController parentVC: UIViewController = rootViewController) {
        showCancelTypeAlert(titleError, message: error.localizedDescription, buttonTitle: buttonOK, onController: parentVC)
    }
    
    
    
    static func showAlert(_ title: String, message: String, onController parentVC: UIViewController = rootViewController) {
        showCancelTypeAlert(title, message: message, buttonTitle: buttonOK, onController: parentVC)
    }
    
    
    
    static func showCancelTypeAlert(_ title: String!, message: String!, buttonTitle bTitle: String, onController parentVC: UIViewController!) {
        showCancelTypeAlert(title, message: message, buttonTitle: bTitle, buttonAction: {(alertAction) in}, onController: parentVC)
    }
    
    
    
    
    static func showCancelTypeAlert(_ title: String!, message: String!, buttonTitle bTitle: String, buttonAction bAction: ((UIAlertAction?) -> Void)!, onController parentVC: UIViewController!) {
        _ = showAlert(title, message: message, buttonsDictionary: ["": {($0)}, bTitle: bAction], baseController: parentVC)
    }

    
    static func showAlert(_ title: String?, message: String?, buttonsDictionary buttons: Dictionary<String, (UIAlertAction?) -> Void>!, baseController parentVC: UIViewController!) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var count: Int = 0
        for (bTitle, bAction) in buttons {
            if bTitle != "" {
                var style: UIAlertAction.Style = .destructive
                if count > 1 {
                    style = .destructive
                } else if count == 1 {
                    style = .default
                } else {
                    style = .cancel
                }
                
                let alertAction = UIAlertAction(title: bTitle, style: style, handler: bAction)
                alertController.addAction(alertAction)
            }
            count += 1
        }
        parentVC.present(alertController, animated: true)
        return alertController
    }
}



func className (_ name:AnyClass) -> String {
    return name.self.description().components(separatedBy: ".").last!
}
