//
//  AlertManager.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/21.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()

    func addAlert(_ presentationContext: UIViewController, completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: "Add Bucket List", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Please, write your bucket list."
        }
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            if let textField = alert.textFields?.first, let title = textField.text {
                completion(title)
            } else {
                completion(nil)
            }
            print("Add 성공")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(add)
        alert.addAction(cancel)
        presentationContext.present(alert, animated: true, completion: nil)
    }

    func deleteAllAlert(_ presentationContext: UIViewController, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Delete All Lists", message: "Are you sure you want to delete all lists?\nOnce deleted, it cannot be recovered.", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Delete All List", style: .destructive) { _ in
            completion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(delete)
        alert.addAction(cancel)
        presentationContext.present(alert, animated: true, completion: nil)
    }
}

