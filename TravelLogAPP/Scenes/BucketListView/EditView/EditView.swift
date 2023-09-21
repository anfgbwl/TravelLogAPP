//
//  EditView.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/20.
//

import SnapKit
import UIKit

class EditView: UIView {
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        return btn
    }()
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Edit Bucket List"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(UIColor.link, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        return btn
    }()
    
    private let category: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputCategory: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Category"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [category, inputCategory])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 20
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let bucketList: UILabel = {
        let label = UILabel()
        label.text = "Bucket List"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputBucketList: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Bucket List Content"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var bucketListStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bucketList, inputBucketList])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 20
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let isCompleted: UILabel = {
        let label = UILabel()
        label.text = "Is Completed"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let isCompletedLabel: UILabel = {
        let label = UILabel()
        label.text = "Is Completed"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var isCompletedStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [isCompleted, isCompletedLabel])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 20
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let createDate: UILabel = {
        let label = UILabel()
        label.text = "Create Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let createDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var createDateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [createDate, createDateLabel])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 20
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let modifyDate: UILabel = {
        let label = UILabel()
        label.text = "Modify Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let modifyDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Modify Date"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var modifyDateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [modifyDate, modifyDateLabel])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 20
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var editStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [categoryStackView, bucketListStackView, isCompletedStackView, createDateStackView, modifyDateStackView])
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
        addSubview(cancelButton)
        addSubview(pageTitle)
        addSubview(saveButton)
        addSubview(editStackView)
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageTitle)
            make.leading.equalTo(18)
        }
        
        pageTitle.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageTitle)
            make.trailing.equalTo(-18)
        }
        
        editStackView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom).offset(30)
            make.leading.trailing.equalTo(18)
        }
    }
}
