//
//  ViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Main Page

import SnapKit
import UIKit

class ViewController: UIViewController {
    // MARK: - UI Conponents

    // ImageView
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "mainImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // Bucket List Button
    private let bucketListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Let's go ✈️✌🏻", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor(red: 87/255, green: 231/255, blue: 117/255, alpha: 255)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // Completed Button
    private let completedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Is completed 🫡", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor(red: 118/255, green: 138/255, blue: 225/255, alpha: 255)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // Bucket List & Completed StackView
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bucketListButton, completedButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    // Profile & Travel Log ImageView
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile")
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        return iv
    }()

    // MARK: - Tapped Action

    @objc private func didTapBucketListButton() {
        let BucketVC = BucketListViewController()
        navigationController?.pushViewController(BucketVC, animated: true)
    }
    
    @objc private func didTapCompleteButton() {
        let CompleteVC = CompleteViewController()
        navigationController?.pushViewController(CompleteVC, animated: true)
    }
    
    @objc private func didTapProfileImageView(_ sender: UITapGestureRecognizer) {
        let ProfileVC = ProfileDesignViewController()
        ProfileVC.modalPresentationStyle = .fullScreen
        present(ProfileVC, animated: true, completion: nil)
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        bucketListButton.addTarget(self, action: #selector(didTapBucketListButton), for: .touchUpInside)
        completedButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView)))
    }
    
    // MARK: - setupUI

    private func setupUI() {
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 255)
        
        view.addSubview(imageView)
        view.addSubview(bucketListButton)
        view.addSubview(completedButton)
        view.addSubview(profileImageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        bucketListButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(50)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }

        completedButton.snp.makeConstraints { make in
            make.top.equalTo(bucketListButton.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.width.equalTo(150)
            make.height.equalTo(140)
        }
    }
}
