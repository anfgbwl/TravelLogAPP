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
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: - setupUI
    private func setupUI() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
    // MARK: - Fetch Data
    private func fetchTask() {
        let request = Task.fetchRequest()
        
        do {
            self.bucketList = try context.fetch(request)
            
        } catch {
            print("Fetch Task Error")
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
        cell.textLabel?.text = task.title
        if task.isCompleted == true {
            cell.textLabel?.textColor = .systemGray2
        } else {
            cell.textLabel?.textColor = .black
        }
        return cell
    }
    
}
