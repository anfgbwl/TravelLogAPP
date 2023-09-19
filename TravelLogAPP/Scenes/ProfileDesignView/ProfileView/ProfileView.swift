//
//  ProfileView.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/19.
//

import SnapKit
import UIKit

class ProfileView: UIView {
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        return btn
    }()
    
    private let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Edit profile"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(UIColor.link, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        return btn
    }()
    
    private let profilePic: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profileImage")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 44
        iv.clipsToBounds = true
        return iv
    }()
    
    private let edit: UILabel = {
        let label = UILabel()
        label.text = "Edit profile picture"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .link
        label.textAlignment = .center
        return label
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputUserName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User Name"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var userNameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userName, inputUserName])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let id: UILabel = {
        let label = UILabel()
        label.text = "Id"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputId: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User Id"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var idStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [id, inputId])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let nickname: UILabel = {
        let label = UILabel()
        label.text = "Nickname"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputNickname: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User Nickname"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var nicknameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nickname, inputNickname])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let userAge: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputUserAge: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User Age"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var userAgeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userAge, inputUserAge])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let bio: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputBio: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Bio"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var bioStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bio, inputBio])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let linkInBio: UILabel = {
        let label = UILabel()
        label.text = "Link"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        return label
    }()
    
    let inputLinkInBio: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Add Link"
        tf.borderStyle = .none
        return tf
    }()
    
    private lazy var linkInBioStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [linkInBio, inputLinkInBio])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var editStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userNameStackView, idStackView, nicknameStackView, userAgeStackView, bioStackView, linkInBioStackView])
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
        addSubview(profilePic)
        addSubview(edit)
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
        
        profilePic.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(88)
        }
        
        edit.snp.makeConstraints { make in
            make.top.equalTo(profilePic.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        editStackView.snp.makeConstraints { make in
            make.top.equalTo(edit.snp.bottom).offset(30)
            make.leading.trailing.equalTo(18)
        }
    }
}
