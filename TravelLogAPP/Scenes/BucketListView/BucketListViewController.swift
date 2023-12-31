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
    private var categories = CategoryManager.shared.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
        tableViewReload()
        fetchAndUpdateData()
    }
    
    deinit {
        print("BucketListVC deinitialized")
    }
}

private extension BucketListViewController {
    func setup() {
        view = bucketListView
        bucketListView.tableView.dataSource = self
        bucketListView.tableView.delegate = self
        bucketListView.addButton.target = self
        bucketListView.addButton.action = #selector(didTapAddButton)
        bucketListView.deleteButton.target = self
        bucketListView.deleteButton.action = #selector(didTapDeleteButton)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTaskInfo), name: NSNotification.Name("UpdateTaskInfoNotification"), object: nil)
    }
    
    func setupUI() {
        navigationItem.title = "✍🏻 Bucket List ✍🏻"
        navigationItem.rightBarButtonItems = [bucketListView.addButton, bucketListView.deleteButton]
    }

    func tableViewReload() {
        viewModel.tableViewReloadHandler = { [weak self] in
            self?.categories = CategoryManager.shared.categories ?? []
            DispatchQueue.main.async {
                self?.bucketListView.tableView.reloadData()
            }
        }
    }
    
    func fetchAndUpdateData() {
        CategoryManager.shared.fetchCategory { [weak self] success in
            if success {
                self?.viewModel.fetchBucketList()
            } else {
                print("🚨 Error: Fetch and update data")
            }
        }
    }
}

private extension BucketListViewController {
    @objc func didTapAddButton() {
        AlertManager.shared.addAlert(self) { title in
            if let title = title {
                let taskId = UUID().uuidString
                self.viewModel.addBucketListItem(title, taskId)
            }
        }
    }
    
    @objc func didTapDeleteButton() {
        AlertManager.shared.deleteAllAlert(self) {
            self.categories = CategoryManager.shared.categories ?? []
            self.viewModel.deleteAllTasks()
            CategoryManager.shared.deleteAllCategories()
        }
    }
    
    @objc func updateTaskInfo() {
        DispatchQueue.main.async {
            self.categories = CategoryManager.shared.categories ?? []
            self.bucketListView.tableView.reloadData()
        }
    }
}

extension BucketListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let category = categories?[section] {
            return category.task?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)

        let titleLabel = UILabel()
        if let category = categories?[section], let title = category.title {
            titleLabel.text = title
        }
        titleLabel.textColor = .link
        titleLabel.frame = CGRect(x: 20, y: 0, width: tableView.bounds.size.width - 30, height: 20)
        
        headerView.addSubview(titleLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListCell.identifier, for: indexPath) as? BucketListCell else {
            fatalError("Error")
        }
        if let category = categories?[indexPath.section] {
            if let tasks = category.task?.allObjects as? [Task], tasks.indices.contains(indexPath.row) {
                let task = tasks[indexPath.row]
                cell.configure(task)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let category = categories?[indexPath.section], let tasks = category.task?.allObjects as? [Task] {
            let selectTask = tasks[indexPath.row]
            let EditVC = EditViewController()
            EditVC.task = selectTask
            present(EditVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { _, _, _ in
            if let category = self.categories?[indexPath.section] {
                if let tasks = category.task?.allObjects as? [Task], tasks.indices.contains(indexPath.row) {
                    let completedTask = tasks[indexPath.row]
                    self.viewModel.isCompletedBucketListItem(completedTask, isCompleted: true)
                }
            }
        }
        completeAction.backgroundColor = UIColor(red: 118/255, green: 138/255, blue: 225/255, alpha: 255)
        
        let inCompleteAction = UIContextualAction(style: .normal, title: "Add List") { _, _, _ in
            if let category = self.categories?[indexPath.section] {
                if let tasks = category.task?.allObjects as? [Task], tasks.indices.contains(indexPath.row) {
                    let inCompletedTask = tasks[indexPath.row]
                    self.viewModel.isCompletedBucketListItem(inCompletedTask, isCompleted: false)
                }
            }
        }
        inCompleteAction.backgroundColor = UIColor(red: 87/255, green: 231/255, blue: 117/255, alpha: 255)
        
        return UISwipeActionsConfiguration(actions: [completeAction, inCompleteAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            if let category = self.categories?[indexPath.section] {
                if var tasks = category.task?.allObjects as? [Task], tasks.indices.contains(indexPath.row) {
                    let deleteTask = tasks[indexPath.row]
                    tasks.remove(at: indexPath.row)
                    self.viewModel.deleteBucketListItem(deleteTask)
                    if tasks.count == 0 {
                        CategoryManager.shared.deleteCategory(category)
                    }
                }
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
