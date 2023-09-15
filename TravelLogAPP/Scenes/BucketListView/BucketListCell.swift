//
//  BucketListCell.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import UIKit
import SnapKit

class BucketListCell: UITableViewCell {
    static let identifier = "BucketListCell"
    
    let bucketListTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ task: Task) {
        bucketListTitle.text = task.title
        if task.isCompleted == true {
            bucketListTitle.textColor = .systemGray2
        } else {
            bucketListTitle.textColor = .black
        }
    }
}

private extension BucketListCell {
    func setupUI() {
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        addSubview(bucketListTitle)
        
        bucketListTitle.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
}
