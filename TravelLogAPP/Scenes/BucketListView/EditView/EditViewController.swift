//
//  EditViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/20.
//

import UIKit

class EditViewController: UIViewController {
    private let editView = EditView()
    private let viewModel = BucketListViewModel()
    
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

private extension EditViewController {
    func setup() {
        view = editView
        setTaskInfo(task!)
        editView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        editView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    func setTaskInfo(_ task: Task) {
        editView.inputCategory.text = task.category?.title
        editView.inputBucketList.text = task.title
        editView.isCompletedLabel.text = task.isCompleted.description
        editView.createDateLabel.text = viewModel.formattedDate(from: task.createDate)
        editView.modifyDateLabel.text = viewModel.formattedDate(from: task.modifyDate)
    }

    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }

    @objc func didTapSaveButton() {
        let newCategoryTitle = editView.inputCategory.text ?? "일반"
        let newCategory = CategoryManager.shared.getCategory(withTitle: newCategoryTitle) ?? CategoryManager.shared.addCategory(newCategoryTitle)
        viewModel.editBucketListItem(task!, editView.inputBucketList.text ?? "", newCategory)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateTaskInfoNotification"), object: viewModel.bucketList)
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

}
