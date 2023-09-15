//
//  BucketListViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Bucket List Page

import SnapKit
import UIKit

class BucketListViewController: UIViewController {
    private let bucketListView = BucketListView()
    private let viewModel = BucketListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewReload()
        setup()
        setupNavigationItem()
        viewModel.fetchBucketList()
    }
    
    deinit {
        print("BucketListVC deinitialized")
    }
}

private extension BucketListViewController {
    func tableViewReload() {
        viewModel.tableViewReloadHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.bucketListView.tableView.reloadData()
            }
        }
    }

    func setup() {
        view = bucketListView
        bucketListView.tableView.dataSource = self
        bucketListView.tableView.delegate = self
        bucketListView.addButton.target = self
        bucketListView.addButton.action = #selector(didTapAddButton)
    }
    
    func setupNavigationItem() {
        navigationItem.title = "✍🏻 Bucket List ✍🏻"
        navigationItem.rightBarButtonItem = bucketListView.addButton
    }
}

private extension BucketListViewController {
    @objc private func didTapAddButton() {
        let alert = UIAlertController(title: "Add Bucket List", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Please, write your bucket list."
        }
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            if let textField = alert.textFields?.first, let title = textField.text {
                self.viewModel.addBucketListItem(title)
                self.viewModel.fetchBucketList()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension BucketListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bucketList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListCell.identifier, for: indexPath) as? BucketListCell else {
            fatalError("Error")
        }
        let task = viewModel.bucketList![indexPath.row]
        cell.configure(task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectTask = viewModel.bucketList![indexPath.row]
        
        let alert = UIAlertController(title: "Edit Bucket List",
                                      message: "\nCreate Date: \(viewModel.formattedDate(from: selectTask.createDate))\nModify Date: \(viewModel.formattedDate(from: selectTask.modifyDate))\n",
                                      preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        textField.text = selectTask.title
        
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            if let textField = alert.textFields?.first, let title = textField.text {
                self.viewModel.editBucketListItem(selectTask, title)
                self.viewModel.fetchBucketList()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { _, _, _ in
            let completedTask = self.viewModel.bucketList![indexPath.row]
            self.viewModel.isCompletedBucketListItem(completedTask, isCompleted: true)
            self.viewModel.fetchBucketList()
        }
        completeAction.backgroundColor = UIColor(red: 118/255, green: 138/255, blue: 225/255, alpha: 255)
        
        let inCompleteAction = UIContextualAction(style: .normal, title: "Add List") { _, _, _ in
            let inCompletedTask = self.viewModel.bucketList![indexPath.row]
            self.viewModel.isCompletedBucketListItem(inCompletedTask, isCompleted: false)
            self.viewModel.fetchBucketList()
        }
        inCompleteAction.backgroundColor = UIColor(red: 87/255, green: 231/255, blue: 117/255, alpha: 255)
        
        return UISwipeActionsConfiguration(actions: [completeAction, inCompleteAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            let deleteTask = self.viewModel.bucketList![indexPath.row]
            self.viewModel.deleteBucketListItem(deleteTask)
            self.viewModel.fetchBucketList()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
