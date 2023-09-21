//
//  BucketListView.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import SnapKit
import UIKit

class BucketListView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        tableView.separatorColor = .systemGray
        tableView.register(BucketListCell.self, forCellReuseIdentifier: BucketListCell.identifier)
        return tableView
    }()

    let addButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(systemName: "plus.circle.fill")
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
