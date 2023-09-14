//
//  CompleteViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Completed Page

import UIKit

class CompleteViewController: UIViewController {
    
    // viewContext
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // MARK: - Variables
    private var completedList: [Task]?
    
    
    // MARK: - UI Conponents
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        tableView.separatorColor = .systemGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "completedListCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        fetchTask()
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.navigationItem.title = "✍🏻 Bucket List ✍🏻"
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
    // MARK: - Core Data
    private func fetchTask() {
        let request = Task.fetchRequest()
        
        let pred = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        request.predicate = pred
        
        do {
            self.completedList = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("🚨 Error: Fetch Task")
        }
    }
}

extension CompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedListCell", for: indexPath)
        let completedTask = completedList![indexPath.row]
        cell.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        cell.textLabel?.text = completedTask.title
        return cell
    }
}
