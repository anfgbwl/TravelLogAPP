//
//  ProfileDesignView.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/15.
//

import SnapKit
import UIKit

class ProfileDesignView: UIView {
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        btn.tintColor = .systemGray2
        return btn
    }()
    
    let userId: UILabel = {
        let label = UILabel()
        label.text = "nabaecamp"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    let menuButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Menu"), for: .normal)
        return btn
    }()
    
    let userPic: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profileImage")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 44
        iv.clipsToBounds = true
        return iv
    }()
    
    let postCount: UILabel = {
        let label = UILabel()
        label.text = "7"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 16.5)
        label.textAlignment = .center
        return label
    }()
    
    private let post: UILabel = {
        let label = UILabel()
        label.text = "post"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let followerCount: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 16.5)
        label.textAlignment = .center
        return label
    }()
    
    private let follower: UILabel = {
        let label = UILabel()
        label.text = "follower"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let followingCount: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 16.5)
        label.textAlignment = .center
        return label
    }()
    
    private let following: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var postStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [postCount, post])
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 0
        return sv
    }()
    
    private lazy var followerStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [followerCount, follower])
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 0
        return sv
    }()
    
    private lazy var followingStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [followingCount, following])
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 0
        return sv
    }()
    
    private lazy var userFollowInfo: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [postStackView, followerStackView, followingStackView])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fillEqually
        return sv
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "르탄이"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    let bio: UILabel = {
        let label = UILabel()
        label.text = "iOS Developer 🍎"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    let linkInbio: UILabel = {
        let label = UILabel()
        label.text = "spartacodingclub.kr"
        label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var bioStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [bio, linkInbio])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 0
        return sv
    }()
    
    private lazy var userInfo: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [userName, bioStackView])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 2
        return sv
    }()
    
    let followButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Follow", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.backgroundColor = .link
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let messageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Message", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.systemGray2.cgColor
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let moreButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "More")
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.systemGray2.cgColor
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    private lazy var middleBar: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [followButton, messageButton, moreButton])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 8
        sv.distribution = .fill
    
        moreButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        followButton.snp.makeConstraints { make in
            make.width.equalTo(messageButton)
        }
        return sv
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let grid: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Grid")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let sectionIndocator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.identifier)
        return cv
    }()
    
    private let navBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 255)
        return view
    }()
    
    let profile: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Profile - Fill"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .white
        
        addSubview(backButton)
        addSubview(userId)
        addSubview(menuButton)
        addSubview(userPic)
        addSubview(userFollowInfo)
        addSubview(userInfo)
        addSubview(middleBar)
        addSubview(divider)
        addSubview(grid)
        addSubview(sectionIndocator)
        addSubview(collectionView)
        addSubview(navBar)
        addSubview(profile)
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(userId)
            make.leading.equalTo(18)
        }
        
        userId.snp.makeConstraints { make in
            make.top.equalTo(54)
            make.centerX.equalToSuperview()
        }
        
        menuButton.snp.makeConstraints { make in
            make.centerY.equalTo(userId)
            make.trailing.equalTo(-16)
        }
        
        userPic.snp.makeConstraints { make in
            make.top.equalTo(userId.snp.bottom).offset(14)
            make.leading.equalTo(14)
            make.width.height.equalTo(88)
        }
        
        userFollowInfo.snp.makeConstraints { make in
            make.centerY.equalTo(userPic)
            make.leading.equalTo(userPic.snp.trailing).offset(41)
            make.trailing.equalTo(-28)
        }
        
        userInfo.snp.makeConstraints { make in
            make.top.equalTo(userPic.snp.bottom).offset(14)
            make.leading.trailing.equalTo(15)
        }
        
        middleBar.snp.makeConstraints { make in
            make.top.equalTo(userInfo.snp.bottom).offset(11)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.height.equalTo(30)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(middleBar.snp.bottom).offset(10)
            make.leading.trailing.equalTo(1)
            make.height.equalTo(2)
        }
        
        grid.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(8)
            make.leading.equalTo(52)
            make.width.height.equalTo(22.5)
        }
        
        sectionIndocator.snp.makeConstraints { make in
            make.top.equalTo(grid.snp.bottom).offset(10.5)
            make.leading.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(2)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionIndocator.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(navBar.snp.top)
        }
        
        navBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }
        
        profile.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.top).offset(19)
            make.centerX.equalToSuperview()
        }
    }
}
