//
//  ProfileDesignViewController.swift
//  TravelLogAPP
//
//  Created by t2023-m0076 on 2023/09/14.
//  Profile & Travel Log Page

import UIKit

class ProfileDesignViewController: UIViewController {
    private let profileDesignView = ProfileDesignView()
    private let viewModel = ProfileDesignViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setUserInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: NSNotification.Name("UpdateUserInfoNotification"), object: nil)
    }
}

private extension ProfileDesignViewController {
    func setup() {
        view = profileDesignView
        profileDesignView.collectionView.delegate = self
        profileDesignView.collectionView.dataSource = self
        profileDesignView.backButton.addTarget(self, action: #selector(setBackButton), for: .touchUpInside)
        profileDesignView.profile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileDesignToProfileVC)))
    }
    
    func setUserInfo() {
        viewModel.fetchUserInfo()
        profileDesignView.userId.text = viewModel.user?.id
        if let userPictureData = viewModel.user?.userPicture {
            profileDesignView.userPic.image = UIImage(data: userPictureData)
        }
        profileDesignView.postCount.text = String(viewModel.pictures.count)
        profileDesignView.followerCount.text = String(Int(viewModel.user?.followerCount ?? 0))
        profileDesignView.followingCount.text = String(Int(viewModel.user?.followingCount ?? 0))
        profileDesignView.nickname.text = viewModel.user?.nickname
        profileDesignView.bio.text = viewModel.user?.bio
        profileDesignView.linkInBio.text = viewModel.user?.linkInBio
    }

    @objc func setBackButton() {
        dismiss(animated: true)
    }

    @objc func profileDesignToProfileVC() {
        let ProfileVC = ProfileViewController()
        present(ProfileVC, animated: true, completion: nil)
    }
    
    @objc func updateUserInfo() {
        DispatchQueue.main.async {
            self.setUserInfo()
        }
    }
}

extension ProfileDesignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else {
            fatalError("Error")
        }
        let img = viewModel.pictures[indexPath.row]
        cell.configure(img)
        return cell
    }
}

extension ProfileDesignViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width / 3) - 1.34
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
