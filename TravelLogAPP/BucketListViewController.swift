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
    
}
