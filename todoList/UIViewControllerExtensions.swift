//
//  UIViewControllerExtensions.swift
//  todoList
//
//  Created by 曾子庭 on 2022/4/22.
//

import UIKit

extension UIViewController {
    
    func showTextFieldAlert(title: String,
                            message: String,
                            completionHandler: @escaping ((String?) -> Void))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確認", style: .default) { _ in
            if let textField = alertController.textFields?.first {
                completionHandler(textField.text)
            }
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
