//
//  BucketListViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Bucket List Page

import UIKit
import SnapKit

class BucketListViewController: UIViewController {
    
    // viewContext
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // MARK: - Variables
    private var bucketList: [Task]?
    
    
    // MARK: - UI Conponents
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        tableView.separatorColor = .systemGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "bucketListCell")
        return tableView
    }()
    
    private let addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem()
        addButton.image = UIImage(systemName: "plus.circle.fill")
        return addButton
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        fetchTask()
        
        addButton.target = self
        addButton.action = #selector(didTapAddButton)
    }
    
    
    // MARK: - Tapped Action
    @objc private func didTapAddButton() {
        let alert = UIAlertController(title: "Add Bucket List", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Please, write your bucket list."
        }
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            let textField = alert.textFields![0]
            let newBucketList = Task(context: self.context)
            newBucketList.title = textField.text
            newBucketList.createDate = Date()
            newBucketList.isCompleted = false
            
            do {
                try self.context.save()
            } catch {
                print("🚨 Error: Save task")
            }
            self.fetchTask()
            
        }
        alert.addAction(add)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - setupUI
    private func setupUI() {
        self.navigationItem.title = "✍🏻 Bucket List ✍🏻"
        self.navigationItem.rightBarButtonItem = addButton
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
    // MARK: - Core Data
    private func fetchTask() {
        let request = Task.fetchRequest()
        
        do {
            self.bucketList = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("🚨 Error: Fetch Task")
        }
    }
    

}

extension BucketListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketListCell", for: indexPath)
        let task = bucketList![indexPath.row]
        cell.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        cell.textLabel?.text = task.title
        if task.isCompleted == true {
            cell.textLabel?.textColor = .systemGray2
        } else {
            cell.textLabel?.textColor = .black
        }
        return cell
    }
    
    // Complete Task
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action, view, completionHandler) in
            let completedTask = self.bucketList![indexPath.row]
            completedTask.isCompleted = true
            
            do {
                try self.context.save()
            } catch {
                print("🚨 Error: Completed task")
            }
            self.fetchTask()
        }
        completeAction.backgroundColor = UIColor(red: 118/255, green: 138/255, blue: 225/255, alpha: 255)
        
        let inCompleteAction = UIContextualAction(style: .normal, title: "Add List") { (action, view, completionHandler) in
            let inCompletedTask = self.bucketList![indexPath.row]
            inCompletedTask.isCompleted = false
            
            do {
                try self.context.save()
            } catch {
                print("🚨 Error: Incompleted task")
            }
            self.fetchTask()
        }
        inCompleteAction.backgroundColor = UIColor(red: 87/255, green: 231/255, blue: 117/255, alpha: 255)
        
        return UISwipeActionsConfiguration(actions: [completeAction, inCompleteAction])
    }
    
    // Delete Task
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
            let deleteTask = self.bucketList![indexPath.row]
            self.context.delete(deleteTask)
            
            do {
                try self.context.save()
            } catch {
                print("🚨 Error: Save task")
            }
            self.fetchTask()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
