//
//  EditViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/20.
//

import UIKit

class EditViewController: UIViewController {
    private let editView = EditView()
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension EditViewController {
    func setup() {
        view = editView
        editView.setTaskInfo(task!)
        editView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
//        editView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }

    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }

//    @objc func didTapSaveButton() {
//        NotificationCenter.default.post(name: NSNotification.Name("UpdateUserInfoNotification"), object: viewModel.user)
//        print("Post UpdateUserInfoNotification")
//        DispatchQueue.main.async {
//            self.dismiss(animated: true)
//        }
//    }

}
