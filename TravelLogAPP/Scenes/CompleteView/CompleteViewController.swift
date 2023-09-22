//
//  CompleteViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Completed Page

import UIKit

class CompleteViewController: UIViewController {
    private let completeView = CompleteView()
    private let completeViewModel = CompleteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
        tableViewReload()
        completeViewModel.fetchCompletedBucketList()
    }
    
    deinit {
        print("CompleteVC deinitialized")
    }
}

private extension CompleteViewController {
    func setup() {
        completeView.tableView.dataSource = self
        completeView.tableView.delegate = self
    }

    func setupUI() {
        view = completeView
        navigationItem.title = "✅ Completed List ✅"
    }
    
    func tableViewReload() {
        completeViewModel.tableViewReloadHandler = { [weak self] in
            print("complete 핸들러 작동")
            DispatchQueue.main.async {
                self?.completeView.tableView.reloadData()
                print("complete 리로드")
            }
        }
    }    
}

extension CompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeViewModel.completedList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListCell.identifier, for: indexPath) as? BucketListCell else {
            fatalError("Error")
        }
        let completedTask = completeViewModel.completedList![indexPath.row]
        cell.configure(completedTask)
        return cell
    }
}
